From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] OMAP: Switch to gpio_direction_output in OMAP_LDP.
Date: Fri, 21 Nov 2008 16:21:20 +0800
Message-ID: <1227255680.14497.78.camel@localhost>
References: <1227189663-27966-1-git-send-email-stanley.miao@windriver.com>
	 <200811201111.09749.david-b@pacbell.net>
	 <1227253842.14497.75.camel@localhost>
	 <200811202352.10830.david-b@pacbell.net>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:57424 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451AbYKUIPW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 03:15:22 -0500
In-Reply-To: <200811202352.10830.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Thu, 2008-11-20 at 23:52 -0800, David Brownell wrote:
> On Thursday 20 November 2008, stanley.miao wrote:
> > 
> > > Use gpio_set_value() to replace omap_set_gpio_dataout(), except
> > > when initializing.  The reset pin *was* being toggled...
> > 
> > These actions are in init function. so keep omap_set_gpio_dataout() in
> > place.

Sorry, it should be "keep gpio_direction_out() in place". I made a
mistake, but the code is right.

Stanley.

> 
> No, omap_set_gpio_dataout() is gone.  You can't call it any more.
> 
>   gpio_direction_output(gpio, initial_value)
> 
> is what you'd want after gpio_request().


