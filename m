From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] CLK: Introduce virtual clock registration
Date: Wed, 20 Aug 2008 14:54:00 +0300
Message-ID: <20080820115400.GF29374@atomide.com>
References: <1219225912-347-1-git-send-email-Hiroshi.DOYU@nokia.com> <20080820101812.GK23346@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65197 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbYHTLy3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 07:54:29 -0400
Content-Disposition: inline
In-Reply-To: <20080820101812.GK23346@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, paul@pwsan.com, eduardo.valentin@indt.org.br

* Felipe Balbi <felipe.balbi@nokia.com> [080820 13:17]:
> On Wed, Aug 20, 2008 at 12:51:51PM +0300, Hiroshi DOYU wrote:
> > +int vclk_enable(struct clk *clk)
> > +{
> > +	int i;
> > +	struct vclk *vc = container_of(clk, struct vclk, clk);
> > +
> > +	for (i = 0; i < vc->n_childs; i++)
> > +		clk_enable(vc->childs[i]);
> 
> missing an error check for clk_enable()

And disable all virtual clocks if any of them fail?
Looks good other than that.

Tony
