From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Tue, 14 Oct 2008 14:24:10 -0700
Message-ID: <20081014212409.GL8150@atomide.com>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com> <alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com> <20081014172921.GJ20247@frodo> <200810141047.44803.david-b@pacbell.net> <20081014180634.GL20247@frodo> <20081014205925.GK8150@atomide.com> <1224018598.4977.27.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64025 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbYJNVYT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 17:24:19 -0400
Content-Disposition: inline
In-Reply-To: <1224018598.4977.27.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

* Igor Stoppa <igor.stoppa@nokia.com> [081014 14:12]:
> On Tue, 2008-10-14 at 13:59 -0700, ext Tony Lindgren wrote:
> 
> > And that we can use same naming in the driver no matter which omap :)
> 
> Wasn't that one of the main features of the clock FW, when it was
> designed?

Yes. But we adding separate ick and fck during omap2420 confused that.

Tony
