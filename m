From: David Brownell <david-b@pacbell.net>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 17:42:16 -0800
Message-ID: <200811251742.21868.david-b@pacbell.net>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <200811251326.36259.david-b@pacbell.net> <6ed0b2680811251501l3120a7cew341ce07f5fe47aff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:31522 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752119AbYKZBmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 20:42:45 -0500
In-Reply-To: <6ed0b2680811251501l3120a7cew341ce07f5fe47aff@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Tuesday 25 November 2008, Grazvydas Ignotas wrote:
> > If they're using the LEDA or LEDB PWMs, providing and exporting
> > a brightness control would be easy.  If they're using the other
> > two PWMs, it'd be more work.
>
> The configuration is as follows:
> LEDA - keypad backlight
> LEDB - power LED
> PWM0 - LCD backlight
> PWM1 - charger LED

Might have been better to use LEDA and LEDB for backlights,
you probably could have saved some external hardware ... those
pins are high drive.  :)


> So we need PWM0 to be "real LED" most (and backlight class too),
> others would be cool as "real" too, but we could live with them being
> simple.
> 
> >> since we are in the same boat. A solution is needed, but I guess the
> >> wolfson people can work it out :)
> >
> > Or maybe the Pandora people.  ;)
>
> Well I feel confused about all this now.. I guess I'll start with
> defining everything as simple GPIO LEDs.

Right, start as gpio leds.  Since I've already looked at it,
I may take a whack at exposing LEDA/LEDB PWMs ... expecting to
use thhe same interface for PWM0/PWM1.

- Dave
