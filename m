From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Thu, 13 Mar 2014 06:19:34 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAB2F96@DBDE04.ent.ti.com>
References: <1394621360-2457-1-git-send-email-pekon@ti.com>
 <1394621360-2457-2-git-send-email-pekon@ti.com> <532070C8.1030903@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAB2CF1@DBDE04.ent.ti.com>
 <CAGo_u6rvUqa-7afTFzBahDJuyVkXAj5J2LL8tQRjZuf8_xWXWA@mail.gmail.com>
 <CAOCHtYhqZoCF13e1YjBiWPufDEmVotL3chO9ZUtivWbVTWVfiQ@mail.gmail.com>
 <20140312192850.GF1996@atomide.com> <5320C8B5.601@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAB2E95@DBDE04.ent.ti.com>
 <20140312215337.GA5735@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53934 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaCMGUH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 02:20:07 -0400
In-Reply-To: <20140312215337.GA5735@kahuna>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>

[...]
> arch/arm/boot/dts/Makefile                    |    1 +
> arch/arm/boot/dts/am335x-bone-memory-cape.dts |  123 +++++++++++++++++++++++++
> 2 files changed, 124 insertions(+)
> create mode 100644 arch/arm/boot/dts/am335x-bone-memory-cape.dts
>
>diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>index 0320303..c5e9bfa 100644
>--- a/arch/arm/boot/dts/Makefile
>+++ b/arch/arm/boot/dts/Makefile
>@@ -226,6 +226,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
> 	am335x-evmsk.dtb \
> 	am335x-bone.dtb \
> 	am335x-boneblack.dtb \
>+	am335x-bone-memory-cape.dtb\
> 	am335x-nano.dtb \
> 	am335x-base0033.dtb \
> 	am3517-evm.dtb \
>diff --git a/arch/arm/boot/dts/am335x-bone-memory-cape.dts b/arch/arm/boot/dts/am335x-bone-memory-cape.dts
>new file mode 100644
>index 0000000..7ab088d
>--- /dev/null
>+++ b/arch/arm/boot/dts/am335x-bone-memory-cape.dts
>
>From discussions, option I could think are..

(a) NAND cape node added in both 'am335x-bone.dts' and
   'am335x-boneblack.dts' but "disabled" by default.

(b) NAND cape node in new '.dts' file (as mentioned above), and generate
   a separate blob individual for cape.

(c) NAND cape node in existing 'am335x-bone-common.dtsi', "disabled"
   by default. But there is no guarantee that future boards remain
   compatible and same 'common_xx.dtsi' can be reused later.

I'll wait for Tony/Benoit-C. to decide on what suits them, as they are the
ones who have to maintain all these. Tony ?

with regards, pekon
