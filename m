From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] ARM: dts: sbc-t3x: add more features support
Date: Fri, 21 Nov 2014 16:02:15 -0800
Message-ID: <20141122000214.GH7046@atomide.com>
References: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40744 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751170AbaKVACZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 19:02:25 -0500
Content-Disposition: inline
In-Reply-To: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Dmitry Lifshitz <lifshitz@compulab.co.il> [141118 01:15]:
> Add support for more SBC-T3x single board computers features:
> 
> * CM-T3x CoM and SB-T35 baseboard EEPROMs
> * TV out
> * Touchscreen
> * CM-T3x30 audio
> * CM-T3x30 keypad

Applying all into omap-for-v3.19/dt-v2 thanks.

Tony
 
> Dmitry Lifshitz (9):
>   ARM: dts: cm-t3x: cleanup comments indentation
>   ARM: dts: cm-t3x: add ADS7846 touchscreen support
>   ARM: OMAP2+: remove cm-t3x touchscreen pdata quirk
>   ARM: dts: cm-t3x: add EEPROM support
>   ARM: dts: sb-t35: add EEPROM support
>   ARM: dts: cm-t3x: add TV out support
>   ARM: dts: sbc-t3x: add TV out display alias
>   ARM: dts: sbc-t3x30: add audio support
>   ARM: dts: cm-t3x30: add keypad support
> 
>  arch/arm/boot/dts/omap3-cm-t3x.dtsi   |  119 +++++++++++++++++++++++++++++++--
>  arch/arm/boot/dts/omap3-cm-t3x30.dtsi |   31 +++++++++
>  arch/arm/boot/dts/omap3-sb-t35.dtsi   |   36 ++++++++++
>  arch/arm/boot/dts/omap3-sbc-t3517.dts |    1 +
>  arch/arm/boot/dts/omap3-sbc-t3530.dts |    1 +
>  arch/arm/boot/dts/omap3-sbc-t3730.dts |    1 +
>  arch/arm/mach-omap2/pdata-quirks.c    |    3 -
>  7 files changed, 183 insertions(+), 9 deletions(-)
> 
> -- 
> 1.7.5.4
> 
