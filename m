From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 11:08:08 +0000
Message-ID: <20110208110808.GA22877@n2100.arm.linux.org.uk>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51738 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349Ab1BHLI1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 06:08:27 -0500
Content-Disposition: inline
In-Reply-To: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

On Tue, Feb 08, 2011 at 11:01:25AM +0000, Dave Martin wrote:
> For v6, wfi is architected as a defined MCR instruction, so
> use that definition.
> 
> Doing a no-op instead of wfi() is probably bad, so for older
> processors than v6, wfi() is not defined.  If needed, some CPU-
> specific wfi() will have to be defined elsewhere.

This is something we kind-of already handle in a different way - see
the individual processor idle function in arch/arm/mm/proc*.S.

There's various errata work-arounds older CPUs need for wfi (or rather
its mcr equivalent) so maybe wfi() should just be an alias for a call
to that function.  Or maybe we shouldn't have a wfi() macro at all.
