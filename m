From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/5] ARM: OMAP4: Add L2 Cache Controller in Device Tree
Date: Tue, 21 Aug 2012 13:29:59 +0300
Message-ID: <20120821102958.GN10347@arwen.pp.htv.fi>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
 <1344855623-14879-5-git-send-email-santosh.shilimkar@ti.com>
 <503240EF.4050805@ti.com>
 <CAMQu2gxgSasF4mmEFiZq-gsZfQwYn07DKyVGBVPWqjYkTSTu6g@mail.gmail.com>
 <CAMQu2gyL4-j9QSKMpNi5QQFsLqex8Q=bW9uNQtsewXVyrTumOQ@mail.gmail.com>
 <20120821102455.GM10347@arwen.pp.htv.fi>
 <CAMQu2gy46sVEBH0hvaXrwOLMfcKH+fwyExFmwzAPzxQKoYwhhA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yAzUYvkKIfeS0jQX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:59482 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755276Ab2HUKd6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 06:33:58 -0400
Received: by lagy9 with SMTP id y9so3802859lag.19
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 03:33:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMQu2gy46sVEBH0hvaXrwOLMfcKH+fwyExFmwzAPzxQKoYwhhA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com


--yAzUYvkKIfeS0jQX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 04:02:38PM +0530, Shilimkar, Santosh wrote:
> On Tue, Aug 21, 2012 at 3:54 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Tue, Aug 21, 2012 at 03:11:51PM +0530, Shilimkar, Santosh wrote:
> >> On Mon, Aug 20, 2012 at 9:21 PM, Shilimkar, Santosh
> >> <santosh.shilimkar@ti.com> wrote:
> >> > On Mon, Aug 20, 2012 at 7:21 PM, Benoit Cousson <b-cousson@ti.com> w=
rote:
> >> >> Hi Santosh,
> >> >>
> >> >> On 08/13/2012 01:00 PM, Santosh Shilimkar wrote:
> >> >>> This provides PL310 Level 2 Cache Controller Device Tree
> >> >>> support for OMAP4 based devices.
> >> >>>
> >> >>> Cc: Benoit Cousson <b-cousson@ti.com>
> >> >>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> >>> ---
> >> >>>  arch/arm/boot/dts/omap4.dtsi       |    7 +++++++
> >> >>>  arch/arm/mach-omap2/omap4-common.c |    6 +++++-
> >> >>>  2 files changed, 12 insertions(+), 1 deletion(-)
> >> >>>
> >> >>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap=
4.dtsi
> >> >>> index 6717c71..cf1efb6 100644
> >> >>> --- a/arch/arm/boot/dts/omap4.dtsi
> >> >>> +++ b/arch/arm/boot/dts/omap4.dtsi
> >> >>> @@ -36,6 +36,13 @@
> >> >>>               };
> >> >>>       };
> >> >>>
> >> >>
> >> >>> +     L2: l2-cache-controller {
> >> >>
> >> >> The reg offset is missing: l2-cache-controller@48242000
> >> >>
> >> >>> +             compatible =3D "arm,pl310-cache";
> >> >>> +             reg =3D <0x48242000 0x1000>;
> >> >>> +             cache-unified;
> >> >>> +             cache-level =3D <2>;
> >> >>> +     };
> >> >>> +
> >> >>
> >> >> In theory, the L2 cache should be referenced from the CPUs.
> >> >>
> >> > Agree.
> >> >
> >> I have added the reference for the L2 controller in CPUs.
> >> Other information like L1 cache size etc can be added in cpu
> >> DT node with another patch.
> >>
> >> Updated patch below. Have also updated git branch
> >> accordingly.
> >>
> >> Regards
> >> Santosh
> >>
> >> From 91d6cb4f999061c8cfc844a3916ee3384f2e488a Mon Sep 17 00:00:00 2001
> >> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> Date: Wed, 4 Jul 2012 17:57:34 +0530
> >> Subject: [PATCH 1/2 v2] ARM: OMAP4: Add L2 Cache Controller in Device =
Tree
> >>
> >> This provides PL310 Level 2 Cache Controller Device Tree
> >> support for OMAP4 based devices.
> >>
> >> Cc: Benoit Cousson <b-cousson@ti.com>
> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >
> > nice work :-)
> >
> > FWIW this looks good to me:
> >
> > Acked-by: Felipe Balbi <balbi@ti.com>
> >
> Thanks.
>=20
> > just one thing, will a similar patch for omap3 be sent ?
> >
> OMAP3 has an integrated L2 cache controller so there
> won't any additional DT node for L2.
>=20
> OMAP3 CPU DT node can be updated with l1/l2 cache
> size etc related information though.

fair enough, thanks for the info.

--=20
balbi

--yAzUYvkKIfeS0jQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM2MmAAoJEIaOsuA1yqREYZIP/iRIJ6e+BCwny1iu2v5miTbs
kgT4gZo7RzFyXCYEvYs8KKz23L6mburvyXCFdg58eyijpWHeFx3ZMTzuTFS7tTO7
t73kn05Pn3SAB6kIq25q6BMGkQ4dO4+uc62Gwu0+hdq7EWhdFB93cSEw/ZSg0aw5
w7SM61Sbp3N2Id3AyS56PLcZVM/M9lcf4/HvDuiYlNkIfGaeuQBam6KKv0Pdhan8
gz35xcBbHS6lpaTHg4RXSAgNZJWHLYcuzqJTib7WzWhDU9c5L95EKmUG76V02EF/
HGB92JNi5hZ53rP8GDN/svtIh9BkSSYl55APyvNubvYg5/rcPnuWo7kdgVZL4EMF
ep1BRNVi2ocvYPRpDaupDTHPwkncRffMqNexH7pDzZFDUDD4df5r4bfhxHwT8SLD
Jn/XeZH9Wg2iBx88vMRB067qkpDqiFW6xBrk25SWzTO/LajgDaE1u6xCLF24Z7+2
mRzYswXkrNx2kmACdfaMNm8uUoQXoUaWUzqbY4/tu/ctIh1uT7BykYDrCS2BPybH
+Qm2f6P0gw1RWGykApzilXt8Mh9dCqCA5YF46KrDGS1TbXb3JY1d36EdLkohDSsE
XLw5UH4C0AoZQDhWmGRVbVzebLk0xK7qkvCdznyJ3niYF0JfqveIC7XNnDnbBfI7
o4dIyGGUXu/uLud24v7/
=syfp
-----END PGP SIGNATURE-----

--yAzUYvkKIfeS0jQX--
