From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/26] OMAPDSS: if dssdev->name==NULL, use alias
Date: Thu, 12 Dec 2013 09:41:49 +0200
Message-ID: <52A968BD.20304@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-7-git-send-email-tomi.valkeinen@ti.com> <37483030.ghHfzYFSnL@avalon> <10507960.9DXH4TSv2E@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="gEHOISIgkbGVOedRu7O4LsTjO1i6XkUlO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43334 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445Ab3LLHlz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 02:41:55 -0500
In-Reply-To: <10507960.9DXH4TSv2E@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

--gEHOISIgkbGVOedRu7O4LsTjO1i6XkUlO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-12 01:56, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> On Thursday 12 December 2013 00:13:01 Laurent Pinchart wrote:
>> On Wednesday 04 December 2013 14:28:33 Tomi Valkeinen wrote:
>>> To avoid the need for a "nickname" property for each display, change
>>> the display registration so that the display's alias (i.e. "display0"=

>>> etc) will be used for the dssdev->name if the display driver didn't
>>> provide a name.
>>>
>>> This means that when booting with board files, we will have more
>>> descriptive names for displays, like "lcd1", "hdmi".
>>
>> Where are those names used ? Are they reported to userspace, or limite=
d to
>> kernel internal use only ?

They are visible via omapdss's sysfs, when using omapfb. They are used
for debug prints and by the user for selecting the default display and
display modes via kernel cmdline, and when he sets the video pipeline
routing. So changing them could be considered breaking the API, but...

With omapdrm the sysfs files do not exist, and I think omapdrm doesn't
use them (except maybe for some debug prints).

>>> With DT we'll only have "display0", etc. But as there are no "nicknam=
es"
>>> for things like serials ports either, I hope we will do fine with thi=
s
>>
>> Just a random thought, maybe the aliases node could help here.
>=20
> I should have read the next patches before replying, sorry :-)
>=20
>> I'm not sure what rules govern its usage. Adding labels to display DT =
nodes
>> could be an option too.

Using of_alias_get_id() means that the alias is in the form "nameX"
where X is a number.

> A label property is still an option.

Hmm, what do you mean? Label as in:

foo : node {
};

Isn't that 'foo' label only visible in DT itself, as a shortcut?

 Tomi



--gEHOISIgkbGVOedRu7O4LsTjO1i6XkUlO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqWi9AAoJEPo9qoy8lh71PTkQAJtoVilfqDUk/dZqMQRD70SH
wnLlQr6nykppWo05kzGCvPDJiu7y5LU000cXClojehXrnq3Cu0ztUMo/naqRgt33
7uyiynCxt22WIUS8QGD6NXvOtGRw2HrALsSV/MGVXGeyBZAegrkSiEtkrWuuupwI
WJ/PmQ7EUTvvV8huy3GWKiu6+klSEPc/b0rt/ffCUKCETbgR/8gm24uoGQp2KdbF
tbPXqAZFxKJakjhzwPUK/cUkvVrobxsFxXa5nVunH6j/2ZCDG3NYvqJ7Z3RckhBa
fnXao/OQtnhKoHPc9wWwgkTkYj9MqSy/Pt7pbhY/mNzGbwlRGKhi+Ui+0KC5vESU
D7USQduSQID/TtRt5U44bfk71pO2LAwYg2DiH73ZshIQdq/pB/0G5F91SbfieuoW
AKIQ2uNB7mKZEsdJXKtoD3fe3MXt1GcVLoQTTFJzYduFiuqLKzDYW1JKAxa0MSzZ
gG1D9myGrpyvtKuybrv8R4Rsy1yElPb3JA9MMU9o3VLFv6uG7ijuYN2mIRugvB1b
fkSNDNK3vHElYQoKPHbuN+bQSq+2snhgb1uOhhRg5giT2Ri17MDmIuZR1sbsi5JL
ouUNooKmuXd/iXW1I/QIaTLxhnW9T/OojnxzSi+MRnR6PZ2OkgaNI+rJTjhz5Mur
rVwnSB91ItSBESqpKMXv
=ayRZ
-----END PGP SIGNATURE-----

--gEHOISIgkbGVOedRu7O4LsTjO1i6XkUlO--
