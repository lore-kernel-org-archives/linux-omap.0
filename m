From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Issue observed with pm_runtime_put_sync
Date: Mon, 18 Oct 2010 08:30:53 -0700
Message-ID: <87k4lfecwi.fsf@deeprootsystems.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBC61359@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:53334 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388Ab0JRPa4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 11:30:56 -0400
Received: by pxi16 with SMTP id 16so158976pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 08:30:55 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBC61359@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Mon, 18 Oct 2010 13:30:30 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Manjunath,

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> While using pm runtime API's with DMA, it was observed that, during
> omap_free_dma, pm_runtime_put_sync is called which results in warning
> dump.  It looks like, when cpu idle patch is under processing, DMA
> interrupt gets fired which inturn call omap_free_dma which results
> multiple spin_locks.
>  
> The DMA driver uses *_get_sync during omap_request_dma and *_put_sync during
> omap_free_dma.
>  
> Environment:
> Kernel:
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> Branch: master
> Commit: 99cf630 Linux-omap rebuilt: Fixed omap4 kernel panic without nosmp,
> updated to -rc7
> +
> DMA hwmod patches
>  
> defconfig: omap2plus_defconfig
> board: OMAP3630 Zoom3
>  
> Is this a known issue or issue with pm runtime API usage in DMA driver?

It's an issue in the runtime PM usage in DMA driver.

Specifically, the _sync versions of the API cannot be used from
interrupt context because they can sleep.

Are the _sync versions really needed at that point?  Without having the
code, I cannot tell, but I susupect that the async versions could be
used there instead.

If not, then the code will need to be reworked so the ISR is not doing
the actual work, but instead is scheduling work to be done later in
process context.

Kevin
