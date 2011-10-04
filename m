From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/2] mfd: twl6030: fix lockdep recursion warning on
 setting wake IRQs
Date: Tue, 4 Oct 2011 11:56:53 +0200
Message-ID: <20111004095653.GT4118@sortiz-mobl>
References: <1317080664-28096-1-git-send-email-toddpoynor@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14828 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755486Ab1JDJxw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Oct 2011 05:53:52 -0400
Content-Disposition: inline
In-Reply-To: <1317080664-28096-1-git-send-email-toddpoynor@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Todd,

On Mon, Sep 26, 2011 at 04:44:23PM -0700, Todd Poynor wrote:
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
Thanks for that, I applied this patch.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
