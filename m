From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] rwsem generic spinlock: use IRQ save/restore spinlocks
Date: Wed, 05 May 2010 16:59:51 -0700
Message-ID: <87vdb1x5l4.fsf@deeprootsystems.com>
References: <1270749350-25152-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62432 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab0EEX74 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 19:59:56 -0400
Received: by vws12 with SMTP id 12so1531213vws.19
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 16:59:55 -0700 (PDT)
In-Reply-To: <1270749350-25152-1-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Thu\,  8 Apr 2010 10\:55\:50 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> rwsems can be used with IRQs disabled, particularily in early boot
> before IRQs are enabled.  Currently the spin_unlock_irq() usage in the
> slow-path will unconditionally enable interrupts and cause problems
> early in boot where interrupts are not yet initialized or enabled.
>
> This patch uses save/restore versions of IRQ spinlocks in the slowpath
> to ensure interrupts are not unintentionally enabled in the case where
> the rwsem is used with IRQs disabled.
>
> Idea for this fix suggested by H. Peter Anvin.
>
> Tested on TI OMAP3-based platform (ARM Cortex-A8)
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Cc: H. Peter Anvin <hpa@zytor.com>
> LKML-Reference: <alpine.LFD.2.00.1004010904540.3707@i5.linux-foundation.org>
> Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>

For the benefit of the l-o archives...

This patch was merged into mainline in .34-rc6 and fixes potential
deadlocks on boot, seen especially when using the SLUB allocator.

Kevin
