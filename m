From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap3: l3: Temporary fix to avoid the kernel hang with
 beagle board.
Date: Sat, 9 Jul 2011 16:25:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107091615000.15984@utopia.booyaka.com>
References: <1304952352-27837-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52961 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab1GIWZR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 18:25:17 -0400
In-Reply-To: <1304952352-27837-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

Hi

On Mon, 9 May 2011, sricharan wrote:

> Paul Walmsley reported a kernel hang issue with beagle board during
> boot. This is an intermittent bug and the execution was found to be
> stuck at the l3 interrupt handler.
> 
> This was due to a dss initiator agent timeout occuring during
> the boot even when there is no actual interconnect access made by the
> dss. since the reason for the dss timeout is not root caused yet,
> the time out feature is disabled at the interconnect level.
> Note that this is a temporary fix that should be removed once
> the dss interconnect agent timeout issue is resolved.

So it's been two months since this bug was reported.  Any progress on 
root-causing it?

I don't see how I can upstream this temporary patch with a straight face.

First, it tries to unconditionally reset the L3 DSS interconnect agent, 
even if there's no problem on the L3 DSS IA that requires a reset.  It 
should only try to reset an IA if it's in a bad state.

Second, are you sure that reset sequence is correct?  Writing a 1 and then 
a 0 to that reset bit, without any barrier or delay in between?  Could you 
please confirm that this is a correct reset sequence with the L3 IA
designers and cc me on the E-mails, or send me an extract from the 
relevant documentation?

Third, the patch disables L3 timeout reporting.  This effectively reacts 
to an error by pretending that the error did not exist.  This isn't right.  
If there's an L3 timeout, it needs to be reported, if at all possible.  It 
should never happen and it indicates something is wrong with the software 
or the hardware.


- Paul
