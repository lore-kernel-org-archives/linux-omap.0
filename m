From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
Date: Mon, 20 Jun 2011 16:01:41 +0100
Message-ID: <20110620150140.GM2082@n2100.arm.linux.org.uk>
References: <20110620095053.GA2082@n2100.arm.linux.org.uk> <20110620101438.GD2082@n2100.arm.linux.org.uk> <4DFF20B3.7010209@ti.com> <20110620104415.GF2082@n2100.arm.linux.org.uk> <4DFF255E.5030308@ti.com> <20110620111336.GG2082@n2100.arm.linux.org.uk> <4DFF2E37.8030602@ti.com> <20110620114019.GH2082@n2100.arm.linux.org.uk> <20110620142338.GL2082@n2100.arm.linux.org.uk> <4DFF5F29.2000904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59551 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab1FTPB6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 11:01:58 -0400
Content-Disposition: inline
In-Reply-To: <4DFF5F29.2000904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 20, 2011 at 08:24:33PM +0530, Santosh Shilimkar wrote:
> I am away from my board now. Will test this change.
> btw, the online-active race is still open even with this patch close
> and should be fixed.

I have yet to see any evidence of that race - I've been running your
test loop for about an hour so far on Versatile Express and nothing
yet.

That's not to say that we shouldn't wait for the active mask to become
true before calling schedule(), but I don't think its as big a deal as
you're suggesting it is.
