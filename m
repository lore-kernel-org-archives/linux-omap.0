From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v2 2/3] ARM: dts: overo: Add support for 4.3'' LCD output
Date: Tue, 20 May 2014 15:55:32 +0200
Message-ID: <537B5ED4.3040805@epfl.ch>
References: <1400589069-21572-1-git-send-email-florian.vaussard@epfl.ch> <1400589069-21572-3-git-send-email-florian.vaussard@epfl.ch> <537B4D6B.5070106@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:56399 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291AbaETNzg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 09:55:36 -0400
In-Reply-To: <537B4D6B.5070106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org



On 05/20/2014 02:41 PM, Tomi Valkeinen wrote:
> On 20/05/14 15:31, Florian Vaussard wrote:
> 
>> +	lcd0: display@0 { +		compatible = "samsung,lte430wq-f0c",
>> "panel-dpi"; +		label = "lcd"; + +		gpios = <&gpio5 16
>> GPIO_ACTIVE_HIGH		/* gpio_144: enable */ +			 &gpio5 17
>> GPIO_ACTIVE_HIGH>;		/* gpio_145: brightness */
> 
> The panel-dpi only takes one gpio, the enable. The backlight should
> be handled with gpio-backlight driver.
> 
> The same applies for the Alto35 patch.
> 

Indeed. I will send a v3.

Regards,
Florian
