From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap4-panda-common: Fix pin muxing for
 wl12xx
Date: Wed, 27 Nov 2013 21:34:31 +0530
Message-ID: <5296180F.7040104@ti.com>
References: <1385041804-19115-1-git-send-email-balajitk@ti.com> <1385041804-19115-2-git-send-email-balajitk@ti.com> <20131121165823.GM10317@atomide.com> <528E4295.2040109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41802 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab3K0QFB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 11:05:01 -0500
In-Reply-To: <528E4295.2040109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 21 November 2013 10:57 PM, Dan Murphy wrote:
> On 11/21/2013 10:58 AM, Tony Lindgren wrote:
>> * Balaji T K <balajitk@ti.com> [131121 05:51]:
>>> pin mux wl12xx_gpio and wl12xx_pins should be part of omap4_pmx_core
>>> and not omap4_pmx_wkup. So, move wl12xx_* to omap4_pmx_core.
>>>
>>> Fix the following error message:
>>> pinctrl-single 4a31e040.pinmux: mux offset out of range: 0x38 (0x38)
>>> pinctrl-single 4a31e040.pinmux: could not add functions for pinmux_wl12xx_pins 56x
>
> Why is the led pins moved then?
Hi Dan,

I just moved 27 lines (wl12xx_pins, wl12xx_gpio) up, git diff generated smaller
diff stat by moving 10 line of code (led_wkgpio_pins) further down :-)

>
>>> SDIO card is not detected after moving pin mux to omap4_pmx_core since
>>> sdmmc5_clk pull is disabled. Enable Pull up on sdmmc5_clk to detect SDIO card.
>> Cool, does this fix the issue with the WLAN not coming up after a warm reset
>> on panda?
>>
>> Regards,
>>
>> Tony
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

