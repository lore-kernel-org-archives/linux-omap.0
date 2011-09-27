From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] mfd: twl6030: fix lockdep recursion warning on setting
 wake IRQs
Date: Tue, 27 Sep 2011 10:44:48 +0530
Message-ID: <4E815BC8.3060206@ti.com>
References: <1317080664-28096-1-git-send-email-toddpoynor@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46683 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751861Ab1I0FOy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 01:14:54 -0400
Received: by mail-yi0-f50.google.com with SMTP id 25so6900908yib.37
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 22:14:53 -0700 (PDT)
In-Reply-To: <1317080664-28096-1-git-send-email-toddpoynor@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org

On Tuesday 27 September 2011 05:14 AM, Todd Poynor wrote:
> LOCKDEP explicitly sets all irq_desc locks as a single lock-class,
> causing "possible recursive locking detected" when the TWL RTC
> driver calls through enable_irq_wake to twl6030_irq_set_wake,
> which recursively calls irq_set_irq_wake.  Although the
> irq_desc and lock are different, LOCKDEP treats these as
> equivalent, presumably due to problems that can be incurred
> when locking more than one irq_desc, so best to avoid this.
> 
> Suspend/resume actions implemented as PM notifiers to avoid
> touch the TWL core for this.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
> 
> This patch applies on top of the patch from Santosh:
> [PATCH] mfd: twl6030: Setup irq_wake infrastructure.
> 
> If PM notifiers aren't preferred then could change
> twl-core to add suspend/resume callbacks, was trying to
> make a lower-impact change.
> 
> This complexity assumes there are systems that include twl6030
> and don't want its IRQs to act as wakeup.  Alternatively,
> could just always enable wake for twl6030's IRQ.
> 
Both options would mostly end up with same lines
of code :)
The patch looks good to me .
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	

Regards
Santosh


