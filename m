From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH v2 0/6] OMAP: Make OMAP LDP boot succussfuly
Date: Wed, 19 Nov 2008 21:51:09 +0300
Message-ID: <20081119185109.GA9183@2ka.mipt.ru>
References: <1226404258-13027-1-git-send-email-stanley.miao@windriver.com> <20081111145715.GA11056@2ka.mipt.ru> <20081113224053.GO3106@atomide.com> <20081114112838.GA20212@2ka.mipt.ru> <20081119181305.GY9504@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay.2ka.mipt.ru ([194.85.80.65]:47503 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508AbYKSSzB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Nov 2008 13:55:01 -0500
Content-Disposition: inline
In-Reply-To: <20081119181305.GY9504@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

On Wed, Nov 19, 2008 at 10:13:08AM -0800, Tony Lindgren (tony@atomide.com) wrote:
> > If w1 part does not depend on any upstream changes not yet in the tree,
> > I will forward it for inclusing, but if it requires some external update
> > to be pushed first, I would like to add w1 part into that merge.
> 
> Yes, please include it into your queue, it does not have any other
> omap dependencies. And we are trying to move all the omap driver
> development to the appropriate driver lists to get in sync with the
> mainline tree.

Ok, I will push this patch series upstream.
Thank you.

-- 
	Evgeniy Polyakov
