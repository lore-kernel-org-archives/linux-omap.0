From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Wed, 15 Oct 2008 00:28:19 +0300
Message-ID: <20081014212802.GB31842@frodo>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com> <alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com> <20081014172921.GJ20247@frodo> <200810141047.44803.david-b@pacbell.net> <20081014180634.GL20247@frodo> <20081014205925.GK8150@atomide.com> <1224018598.4977.27.camel@localhost> <20081014212409.GL8150@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53713 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbYJNV2w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 17:28:52 -0400
Content-Disposition: inline
In-Reply-To: <20081014212409.GL8150@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Stoppa <igor.stoppa@nokia.com>, Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Tue, Oct 14, 2008 at 02:24:10PM -0700, Tony Lindgren wrote:
> * Igor Stoppa <igor.stoppa@nokia.com> [081014 14:12]:
> > On Tue, 2008-10-14 at 13:59 -0700, ext Tony Lindgren wrote:
> > 
> > > And that we can use same naming in the driver no matter which omap :)
> > 
> > Wasn't that one of the main features of the clock FW, when it was
> > designed?
> 
> Yes. But we adding separate ick and fck during omap2420 confused that.

Also, it's useful to keep the name shown in TRM to ease the task of
searching TRM for information about that particular clock.

-- 
balbi
