From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH RESEND 0/5] ARM: dts: AM33XX: Add device tree data
Date: Wed, 19 Sep 2012 21:23:38 +0000
Message-ID: <B7CE1C39EBFBA0428A012975D4B2FC830B5DF78F@DNCE05.ent.ti.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45914 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787Ab2ISVXs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:23:48 -0400
In-Reply-To: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, "tony@atomide.com" <tony@atomide.com>, 'paul Walmsley' <paul@pwsan.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

+ Paul

Hi Anil,

Thanks for the rebase / repost. I'll pulled the full series if Paul is OK with
  ARM: OMAP2+: AM33XX: Add clock entries to omap_clk data

Paul,
Is that OK?

Regards,
Benoit

>
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 12.654.784

-----Original Message-----
>From: AnilKumar, Chimata
>Sent: Wednesday, September 19, 2012 4:19 PM
>To: tony@atomide.com
>Cc: Cousson, Benoit; linux-arm-kernel@lists.infradead.org; linux-
>omap@vger.kernel.org; AnilKumar, Chimata
>Subject: [PATCH RESEND 0/5] ARM: dts: AM33XX: Add device tree data
>
>Add device tree data of pinctrl, d_can, lis331dlh and tmp275 drivers
>for AM33XX family of devices. These patches were submitted earlier
>and reviewed. Re-sending to apply cleanly on linux-omap/devel-dt
>tree. These patches were tested on am33xx-evm and am335x-bone.
>
>AnilKumar Ch (5):
>  ARM: dts: AM33XX: Add basic pinctrl device tree data
>  ARM: dts: AM33XX: Add D_CAN device tree data
>  ARM: OMAP2+: AM33XX: Add clock entries to omap_clk data
>  ARM: dts: AM33XX: Add lis331dlh device tree data to am335x-evm
>  ARM: dts: AM33XX: Add temperature sensor device tree data to
>    am335x-evm
>
> arch/arm/boot/dts/am335x-evm.dts     |   44
>++++++++++++++++++++++++++++++++++
> arch/arm/boot/dts/am33xx.dtsi        |   27 +++++++++++++++++++++
> arch/arm/mach-omap2/clock33xx_data.c |    1 +
> 3 files changed, 72 insertions(+)
>
>--
>1.7.9.5


