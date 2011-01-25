From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Tue, 25 Jan 2011 13:41:28 +0000
Message-ID: <20110125134128.GJ13300@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com> <20110125114635.GB13300@n2100.arm.linux.org.uk> <236d45e400a960cc3b32db538b3a79ae@mail.gmail.com> <20110125121655.GD13300@n2100.arm.linux.org.uk> <4534e82bf14eeea9f96769df760df5ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39050 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab1AYNlt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 08:41:49 -0500
Content-Disposition: inline
In-Reply-To: <4534e82bf14eeea9f96769df760df5ae@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ccross@android.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org

On Tue, Jan 25, 2011 at 06:06:27PM +0530, Santosh Shilimkar wrote:
> Ok. I missed some information my last email.
> The SCU power status programming is used to take CPU in/out
> of coherency as an alternative to SMP bit. We don't
> have an access to SMP bit on OMAP4. ARM has already
> confirmed SCU programming is same as SMP bit enable/disable.
> 
> I don't know how safe is to use spin lock when one CPU is
> goes out of coherency after programming the power state. The
> spin lock release may not even be visible to other CPU.
> The programming happens from IDLE or suspend where the

BTW, presumably we should be flushing the caches/tlbs before setting
the CPU power register to a non-normal setting?

I'll wait until there's more information available (such as an example
implementation.)
