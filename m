From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Wed, 14 Nov 2012 19:01:37 +0000
Message-ID: <20121114190137.GD3332@n2100.arm.linux.org.uk>
References: <20121114185335.GU6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42360 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab2KNTBs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 14:01:48 -0500
Content-Disposition: inline
In-Reply-To: <20121114185335.GU6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Dave Martin <dave.martin@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wed, Nov 14, 2012 at 10:53:35AM -0800, Tony Lindgren wrote:
> Looks like enabling CONFIG_ARM_ERRATA_751472 causes omap4 blaze
> to not boot when enabled. The ARM core on it is an earlier r1p2:
> 
> CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
> 
> Unfortunately I don't have the details of errata 751472, but I'm
> guessing we need to disable it for r1p*.

Fails because it can't write the diagnostic register from non-secure
mode or fails later?
