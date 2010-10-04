From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Mon, 4 Oct 2010 12:58:42 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE4D9@dbde02.ent.ti.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
 <20101001213532.1408.55832.stgit@twilight.localdomain>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3C6@dbde02.ent.ti.com>
 <20101004065624.GD2559@legolas.emea.dhcp.ti.com>
 <20101004070040.GE2559@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45882 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab0JDH2u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 03:28:50 -0400
In-Reply-To: <20101004070040.GE2559@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Balbi, Felipe
> Sent: Monday, October 04, 2010 12:31 PM
> To: Balbi, Felipe
> Cc: Shilimkar, Santosh; Paul Walmsley; linux-omap@vger.kernel.org; linux-
> arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 08/10] OMAP: split plat-omap/common.c
> 
> On Mon, Oct 04, 2010 at 01:56:24AM -0500, Balbi, Felipe wrote:
> >On Mon, Oct 04, 2010 at 12:34:48AM -0500, Shilimkar, Santosh wrote:
> >>Felipe,
> >>
> >>> -----Original Message-----
> >>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >>> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> >>> Sent: Saturday, October 02, 2010 3:06 AM
> >>> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> >>> Subject: [PATCH 08/10] OMAP: split plat-omap/common.c
> >>>
> >>> Split plat-omap/common.c into three pieces:
> >>>
> >>> 1. the 32KiHz sync timer and clocksource code, which now lives in
> >>>    plat-omap/32ksynctimer.c;
> >>>
> >>I remember you have converted the 32k sync time code to a platform
> driver.
> >>That was also addressing the multi-omap build and was removing all
> >>the compile time switches.
> >>Do you plan to rebase it and post it again ?
> >
> >I still have that sitting on my gitorious tree. The patch is attached
> >to this mail. I compile tested (only) for omap3_defconfig, it probably
> >needs to start using pm_runtime functions at some point and probably
> >move to drivers/clocksource instead of arch/arm/plat-omap.
> >
> >patch is also available at [1]
> >
> >[1] git://gitorious.org/usb/usb.git clksource
> 
> I made a few changes to make checkpatch.pl --strict happy. Attached
> 
Good !!
This patch addresses splitting as well as multi-omap builds and probably
also a better candidate in case we need to convert sync timer to hwmod
driver.

Paul, what's your take?

Regards,
Santosh

