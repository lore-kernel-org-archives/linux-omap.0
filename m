From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/2] mfd: twl6030: Disable IRQ during suspend
Date: Tue, 4 Oct 2011 11:57:31 +0200
Message-ID: <20111004095731.GU4118@sortiz-mobl>
References: <1317080664-28096-1-git-send-email-toddpoynor@google.com>
 <1317080664-28096-2-git-send-email-toddpoynor@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:35950 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755486Ab1JDJyb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Oct 2011 05:54:31 -0400
Content-Disposition: inline
In-Reply-To: <1317080664-28096-2-git-send-email-toddpoynor@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Todd,

On Mon, Sep 26, 2011 at 04:44:24PM -0700, Todd Poynor wrote:
> Module IRQs may still be disabled by DPM at the time the TWL6030
> ISR runs, causing handle_simple_irq() to silently do nothing.
> This may result in missing TWL RTC alarm wakeups, for example,
> since the RTC child module ISR is not called to ack the IRQ.
> 
> Disable the TWL6030 IRQ during suspend, enable it at DPM resume
> time, at which time the child module IRQs will be re-enabled.
Applied as well, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
