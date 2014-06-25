From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v1 3/3] ARM: dts: am335x-bone: add support for
 beaglebone LCD4 cape
Date: Wed, 25 Jun 2014 04:38:53 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAF7327@DBDE04.ent.ti.com>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-4-git-send-email-pekon@ti.com>
 <20140624150336.GA10041@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37202 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbaFYEjY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2014 00:39:24 -0400
In-Reply-To: <20140624150336.GA10041@arch.cereza>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Tony Lindgren <tony@atomide.com>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, =?iso-8859-1?Q?Guido_Mart=EDnez?= <guido@vanguardiasur.com.ar>

>From: Ezequiel Garcia
>>On 24 Jun 05:54 PM, Pekon Gupta wrote:
>> This patch adds support for LCD4 cape as advertised on
>>   http://elinux.org/CircuitCo:BeagleBone_LCD4
>>
>> This cape has:
>> * 480x272 TFT-LCD panel
>>  - LCD panel datasheet and timing information are sourced from [1]
>>  - LCD backlight is connected to 'EHRPWM1A' on cape board, but its used for
>>    enabling backlight power-supply. So 'gpio-backlight' driver is used instead
>>    of 'pwm-backlight' driver (Kconfig: BACKLIGHT_GPIO=y).
>>
>
>I'm confused about this, can you clarify why you are not using pwm-backlight?
>

As per the schematics of this LCD4 cape board, "EHRPWM1A" pin controls
enabling/disabling of the power to backlight LED. It does not control the
voltage levels (brightness levels) of the LED. Thus it wasn't making sense
to use pwm-backlight driver which more suitable in cases where you have
multiple levels of brightness.
Here, you have only 2 levels "backlight=off | on", so I used gpio-backlight driver.
Though you can use pwm-backlight driver also, but the backlight turns ON
only when you set the /sys/class/backlight/<backlight_device>/brighteness
to maximum level (as set in DT).


with regards, pekon
