From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/3] lp5521: move to drivers/leds
Date: Mon, 6 Oct 2008 09:33:49 -0700
Message-ID: <200810060933.49739.david-b@pacbell.net>
References: <1223284291-7675-4-git-send-email-felipe.balbi@nokia.com> <20081006125809.GR7437@gandalf.research.nokia.com> <48EA135D.3070104@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:32655 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752879AbYJFQd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 12:33:57 -0400
In-Reply-To: <48EA135D.3070104@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mathias nyman <mathias.nyman@nokia.com>
Cc: felipe.balbi@nokia.com, ext Riku Voipio <riku.voipio@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, rpurdie@rpsys.net

On Monday 06 October 2008, mathias nyman wrote:
> The driver for the next version of the lp552x chip uses the led class 
> for the direct mode

That sounds like the way to start ... any reason why the
current driver couldn't be changed do the same?

This would seem like a good motivation to add some features
to the LED framework.  Here are three types of LED that it
doesn't support well today:

 - Bicolor leds with two leads ... R-or-G, two wires,
   opposite diode directions.

 - Bicolor LEDs with three leads ... like R-and-Y, three
   wires, common anode or common cathode

 - RGB leds, four leads ... like R-and-G-and-B, etc

Except for the first case, these can be stuffed into the
framework by modeling them as multiple LEDs.  But when you
do that it gets awkward to make sure that for example you
get a purple (+R, -G, +B) blink, since the timers need to
be exactly in phase.  Or to combine blinking with PWM, so
you could for example mix in a little green...

Surely some features that would support RGB (RG, YG, etc)
LEDs better could support both fancy (lp5521) and simple
(GPIO without PWM) implementations ...

- Dave


