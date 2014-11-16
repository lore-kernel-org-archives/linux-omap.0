From: Pavel Machek <pavel@ucw.cz>
Subject: Re: dtb size limit? was Re: Tiny dts change breaks boot on n900
Date: Sun, 16 Nov 2014 09:38:31 +0100
Message-ID: <20141116083831.GB30646@amd>
References: <20141110123118.GA31134@amd>
 <20141110125806.GA16650@amd>
 <5460D8F4.9000507@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5460D8F4.9000507@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org

On Mon 2014-11-10 15:25:40, Andreas F=E4rber wrote:
> Am 10.11.2014 um 12:58 schrieb Pavel Machek:
> > If I replace the blo[ck] below with
> >=20
> >  a =3D <1>;
> >  b =3D <2>;
> >  c =3D <3>;
> >  d =3D <4>;
> >=20
> > Resulting kernel boots. Replacing it with
> >=20
> >  a-really-long-attribute-name-hopefully-this-breaks-stuff =3D <1>;
> >  b =3D <2>;
> >  c =3D <3>;
> >  d =3D <4>;
> >=20
> > Breaks the boot. I'm using dtb append option. Any ideas? Nonbooting
> > dtb is 68910 bytes.
>=20
> Did you verify that your initrd, if any, does not overlap the end of =
the
> kernel when loading it from the bootloader?

I don't use initrd, so this can't be it. Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
