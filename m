From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: powerdomain: Wait for powerdomain
 transition in pwrdm_state_switch()
Date: Thu, 15 Mar 2012 16:40:05 -0700
Message-ID: <20120315234004.GD7276@atomide.com>
References: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com>
 <1331562873-29535-2-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1203151129160.26218@utopia.booyaka.com>
 <20120315175122.GB7276@atomide.com>
 <alpine.DEB.2.00.1203151701290.2133@utopia.booyaka.com>
 <20120315232256.GC7276@atomide.com>
 <alpine.DEB.2.00.1203151733360.5007@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:16633 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032394Ab2COXkJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 19:40:09 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1203151733360.5007@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

* Paul Walmsley <paul@pwsan.com> [120315 16:36]:
> On Thu, 15 Mar 2012, Tony Lindgren wrote:
> 
> > It seems that I need this patch plus need to undo the wrong
> > serial muxing in commit 7496ba30 (ARM: OMAP2+: UART: Add default mux
> > for all uarts) to make my zoom3 boot reliably.
> 
> Okay.  Well want to take the powerdomain patch for the v3.3-rc series 
> then?

Uhh now got a random issue of "BUG: bad unlock balance detected"..
Random oopses seem less common now, but still not booting reliably.

Regards,

Tony
