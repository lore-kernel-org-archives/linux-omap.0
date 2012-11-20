From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: twl4030: Use only TWL4030_MODULE_LED for LED configuration
Date: Tue, 20 Nov 2012 19:42:52 +0100
Message-ID: <CACRpkda6s2_76_GAWk3u5zEvRjjtE07wSah7orym_=19vJvmRA@mail.gmail.com>
References: <1352799313-21019-1-git-send-email-peter.ujfalusi@ti.com>
	<CACRpkdayZK2sPXJW=COFi7C=P5=fbi-q7UukWbQ8dheaJ=bjAA@mail.gmail.com>
	<50A9F335.80107@ti.com>
	<CACRpkdbvXFtHoOXThUrT4Z+8nO_HJCFq-May+4zaOsNv-886LA@mail.gmail.com>
	<50AA23C4.1000706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58789 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab2KTSmz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 13:42:55 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so1875357eek.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Nov 2012 10:42:54 -0800 (PST)
In-Reply-To: <50AA23C4.1000706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, Nov 19, 2012 at 1:19 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 11/19/2012 11:40 AM, Linus Walleij wrote:
>> So what we're dealing with is: a LED-specific PWM, being used
>> as a PWM with eternal dutycycle and then being used as GPIO.
>>
>> Well, we get to deal with it ... :-/
>
> gpio/gpio-pwm driver?

Yeah something like that, but such a driver would need some huge
boilerplate saying that this approach isn't entirely sound.

Yours,
Linus Walleij
