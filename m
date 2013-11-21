From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap4-panda-common: Fix pin muxing for
 wl12xx
Date: Thu, 21 Nov 2013 11:27:49 -0600
Message-ID: <528E4295.2040109@ti.com>
References: <1385041804-19115-1-git-send-email-balajitk@ti.com> <1385041804-19115-2-git-send-email-balajitk@ti.com> <20131121165823.GM10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36853 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211Ab3KUR2O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Nov 2013 12:28:14 -0500
In-Reply-To: <20131121165823.GM10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>
Cc: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 11/21/2013 10:58 AM, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [131121 05:51]:
>> pin mux wl12xx_gpio and wl12xx_pins should be part of omap4_pmx_core
>> and not omap4_pmx_wkup. So, move wl12xx_* to omap4_pmx_core.
>>
>> Fix the following error message:
>> pinctrl-single 4a31e040.pinmux: mux offset out of range: 0x38 (0x38)
>> pinctrl-single 4a31e040.pinmux: could not add functions for pinmux_wl12xx_pins 56x

Why is the led pins moved then?

>> SDIO card is not detected after moving pin mux to omap4_pmx_core since
>> sdmmc5_clk pull is disabled. Enable Pull up on sdmmc5_clk to detect SDIO card.
> Cool, does this fix the issue with the WLAN not coming up after a warm reset
> on panda?
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
------------------
Dan Murphy

