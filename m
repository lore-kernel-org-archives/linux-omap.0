From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: PWM drivers for TWL4030
Date: Wed, 26 Nov 2008 01:01:15 +0200
Message-ID: <6ed0b2680811251501l3120a7cew341ce07f5fe47aff@mail.gmail.com>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com>
	 <200811251206.54848.david-b@pacbell.net>
	 <612C6524-68F3-43C0-A127-4531F6B9B58F@student.utwente.nl>
	 <200811251326.36259.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:3263 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbYKYXBS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 18:01:18 -0500
Received: by yw-out-2324.google.com with SMTP id 9so121251ywe.1
        for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 15:01:16 -0800 (PST)
In-Reply-To: <200811251326.36259.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

> If they're using the LEDA or LEDB PWMs, providing and exporting
> a brightness control would be easy.  If they're using the other
> two PWMs, it'd be more work.
The configuration is as follows:
LEDA - keypad backlight
LEDB - power LED
PWM0 - LCD backlight
PWM1 - charger LED

So we need PWM0 to be "real LED" most (and backlight class too),
others would be cool as "real" too, but we could live with them being
simple.

>> since we are in the same boat. A solution is needed, but I guess the
>> wolfson people can work it out :)
>
> Or maybe the Pandora people.  ;)
Well I feel confused about all this now.. I guess I'll start with
defining everything as simple GPIO LEDs.
