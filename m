From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc5 4/5] twl4030 power button irq
Date: Thu, 20 Nov 2008 02:45:42 -0800
Message-ID: <200811200245.42944.david-b@pacbell.net>
References: <200811191728.58850.david-b@pacbell.net> <20081120101242.GF8667@gandalf.research.nokia.com>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:37999 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753003AbYKTKpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2008 05:45:45 -0500
In-Reply-To: <20081120101242.GF8667@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

On Thursday 20 November 2008, Felipe Balbi wrote:
> 
> > Disable the TWL4030_PWRIRQ_PWRBTN symbol from the system headers;
> > initialization of the power button handler still needs work, so
> > an equivalent symbol is defined in its driver.
> > 
> > ...
> 
> How about moving this to a platform_device as well and also move to
> drivers/input/misc ?

That'd seem to be the right solution.


> This question, of course, won't prevent this patch from being applied.

Right.  This series is just to fix things up so the last patch
(or an equivalent) can safely be pulled down from mainline.

- dave



