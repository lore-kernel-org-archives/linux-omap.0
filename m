From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv10 04/14] omap: prm: add support for suspend prepare and finish callbacks
Date: Fri, 09 Dec 2011 15:04:59 -0800
Message-ID: <87aa71l52c.fsf@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
	<1323440857-385-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:47556 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752249Ab1LIXFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 18:05:08 -0500
Received: by ggnv1 with SMTP id v1so7909950ggn.1
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 15:05:01 -0800 (PST)
In-Reply-To: <1323440857-385-5-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Fri, 9 Dec 2011 16:27:27 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com

Tero Kristo <t-kristo@ti.com> writes:

> These are needed because runtime PM is disabled during suspend, and
> it is bad if we get interrupts from the PRCM chain handler during it.
> This patch masks all the PRCM interrupt events, but does not ack them,
> if an interrupt is received during suspend. Once suspend->finish
> is called, all the masked events will be re-enabled, which causes
> immediate PRCM interrupt and handles the postponed event.
>
> The suspend prepare and complete  callbacks will be called from pm34xx.c /
> pm44xx.c files in the following patches.

You might just update this changelog to clarify why you're using the the
driver-specific prepare & complete terminology whereas this code is
using begin/finish hooks as part of platform_pm_ops.

IOW, state that this will soon be becoming a real driver, so you're
using the driver terminology.

Also note that subject uses prepare & finish instead of prepare & complete.

Kevin

