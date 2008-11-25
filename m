From: David Brownell <david-b@pacbell.net>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 12:06:54 -0800
Message-ID: <200811251206.54848.david-b@pacbell.net>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <200811251046.45693.david-b@pacbell.net> <89DAA6D4-9105-480E-9884-B94DE28C2C61@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:48430 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752256AbYKYUTY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 15:19:24 -0500
In-Reply-To: <89DAA6D4-9105-480E-9884-B94DE28C2C61@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Tuesday 25 November 2008, Koen Kooi wrote:
> >
> > How about a standard LED driver (optionally with a brightness
> > control) and the newish "backlight" trigger?
> 
> Does the backlight trigger hook into the backlight class? 

It doesn't seem to call backlight_device_register(), though
I don't know why not.  It just looks like it hooks into the
same notification events the backlight class does.

If you think that's trouble, it would probably be a good
thing to bring that up with the author of that new trigger
code (drivers/leds/ledtrig-backlight.c) ... it's very new,
and I'd expect such userspace interface goofs still ought
to be fixable.

- Dave

