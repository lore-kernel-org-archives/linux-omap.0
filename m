From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 00/10] ARM: dts: AM33XX: Add device tree data
Date: Mon, 5 Nov 2012 13:46:27 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA647CE@DBDE01.ent.ti.com>
References: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208Ab2KENqo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 08:46:44 -0500
In-Reply-To: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Mon, Nov 05, 2012 at 16:15:40, AnilKumar, Chimata wrote:
> Add device tree date for GPIO based various drivers matrix keypad,
> volume keys, push buttons and use leds accross three AM33XX devices
> viz EVM, BeagleBone and Starter Kit.
> 
> To make it functional this series also adds pinctrl data for all
> the GPIOs used by various drivers. In this series only default state
> pinmux/conf settings are added because of sleep/idle state pinctrl
> values are not available.
> 
> These patches are based on linux-omap-dt:for_3.8/dts tree and these

My bad, small correction in this statement, these patches apply cleanly
on linux-omap-dt:for_3.8/dts tree with the below two patches.
http://www.spinics.net/lists/arm-kernel/msg204872.html
http://www.spinics.net/lists/arm-kernel/msg204873.html

Thanks
AnilKumar

> were tested on am33xx devices according to added functionality.
> 
> AnilKumar Ch (10):
>   ARM: dts: AM33XX: Add pinmux configuration for matrix keypad to EVM
>   ARM: dts: AM33XX: Add matrix keypad device tree data to am335x-evm
>   ARM: dts: AM33XX: Add pinmux configuration for volume-keys to EVM
>   ARM: dts: AM33XX: Add volume-keys device tree data to am335x-evm
>   ARM: dts: AM33XX: Add pinmux configuration for user-leds to BONE
>   ARM: dts: AM33XX: Add user-leds device tree data to am335x-bone
>   ARM: dts: AM33XX: Add pinmux configuration for gpio-leds to EVMSK
>   ARM: dts: AM33XX: Add user-leds device tree data to am335x-evmsk
>   ARM: dts: AM33XX: Add pinmux configuration for gpio-keys to EVMSK
>   ARM: dts: AM33XX: Add push-buttons device tree data to am335x-evmsk
> 
>  arch/arm/boot/dts/am335x-bone.dts  |   44 +++++++++++++++++++
>  arch/arm/boot/dts/am335x-evm.dts   |   63 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/am335x-evmsk.dts |   84 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 191 insertions(+)
> 
> -- 
> 1.7.9.5
> 
> 

