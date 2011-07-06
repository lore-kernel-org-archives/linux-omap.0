From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 19/20] GPIO: OMAP: optimize suspend and resume functions
Date: Wed, 06 Jul 2011 13:54:50 -0700
Message-ID: <87d3hnf7tx.fsf@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
	<1309513634-20971-20-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:54702 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756094Ab1GFUyy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 16:54:54 -0400
Received: by mail-iy0-f177.google.com with SMTP id 15so352222iyn.36
        for <linux-omap@vger.kernel.org>; Wed, 06 Jul 2011 13:54:54 -0700 (PDT)
In-Reply-To: <1309513634-20971-20-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Fri, 1 Jul 2011 15:17:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> There is no need to operate on all the banks every time the function is called.
> Just operate on the current bank passed by the framework.

That's a good change.

There is also no need to runtime suspend/resume the bank if
bank->suspend_wakeup == 0 during suspend (or bank->saved_wakeup == 0
during resume.)

IOW, banks with no wakeups enabled have an unnecessary runtime
resume/suspend in both the system suspend and resume path.

Kevin
