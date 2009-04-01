From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] ARM: OMAP3: Fix secure sram saving
Date: Tue, 31 Mar 2009 17:23:16 -0700
Message-ID: <87y6ulrzm3.fsf@deeprootsystems.com>
References: <1238075941-24931-1-git-send-email-kalle.jokiniemi@digia.com>
	<1238075941-24931-2-git-send-email-kalle.jokiniemi@digia.com>
	<1238075941-24931-3-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:13386 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765919AbZDAAXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 20:23:20 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3292909rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 17:23:19 -0700 (PDT)
In-Reply-To: <1238075941-24931-3-git-send-email-kalle.jokiniemi@digia.com> (Kalle Jokiniemi's message of "Thu\, 26 Mar 2009 15\:59\:00 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>

Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:

> The secure sram context save uses dma channels 0 and 1.
> In order to avoid collision between kernel DMA transfers and
> ROM code dma transfers, we need to reserve DMA channels 0
> 1 on high security devices.
>
> A bug in ROM code leaves dma irq status bits uncleared.
> Hence those irq status bits need to be cleared when restoring
> DMA context after off mode.
>
> There was also a faulty parameter given to PPA in the secure
> ram context save assembly code, which caused interrupts to
> be enabled during secure ram context save. This caused the
> save to fail sometimes, which resulted the saved context
> to be corrupted, but also left DMA channels in secure mode.
> The secure mode DMA channels caused "DMA secure error with
> device 0" errors to be displayed.
>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Thanks, pushing after fixing this minor checkpatch warning:

WARNING: braces {} are not necessary for single statement blocks
#82: FILE: arch/arm/plat-omap/dma.c:2337:
+	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP)) {
+		dma_write(0x3 , IRQSTATUS_L0);
+	}

Kevin

