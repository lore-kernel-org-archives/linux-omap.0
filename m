From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/6] OMAP: Make OMAP LDP boot succussfuly
Date: Wed, 19 Nov 2008 11:14:20 -0800
Message-ID: <20081119191419.GA9504@atomide.com>
References: <1226404258-13027-1-git-send-email-stanley.miao@windriver.com> <20081111145715.GA11056@2ka.mipt.ru> <20081113224053.GO3106@atomide.com> <20081114112838.GA20212@2ka.mipt.ru> <20081119181305.GY9504@atomide.com> <20081119185109.GA9183@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61295 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbYKSTOZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 14:14:25 -0500
Content-Disposition: inline
In-Reply-To: <20081119185109.GA9183@2ka.mipt.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

* Evgeniy Polyakov <johnpol@2ka.mipt.ru> [081119 10:55]:
> On Wed, Nov 19, 2008 at 10:13:08AM -0800, Tony Lindgren (tony@atomide.com) wrote:
> > > If w1 part does not depend on any upstream changes not yet in the tree,
> > > I will forward it for inclusing, but if it requires some external update
> > > to be pushed first, I would like to add w1 part into that merge.
> > 
> > Yes, please include it into your queue, it does not have any other
> > omap dependencies. And we are trying to move all the omap driver
> > development to the appropriate driver lists to get in sync with the
> > mainline tree.
> 
> Ok, I will push this patch series upstream.
> Thank you.

Thanks! The rest of the omap w1 patche should be coming to you via LKML
then ;)

Tony
