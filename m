From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] Add support for GPIO LEDs on pandora
Date: Thu, 8 Jan 2009 17:12:35 +0200
Message-ID: <20090108151234.GR27566@atomide.com>
References: <1227780163-5879-1-git-send-email-notasas@gmail.com> <20090108143232.GO27566@atomide.com> <03538FC0-A9B7-4770-B799-6730E9F09899@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54606 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527AbZAHPMi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 10:12:38 -0500
Content-Disposition: inline
In-Reply-To: <03538FC0-A9B7-4770-B799-6730E9F09899@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>

* Koen Kooi <k.kooi@student.utwente.nl> [090108 16:56]:
>
> Op 8 jan 2009, om 15:32 heeft Tony Lindgren het volgende geschreven:
>
>> * Grazvydas Ignotas <notasas@gmail.com> [081127 12:04]:
>>> Pandora has some LEDs and backlights connected to OMAP
>>> GPIOs and TWL4030/TPS65950 LED/PWM signals. This patch
>>> registers them all with leds-gpio driver. TWL4030/TPS65950
>>> controlled ones will be switched to PWM driver when it's ready.
>>
>> Pushing to l-o tree and adding to omap3-upstream queue for next
>> merge window. Not adding the defconfig changes to upstream queue
>> right now as the patch does not apply.
>>>
>>> +		.name			= "pandora::lcd_bl",
>>> +		.default_trigger	= "backlight",
>>> +		.gpio			= -EINVAL,
>>>
>
> That's a wrong usage of the 'backlight' trigger, which shouldn't get  
> into mainline since it sets a bad example. The backlight trigger is  
> meant to sync leds with the backlight (e.g. dim keypad leds), not to  
> make leds a backlight.

OK, thanks, dropping from l-o and omap3-upstream.

Tony
