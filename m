From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 12:13:34 +0000
Message-ID: <20110208121334.GB22877@n2100.arm.linux.org.uk>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org> <20110208110808.GA22877@n2100.arm.linux.org.uk> <201102081311.52004.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55525 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab1BHMN4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 07:13:56 -0500
Content-Disposition: inline
In-Reply-To: <201102081311.52004.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Dave Martin <dave.martin@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tue, Feb 08, 2011 at 01:11:51PM +0100, Arnd Bergmann wrote:
> On Tuesday 08 February 2011, Russell King - ARM Linux wrote:
> > On Tue, Feb 08, 2011 at 11:01:25AM +0000, Dave Martin wrote:
> > > For v6, wfi is architected as a defined MCR instruction, so
> > > use that definition.
> > > 
> > > Doing a no-op instead of wfi() is probably bad, so for older
> > > processors than v6, wfi() is not defined.  If needed, some CPU-
> > > specific wfi() will have to be defined elsewhere.
> > 
> > This is something we kind-of already handle in a different way - see
> > the individual processor idle function in arch/arm/mm/proc*.S.
> > 
> > There's various errata work-arounds older CPUs need for wfi (or rather
> > its mcr equivalent) so maybe wfi() should just be an alias for a call
> > to that function.  Or maybe we shouldn't have a wfi() macro at all.
> 
> I don't see any users of the sev/wfe/wfi macros in the current kernel,
> so removing them seems like a good strategy to avoid people from
> using them incorrectly.

That's because they've only just been added.  See the massive 63-patch set
from Viresh which has been posting to this mailing list.
