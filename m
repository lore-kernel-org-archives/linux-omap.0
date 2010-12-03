From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v7] OMAP2+: PM: omap device: API's for handling
 mstandby mode
Date: Fri, 3 Dec 2010 15:17:47 +0530
Message-ID: <20101203092514.GA10048@GLPP-machine>
References: <1291298392-28729-1-git-send-email-manjugk@ti.com>
 <4CF8AC8B.9040800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:42005 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932303Ab0LCJrW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 04:47:22 -0500
Received: by gyd12 with SMTP id 12so4938156gyd.34
        for <linux-omap@vger.kernel.org>; Fri, 03 Dec 2010 01:47:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CF8AC8B.9040800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Cousson, Benoit <b-cousson@ti.com> [2010-12-03 09:38:35 +0100]:

> On 12/2/2010 2:59 PM, G, Manjunath Kondaiah wrote:
> >Certain errata in OMAP2+ processors will require forcing
> >master standby to "no standby" mode before completing on going
> >operation. Without this, the results will be unpredictable.
> >
> >Since current implementation of PM run time framework does not support
> >changing sysconfig settings during middle of the on going operation,
> >these API's will support the same. One API will force the device's
> >sysconfig mstandby mode settings to "no standby" and other API will
> >release "no standby" mode and sets it to "smart standby" or "no
> >standby? depending on HWMOD_SWSUP_MSTANDBY value.
> >
> >The hwmod API "omap_hwmod_set_master_standbymode" will use
> >no_stdby_cnt(introduced in omap_hwmod structure) for controlling
> >access to sysconfig register settings in case of overlapping
> >request/release API's are called. It also disables interrupts during
> >syconfig register access.
> >
> >These API's should be used by device drivers only incase of
> >erratum applicable to their modules if there is no other methods
> >to resolve.
> >
> >These API's are required for multiple DMA errata which require
> >putting DMA controller in no mstandby mode before stopping dma.
> >
> >The applicable errata:
> >1. Erratum ID: i557(Applicable for omap36xx all ES versions)
> >The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared
> >through config port while in Standby.
> >
> >2. Erratum ID: i541
> >sDMA FIFO draining does not finish. Applicable to all omap2+ except
> >omap4.
> >
> >3. Erratum ID:i88
> >The sDMA to be put in no mstandby mode before disabling the channel
> >after completing the data transfer operation.
> >Applicable only for OMAP3430 ES1.0
> >
> >Also fixes typo HWMOD_SWSUP_MSTDBY to HWMOD_SWSUP_MSTANDBY in
> >omap_hwmod.h
> >
> >Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> >Cc: Kevin Hilman<khilman@deeprootsystems.com>
> >Cc: Paul Walmsley<paul@pwsan.com>
> >Cc: linux-arm-kernel@lists.infradead.org
> 
> You have to CC lakml during send-email, but it should not be in the
> changelog.
> 
> On the other hand, it is a good practice to add all the authors of
> the file you change in CC.
> 
> >---
> >v3: Review comments incorporated for:
> >https://patchwork.kernel.org/patch/282212/
> >
> >v4: added mutex changes
> >https://patchwork.kernel.org/patch/338611/
> >
> >v5: typo fixes for errata and erratum
> >https://patchwork.kernel.org/patch/352481/
> >
> >v6: fixed oh increment bug and also mutex(missing in v5)
> >https://patchwork.kernel.org/patch/372231/
> >
> >v7: replaced mutex lock with spin lock. Added use count for controlling
> >access to sysconfig registers in case if overlapping request/release API's
> >are used.
> 
> I'm not sure it should be done here. I'd rather keep that code in
> the DMA, since this is the only user of that feature.

Are you referring to spin lock or usage count? 

-Manjunath


