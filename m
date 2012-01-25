From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP3530 vs DM3730
Date: Wed, 25 Jan 2012 13:07:06 +0200
Message-ID: <1327489626.1858.34.camel@deskari>
References: <4F1AE4E6.8090000@mlbassoc.com>
	 <79CD15C6BA57404B839C016229A409A8317AF070@DBDE01.ent.ti.com>
	 <4F1D64A1.6020604@mlbassoc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-jHwWR1jg+yc3E6VR02bu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:33537 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751180Ab2AYLHM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 06:07:12 -0500
Received: by lags15 with SMTP id s15so3067569lag.20
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 03:07:09 -0800 (PST)
In-Reply-To: <4F1D64A1.6020604@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--=-jHwWR1jg+yc3E6VR02bu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-01-23 at 06:46 -0700, Gary Thomas wrote:
> On 2012-01-22 22:06, Hiremath, Vaibhav wrote:
> > On Sat, Jan 21, 2012 at 21:46:38, Gary Thomas wrote:
> >> I'm running the public 3.0 kernel on my boards.  I have some boards
> >> which can have either OMAP3530 or DM3730 (newer boards have the
> >> newer part, but everything else is the same).
> >>
> >> On the OMAP3530, I can enable the graphics overlay on the TV (S-Video)
> >> output via the attached script.  On the DM3730 boards, this crashes
> >> the kernel hard :-(
> >>
> > Can you share the kernel crash log here?
>=20
> Sadly, no, as it just locks up tight.  At this point, I can only
> reset manually.  I've tried sifting through the dmesg log (_log_buf)
> in U-Boot, but I don't see any tell-tale trace of why it crashes.
>=20
> Further investigation shows that it's not really a problem between 3530 a=
nd
> 3730, sorry.  I thought I had a 3530 system where it worked, but trying i=
t
> again today, it also fails. It seems to always fail when I enable fb2 as =
an
> overlay using the TV as the manager.
>=20
> I know this worked as far back as 2.6.28 and it works again in 3.2. I've
> isolated where the kernel fails to the function dispc_pclk_rate().  This
> function is quite different in 3.2 than 3.0, so I back-stitched it like
> this:
>=20
> unsigned long dispc_pclk_rate(enum omap_channel channel)
> {
>          unsigned long r;
>=20
>          if (dispc_mgr_is_lcd(channel)) {
>                  int pcd;
>                  u32 l;
>=20
>                  l =3D dispc_read_reg(DISPC_DIVISORo(channel));
>                  pcd =3D FLD_GET(l, 7, 0);
>                  r =3D dispc_lclk_rate(channel);
>=20
>                  return r / pcd;
>          } else {
>                  unsigned long venc_get_pixel_clock(void);
>                  return venc_get_pixel_clock();
>          }
> }

I think this commit fixes the crash:
c3dc6a7afb47735b82a4c0061e814454a649dbfc

Your changes above seems to be ok for omap3.

> The kernel no longer crashes hard, but now I get these error messages
> printed when I enable the overlay:
>    omapdss DISPC error: GFX_FIFO_UNDERFLOW, disabling GFX
>    omapdss DISPC error: GO bit not down for channel 1
>    omapdss DISPC error: VID2_FIFO_UNDERFLOW, disabling VID2
>    omapdss DISPC error: SYNC_LOST_DIGIT, disabling TV

So does everything work if you use the LCD? And the problems only appear
when you enable the tv-output?

You could try a bit more step-by-step approach in your script. First
enable GFX overlay on the LCD, and resize it so that it fits to both LCD
and TV. See that it works ok. Then enable the TV-out. Then move the GFX
overlay to the TV. etc.=20

Also, if you have your test setup working on newer kernel, and it
doesn't work on older, you could get dumps of the dss registers and
compare those. (debugfs/omapdss/dispc and venc).

Hmm. Actually, your script is missing something: it doesn't set the
input_size, i.e. the framebuffer size for fb2. You should set it before
enabling the overlay (fbset -xres $w -vxres $w -yres $h -vyres $h).

I haven't tested tv-out for a while, but I could give it a try on
BeagleBoard. Although I don't have an s-video cable, but I guess it's
enough if I don't see the underflows =3D).

 Tomi


--=-jHwWR1jg+yc3E6VR02bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPH+JaAAoJEPo9qoy8lh714wkP/0mDM3Fo/usG6KmRLSFH2yfi
bHjd+knwIiJCzqRsf2OxHd3Gx6vDsRDQBkO7bKQF08a+0BTKq9xSqXd2Kofqh+wm
KiiwYEM0yQRinckUua0wO0TAVH3FPhxmDsyB5sIKjbIM+cfMaKc18Qz6MkQGq+at
2ZyemRYCX4Ho0y0T5+BVoi16VSb91Nfr09T4r3qvEPYEjS6Yi9WAdbQFonnpLW7k
VHwRC0w8jWnuJIAjjPjaKNzafr+LxHNu3sqEu3QWWxkpMaLgjyYlMG4mgF7PfxQ4
9b+tweI3IoHseIr1Tj/0wte+w1TCjpXnz5q2+aanRMwr/0LXfipDWib1c6CTrKuN
RqilX21otep9e1pgxOFio5lJcGuS5ihTuso9RaFzlcQw6ArV/2Gay7D1E9Fq05uV
JpaqRDSjYKluP0NaToH/vCZXl16odcDTVSDXUcNtBb1IegKpq//Xoppd2ie9RE8w
tfmlJkkDId5UsXNxWxBInQd/33YZ2rnHsRB/Mc3Damt/W5QVAs5AJRT/KgyCLXuq
zJ9MBbuLWVrM9M0Oyz3TJiZnJBp48WW2rvrTQxmu+O56Fs/nzJ71hGCeO5PB68mw
Fh0W66zEA8SFBXyXNM3iWjPKWE/cARiJlkYPq4J2gHy5VHxq4yG8SCb5m2SrVElb
1JtJBS6pFJ6nyhz3/DnZ
=fjW2
-----END PGP SIGNATURE-----

--=-jHwWR1jg+yc3E6VR02bu--

