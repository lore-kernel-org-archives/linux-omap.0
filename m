From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: powerdomain: Wait for powerdomain
 transition in pwrdm_state_switch()
Date: Thu, 15 Mar 2012 16:22:57 -0700
Message-ID: <20120315232256.GC7276@atomide.com>
References: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com>
 <1331562873-29535-2-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1203151129160.26218@utopia.booyaka.com>
 <20120315175122.GB7276@atomide.com>
 <alpine.DEB.2.00.1203151701290.2133@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34553 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161037Ab2COXXD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 19:23:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1203151701290.2133@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

* Paul Walmsley <paul@pwsan.com> [120315 16:04]:
> On Thu, 15 Mar 2012, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [120315 10:35]:
> > > On Mon, 12 Mar 2012, Santosh Shilimkar wrote:
> > > 
> > > > Commit b1cbdb00d{OMAP: clockdomain: Wait for powerdomain to be ON
> > > > when using clockdomain force wakeup} was assuming that pwrdm_state_switch()
> > > > does wait for the powerdomain transition which is not the case.
> > > > 
> > > > Fix this API by adding the pwrdm_wait_transition().
> > > > 
> > > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > > CC: Rajendra Nayak <rnayak@ti.com>
> > > > CC: Paul Walmsley <paul@pwsan.com>
> > > 
> > > Acked-by: Paul Walmsley <paul@pwsan.com>
> > > 
> > > Sounds like this fixes a major kernel oops bug for Tony so this should go 
> > > in ASAP to v3.3-rc series.
> > 
> > Got a random oops with this one applied still, just happened
> > to take longer this time :(
> 
> Oh well.  Will queue it for v3.4-rc1 then...

It seems that I need this patch plus need to undo the wrong
serial muxing in commit 7496ba30 (ARM: OMAP2+: UART: Add default mux
for all uarts) to make my zoom3 boot reliably.

Regards,

Tony
