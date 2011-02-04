From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ARM: Make CONFIG_FPE_NWFPE depend on
	!CONFIG_THUMB2_KERNEL
Date: Fri, 4 Feb 2011 11:03:42 +0000
Message-ID: <20110204110342.GE15004@n2100.arm.linux.org.uk>
References: <1291895982-4775-1-git-send-email-dave.martin@linaro.org> <1291895982-4775-3-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57982 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab1BDLDx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 06:03:53 -0500
Content-Disposition: inline
In-Reply-To: <1291895982-4775-3-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Thu, Dec 09, 2010 at 11:59:42AM +0000, Dave Martin wrote:
> Because the nwfpe support is unlikely to be used on new platforms
> and requires CONFIG_OABI_COMPAT, which is not generally used with
> ARMv7+, we shouldn't expect to build nwfpe support into a Thumb-2
> kernel.
> 
> At present, nwfpe contains assembly code which isn't Thumb-2
> compatible, and for now it doesn't appear useful to port this
> code.

You might as well make OABI_COMPAT depend on !THUMB2_KERNEL.  OABI
userland is useless without FPA support.
