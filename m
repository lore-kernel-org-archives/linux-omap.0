From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 16/33] OMAPDSS: acx565akm panel: handle gpios in panel
 driver
Date: Mon, 18 Feb 2013 10:11:54 +0200
Message-ID: <5121E24A.6090502@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-17-git-send-email-archit@ti.com> <20130213172913.GD21750@blackmetal.musicnaut.iki.fi> <511C896C.10007@ti.com> <511C8B16.5060605@ti.com> <5121D941.3060609@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig43BFD722BF35BE513738B58F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36164 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226Ab3BRIMG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 03:12:06 -0500
In-Reply-To: <5121D941.3060609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig43BFD722BF35BE513738B58F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-18 09:33, Archit Taneja wrote:
> On Thursday 14 February 2013 12:28 PM, Tomi Valkeinen wrote:
>> On 2013-02-14 08:51, Archit Taneja wrote:
>>> On Wednesday 13 February 2013 10:59 PM, Aaro Koskinen wrote:
>>>> Hi,
>>>>
>>>> On Wed, Feb 13, 2013 at 07:52:08PM +0530, Archit Taneja wrote:
>>>>> +static struct panel_acx565akm_data *get_panel_data(struct
>>>>> omap_dss_device *dssdev)
>>>>> +{
>>>>> +    return (struct panel_acx565akm_data *) dssdev->data;
>>>>> +}
>>>>> +
>>>>>    static int acx_panel_probe(struct omap_dss_device *dssdev)
>>>>>    {
>>>>>        int r;
>>>>>        struct acx565akm_device *md =3D &acx_dev;
>>>>> +    struct panel_acx565akm_data *panel_data =3D get_panel_data(dss=
dev);
>>>>
>>>> Why the get_panel_data function is needed, isn't the cast unnecessar=
y?
>>>
>>> the 'data' member of omap_dss_device has the type 'void *', we need t=
o
>>> cast it to access the panel_acx565akm_data struct pointer.
>>
>> You don't need an explicit cast to assign a void pointer to a pointer =
to
>> something else (or vice versa, I think).
>>
>> I remember us having similar constructs in some other panel drivers
>> also. I think they are unnecessary also.
>=20
> I was considering keeping the get_panel_data() funcs in the panel
> drivers though. This way, whenever the way of retrieving platform data
> changes because of DT or CDF or something else, we would just need to
> modify the get_panel_data func.

I think it's simpler if we manage the fetching of the platform data in
probe one, and just store a struct panel_acx565akm_data or such to the
panel driver's data.

For DT we don't have platform data, but we can create the same platform
data struct from the DT properties.

So the above would become something like:

struct acx565akm_device *md =3D &acx_dev;
struct panel_acx565akm_data *panel_data =3D md->pdata;

 Tomi



--------------enig43BFD722BF35BE513738B58F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRIeJKAAoJEPo9qoy8lh71oHcQAIozu7L4LUkWQCICIQWzWlL3
GSpUxD2KlYz1aej8cxi6W9dLbfAFK4MMRdWdp48oVmbEcxSNVDUTBcsH4NJ2W2wv
Jfm1jesT/LSOaGMzysp7oJH7kO3kQEcN1YcfXeU+LQJnlA1XWMWGqmRxux7F97RV
mkHa6Isyl74ISSZpVUae9unvLwLvz+t4kv49o38eVvNJOG1JkeZUcnFws0+XgETB
mhNydzjSpeShtDFdTwWUjsh7fSII8b1iFc90/RA8rXb8jo6uwKIToRj8cgdgNd+3
t79Kak8VyTltaQNGUWXYib0Sqc7qBySk+Mdv2AI6jrbL9DZ3D6UBQBTWlx2Zr+1X
fd7urMrfsGfVEU2HB1BZ2FW5gXfSe/n78ZNsnznsW1XDx8oAguq523rMLSlSSOD6
TniLC4sLFmqA5ZSLpQOiN40rMchpCAa+tZtGYcgucRJOEUeduwcbyNPj444oN9bh
NlAJC8r8vXxuB6jb7rqELEXXQfpdOSqkPGC7/N5oTUiZ2fz9/gb3u8DYjEpbFzkj
RqPcj9vT9KzYqnMdFpS1msB+yEUTysJ3I4ZYhtozRxps7/sBMpWSHBOQIo9VHwpP
LmafYpitLn4FEZ6iPdJCE4ICIFZ2EfUIYRooYJNqYaYYVuxZ3qyljZOzmV5kfRyu
v5oRMltI3UvPcGzWJKfh
=t7PH
-----END PGP SIGNATURE-----

--------------enig43BFD722BF35BE513738B58F--
