From: "Curran, Dominic" <dcurran@ti.com>
Subject: RE: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
Date: Tue, 17 Feb 2009 13:35:08 -0600
Message-ID: <96DA7A230D3B2F42BA3EF203A7A1B3B5012AB1624E@dlee07.ent.ti.com>
References: <A24693684029E5489D1D202277BE894420A15D8B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55315 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbZBQTfQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 14:35:16 -0500
In-Reply-To: <A24693684029E5489D1D202277BE894420A15D8B@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Aguirre Rodriguez, Sergio Alberto
> Sent: Tuesday, February 17, 2009 10:03 AM
> To: Nishanth Menon; Curran, Dominic
> Cc: linux-omap
> Subject: RE: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
>
>
>
> > -----Original Message-----
> > From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
> > Sent: Tuesday, February 17, 2009 9:33 AM
> > To: Curran, Dominic
> > Cc: linux-omap; Aguirre Rodriguez, Sergio Alberto
> > Subject: Re: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
> >
> > Curran, Dominic said the following on 02/17/2009 04:27 PM:
> > >> -----Original Message-----
> > >> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
> > >> Sent: Tuesday, February 17, 2009 2:12 AM
> > >> To: Curran, Dominic
> > >> Cc: linux-omap; Aguirre Rodriguez, Sergio Alberto
> > >> Subject: Re: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
> > >>
> > >> Would a solution as follows be appropriate?
> > >> in arch/arm/mach-omap2/Kconfig:
> > >>  config MACH_OMAP_ZOOM2
> > >>            bool "OMAP3 ZOOM2 board"
> > >>            depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > >> +        select TWL4030_CORE if VIDEO_OMAP3
> > >>
> > >> A similar strategy has been implemented for N800, albeit for other
> > >> peripherals.
> > >>
> > >
> > > If 'reverse dependencies' set the symbol and its dependencies I would
> > say this would be a good solution, but unfortunately it does not.
> > > The documentation for reverse dependencies warns:
> > >
> > >  107         select should be used with care. select will force
> > >  108         a symbol to a value without visiting the dependencies.
> > >  109         By abusing select you are able to select a symbol FOO even
> > >  110         if FOO depends on BAR that is not set.
> > >  111         In general use select only for non-visible symbols
> > >
> > > Since TWL4030 has dependencies then I don't think this is appropriate
> > Mach-omap && video_omap3 depends on twl4030 and twl4030 is not reverse
> > dependent on mach-omap. twl4030 is dependent on i2c - I believe based on
> > drivers/mfd/Kconfig how do we handle this? Maybe a select of i2c is
> > appropriate there? or how about:
> >
> > +        select TWL4030_CORE if VIDEO_OMAP3
> > +        select  I2C if TWL4030_CORE
> >
> >
> > You may want to see arch/arm/mach-omap2/Kconfig -> MACH_NOKIA_N800. I
> > think we have a similar condition there with CBUS and VIDEO_TCM825X I
> > think..
>
> Honestly, I'm a bit lost about the goal of this. I don't see how this is
> solving our problem.
>
> - 3430SDP and Zoom1/2 uses TWL4030 for power handling the camera sensors
> - Current Omap3 camera driver can be used in other platforms than the above
> that uses OMAP3x30 chip, so we cannot add dependencies on camera driver to
> platform specific powering methods.
> - On above platforms, there exists the need for compiling without T2 support
> sometimes and you don't want a broken build because of this
>
> How is above helping for solving this out?
>
> >
> > my 2cents: i like select better than #ifdef ;).. but then, that is just
> > me :)..
> >
> > Regards,
> > Nishanth Menon

Fyi, This didn't seem to work:

$ make menuconfig
scripts/kconfig/mconf arch/arm/Kconfig
drivers/media/Kconfig:35:error: found recursive dependency: VIDEO_V4L2_COMMON ->
VIDEO_V4L2 -> VIDEO_CAPTURE_DRIVERS -> VIDEO_OMAP3 -> TWL4030_CORE -> I2C -> VIDEO_V4L2_COMMON
make[1]: *** [menuconfig] Error 1
make: *** [menuconfig] Error 2
[gromit@gromit omapzoom04]$

Sergio told me you had discussed a different approach anyway...

