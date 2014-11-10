From: =?windows-1252?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: dtb size limit? was Re: Tiny dts change breaks boot on n900
Date: Mon, 10 Nov 2014 15:25:40 +0000
Message-ID: <5460D8F4.9000507@suse.de>
References: <20141110123118.GA31134@amd> <20141110125806.GA16650@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141110125806.GA16650@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org

Am 10.11.2014 um 12:58 schrieb Pavel Machek:
> If I replace the blo[ck] below with
>=20
>  a =3D <1>;
>  b =3D <2>;
>  c =3D <3>;
>  d =3D <4>;
>=20
> Resulting kernel boots. Replacing it with
>=20
>  a-really-long-attribute-name-hopefully-this-breaks-stuff =3D <1>;
>  b =3D <2>;
>  c =3D <3>;
>  d =3D <4>;
>=20
> Breaks the boot. I'm using dtb append option. Any ideas? Nonbooting
> dtb is 68910 bytes.

Did you verify that your initrd, if any, does not overlap the end of th=
e
kernel when loading it from the bootloader?

Andreas

--=20
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 21284 AG N=FCrn=
berg
