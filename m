From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 3/3] lp5521: move to drivers/leds
Date: Tue, 07 Oct 2008 09:32:45 +0100
Message-ID: <1223368365.5201.2.camel@dax.rpnet.com>
References: <1223284291-7675-4-git-send-email-felipe.balbi@nokia.com>
	 <20081006125809.GR7437@gandalf.research.nokia.com>
	 <48EA135D.3070104@nokia.com>  <200810060933.49739.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:52014 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbYJGIdK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Oct 2008 04:33:10 -0400
In-Reply-To: <200810060933.49739.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: mathias nyman <mathias.nyman@nokia.com>, felipe.balbi@nokia.com, ext Riku Voipio <riku.voipio@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Mon, 2008-10-06 at 09:33 -0700, David Brownell wrote:
> This would seem like a good motivation to add some features
> to the LED framework.  Here are three types of LED that it
> doesn't support well today:
> 
>  - Bicolor leds with two leads ... R-or-G, two wires,
>    opposite diode directions.
> 
>  - Bicolor LEDs with three leads ... like R-and-Y, three
>    wires, common anode or common cathode
> 
>  - RGB leds, four leads ... like R-and-G-and-B, etc
> 
> Except for the first case, these can be stuffed into the
> framework by modeling them as multiple LEDs.  But when you
> do that it gets awkward to make sure that for example you
> get a purple (+R, -G, +B) blink, since the timers need to
> be exactly in phase.  Or to combine blinking with PWM, so
> you could for example mix in a little green...
> 
> Surely some features that would support RGB (RG, YG, etc)
> LEDs better could support both fancy (lp5521) and simple
> (GPIO without PWM) implementations ...

The question is how and what you add to the class to support these
types. It could be as simple as some more obvious naming conventionto
associate LEDs and a way of sharing triggers amongst LEDs I guess...

Cheers,

Richard


