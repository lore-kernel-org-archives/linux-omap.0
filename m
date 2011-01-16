From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: State of LDP3430 platform
Date: Sat, 15 Jan 2011 18:05:24 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE896716203EAE6F3B1@dlee02.ent.ti.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
 <20101206181913.GH8345@atomide.com>
 <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
 <20101207083720.GB18336@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
 <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
 <20110115000301.GT4957@atomide.com>
 <alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com>
 <20110115233744.GA18159@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53687 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889Ab1APAFf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Jan 2011 19:05:35 -0500
In-Reply-To: <20110115233744.GA18159@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>


> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Saturday, January 15, 2011 5:38 PM
> Why does OMAP initialize its clock sources soo late, outside of
> the timer initialization?  This means you have no counter in place
> (except for the jiffies counter) during early boot.
>
> Is there a reason why OMAP uniquely does this?

Not any good reason.  I'm aware of historic porting issue and the missed/hidden need for early init for some time services.

1st attempts to do really early init (like 7 years back) were messed as not all kernel services used to be available when the time early time init functions happened.

It was hidden because u-boot had already turned on the same clock the kernel level driver used. So there was no failure (until the kernel used something else).

Recurring breaks & fixes happened to out of trees as owners changed.  The mainline never enabled driver till recently.

Regards,
Richard W.
