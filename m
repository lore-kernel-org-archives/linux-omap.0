From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP1: unnecessary timer interrupt handler code?
Date: Mon, 9 May 2011 09:03:35 +0300
Message-ID: <20110509060332.GV27860@atomide.com>
References: <20110508162800.GM27807@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:64807 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752084Ab1EIGDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 02:03:36 -0400
Content-Disposition: inline
In-Reply-To: <20110508162800.GM27807@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110508 19:24]:
> MPU timer 2 is used on OMAP1 for the clock source and scheduler clock.
> It registers an interrupt, which counts the number of overflows of
> this timer.  However, this counter is only referenced by the interrupt
> handler.
> 
> So, it seems that the following code serves very little purpose.  Can
> it be simply deleted?

Seems safe to me. This is probably some left over legacy code
from long time ago.

Regards,

Tony
