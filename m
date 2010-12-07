From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v1 0/9] OMAP: DMA: hwmod and DMA as platform device
Date: Tue, 7 Dec 2010 16:34:05 +0530
Message-ID: <20101207110405.GB1754@GLPP-machine>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57473 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755393Ab0LGLDc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 06:03:32 -0500
Received: by gya6 with SMTP id 6so1328984gya.11
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 03:03:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291434246-30716-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Tony,

* G, Manjunath Kondaiah <manjugk@ti.com> [2010-12-04 09:13:57 +0530]:

> Patch series to convert DMA library into platform driver using platform
> device model and adapting hwmod for omap2+.
> 
> The original patch series :
> http://comments.gmane.org/gmane.linux.ports.arm.omap/46953
> has been split into two patch series based on suggestion from Tony.
> (https://patchwork.kernel.org/patch/375831/)
> 
> The first series will prepare existing DMA library for DMA hwmod and 
> converting the same into platform driver.
> 
> The second series will have:
> arch/arm/mach-omap1/dma.c       omap1 specific platform init
> arch/arm/mach-omap2/dma.c       omap2+ specific platform init
> drivers/dma/omap-dma.c          driver using dmaengine.c
> 
> Patch series1 Design:
> 1. The low level read/write macros are converted into static inline functions
> so that, these functions can be moved to respective mach-omap driver
> files later.
> (Thanks to Tony and Kevin for their suggestions on handling all omap register
> offset without adding extra enums)
> 2. Implements generic errata handling for all OMAP DMA errata.
> 3. DMA hwmod data is updated for respective hwmod db files.
> 4. The DMA library is split into two layers.
>    a. The generic code is retained in plat-omap/dma.c
>    b. The machine specific init code is moved to
>       respective mach-omap dma files.
> 
> Minimal machine specific code is moved to respective mach-omap dma files with 
> this series. Rest of code movement and API cleanup's are handled in second
> series.
> 
> Patch series applies on top of latest linux omap master branch:
> *************************************************************************
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> Branch: master
> commit a04fd22204b13ce34a3f8a8157f83c44d64f8da9
> Merge: e941bb0 afd2d11
> Author: Tony Lindgren <tony@atomide.com>
> 
>     Linux-omap rebuilt: Merged in usb patches for testing
> *************************************************************************

If there are no further issues, can you pls merge this series for
testing. I can send pull request if it is convinient.

As per the alignment with original series(v5), all the fixes done for
OMAP1 are pulled into this patch series. OMAP1 and OMAP2+ will build and
boots with published test reports.

-Manjunath
