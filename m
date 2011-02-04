From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Fri, 4 Feb 2011 10:41:13 +0000
Message-ID: <20110204104113.GD15004@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com> <20110125114635.GB13300@n2100.arm.linux.org.uk> <236d45e400a960cc3b32db538b3a79ae@mail.gmail.com> <20110125121655.GD13300@n2100.arm.linux.org.uk> <4534e82bf14eeea9f96769df760df5ae@mail.gmail.com> <20110125125656.GG13300@n2100.arm.linux.org.uk> <20110125130422.GH13300@n2100.arm.linux.org.uk> <20110125130611.GA15663@n2100.arm.linux.org.uk> <627ff975140c8e4afbad281105b29d35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48628 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab1BDKla (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 05:41:30 -0500
Content-Disposition: inline
In-Reply-To: <627ff975140c8e4afbad281105b29d35@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

On Tue, Jan 25, 2011 at 11:53:35PM +0530, Santosh Shilimkar wrote:
> After fixing the 3rd version for base address break, I was able to
> use this patch and test it. Seems to work. SMC related stuff can
> be ignored because OMAP4 ES1.0 doesn't have functional PM hardware
> support.

I think I'd prefer to do as the other functions do, and pass in the
scu base address from the platform code.  It's potentially more
efficient for platforms which have a fixed SCU base address.
