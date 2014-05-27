From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC v2 2/5] OMAPDSS: DT: Get source endpoint by matching reg-id
Date: Tue, 27 May 2014 13:24:32 +0300
Message-ID: <538467E0.2000305@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com> <1401096492-1405-1-git-send-email-archit@ti.com> <1401096492-1405-2-git-send-email-archit@ti.com> <53844E14.9090504@ti.com> <53845F99.60603@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="shjFE6r06LKNH2Q5NkiWX5wGniMnJtPoR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51566 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742AbaE0KYf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 May 2014 06:24:35 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id s4RAOZCD031128
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 05:24:35 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4RAOZeg014699
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 05:24:35 -0500
In-Reply-To: <53845F99.60603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

--shjFE6r06LKNH2Q5NkiWX5wGniMnJtPoR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 27/05/14 12:49, Archit Taneja wrote:
> On Tuesday 27 May 2014 02:04 PM, Tomi Valkeinen wrote:

>> Hmm, maybe the above function, and the helper functions, should be
>> changed a bit more, so that this function would do:
>>
>> ep =3D omapdss_of_get_first_endpoint(node);
>> src_port =3D omapdss_of_get_remote_port(ep);
>> src =3D omap_dss_find_output_by_port_node(src_port);
>=20
> src_port will be just on level up(the parent node), the source node wil=
l
> be still a couple of hops up.
>=20
> Getting the source node would require us to do some DT related hopping
> in omap_dss_find_output_by_port_node(). And it'll also require parsing
> of the dss output_list in output.c. I'm worried it'll be a bit messy,
> and we might end up adding some DT parsing in output.c

But now the function above is messy =3D).

Well, I haven't thought what the code would actually be. I just thought
the functions I wrote would be logical in this context. As the output
omap_dss_device more or less is a "port", it would feel logical to ask
for the omap_dss_device by giving the port node.

But you're right, the function in output.c would need to do a bit more
than now. Then again, we could add helper functions to dss-of.c, so that
output.c wouldn't need to do them manually.

I guess the helper funcs in this case would be:

struct device_node *dss_of_port_get_parent_device(struct device_node *por=
t);

int dss_of_port_get_port_number(struct device_node *port);

 Tomi



--shjFE6r06LKNH2Q5NkiWX5wGniMnJtPoR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJThGfgAAoJEPo9qoy8lh71qe0P/idudQ8B9CgNB4EQXorswrQB
FW35TNdDV51Q0RxoPbaYQul7vi3Sq2nzsrPA7tMYEs68f0UpJKxuW4WXiybFIY/+
uHI6BYTnB6Hv49EGHJlMbnveHTPdz2gY1edEa1EBMVLtY4VcaLdibYLZCuOpFuqZ
dfMkCzbcm1aIDoclg5VQWSo13OZDENJme0fvchOjjvJYLfImqcobiX7qRN7KkJ7J
RukW9kfpYfCJNZCgY7LK1wfZoPYjnqLiOrqAD0rQkXRhhfxx5PgZQcMaLrJDI9Ou
2Y7XnVNhW4RoVUy0lTslCBKAIoyM0hSop/QopHP+oZZkEiEBQEC4UXCsaRbwg4eN
EhNMk+1GMvaA6UCudm6qYzZ/hbyn1gVDWQcUIYqgNZn3LZuRaPMyMO9Au70dN5Ee
S6OmngKBLZbVGyAmIwt+c/cAKIdRIr9UVXYZxyq/B6kh8L2dK2oc9Si9YmQqWlv4
5f15HMN9O+RfHrRY/VPX0q+OSPA/EFSS3RbHdQ+wIMu6T1X2TZwyhowvcjaux+Rf
I9cyLirU6Yn+iHpBoMXqFJglu4LOrULM1Z1Lh14Q5KADWyYLwOIdu4CR9gGbq9k+
yhQPS6BJ6uZv6D2DS7sZaaCdF0WEM+WsOwrjNblbIgxwKBLA4gjtsk7y3QeitpcF
q68/xXq26xPzMpIJAh99
=Mz5g
-----END PGP SIGNATURE-----

--shjFE6r06LKNH2Q5NkiWX5wGniMnJtPoR--
