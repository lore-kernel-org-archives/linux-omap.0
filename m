From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/9] twl4030 updates
Date: Fri, 26 Sep 2008 22:23:42 +0300
Message-ID: <20080926192341.GF9890@frodo>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809261012.28007.david-b@pacbell.net> <200809261200.30728.david-b@pacbell.net> <5e088bd90809261210x61bbd07ey6742dfd13180073f@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46476 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYIZTXy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 15:23:54 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809261210x61bbd07ey6742dfd13180073f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Sep 26, 2008 at 12:10:41PM -0700, Steve Sakoman wrote:
> On Fri, Sep 26, 2008 at 12:00 PM, David Brownell <david-b@pacbell.net> wrote:
> > And after applying this, and removing MADC config from
> > the Beagle and Overo board setup files, things worked!!
> 
> That's really great news!
> 
> > Moreover ... the USB host code worked, at least partially.
> > (Finally!  RC7.)  It enumerated the external hub, and the
> > Ethernet adapter hooked up to it.
> 
> Just to clarify -- you are referring to musb host code, correct?

He's actually refering to twl4030-usb being able to understand id pin is
grounded and start sourcing vbus. Without it, musb would never know it's
supposed to work as host ;-)

-- 
balbi
