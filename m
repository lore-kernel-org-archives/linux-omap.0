From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v7] OMAP2+: PM: omap device: API's for handling
 mstandby mode
Date: Thu, 2 Dec 2010 19:53:30 +0530
Message-ID: <20101202142329.GA21529@GLPP-machine>
References: <1291298392-28729-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:59477 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757715Ab0LBOXE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 09:23:04 -0500
Received: by mail-yw0-f52.google.com with SMTP id 9so5650321ywf.25
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 06:23:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291298392-28729-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org


* G, Manjunath Kondaiah <manjugk@ti.com> [2010-12-02 19:29:52 +0530]:

> Certain errata in OMAP2+ processors will require forcing
> master standby to "no standby" mode before completing on going
> operation. Without this, the results will be unpredictable.
> 
> Since current implementation of PM run time framework does not support
> changing sysconfig settings during middle of the on going operation,
> these API's will support the same. One API will force the device's
> sysconfig mstandby mode settings to "no standby" and other API will
> release "no standby" mode and sets it to "smart standby" or "no
> standby? depending on HWMOD_SWSUP_MSTANDBY value.
> 
> The hwmod API "omap_hwmod_set_master_standbymode" will use
> no_stdby_cnt(introduced in omap_hwmod structure) for controlling
> access to sysconfig register settings in case of overlapping
> request/release API's are called. It also disables interrupts during
> syconfig register access.
> 
> These API's should be used by device drivers only incase of
> erratum applicable to their modules if there is no other methods
> to resolve.
> 
> These API's are required for multiple DMA errata which require
> putting DMA controller in no mstandby mode before stopping dma.
> 
> The applicable errata:
> 1. Erratum ID: i557(Applicable for omap36xx all ES versions)
> The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared
> through config port while in Standby.
> 
> 2. Erratum ID: i541
> sDMA FIFO draining does not finish. Applicable to all omap2+ except
> omap4.
> 
> 3. Erratum ID:i88
> The sDMA to be put in no mstandby mode before disabling the channel
> after completing the data transfer operation.
> Applicable only for OMAP3430 ES1.0
> 
> Also fixes typo HWMOD_SWSUP_MSTDBY to HWMOD_SWSUP_MSTANDBY in
> omap_hwmod.h
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: linux-arm-kernel@lists.infradead.org

Pls ignore this patch. I have resent this patch as:
[PATCH v7 RESEND] OMAP2+: PM: omap device: API's for handling mstandby
mode

Sorry for noise.

-Manjunath

[...]
