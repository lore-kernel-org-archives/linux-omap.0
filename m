From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH 0/5] 32k sync timer meets hwmod
Date: Thu, 21 Oct 2010 10:34:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035EBA9C07@dbde02.ent.ti.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
 <4CBF5F46.4030609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44560 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278Ab0JUFEQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 01:04:16 -0400
In-Reply-To: <4CBF5F46.4030609@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Cousson, Benoit
> Sent: Thursday, October 21, 2010 3:00 AM
> To: Balbi, Felipe
> Cc: Tony Lindgren; Linux OMAP Mailing List
> Subject: Re: [PATCH 0/5] 32k sync timer meets hwmod
> 
> Hi Felipe,
> 
> Just one minor comment about the subjects.
> 
> On 10/19/2010 11:22 AM, Felipe Balbi wrote:
> > Hi all,
> >
> > Converted 32k-sync timer to platform_driver
> > and now using pm_runtime and hwmod.
> >
> > Tested on 3430 by me and 4430 by Tarun
> >
> > If someone could test on 2430 and 2420, I would
> > be really glad.
> >
> > Felipe Balbi (5):
> >    arm: omap1/2/3/4: convert 32k-sync driver to a platform_driver
> >    arm: omap: counter-32k: convert to pm_runtime API
> >    clocksource: move omap 32k timer to drivers/clocksource
> >    arm: omap: introduce 32k timer hwmod for omap2/3/4
> >    arm: omap: 32k: move to omap_device_build
> 
> 32k-sync, counter-32k, 32k timer, and then 32k... That's a lot of
> different names for that IP :)
> 
> You should maybe stick to counter-32k and add a comment saying that the
> synctimer32k name was so bad, that we renamed it counter-32k.
I have used counter-32k name for one of the clock source names in dmtimer.
-tarun

> 
> >
> >   arch/arm/mach-omap1/devices.c              |   24 +++
> >   arch/arm/mach-omap2/clock2420_data.c       |    2 +-
> >   arch/arm/mach-omap2/clock2430_data.c       |    2 +-
> >   arch/arm/mach-omap2/clock3xxx_data.c       |    2 +-
> >   arch/arm/mach-omap2/devices.c              |   36 +++++
> >   arch/arm/mach-omap2/omap_hwmod_2420_data.c |   52 ++++++
> >   arch/arm/mach-omap2/omap_hwmod_2430_data.c |   52 ++++++
> >   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   51 ++++++
> >   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   61 ++++++++
> >   arch/arm/plat-omap/Makefile                |    2 +-
> >   arch/arm/plat-omap/counter_32k.c           |  183 --------------------
> --
> >   drivers/clocksource/Makefile               |    1 +
> >   drivers/clocksource/omap-32k.c             |  231
> ++++++++++++++++++++++++++++
> >   13 files changed, 512 insertions(+), 187 deletions(-)
> >   delete mode 100644 arch/arm/plat-omap/counter_32k.c
> >   create mode 100644 drivers/clocksource/omap-32k.c
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
