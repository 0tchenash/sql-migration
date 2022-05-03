import sqlite3


def execute(query, args=None):
    connection = sqlite3.connect('animal.db')
    cursor = connection.cursor()
    cursor.execute(query, args)
    result = cursor.fetchall()
    connection.close()
    return result


def get_cat(idx):
    query = """
            SELECT DISTINCT animals_new.name,
                animals_new.date_of_birth,
                Colors1.color,
                Colors2.color,
                Programs.program,
                Statuses.status,
                B.breed

            FROM Admissions
                LEFT JOIN Statuses  on Admissions.status_id = Statuses.status_id
                LEFT JOIN Programs ON Admissions.program_id = Programs.program_id
                LEFT JOIN animals_new ON Admissions.animal_id = animals_new.animal_id
                LEFT JOIN Colors Colors1 ON animals_new.main_color_id = Colors1.color_id
                LEFT JOIN Colors Colors2 ON animals_new.second_color_id = Colors2.color_id
                LEFT JOIN Breeds B on animals_new.breed_id = B.breed_id
            WHERE id = :id
            """
    data = execute(query, {'id': idx})[0]
    cat = {
        'name': data[0],
        'date_of_birth': data[1],
        'main_color': data[2],
        'second_color': data[3],
        'program': data[4],
        'status': data[5],
        'breed': data[6]
    }
    return cat
