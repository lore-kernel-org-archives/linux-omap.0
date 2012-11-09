From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: DTS for 3.8 part 2
Date: Fri, 9 Nov 2012 14:00:05 -0800
Message-ID: <20121109220005.GU6801@atomide.com>
References: <509D0CC4.4080305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23468 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755906Ab2KIWAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 17:00:10 -0500
Content-Disposition: inline
In-Reply-To: <509D0CC4.4080305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "AnilKumar, Chimata" <anilkumar@ti.com>, Ricardo Neri <ricardo.neri@ti.com>, "Vutla, Lokesh" <lokeshvutla@ti.com>, "Mohammed, Afzal" <afzal@ti.com>

* Benoit Cousson <b-cousson@ti.com> [121109 06:03]:
> Hi Tony,
> 
> Please pull some more OMAP5 and AM33xx data for 3.8.

Thanks pulling into omap-for-v3.8/dt.

Regards,

Tony

> 
> Thanks,
> Benoit
> 
> 
> 
> The following changes since commit 3b3132f7e80e3d786f8ad5d5b97d4b6122be9aaa:
>   Jon Hunter (1):
>         ARM: dts: OMAP5: Add counter node
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.8/dts_part2
> 
> Afzal Mohammed (1):
>       usb: musb: dsps: dt binding - add resources, example
> 
> Ajay Kumar Gupta (1):
>       ARM: dts: AM33XX: Add usbss node
> 
> AnilKumar Ch (10):
>       ARM: dts: AM33XX: Add pinmux configuration for matrix keypad to EVM
>       ARM: dts: AM33XX: Add matrix keypad device tree data to am335x-evm
>       ARM: dts: AM33XX: Add pinmux configuration for volume-keys to EVM
>       ARM: dts: AM33XX: Add volume-keys device tree data to am335x-evm
>       ARM: dts: AM33XX: Add pinmux configuration for user-leds to BONE
>       ARM: dts: AM33XX: Add user-leds device tree data to am335x-bone
>       ARM: dts: AM33XX: Add pinmux configuration for gpio-leds to EVMSK
>       ARM: dts: AM33XX: Add user-leds device tree data to am335x-evmsk
>       ARM: dts: AM33XX: Add pinmux configuration for gpio-keys to EVMSK
>       ARM: dts: AM33XX: Add push-buttons device tree data to am335x-evmsk
> 
> Benoit Cousson (1):
>       ARM: dts: Makefile: Add the am335x-evmsk target in dtbs list
> 
> Lokesh Vutla (3):
>       ARM: dts: omap5-evm: Fix size of memory defined for EVM
>       ARM: dts: omap5: EMIF device tree data for OMAP5 boards
>       ARM: dts: omap5-evm: LPDDR2 memory device details for EVM
> 
> Ricardo Neri (2):
>       ARM: dts: omap4-panda: Add pinmux configuration for HDMI
>       ARM: dts: omap4-sdp: Add pinmux configuration for HDMI
> 
>  .../devicetree/bindings/usb/am33xx-usb.txt         |   21 +++++
>  arch/arm/boot/dts/Makefile                         |    1 +
>  arch/arm/boot/dts/am335x-bone.dts                  |   44 ++++++++++
>  arch/arm/boot/dts/am335x-evm.dts                   |   63 +++++++++++++++
>  arch/arm/boot/dts/am335x-evmsk.dts                 |   84 ++++++++++++++++++++
>  arch/arm/boot/dts/am33xx.dtsi                      |   17 ++++
>  arch/arm/boot/dts/omap4-panda-a4.dts               |   17 ++++
>  arch/arm/boot/dts/omap4-panda-es.dts               |    9 ++
>  arch/arm/boot/dts/omap4-panda.dts                  |   18 ++++
>  arch/arm/boot/dts/omap4-sdp-es23plus.dts           |   17 ++++
>  arch/arm/boot/dts/omap4-sdp.dts                    |   18 ++++
>  arch/arm/boot/dts/omap5-evm.dts                    |   13 +++-
>  arch/arm/boot/dts/omap5.dtsi                       |   22 +++++
>  arch/arm/boot/dts/samsung_k3pe0e000b.dtsi          |   67 ++++++++++++++++
>  14 files changed, 410 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap4-panda-a4.dts
>  create mode 100644 arch/arm/boot/dts/omap4-sdp-es23plus.dts
>  create mode 100644 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
