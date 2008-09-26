From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/9] twl4030 updates
Date: Fri, 26 Sep 2008 20:50:33 +0300
Message-ID: <20080926175033.GC9890@frodo>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809261012.28007.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39866 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbYIZRup (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 13:50:45 -0400
Content-Disposition: inline
In-Reply-To: <200809261012.28007.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Sep 26, 2008 at 10:12:27AM -0700, David Brownell wrote:
> Let's apply the following patch 10/9 on top of this though.
> And probably update the board files similarly (alpha order).
> 
> As an FYI, if you look at the "MFD core" you'll observe that
> if some crap gets stripped away, the *useful* bit is a utility
> making some of this create-a-child-node easier.  It's not worth
> using now.  But a little bird told me that some of that crap
> may be getting stripped away soon, so add_children() could
> become simpler.  Wouldn't affect the function drivers (the
> OTG transceiver, keypad, GPIO, RTC, etc) because we have, with
> foresight, been using platform_device already.  ;)

I was trying to organize by order of importance to a running system. If
we run out of memory when registering the madc child, that should be ok,
but if we run out of memory when registering rtc, that might cause some
problems, right ?

If you prefer in alphabetic order, it's no problem, I'll fix that ;-)

-- 
balbi
