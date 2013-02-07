From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 00/10] video: da8xx-fb: runtime timing configuration
Date: Thu, 7 Feb 2013 11:13:01 +0200
Message-ID: <5113701D.2080009@ti.com>
References: <cover.1358250489.git.afzal@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93EAA2846@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig84BFB8ADE209F0A10B699267"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EAA2846@DBDE01.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--------------enig84BFB8ADE209F0A10B699267
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 2013-02-07 11:05, Mohammed, Afzal wrote:
> Hi Tomi, Florian,
>=20
> On Tue, Jan 15, 2013 at 19:00:50, Mohammed, Afzal wrote:
>=20
>> This series makes da8xx-fb driver (device found on DaVinci and AM335x)=

>> capable of handling runtime timing configuration by adding fb_set_par.=

>>
>> The last change adds actual fb_set_par support. Other preceeding
>> changes makes the way clear for it as well as does certain cleanup's
>> on the way.
>>
>> This has been tested on da850 evm as is. This was also tested on
>> am335x-evm & am335x-evmsk with a series that adds DT support.
>>
>> This is based on v3.8-rc3, this is the only change in this revision.
>> The new version of this series is being posted so that this series can=

>> be applied easily (as __dev* are removed, there would be merge
>> conflicts with v2, which was based on -rc2).
>> series
>=20
> Can you please consider this series for inclusion. There are no
> pending comments or dependency for this series. If you need a
> pull request, let me know, I will sent it.

I handled only the pull request for 3.8 merge window to help Florian
with it. I didn't mean to become a co-maintainer or such =3D).

 Tomi



--------------enig84BFB8ADE209F0A10B699267
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRE3AdAAoJEPo9qoy8lh71KvwP/j7flxTpyAiBAE+bOxK4G7Kt
9Gn1FdshJPQAfMtgq9i/8TPeAAEPAA5deXr3lzHFzZVRcmlgP/t20hW19Fd6G5BB
17Z6ARmEXbl6zgMavI8G6eQ8VSs1RAOtrc1wksVRDSJzYNSQ7qeh2yjQ5xj/eUQu
6a0vInt5UzYFOjnayqLMl4ur75PhLPQ1qfzwsTjQ5SNK4iX04SKDSJwIs2ujZeMH
aICzD5CvoaMDxKljl6qu3IQ+9YOAmBJGIwW8jPc7s/MbUBsiFu680sRRKm69yeLZ
9947pZ4o+889fywmEiaDW+FJIDte/IrYeI3WdM5eRQ9aYi8wVKY44lfmU6Uxiddc
GSE5DnfNNMInUexcQcIZbYIjoqBbysG49CXdV/dm4QHdfbztoTuBoL3IdfIunUUC
ki8CARKFEQvXUakrFZgHopFp5tndLlUK0TZ1Z0hH7BkbSpSAfV0qw7umZK4uYNki
MPPLd6rClcdLavEvP0y/AJqbqqsN7ejPb6iUfraS87H4e6iO6KUnO6bYVMVdgfLU
hwWeDtoKfS+P0TWApo89nWRO7mPbfrAQsNWWliL3XDcEVuJnhSSniYpjO+I9W3YW
Ll6AjTEbCukLEgpwOZJKN1mtRy5w9PbLqq9xpOn46uwEzbl10/An+GdI8ovijQNF
NnDJizsamiCHjVE7fweJ
=l0He
-----END PGP SIGNATURE-----

--------------enig84BFB8ADE209F0A10B699267--
