From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: PWM drivers for TWL4030
Date: Wed, 26 Nov 2008 11:47:11 +0200
Message-ID: <6ed0b2680811260147vf338d8av9906157a6c15b456@mail.gmail.com>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com>
	 <200811251326.36259.david-b@pacbell.net>
	 <6ed0b2680811251501l3120a7cew341ce07f5fe47aff@mail.gmail.com>
	 <200811251742.21868.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:6260 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbYKZJrO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 04:47:14 -0500
Received: by ey-out-2122.google.com with SMTP id 6so163278eyi.37
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 01:47:12 -0800 (PST)
In-Reply-To: <200811251742.21868.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Wed, Nov 26, 2008 at 3:42 AM, David Brownell <david-b@pacbell.net> wrote:
> On Tuesday 25 November 2008, Grazvydas Ignotas wrote:
>> > If they're using the LEDA or LEDB PWMs, providing and exporting
>> > a brightness control would be easy.  If they're using the other
>> > two PWMs, it'd be more work.
>>
>> The configuration is as follows:
>> LEDA - keypad backlight
>> LEDB - power LED
>> PWM0 - LCD backlight
>> PWM1 - charger LED
>
> Might have been better to use LEDA and LEDB for backlights,
> you probably could have saved some external hardware ... those
> pins are high drive.  :)
LEDB probably wasn't used for LCD backlight because it doesn't provide
enough power (60mA only). Don't know for sure, it wasn't me who
designed the hardware.

> Right, start as gpio leds.  Since I've already looked at it,
> I may take a whack at exposing LEDA/LEDB PWMs ... expecting to
> use thhe same interface for PWM0/PWM1.
That would be great, thanks!
