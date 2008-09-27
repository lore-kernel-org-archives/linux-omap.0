From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/9] twl4030 updates
Date: Sat, 27 Sep 2008 14:45:06 -0700
Message-ID: <200809271445.07134.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809271214.30165.david-b@pacbell.net> <20080927211726.GA8468@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:29240 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753396AbYI0VpJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Sep 2008 17:45:09 -0400
In-Reply-To: <20080927211726.GA8468@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Saturday 27 September 2008, Felipe Balbi wrote:
> On Sat, Sep 27, 2008 at 12:14:29PM -0700, David Brownell wrote:
> > Here are some more cleanups to consider including ... these
> > should apply on top of all nine patches.
> 
> You want me to keep it on top of the other 9 (10) patches or meld it
> together ? I think it'd be better to meld on the previous patches so
> we introduce the patches the way they should look like. Right ?

Not sure it matters in this case; if we were talking about patches
that will merge upstream, I'd agree.

But what merges upstream will look like a brand new twl4030 core,
in drivers/mfd, so all this OMAP history will be gone.

So the issue here is just what's easiest for you and Tony.

- Dave
