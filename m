From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap3: l3: Temporary fix to avoid the kernel hang with
 beagle board.
Date: Sat, 9 Jul 2011 18:30:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107091828310.15984@utopia.booyaka.com>
References: <1304952352-27837-1-git-send-email-r.sricharan@ti.com> <alpine.DEB.2.00.1107091615000.15984@utopia.booyaka.com> <4E18F0D1.3080704@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45990 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab1GJAak (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 20:30:40 -0400
In-Reply-To: <4E18F0D1.3080704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Santosh,

On Sat, 9 Jul 2011, Santosh Shilimkar wrote:

> Sorry for not closing the loop on this thread but I thought Tomi
> root-caused the DSS timeout issue to incorrect reset sequence of
> DSS IP. With that fixed I though we shouldn't see that issue.

OK great, happy to hear that it was tracked down!

Tomi, do you have patches to fix the reset bug?

> > First, it tries to unconditionally reset the L3 DSS interconnect
> > agent, even if there's no problem on the L3 DSS IA that requires a
> > reset.  It should only try to reset an IA if it's in a bad state.
> > 
> This was to ensure that the issue hasn't happened during boot-loader
> DSS reset sequence in case it does. But I agree with your comments.

That's a good idea, but the patch should only do that if the L3 DSS IA is 
reporting a timeout error.

> > Second, are you sure that reset sequence is correct?  Writing a 1 and
> > then a 0 to that reset bit, without any barrier or delay in between?
> > Could you please confirm that this is a correct reset sequence with
> > the L3 IA designers and cc me on the E-mails, or send me an extract
> > from the relevant documentation?
> > 
> > Third, the patch disables L3 timeout reporting.  This effectively
> > reacts to an error by pretending that the error did not exist.  This
> > isn't right. If there's an L3 timeout, it needs to be reported, if at
> > all possible.  It should never happen and it indicates something is
> > wrong with the software or the hardware.
> > 
> Will come back to you on above queries.

regards,

- Paul
