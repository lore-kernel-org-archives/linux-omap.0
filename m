From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] mfd: twl6030: Disable IRQ during suspend
Date: Tue, 27 Sep 2011 10:45:40 +0530
Message-ID: <4E815BFC.9090203@ti.com>
References: <1317080664-28096-1-git-send-email-toddpoynor@google.com> <1317080664-28096-2-git-send-email-toddpoynor@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:49500 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752582Ab1I0FPp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 01:15:45 -0400
Received: by mail-yi0-f41.google.com with SMTP id 25so6625063yia.14
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 22:15:44 -0700 (PDT)
In-Reply-To: <1317080664-28096-2-git-send-email-toddpoynor@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org

On Tuesday 27 September 2011 05:14 AM, Todd Poynor wrote:
> Module IRQs may still be disabled by DPM at the time the TWL6030
> ISR runs, causing handle_simple_irq() to silently do nothing.
> This may result in missing TWL RTC alarm wakeups, for example,
> since the RTC child module ISR is not called to ack the IRQ.
> 
> Disable the TWL6030 IRQ during suspend, enable it at DPM resume
> time, at which time the child module IRQs will be re-enabled.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	

Regards
Santosh
