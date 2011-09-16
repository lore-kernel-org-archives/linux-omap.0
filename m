From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 24/25] OMAP4: cpuidle: Switch to gptimer from twd in deeper C-states.
Date: Fri, 16 Sep 2011 10:51:23 -0700
Message-ID: <878vpope90.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-25-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43892 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754958Ab1IPRv2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 13:51:28 -0400
Received: by mail-yw0-f43.google.com with SMTP id 21so3980505ywm.2
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 10:51:27 -0700 (PDT)
In-Reply-To: <1315144466-9395-25-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sun, 4 Sep 2011 19:24:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> CPU local timer(TWD) stops when the CPU is transitioning into
> deeper C-States. Since these timers are not wakeup capable, we
> need the wakeup capable global timer to program the wakeup time
> depending on the next timer expiry.
>
> It can be handled by registering a global wakeup capable timer along
> with local timers marked with (mis)feature flag CLOCK_EVT_FEAT_C3STOP.

nit: this comment makes is sound like this patch adds the registration
of this timer, when all this patch does is add the notification.

Changelog should be updated to make it clear that the global timer exists
already, and is already marked with the C3STOP flag.

> Then notify the clock events layer from idle code using
> CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT).
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Other than that

Acked-by: Kevin Hilman <khilman@ti.com>

