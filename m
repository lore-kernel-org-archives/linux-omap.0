From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: architected timers: Mark the clockevent with the
	C3_STOP feature
Date: Wed, 4 Jul 2012 11:26:17 +0100
Message-ID: <20120704102617.GC16639@n2100.arm.linux.org.uk>
References: <1341395673-29660-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37739 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756949Ab2GDK0e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 06:26:34 -0400
Content-Disposition: inline
In-Reply-To: <1341395673-29660-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Marc Zyngier <marc.zyngier@arm.com>, linux-omap@vger.kernel.org

On Wed, Jul 04, 2012 at 03:24:33PM +0530, Santosh Shilimkar wrote:
> ARM arch timers stop in low power state and hence can not wakeup CPUs in
> deeper idle states when used as cloc event devices. Marking these clock event
> devices with C3_STOP so that during lowpower states, the tick is managed by
> wakeup capable broadcast timer.

Will tells me that the arch timers don't stop in low power modes, they
just can't produce wakeup events.  Apparantly the spec says:

   The system counter must be implemented in an always-on power domain.
   Use of lower-frequency modes must not affect the implemented accuracy.

Are you sure your above description of the problem is correct?
