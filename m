From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2] omap4: Fix multi-omap boot with reset un-used clocks
Date: Thu, 20 May 2010 10:28:35 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C56668CC@dbde02.ent.ti.com>
References: <1274287087-4049-1-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1005191708320.27473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59911 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756Ab0ETE6k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 00:58:40 -0400
In-Reply-To: <alpine.DEB.2.00.1005191708320.27473@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, May 20, 2010 4:41 AM
> To: Shilimkar, Santosh; Menon, Nishanth
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v2] omap4: Fix multi-omap boot with reset un-used clocks
> 
> Hi,
> 
> On Wed, 19 May 2010, Santosh Shilimkar wrote:
> 
> > This patch uses "ENABLE_ON_INIT" flag on the emif clock nodes
> > to avoid the emif clk getting cut as part of reset un-used clock
> > routine which prevents boot.
> >
> > Since omap4 "omap2_clk_init()" calls "clk_enable_init_clocks()"
> > which increases the usecount on all ENABLE_ON_INIT clocks, it
> > prevents "omap2_clk_disable_unused()" from disabling the clock.
> >
> > The real fix is to have driver for EMIF and do clock get/enable
> > as part of it. The EMIF driver is planned to be done HWMOD way
> > so till that available to keep omap3_defconfig booting on OMAP4430,
> > this patch is necessary.
> > (Will updated the auto-gen script for 44xx accordingly)
> >
> > The fix was suggested by Paul Walmsley
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> 
> Thanks, I've added Nishanth's Tested-by: and fixed the patch changelog;
> the following patch is now queued for 2.6.35-rc, unless there are any
> further comments.
> 
Thanks Paul.

Regards,
Santosh
