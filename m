From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: Add aliases for McBSP fclk clocks
Date: Fri, 9 Mar 2012 11:02:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203091101400.7039@utopia.booyaka.com>
References: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com> <4F5A258F.8050704@ti.com> <20120309180027.GF12083@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47928 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab2CISCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 13:02:16 -0500
In-Reply-To: <20120309180027.GF12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

On Fri, 9 Mar 2012, Tony Lindgren wrote:

> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120309 07:47]:
> > Hi Paul, Tony,
> > 
> > On 03/06/2012 10:55 AM, Peter Ujfalusi wrote:
> > > CLKS signal for McBSP ports can be selected from internal (PRCM) or external
> > > (ABE_CLKS pin) source.
> > > To be able to use existing code we need to create clock aliases consistent
> > > among OMAP2/3/4.
> > 
> > Would you be able to take a look at this patch?
> 
> To me this looks safe to merge via ASoC tree, assuming Paul
> acks it too, and it does not cause merge conflicts with
> Paul's changes:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Please let's not merge this one yet.  It should not be necessary to change 
the clkdev aliases, this change should occur in the hwmod code.


- Paul
