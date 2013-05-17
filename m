From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 0/2] ARM: OMAP AM33XX: clock data: Enable clkout2 output
 on SoC pad
Date: Fri, 17 May 2013 11:07:38 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC8C081@DBDE04.ent.ti.com>
References: <1367919574-21353-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55504 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349Ab3EQLII convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 07:08:08 -0400
In-Reply-To: <1367919574-21353-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Tuesday, May 07, 2013 3:10 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; Cousson, Benoit; paul@pwsan.com; linux-arm-
> kernel@lists.infradead.org; Hiremath, Vaibhav
> Subject: [PATCH 0/2] ARM: OMAP AM33XX: clock data: Enable clkout2
> output on SoC pad
> 
> 'clkout2' comes out on the device pad and is being used by various
> external on-board peripherals like, Audio codecs, Wilink and stuff.
> So enable the clkout2 by default during init sequence itself
> along with right pinmux configuration clkout2 output.
> 
> Also, add the missing entry of "clkout2_ck" to the AM33xx clock table.
> 
> As far as enabling of clkout2 during init is concerned,
> we can argue that it can be handled using DT property and enable
> the clock only when specified; but not until OMAP clock-tree
> migration to DT.
> 
> Vaibhav Hiremath (2):
>   ARM: OMAP AM33XX: clock data: Enable clkout2 as part of init
>   ARM: dts: AM33XX: Set pinmux for clkout2 pad used for clock output
> 
>  arch/arm/boot/dts/am335x-bone.dts     |    8 +++++++-
>  arch/arm/boot/dts/am335x-evm.dts      |    8 +++++++-
>  arch/arm/boot/dts/am335x-evmsk.dts    |    8 +++++++-
>  arch/arm/mach-omap2/cclock33xx_data.c |    2 ++
>  4 files changed, 23 insertions(+), 3 deletions(-)

Tony, Paul and Benoit,

Any update on this series?

Thanks,
Vaibhav

