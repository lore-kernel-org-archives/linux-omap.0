From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/3] omap: gpmc-nand: add ability to keep timings
 defined by the bootloader
Date: Mon, 3 May 2010 14:16:29 -0700
Message-ID: <20100503211628.GZ29604@atomide.com>
References: <cover.1272530653.git.mike@compulab.co.il>
 <f20c8d0dc1c81a0cc5a334d03c9c7dc73046293d.1272530653.git.mike@compulab.co.il>
 <20100503182426.GX29604@atomide.com>
 <z2mf870da181005031332w8b8fd1d9vc19af82b4b3fccbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61244 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab0ECVQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 17:16:31 -0400
Content-Disposition: inline
In-Reply-To: <z2mf870da181005031332w8b8fd1d9vc19af82b4b3fccbe@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike.rapoport@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, vimal.newwork@gmail.com, s-ghorai@ti.com

* Mike Rapoport <mike.rapoport@gmail.com> [100503 13:28]:
> On Mon, May 3, 2010 at 9:24 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> > * Mike Rapoport <mike@compulab.co.il> [100429 01:44]:
> >> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> >
> > Please add a proper description to all the patches.
> >
> >> --- a/arch/arm/mach-omap2/gpmc-nand.c
> >> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> >> @@ -116,6 +124,11 @@ int __init gpmc_nand_init(struct omap_nand_pl=
atform_data *_nand_data)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;
> >> =C2=A0 =C2=A0 =C2=A0 }
> >>
> >> + =C2=A0 =C2=A0 if (gpmc_nand_data->keep_timings) {
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpmc_cs_get_timings(gp=
mc_nand_data->cs, &gpmc_default_timings);
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpmc_nand_data->gpmc_t=
 =3D &gpmc_default_timings;
> >> + =C2=A0 =C2=A0 }
> >> +
> >> =C2=A0 =C2=A0 =C2=A0 err =3D gpmc_nand_setup();
> >> =C2=A0 =C2=A0 =C2=A0 if (err < 0) {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "NAN=
D platform setup failed: %d\n", err);
> >
> > Hmm, so you're setting the timings based on the bootloader values?
> >
> > I' think the problem with that is that chances are that it still wo=
n't
> > work for other L3 frequencies because of rounding errors.
> >
> > With gpmc_cs_get_timings() you're already using tick rounded timing=
s,
> > so you won't get the required accuracy out of those for the other
> > L3 frequencies.
>=20
> Agree. But even if the timings are in nanoseconds there are rounding
> errors, and there are still chances that L3 frequency change will
> break NAND
> So it comes down to what provides better tolerance, the explicit NAND
> timings in nanosecs or (rounded) timings in ticks derived from
> bootloader settings...

My experience is that you can get the nanosec timings from the device
datasheet(s) and that just should work for any L3 frequency. My
experience is also that trying to do it the other way around won't work
because of rounding errors. Trying to produce nanosecond values out
of the tick values just is not accurate enough.

That's why gpmc-onenand.c and usb-tusb6010.c timings are done the way
they are, and they're known to work at various L3 frequencies.

> > So maybe just not do anything, and print a warning on gpmc L3 chang=
es
> > if the timings are not set?
>=20
> I don't quite understand where exactly this warning should go. I
> haven't found any treatment of L3 frequency changes in gpmc related
> code neither in linux-omap nor in linux-omap-pm...

Ah, right. There's currently nothing doing that.. That would have to
be done based on cpufreq notifiers (or clock notifiers). But we don't
have any of that at least in the mainline yet. Hmm I don't even think
we currently scale the L3 for cpufreq.. Right now the best way to test
would be by booting at different L3 frequencies.

Anyways, my point is that setting gpmc_default_timings based on the
bootloader after doing the gpmc_cs_get_timings is most likely unsafe
for other L3 frequencies.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
