From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH 00/18] omap platform data and board updates for 2.6.35 merge window
Date: Wed, 5 May 2010 22:21:13 +0200
Message-ID: <5555D7E5-3848-4915-A7B0-1CD1732E1C69@student.utwente.nl>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:63886 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902Ab0EEUVT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 16:21:19 -0400
Received: by ewy22 with SMTP id 22so1610029ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 13:21:16 -0700 (PDT)
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

Tony,

Any chance of https://patchwork.kernel.org/patch/94049/ going in as well? Tomi has acked it already.

regards,

Koen

Op 5 mei 2010, om 21:32 heeft Tony Lindgren het volgende geschreven:

> Hi all,
> 
> Here are some omap patches for review. This series is pretty much
> all platform data and board init updates for omap1/2/3.
> 
> The omap4 patches are still coming, but seem to need a bit more work.
> 
> Regards,
> 
> Tony
> 
> ---
> 
> Ajay Kumar Gupta (1):
>      AM35x: fix UI card EHCI port and LCD dependency
> 
> Janusz Krzysztofik (1):
>      omap1: amsdelta: defconfig updates
> 
> Jarkko Nikula (3):
>      omap: rx51: Change the TWL4030 VMMC2 voltage constraints andsupply name
>      omap: rx51: Add i2c2 board_info with tlv320aic3x
>      omap: rx51: Add supplies for the tlv320aic3x codec driver
> 
> Sriram (6):
>      can:ti_hecc: board specific hookup on AM3517EVM
>      can:ti_hecc: Enable CAN support on AM3517
>      AM35xx EMAC : define submodule offsets
>      AM35xx : Platform specific hookup for EMAC module
>      OMAP3 : clock data: Update name string for EMAC clocks
>      AM3517 defconfig update : enable EMAC support
> 
> Steve Sakoman (1):
>      omap: Overo: Add support for second ethernet port
> 
> Thomas Weber (2):
>      omap: Devkit8000: Add mux initialization
>      omap: Devkit8000: Update default configuration
> 
> Vaibhav Hiremath (1):
>      OMAP2/3: Add V4L2 DSS driver support in device.c
> 
> Viral Mehta (3):
>      omap2: Add I2C bus 1 initialisation for 2430sdp
>      omap2: Add OHCI USB platform init for 2430 SDP
>      omap2: select ARCH_OMAP_OTG for OMAP2430 SDP
> 
> 
> arch/arm/configs/am3517_evm_defconfig        |   92 ++++++++++++++-
> arch/arm/configs/ams_delta_defconfig         |    9 +
> arch/arm/configs/devkit8000_defconfig        |  157 +++++++++++++++-----------
> arch/arm/mach-omap2/Kconfig                  |    1 
> arch/arm/mach-omap2/board-2430sdp.c          |   21 +++
> arch/arm/mach-omap2/board-am3517evm.c        |  146 ++++++++++++++++++++++++
> arch/arm/mach-omap2/board-devkit8000.c       |  155 ++++++++++++++++++++++++++
> arch/arm/mach-omap2/board-overo.c            |   14 ++
> arch/arm/mach-omap2/board-rx51-peripherals.c |   77 +++++++++++--
> arch/arm/mach-omap2/clock3xxx_data.c         |    4 -
> arch/arm/mach-omap2/devices.c                |   28 +++++
> arch/arm/mach-omap2/include/mach/am35xx.h    |   20 +++
> 12 files changed, 632 insertions(+), 92 deletions(-)
> 
> -- 
> Signature
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

