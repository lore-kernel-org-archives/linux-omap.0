From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 7/9] OMAP: hwmod: enable / disable pad wakeups for a module dynamically
Date: Fri, 01 Jul 2011 15:18:17 -0700
Message-ID: <87mxgxsl06.fsf@ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
	<1309338303-2086-8-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:36492 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756640Ab1GAWSV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 18:18:21 -0400
Received: by mail-pz0-f52.google.com with SMTP id 13so4615081pzd.11
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 15:18:20 -0700 (PDT)
In-Reply-To: <1309338303-2086-8-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 29 Jun 2011 12:05:01 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Tero Kristo <t-kristo@ti.com> writes:

> PRCM chain interrupt registration is done now as part of
> omap_hwmod_enable_wakeup() and omap_hwmod_disable_wakeup() calls. This
> allows module ISR:s to be called when the module is idle but an IO_PAD
> event is detected on the module input pads.

These functions are the enable/disable for module-level wakeups, you
need to use the proposed enable/disable functions for IO ring wakeups as
proposed in the patch from Govindraj[1].

I'm hoping that patch will be queued for v3.1, but will wait for Paul's
comments on that patch.

Kevin
