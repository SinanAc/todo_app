class Url {
  String baseUrl = 'http://10.0.2.2:3000';

  String createNote = '/note/create';
  String updateNote = '/note/update';
  String deleteNote = '/note/delete/{id}';
  String getAllNote = '/note/getAll';
}
// {
// "data":[
// {
//   "_id": "id02",
//   "title": "Daily",
//   "content": "sample content"
// },
// {
//   "_id": "id02",
//   "title": "Daily",
//   "content": "sample content"
// }
// ]
// }
