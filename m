From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 21:14:33 +0200
Message-ID: <20081125191432.GA6038@gandalf.research.nokia.com>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <6ed0b2680811250859x179afb67l5cca390d3b1e4de1@mail.gmail.com> <200811251042.36549.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38235 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbYKYTO5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 14:14:57 -0500
Content-Disposition: inline
In-Reply-To: <200811251042.36549.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, henrik.saari@nokia.com

On Tue, Nov 25, 2008 at 10:42:36AM -0800, David Brownell wrote:
> There are actually four PWM signals ... two associated with LEDs
> (or VIBRA.M, or VIBRA.P; high current) with fast input clocks,
> then PWM0 and PWM1 with slower input clocks which are alternate
> GPIO settings.  PWM1 can be used as VIBRA.SYNC.
> 
> The two LED PWMs are used as GPIOs on the Beagle ... so the GPIO
> driver supports them as output-only GPIOs, setting the LED PWMs
> up to be "always on" or "always off".
> 
> In short:  all the PWM-equipped pins have "clean" driver support,
> but only for using them as GPIOs, not as PWM.

Henrik Saari, Cced, actually wrote the twl4030-vibra driver and, afaict,
it's using the LED Class. Henrik, do you wanna share the code ?? :-)

> Right now, just use LEDA and LEDB as GPIO-19 and GPIO-20, like
> Beagle does; ditto for PWM-0/GPIO-6 and PWM-1/GPIO-7.
> 
> Near term, something to support led_classdev.brightness_{set,get}
> methods would make sense to me, for LEDA and LEDB.  The EVMs could
> set up LEDA devices and hook them up to the "backlight" trigger.
> The same thing could be done for PWM0 and PWM1.
> 
> Long term, we may have a PWM framework ... but it's not ready yet,
> and hasn't even been refreshed recently either.  And so far as I
> know, ALSA has no notion of supporting the VIBRA module hookup
> options for "audio" output.

I think for now, we can keep it as LED driver, then ?

-- 
balbi
