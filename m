From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: ehci-omap patches (Was Re: [PATCH 0/5] [RESEND] lm8323 patches)
Date: Thu, 19 Feb 2009 23:32:07 +0200
Message-ID: <20090219213207.GL20723@frodo>
References: <1235046583-29696-1-git-send-email-me@felipebalbi.com> <20090219203251.GG20723@frodo> <20090219210429.GB7414@atomide.com> <20090219211820.GJ20723@frodo> <20090219212927.GE7414@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51374 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157AbZBSVcO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 16:32:14 -0500
Content-Disposition: inline
In-Reply-To: <20090219212927.GE7414@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org

On Thu, Feb 19, 2009 at 01:29:27PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <me@felipebalbi.com> [090219 13:19]:
> > On Thu, Feb 19, 2009 at 01:04:30PM -0800, Tony Lindgren wrote:
> > > * Felipe Balbi <me@felipebalbi.com> [090219 12:58]:
> > > > On Thu, Feb 19, 2009 at 02:29:38PM +0200, Felipe Balbi wrote:
> > > > > Hi Tony,
> > > > > 
> > > > > the final version is already going to mainline via linux-input,
> > > > > you might wanna apply these to l-o to avoid conflicts later.
> > > > 
> > > > mainline had a few comments to this driver which will come as an extra
> > > > cleanup patch since there's no functionality change, only style changes
> > > > so far.
> > > > 
> > > > These should be safe to apply.
> > > 
> > > OK, will push today.
> > 
> > Cool thanks, now that we're in the "push drivers upstream season", what
> > abou the ehci driver ? Did you get any patches from TI tony ? I asked
> > you to drop some patches from me because they said they would come up
> > with a better solution. If I get a board to test ehci, I'll push that
> > driver upstream as well, it's been too long waiting and TI still didn't
> > give us the patches for ehci, nor ohci.
> 
> No patches from TI :( It would be nice to get that driver into the
> out of the linux-omap tree.

I could patch but wouldn't have how to test it :-(

My beagle doesn't have ehci port, too bad.

-- 
balbi
