From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 16:20:36 +0000
Message-ID: <20110208162036.GA6188@n2100.arm.linux.org.uk>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org> <201102081311.52004.arnd@arndb.de> <20110208121334.GB22877@n2100.arm.linux.org.uk> <201102081353.20390.arnd@arndb.de> <AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40778 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab1BHQVA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 11:21:00 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tue, Feb 08, 2011 at 02:45:51PM +0000, Dave Martin wrote:
> If support for a v6K processor is included, we have no way to know
> from preprocessor definitions whether a plain v6 processor is also to
> be supported.

Yes we do.  See the v6 patches I've recently posted to various mailing
lists.

This patch series was created in the hope that it could be tested by a
sufficient number of people so that it could go into -rc1 as at the
moment, omap2plus_defconfig builds data-corrupting kernels.

Unfortunately, the response was not as good as I was hoping - it's
possible to count the number of testers on one hand.  So it's now
scheduled for the next merge window.  What this means is that v2.6.37
and v2.6.38 omap2plus_defconfig kernels _will_ _be_ _unsafe_ when run
on SMP hardware, and will remain that way.  If a fix is not suitable for
-rc, it most certainly isn't suitable for -stable.

What the patch set does demonstrate that we can know at preprocessor
time that plain v6 processors should be supported along side v6k and
v7.
