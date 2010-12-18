From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] ARM: OMAP: Power on EHCI, serial, camera and DVI on beagleboard-xM
Date: Sat, 18 Dec 2010 09:22:44 +0100
Message-ID: <B37963A7-0B47-4532-85DD-DA6769DE6A51@dominion.thruhere.net>
References: <1291725639-86397-1-git-send-email-koen@beagleboard.org> <E4A07EF4-1694-4B22-8015-0710B6BE7A2E@dominion.thruhere.net> <4D077E25.5070609@ti.com> <20101218020744.GN5941@atomide.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58258 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464Ab0LRIWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 03:22:48 -0500
Received: by wwa36 with SMTP id 36so1415098wwa.1
        for <linux-omap@vger.kernel.org>; Sat, 18 Dec 2010 00:22:46 -0800 (PST)
In-Reply-To: <20101218020744.GN5941@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


Op 18 dec 2010, om 03:07 heeft Tony Lindgren het volgende geschreven:

> * Anand Gadiyar <gadiyar@ti.com> [101214 06:25]:
>> On 12/14/2010 7:41 PM, Koen Kooi wrote:
>>> Any comments on this?
> ...
> 
>>>> 
>>>> -	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
>>>> -	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
>> 
>> This disappeared. So no more PMU STAT led?
> 
> Koen, any update on this?

I'll send and updated patch after the weekend.

regards,

Koen
