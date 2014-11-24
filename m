From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] ARM: dts: sbc-t3x: add audio and TV out support
Date: Mon, 24 Nov 2014 07:58:42 -0800
Message-ID: <20141124155841.GD2817@atomide.com>
References: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52507 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbaKXQBS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 11:01:18 -0500
Content-Disposition: inline
In-Reply-To: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Dmitry Lifshitz <lifshitz@compulab.co.il> [141123 01:44]:
> Add support for more SBC-T3x single board computers features:
> 
> * Audio on CM-T3x30
> * TV out on CM-T3x
> 
> This patch set adds missing I2C1 pinmux required for CM-T3x EEPROM and 
> CM-T3x30 audio support.

Thanks applying into omap-for-v3.19/dt-v2. Let's also do fixes
only for v3.19 from now on as -rc6 is tagged.

Regards,

Tony
 
> Dmitry Lifshitz (4):
>   ARM: dts: cm-t3x: add I2C1 pinmux
>   ARM: dts: cm-t3x: add TV out support
>   ARM: dts: sbc-t3x: add TV out display alias
>   ARM: dts: sbc-t3x30: add audio support
> 
>  arch/arm/boot/dts/omap3-cm-t3x.dtsi   |   48 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-cm-t3x30.dtsi |   18 ++++++++++++
>  arch/arm/boot/dts/omap3-sb-t35.dtsi   |   16 +++++++++++
>  arch/arm/boot/dts/omap3-sbc-t3517.dts |    1 +
>  arch/arm/boot/dts/omap3-sbc-t3530.dts |    1 +
>  arch/arm/boot/dts/omap3-sbc-t3730.dts |    1 +
>  6 files changed, 85 insertions(+), 0 deletions(-)
> 
> -- 
> 1.7.5.4
> 
