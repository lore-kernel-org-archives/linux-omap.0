From: "Curran, Dominic" <dcurran@ti.com>
Subject: RE: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
Date: Tue, 17 Feb 2009 08:27:07 -0600
Message-ID: <96DA7A230D3B2F42BA3EF203A7A1B3B5012AB15CC9@dlee07.ent.ti.com>
References: <499A7133.4050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34563 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbZBQO1Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 09:27:16 -0500
In-Reply-To: <499A7133.4050803@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>



> -----Original Message-----
> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
> Sent: Tuesday, February 17, 2009 2:12 AM
> To: Curran, Dominic
> Cc: linux-omap; Aguirre Rodriguez, Sergio Alberto
> Subject: Re: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
>
> Dominic Curran said the following on 02/17/2009 02:15 AM:
> > From: Dominic Curran <dcurran@ti.com>
> > Subject: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
> >
> > This patch changes the method of testing for TWL4030 in the sensor portion
> of the
> > board file.
> > Previously, if TWL4030 was not built into kernel then the build would be
> stopped
> > by code in the board file simular to:
> >  #ifndef CONFIG_TWL4030_CORE
> >  #error "no power companion board defined!"
> >  #endif
> >
> > However for debugging purposes it maybe required to build without TWL4030.
> > Therefore this patch allows the kernel to be compiled without a build error
> when
> > TWL4030 is not present.
> > In such a case the sensor power function will build, but when called
> immediately
> > return a -ENODEV error (so initilization of sensor will go no further).
> >
> > This change is targeted at all camera sensors within the board files for
> SDP,
> > Zoom1 & Zoom2.
> >
> > Alternative fixes to this problem like changes to Kconfig were considered,
> but
> > rejected as inappropriate solutions.
> >
> >
> Would a solution as follows be appropriate?
> in arch/arm/mach-omap2/Kconfig:
>  config MACH_OMAP_ZOOM2
>            bool "OMAP3 ZOOM2 board"
>            depends on ARCH_OMAP3 && ARCH_OMAP34XX
> +        select TWL4030_CORE if VIDEO_OMAP3
>
> A similar strategy has been implemented for N800, albeit for other
> peripherals.
> Regards,
> Nishanth Menon

If 'reverse dependencies' set the symbol and its dependencies I would say this would be a good solution, but unfortunately it does not.
The documentation for reverse dependencies warns:

 107         select should be used with care. select will force
 108         a symbol to a value without visiting the dependencies.
 109         By abusing select you are able to select a symbol FOO even
 110         if FOO depends on BAR that is not set.
 111         In general use select only for non-visible symbols

Since TWL4030 has dependencies then I don't think this is appropriate.

