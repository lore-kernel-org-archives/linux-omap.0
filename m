From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 05/15] OMAP: GPIO: Make gpio_context part of gpio_bank
 structure
Date: Thu, 26 May 2011 15:29:37 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D178024@dbde02.ent.ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60034 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757114Ab1EZJ7s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 May 2011 05:59:48 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>


> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Thursday, May 26, 2011 3:29 PM
> To: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org
> Cc: Hilman, Kevin; Shilimkar, Santosh; tony@atomide.com; 
> linux-arm-kernel@lists.infradead.org; Varadarajan, Charulatha
> Subject: RE: [PATCH 05/15] OMAP: GPIO: Make gpio_context part 
> of gpio_bank structure
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> > DebBarma, Tarun Kanti
> > Sent: Tuesday, May 24, 2011 7:55 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Hilman, Kevin; Shilimkar, Santosh; tony@atomide.com; 
> > linux-arm-kernel@lists.infradead.org; Varadarajan, Charulatha
> > Subject: [PATCH 05/15] OMAP: GPIO: Make gpio_context part of 
> > gpio_bank structure
> > 
> > From: Charulatha V <charu@ti.com>
> > 
> > gpio_context array, which is used to save gpio bank's context,
> > is used only for OMAP3 architecture.
> > 
> > Move gpio_context as part of gpio_bank structure so that
> > it can be specific to each gpio bank and can be used for
> > any OMAP architecture
> > 
> > TODO: extend the gpio save/restore context function for OMAP4
> > architecture. This is done in one of the next patches in this
> > series
> 
> [sp] Should this TODO be part of commit?
>      BTW, this is the last patch in the series.
> 

Sorry, mistake... This showed up last on my mailbox.
~sanjeev

> ~sanjeev
> 