From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3 v2] omap: pm: Move the common code to allow re-use
Date: Tue, 14 Sep 2010 13:29:52 -0700
Message-ID: <878w34m5kv.fsf@deeprootsystems.com>
References: <1284492841-14858-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626Ab0INUaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 16:30:03 -0400
Received: by pwi3 with SMTP id 3so2573977pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Sep 2010 13:30:02 -0700 (PDT)
In-Reply-To: <1284492841-14858-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Wed, 15 Sep 2010 01:03:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, b-cousson@ti.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> (v2 is rebased on Kevin's 'pm-next' branch)
>
> This is small series moves some common pm code out of pm34xx.c so
> that omap4 can re-use this and not duplicate it.
>
> It's boot tested on OMAP3/4 with omap3_defconfig and also simple
> test with millisecond debugfs entry and suspend/resume.
>
> Santosh Shilimkar (3):
>       omap: pm-debug: Move common debug code to pm-debug.c
>       omap: pm-debug: Enable wakeup_timer_milliseconds debugfs entry
>       omap: pm: Move set_pwrdm_state routine to common pm.c

Thanks, adding to my pm-next queue for 2.6.37.

Kevin
