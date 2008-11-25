From: David Brownell <david-b@pacbell.net>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 13:29:41 -0800
Message-ID: <200811251329.41258.david-b@pacbell.net>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <200811251046.45693.david-b@pacbell.net> <2F17FBB3-1626-40FC-B9CE-C5C85C000B19@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:48509 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752269AbYKYV3n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 16:29:43 -0500
In-Reply-To: <2F17FBB3-1626-40FC-B9CE-C5C85C000B19@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>

On Tuesday 25 November 2008, Koen Kooi wrote:
> I googled a bit and poked Richard Purdie (CC'ed) and he says:
> "Thats not what the trigger was supposed to be used for..."

However, drivers/leds/Kconfig disagrees:

config LEDS_TRIGGER_BACKLIGHT
        tristate "LED backlight Trigger"
        depends on LEDS_TRIGGERS
        help
          This allows LEDs to be controlled as a backlight device: they
          turn off and on when the display is blanked and unblanked.

"LEDS to be controlled as a backlight device" is exactly what
I was talking about.  And in fact, it works ... with the small
exception that no backlight class device is involved.

