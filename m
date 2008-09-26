From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/9] twl4030 updates
Date: Fri, 26 Sep 2008 11:55:21 -0700
Message-ID: <200809261155.21887.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809261012.28007.david-b@pacbell.net> <20080926175033.GC9890@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:22158 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751983AbYIZSzY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Sep 2008 14:55:24 -0400
In-Reply-To: <20080926175033.GC9890@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Friday 26 September 2008, Felipe Balbi wrote:
> I was trying to organize by order of importance to a running system. If
> we run out of memory when registering the madc child, that should be ok,
> but if we run out of memory when registering rtc, that might cause some
> problems, right ?

If we run out of memory *that early* it'll be a miracle if 
the system can run at all...


> If you prefer in alphabetic order, it's no problem, I'll fix that ;-)

Alphabetical should be the default assumption.  It makes
things easier to maintain ... when you're trying to find
something, it's easy to figure out where it should be.


