From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] AM3517: Fix suspend-resume sequence
Date: Fri, 19 Aug 2011 20:53:58 +0100
Message-ID: <20110819195358.GA18947@n2100.arm.linux.org.uk>
References: <1313754927-11992-1-git-send-email-abhilash.kv@ti.com> <1313754927-11992-2-git-send-email-abhilash.kv@ti.com> <1313754927-11992-3-git-send-email-abhilash.kv@ti.com> <1313754927-11992-4-git-send-email-abhilash.kv@ti.com> <1313754927-11992-5-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35076 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153Ab1HSTyM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Aug 2011 15:54:12 -0400
Content-Disposition: inline
In-Reply-To: <1313754927-11992-5-git-send-email-abhilash.kv@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, khilman@ti.com

On Fri, Aug 19, 2011 at 05:25:27PM +0530, Abhilash K V wrote:
> This patch fixes the crash seen while resuming with i2c devices
> enabled. This crash was happening because the interface-clocks
> were disabled in the suspend sequence, and not re-enabled on
> resumption.
> The current patch saves the value of the CM_ICLKEN1_CORE register
> before zeroing it out, and restores upon resumption. In AM3517 the
> interface clocks are enabled by the clock module ONLY during
> initialization, so the suspend sequence (in arch/arm/mach-omap2/
> sleep3517.S) has to manually turn it off before executing wfi
> and then back on again on returning from wfi, to ensure that all
> interface clocks are enabled when control returns to omap_sram_idle()
> after waking up from idle.

We don't need to know that your original implementation had a problem and
you fixed it with a later patch.  Just roll the two patches together.

When Linus talks about unnecessary churn, this is one of the reasons it
happens.  Please change your workflow to reduce the amount of changes
done - especially when you're submitting patches which create entirely
new files.
