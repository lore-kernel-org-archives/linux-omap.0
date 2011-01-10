From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 3/3] omap3: beaglexm: fix power on of DVI
Date: Mon, 10 Jan 2011 08:34:50 -0600
Message-ID: <4D2B190A.4020504@ti.com>
References: <[PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes> <1294441282-17986-4-git-send-email-nm@ti.com> <alpine.DEB.1.10.1101101445080.18906@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:59121 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753422Ab1AJOez (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Jan 2011 09:34:55 -0500
Received: by gyh20 with SMTP id 20so7342422gyh.34
        for <linux-omap@vger.kernel.org>; Mon, 10 Jan 2011 06:34:54 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1101101445080.18906@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>

Aaro Koskinen had written, on 01/10/2011 06:51 AM, the following:
[..]
>> +    if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
>> +        gpio_request(gpio + 1, "nDVI_PWR_EN");
>> +        gpio_direction_output(gpio + 1, 0);
>> +        gpio_request(gpio + 2, "DVI_LDO_EN");
>> +        gpio_direction_output(gpio + 2, 1);
> 
> FYI, gpiolib provides gpio_request_one() and gpio_request_array() calls
> which make code simpler. I think any new code should use those _and_
> do proper error checking.
Thanks for pointing this out. Funny why it is in 
include/asm-generic/gpio.h instead of in include/linux/gpio.h 
considering it implemented in drivers/gpio/gpiolib.c :(

Am I right in understanding that you are mentioning about DVI gpios 
alone? in that case, the LDO gpio is used for other functions as well in 
addition to driving DVI. I suppose we dont want to loose that function 
because dvi pwr_en gpio failed.

-- 
Regards,
Nishanth Menon
