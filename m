From: "Kridner, Jason" <jdk@ti.com>
Subject: RE: leds-gpio broken with current git?
Date: Mon, 23 Feb 2009 08:30:23 -0600
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E210F49EC@dlee03.ent.ti.com>
References: <7088542D-28A0-4BCA-9583-6BCDDF9E960A@student.utwente.nl>
 <200901150758.49601.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50778 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497AbZBWOad convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 09:30:33 -0500
In-Reply-To: <200901150758.49601.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of David Brownell
> Sent: Thursday, January 15, 2009 9:59 AM
> To: Koen Kooi
> Cc: linux-omap@vger.kernel.org List
> Subject: Re: leds-gpio broken with current git?
> 
> On Thursday 15 January 2009, Koen Kooi wrote:
> > I've been playing with different kernels on beagleboard lately and
> it
> > seems that somewhere between 2.6.28rc8 and the final release leds-
> gpio
> > got broken for beagleboard:
> >
> > Registered led device: beagleboard::usr0
> > Registered led device: beagleboard::usr1
> > leds-gpio: probe of leds-gpio failed with error -22
> 
> Works for me, no "-EINVAL", on 2.6.28-omap1 and no patches
> that should affect GPIOs or LEDs.  Last patch applied to
> GIT is 15f75b6226c2d3b82062bb721e7cb9a1d6f35efd (musbhsdma).
> 
> OK, I'm just pulling a new batch of objects, I'm guessing
> Tony snuck in RC1 already ... yes, I see he just sent a
> post about that a few minutes ago.  ;)

Perhaps something broke with Tony's RC1 merge?  The LEDs are broken for me as well.

> 
> - Dave
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

