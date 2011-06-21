From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Bug in _und_usr on dual-core ARM?
Date: Tue, 21 Jun 2011 10:15:29 +0100
Message-ID: <20110621091529.GA22868@n2100.arm.linux.org.uk>
References: <BANLkTinY+_+tHatRWuRFUJewUibpmvkUqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34151 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab1FUJPt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jun 2011 05:15:49 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinY+_+tHatRWuRFUJewUibpmvkUqA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: TAO HU <tghk48@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, Zhou Ming-a17711 <a17711@motorola.com>

On Tue, Jun 21, 2011 at 04:31:19PM +0800, TAO HU wrote:
> Hi, All
> 
> We got an issue on our OMAP4 SMP system.
> Looks like __und_user(), which was triggered by a user space
> exception, got a page fault hence lead to might_sleep() failure.

Could you see whether this patch prevents the warning please.

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index bc0e1d8..d52b940 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -289,7 +289,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
 	 */
-	if (in_atomic() || !mm)
+	if (in_atomic() || irqs_disabled() || !mm)
 		goto no_context;
 
 	/*

