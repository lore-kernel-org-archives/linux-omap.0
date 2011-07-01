From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 2/9] PRCM: Add support for PAD wakeup interrupts
Date: Fri, 01 Jul 2011 15:03:59 -0700
Message-ID: <8762nlu08g.fsf@ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
	<1309338303-2086-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:39633 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755520Ab1GAWEG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 18:04:06 -0400
Received: by mail-iy0-f171.google.com with SMTP id 12so4194740iyi.2
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 15:04:04 -0700 (PDT)
In-Reply-To: <1309338303-2086-3-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 29 Jun 2011 12:04:56 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> PRCM interrupt handler will now parse registered pads to see whether there
> is an active wakeup event. If there is a pending wakeup event, the registered
> ISR will be called.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This patch adds a new, duplicate mapping of pad-to-IRQ which is already
contained in each omap_hwmod.  See my comments on the v3 version of this
patch[1] which describes how I think this should be handled.

Kevin

[1] http://marc.info/?l=linux-omap&m=130895127714616&w=2
