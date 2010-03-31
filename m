From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC/PATCH 1/4] gpiolib: introduce set_debounce method
Date: Wed, 31 Mar 2010 17:50:59 +0300
Message-ID: <20100331145059.GA3833@gandalf>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
 <1270038435-28106-2-git-send-email-felipe.balbi@nokia.com>
 <20100331134627.GA27613@sirena.org.uk>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43218 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab0CaOuc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 10:50:32 -0400
Content-Disposition: inline
In-Reply-To: <20100331134627.GA27613@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Mar 31, 2010 at 02:46:28PM +0100, Mark Brown wrote:
> > +int gpio_set_debounce(unsigned gpio, int value)
> > +{
> 
> What are the intended semantics of value here?

debounce time. I just used value because other functions also call it
value.

-- 
balbi
