From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
Date: Tue, 17 Feb 2009 11:20:24 -0600
Message-ID: <A24693684029E5489D1D202277BE894420A15F44@dlee02.ent.ti.com>
References: <782515bb0902170852j5c2c75f9hdb9186fc3ad1422f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48165 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbZBQRUd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 12:20:33 -0500
In-Reply-To: <782515bb0902170852j5c2c75f9hdb9186fc3ad1422f@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Curran, Dominic" <dcurran@ti.com>, linux-omap <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
> Sent: Tuesday, February 17, 2009 10:53 AM
> To: Aguirre Rodriguez, Sergio Alberto
> Cc: Curran, Dominic; linux-omap
> Subject: Re: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
> 
> On Tue, Feb 17, 2009 at 6:02 PM, Aguirre Rodriguez, Sergio Alberto
> <saaguirre@ti.com> wrote:
> >> -----Original Message-----
> >> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
> >> Sent: Tuesday, February 17, 2009 9:33 AM
> >> To: Curran, Dominic
> >> Cc: linux-omap; Aguirre Rodriguez, Sergio Alberto
> >> Subject: Re: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
> >>
> >> Curran, Dominic said the following on 02/17/2009 04:27 PM:
> >> >> -----Original Message-----
> >> >> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
> >> >> Sent: Tuesday, February 17, 2009 2:12 AM
> >> >> To: Curran, Dominic
> >> >> Cc: linux-omap; Aguirre Rodriguez, Sergio Alberto
> >> >> Subject: Re: [OMAPZOOM][PATCH] Testing for TWL4030 in board file
> change.
> >> >>
> >> >> Would a solution as follows be appropriate?
> >> >> in arch/arm/mach-omap2/Kconfig:
> >> >>  config MACH_OMAP_ZOOM2
> >> >>            bool "OMAP3 ZOOM2 board"
> >> >>            depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >> >> +        select TWL4030_CORE if VIDEO_OMAP3
> >> >>
> >> >> A similar strategy has been implemented for N800, albeit for other
> >> >> peripherals.
> >> >>
> >> >
> >> > If 'reverse dependencies' set the symbol and its dependencies I would
> >> say this would be a good solution, but unfortunately it does not.
> >> > The documentation for reverse dependencies warns:
> >> >
> >> >  107         select should be used with care. select will force
> >> >  108         a symbol to a value without visiting the dependencies.
> >> >  109         By abusing select you are able to select a symbol FOO
> even
> >> >  110         if FOO depends on BAR that is not set.
> >> >  111         In general use select only for non-visible symbols
> >> >
> >> > Since TWL4030 has dependencies then I don't think this is appropriate
> >> Mach-omap && video_omap3 depends on twl4030 and twl4030 is not reverse
> >> dependent on mach-omap. twl4030 is dependent on i2c - I believe based
> on
> >> drivers/mfd/Kconfig how do we handle this? Maybe a select of i2c is
> >> appropriate there? or how about:
> >>
> >> +        select TWL4030_CORE if VIDEO_OMAP3
> >> +        select  I2C if TWL4030_CORE
> >>
> >>
> >> You may want to see arch/arm/mach-omap2/Kconfig -> MACH_NOKIA_N800. I
> >> think we have a similar condition there with CBUS and VIDEO_TCM825X I
> >> think..
> >
> > Honestly, I'm a bit lost about the goal of this. I don't see how this is
> solving our problem.
> >
> >
> > How is above helping for solving this out?
> config MACH_OMAP_ZOOM2
>             bool "OMAP3 ZOOM2 board"
>             depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  +        select TWL4030_CORE if VIDEO_OMAP3
> > - 3430SDP and Zoom1/2 uses TWL4030 for power handling the camera sensors
> We say that on zoom2 configuration, if video_omap3 is enabled == use
> any camera, we need twl4030 -> for power etc (if you like you can add
> a # comment ;) )..
> 
> > - Current Omap3 camera driver can be used in other platforms than the
> above that uses OMAP3x30 chip, so we cannot add dependencies on camera
> driver to platform specific powering methods.
> the above method i proposed has no dependency on specific camera ->
> the dependency is based on MACH_OMAP_ZOOM2 -> on other platforms,
> handle them accordingly -> esp if you have a different (power
> management)PM Chip or even no PM chip :)..
> > - On above platforms, there exists the need for compiling without T2
> support  sometimes and you don't want a broken build because of this
> you wont.. if you want to build without t2, you need to disable all
> drivers which depend on T2 -> including camera. this also avoids a
> unnecessary probe call since it wont even be built in..


Ok, now I'm convinced this would do the job. Sorry for having trouble understanding your idea.

Thanks for clarifying!

So Dom,

Then shall we add to MACH_OMAP_3430SDP, MACH_OMAP_LDP and MACH_OMAP_ZOOM2 these selects?:

        select TWL4030_CORE if VIDEO_OMAP3
        select  I2C if TWL4030_CORE

And get rid entirely of ifdefs for TWL4030.

> 
> Regards,
> Nishanth Menon

