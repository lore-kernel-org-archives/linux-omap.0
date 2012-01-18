From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 1/5] arm:omap1/2/3/4:Convert 32k-Sync clocksource
	driver to platform_driver
Date: Wed, 18 Jan 2012 11:59:52 +0000
Message-ID: <20120118115952.GM16726@n2100.arm.linux.org.uk>
References: <1326886086-27313-1-git-send-email-hvaibhav@ti.com> <1326886086-27313-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45358 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab2ARMAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jan 2012 07:00:10 -0500
Content-Disposition: inline
In-Reply-To: <1326886086-27313-2-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, johnstul@us.ibm.com, balbi@ti.com, tglx@linutronix.de, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org

On Wed, Jan 18, 2012 at 04:58:02PM +0530, Vaibhav Hiremath wrote:
> Convert counter_32k clocksource driver to standard platform_driver
> and move it drivers/clocksource/ directory.
> 
> Also, rename it to more generic name "omap-32k.c".

NAK.  sched_clock is supposed to be available early.  Platform device
driver initialization is FAR too late.

Note that some of the code you're moving has changed in current kernels.
