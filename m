From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP dts: Only build dtb if associated SoC is built
Date: Tue, 6 May 2014 10:18:28 -0700
Message-ID: <20140506171827.GP18474@atomide.com>
References: <1399162297-23527-1-git-send-email-pbrobinson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63897 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbaEFRSc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2014 13:18:32 -0400
Content-Disposition: inline
In-Reply-To: <1399162297-23527-1-git-send-email-pbrobinson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Robinson <pbrobinson@gmail.com>
Cc: linux-omap@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org

* Peter Robinson <pbrobinson@gmail.com> [140503 17:12]:
> With ARCH_OMAP2PLUS being separated out into OMAP2/3/4/5 etc all the TI device
> tree blobs are built no matter the combination of SoCs that are enabled. This
> often causes a bunch of irrelevant .dts to be built on a multi platform kernel,
> this enables the building of just the ones relevant to the SoCs that are
> actually enabled. It also orders the dts file alphabetically.

Sure, makes sense and grouping + sorting also helps to avoid trivial
merge conflicts.

I've changed the ordering a bit as am335x is based on omap3, and
omap43x based on omap4. And 3517 is an omap3 with the faster
Ethernet and few other changes.

I'll apply the following patch into omap-for-v3.16/dt. BTW, looks
like you missed a Signed-off-by in your original patch.

Regards,

Tony


From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 4 May 2014 01:11:37 +0100
Subject: [PATCH] ARM: OMAP dts: Only build dtb if associated SoC is built

With ARCH_OMAP2PLUS being separated out into OMAP2/3/4/5 etc all the TI device
tree blobs are built no matter the combination of SoCs that are enabled. This
often causes a bunch of irrelevant .dts to be built on a multi platform kernel,
this enables the building of just the ones relevant to the SoCs that are
actually enabled. It also orders the dts file alphabetically.

This also helps to avoid trivial merge conflicts when adding support
for new boards.

[tony@atomide.com: updated the order for am335x and am43x, moved am3517 to omap3]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 377b7c3..6efdd3e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -230,65 +230,65 @@ dtb-$(CONFIG_ARCH_NOMADIK) += ste-nomadik-s8815.dtb
 dtb-$(CONFIG_ARCH_NSPIRE) += nspire-cx.dtb \
 	nspire-tp.dtb \
 	nspire-clp.dtb
-dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
-	omap2430-sdp.dtb \
+dtb-$(CONFIG_ARCH_OMAP2) += omap2420-h4.dtb \
 	omap2420-n800.dtb \
 	omap2420-n810.dtb \
 	omap2420-n810-wimax.dtb \
+	omap2430-sdp.dtb
+dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
+	am3517-evm.dtb \
+	am3517_mt_ventoux.dtb \
 	omap3430-sdp.dtb \
 	omap3-beagle.dtb \
+	omap3-beagle-xm.dtb \
+	omap3-beagle-xm-ab.dtb \
 	omap3-cm-t3517.dtb \
-	omap3-sbc-t3517.dtb \
 	omap3-cm-t3530.dtb \
-	omap3-sbc-t3530.dtb \
 	omap3-cm-t3730.dtb \
-	omap3-sbc-t3730.dtb \
 	omap3-devkit8000.dtb \
-	omap3-beagle-xm.dtb \
-	omap3-beagle-xm-ab.dtb \
 	omap3-evm.dtb \
 	omap3-evm-37xx.dtb \
+	omap3-gta04.dtb \
+	omap3-igep0020.dtb \
+	omap3-igep0030.dtb \
 	omap3-ldp.dtb \
+	omap3-lilly-dbb056.dtb \
 	omap3-n900.dtb \
 	omap3-n9.dtb \
 	omap3-n950.dtb \
 	omap3-overo-alto35.dtb \
-	omap3-overo-storm-alto35.dtb \
 	omap3-overo-chestnut43.dtb \
-	omap3-overo-storm-chestnut43.dtb \
 	omap3-overo-gallop43.dtb \
-	omap3-overo-storm-gallop43.dtb \
 	omap3-overo-palo43.dtb \
+	omap3-overo-storm-alto35.dtb \
+	omap3-overo-storm-chestnut43.dtb \
+	omap3-overo-storm-gallop43.dtb \
 	omap3-overo-storm-palo43.dtb \
-	omap3-overo-summit.dtb \
 	omap3-overo-storm-summit.dtb \
-	omap3-overo-tobi.dtb \
 	omap3-overo-storm-tobi.dtb \
-	omap3-gta04.dtb \
-	omap3-igep0020.dtb \
-	omap3-igep0030.dtb \
-	omap3-lilly-dbb056.dtb \
-	omap3-zoom3.dtb \
-	omap4-duovero-parlor.dtb \
+	omap3-overo-summit.dtb \
+	omap3-overo-tobi.dtb \
+	omap3-sbc-t3517.dtb \
+	omap3-sbc-t3530.dtb \
+	omap3-sbc-t3730.dtb \
+	omap3-zoom3.dtb
+dtb-$(CONFIG_SOC_AM33XX) += am335x-base0033.dtb \
+	am335x-bone.dtb \
+	am335x-boneblack.dtb \
+	am335x-evm.dtb \
+	am335x-evmsk.dtb \
+	am335x-nano.dtb
+dtb-$(CONFIG_ARCH_OMAP4) += omap4-duovero-parlor.dtb \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
 	omap4-panda-es.dtb \
-	omap4-var-som.dtb \
 	omap4-sdp.dtb \
 	omap4-sdp-es23plus.dtb \
-	omap5-uevm.dtb \
-	am335x-evm.dtb \
-	am335x-evmsk.dtb \
-	am335x-bone.dtb \
-	am335x-boneblack.dtb \
-	am335x-nano.dtb \
-	am335x-base0033.dtb \
-	am3517-craneboard.dtb \
-	am3517-evm.dtb \
-	am3517_mt_ventoux.dtb \
-	am43x-epos-evm.dtb \
-	am437x-gp-evm.dtb \
-	dra7-evm.dtb
+	omap4-var-som.dtb
+dtb-$(CONFIG_SOC_AM43XX) += am43x-epos-evm.dtb \
+	am437x-gp-evm.dtb
+dtb-$(CONFIG_SOC_OMAP5) += omap5-uevm.dtb
+dtb-$(CONFIG_SOC_DRA7XX) += dra7-evm.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_QCOM) += qcom-msm8660-surf.dtb \
