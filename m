From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/3] lp5521: move to drivers/leds
Date: Tue, 7 Oct 2008 02:09:29 -0700
Message-ID: <200810070209.30193.david-b@pacbell.net>
References: <1223284291-7675-4-git-send-email-felipe.balbi@nokia.com> <200810060933.49739.david-b@pacbell.net> <1223368365.5201.2.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:31780 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751728AbYJGJJc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 05:09:32 -0400
In-Reply-To: <1223368365.5201.2.camel@dax.rpnet.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: mathias nyman <mathias.nyman@nokia.com>, felipe.balbi@nokia.com, ext Riku Voipio <riku.voipio@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tuesday 07 October 2008, Richard Purdie wrote:
> The question is how and what you add to the class to support these
> types.

I was trying to go for "the right question is half the answer".
That would be the other half.  ;)


> It could be as simple as some more obvious naming conventionto 
> associate LEDs and a way of sharing triggers amongst LEDs I guess...

Trigger names could be LED names.   So that when one led changes
state, so would anything triggering on that name.  That's one
way to share...


We're also missing multi-led triggers, most notably cylon eyes.  :)

