From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Tue, 25 Jan 2011 11:29:46 +0000
Message-ID: <20110125112946.GA13300@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com> <20110124110609.GJ16202@n2100.arm.linux.org.uk> <20110124111114.GA19409@n2100.arm.linux.org.uk> <AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50675 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab1AYLa1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 06:30:27 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 24, 2011 at 11:39:13PM -0800, Colin Cross wrote:
> This doesn't work for oneshot timers if the TWD_TIMER_CONTROL register
> gets reset by cpu idle between twd_set_mode and twd_set_next_event.
> Shadowing ctrl in a percpu variable and rewriting it during every call
> to twd_set_next_event does work, but that's not much different, and a
> little less efficient, than just saving and restoring the control and
> load registers in idle.  It does have the advantage that platforms
> don't need any extra calls.

BTW, do you think the patch is, nevertheless, an improvement and something
we should do?  If so, please can I have your ack for it?

Thanks.
