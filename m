From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Fri, 16 Oct 2009 09:16:18 +0200
Message-ID: <4AD81DC2.4080607@googlemail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040106010602090901040504"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:36064 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755730AbZJPHR4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 03:17:56 -0400
Received: by fxm18 with SMTP id 18so2050619fxm.37
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 00:17:19 -0700 (PDT)
In-Reply-To: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Rigby <jcrigby@gmail.com>
Cc: linux-omap@vger.kernel.org, Madhusudhan <madhu.cr@ti.com>, Steve Sakoman <sakoman@gmail.com>

This is a multi-part message in MIME format.
--------------040106010602090901040504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

John Rigby wrote:
> I have seen several discussions about lack of sdio irq support in the
> hsmmc driver but no patches.  Has anyone on this list implemented this
> and/or can anyone point me to patches?

What a coincidence ;)

I'm currently working on this. See attachment what I currently have. 
It is compile tested only against recent omap linux head. I don't have 
a board using SDIO at the moment, so no real testing possible :(

Some background, maybe it helps people to step in:

Gumstix OMAP3 based Overo air board connects Marvell 88W8686 wifi by 
MMC port 2 in 4 bit configuration [1]. The wifi performance is quite 
bad (~100kB/s). There is some rumor that this might be SDIO irq 
related [2]. There was an attempt to fix this [3] already, but this 
doesn't work [4]. Having this, I started to look into it.

I used [3], the TI Davinci driver [5] (supporting SDIO irq), the SDIO 
Simplified Specification [6] and the OMAP35x TRM [7] as starting points.

Unfortunately, the Davinci MMC registers and irqs are different 
(Davinci has a dedicated SDIO irq). But combining [3] and [5] helps to 
get an idea what has to be done.

I think the main issues of [3] were that it doesn't enable IBG for 4 
bit mode ([6] chapter 8.1.2) and that mmc_omap_irq() doesn't reset the 
irq bits.

Topics I still open:

- Is it always necessary to deal with IE _and_ ISE register? I'm not 
totally clear what the difference between these two registers are ;) 
And in which order they have to be set.

- Davinci driver [5] in line 1115 checks for data line to call 
mmc_signal_sdio_irq() for irq enable.

- Davinci driver deals with SDIO in xfer_done() (line 873)

- Davinci driver sets block size to 64 if SDIO in line 701

It would be quite nice if anybody likes to comment on attachment and 
help testing.

Many thanks and best regards

Dirk

[1] http://gumstix.net/wiki/index.php?title=Overo_Wifi

[2] http://groups.google.com/group/beagleboard/msg/14e822778c5eeb56

[3] http://groups.google.com/group/beagleboard/msg/d0eb69f4c20673be

[4] http://groups.google.com/group/beagleboard/msg/5cdfe2a319531937

[5] 
http://arago-project.org/git/projects/?p=linux-davinci.git;a=blob;f=drivers/mmc/host/davinci_mmc.c;h=1bf0587250614c6d8abfe02028b96e0e47148ac8;hb=HEAD

[6] http://www.sdcard.org/developers/tech/sdio/sd_bluetooth_spec/

[7] http://focus.ti.com/lit/ug/spruf98c/spruf98c.pdf


--------------040106010602090901040504
Content-Type: text/plain;
 name="omap_hsmmc_sdio_irq_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_hsmmc_sdio_irq_patch.txt"

Subject: [PATCH][RFC] OMAP HSMMC: Add SDIO interrupt support
Form: Dirk Behme <dirk.behme@googlemail.com>

At the moment, OMAP HSMMC driver supports only SDIO polling, resulting in poor
performance. Add support for SDIO interrupt handling. 

Signed-off-by: Dirk Behme <dirk.behme@googlemail.com>
---

Patch against recent omap-linux head "Linux omap got rebuilt from scratch"
274c94b29ee7c53609a756acca974e4742c59559

Compile tested only. Please comment and help testing.

 drivers/mmc/host/omap_hsmmc.c |   48 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

Index: linux-beagle/drivers/mmc/host/omap_hsmmc.c
===================================================================
--- linux-beagle.orig/drivers/mmc/host/omap_hsmmc.c
+++ linux-beagle/drivers/mmc/host/omap_hsmmc.c
@@ -27,6 +27,7 @@
 #include <linux/timer.h>
 #include <linux/clk.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
 #include <linux/mmc/core.h>
 #include <linux/io.h>
 #include <linux/semaphore.h>
@@ -65,6 +66,7 @@
 #define SDVSDET			0x00000400
 #define AUTOIDLE		0x1
 #define SDBP			(1 << 8)
+#define IBG			(1 << 19)
 #define DTO			0xe
 #define ICE			0x1
 #define ICS			0x2
@@ -76,6 +78,7 @@
 #define INT_EN_MASK		0x307F0033
 #define BWR_ENABLE		(1 << 4)
 #define BRR_ENABLE		(1 << 5)
+#define CIRQ_ENABLE		(1 << 8)
 #define INIT_STREAM		(1 << 1)
 #define DP_SELECT		(1 << 21)
 #define DDIR			(1 << 4)
@@ -87,6 +90,7 @@
 #define CC			0x1
 #define TC			0x02
 #define OD			0x1
+#define CIRQ			(1 <<  8)
 #define ERR			(1 << 15)
 #define CMD_TIMEOUT		(1 << 16)
 #define DATA_TIMEOUT		(1 << 20)
@@ -653,6 +657,15 @@ static irqreturn_t omap_hsmmc_irq(int ir
 	status = OMAP_HSMMC_READ(host->base, STAT);
 	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
 
+	if (status & CIRQ) {
+		dev_dbg(mmc_dev(host->mmc), "SDIO interrupt");
+		OMAP_HSMMC_WRITE(host->base, IE, OMAP_HSMMC_READ(host->base, IE)
+				 & ~(CIRQ_ENABLE));
+		mmc_signal_sdio_irq(host->mmc);
+		spin_unlock(&host->irq_lock);
+		return IRQ_HANDLED;
+	}
+
 	if (status & ERR) {
 #ifdef CONFIG_MMC_DEBUG
 		omap_hsmmc_report_irq(host, status);
@@ -1165,8 +1178,15 @@ static void omap_hsmmc_set_ios(struct mm
 		break;
 	case MMC_BUS_WIDTH_4:
 		OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
-		OMAP_HSMMC_WRITE(host->base, HCTL,
-			OMAP_HSMMC_READ(host->base, HCTL) | FOUR_BIT);
+		if (mmc_card_sdio(host->mmc->card)) {
+			OMAP_HSMMC_WRITE(host->base, HCTL,
+					 OMAP_HSMMC_READ(host->base, HCTL)
+					 | IBG | FOUR_BIT);
+		} else {
+			OMAP_HSMMC_WRITE(host->base, HCTL,
+					 OMAP_HSMMC_READ(host->base, HCTL)
+					 | FOUR_BIT);
+		}
 		break;
 	case MMC_BUS_WIDTH_1:
 		OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
@@ -1512,6 +1532,24 @@ static int omap_hsmmc_disable_fclk(struc
 	return 0;
 }
 
+static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	u32 ie, ise;
+
+	ise = OMAP_HSMMC_READ(host->base, ISE);
+	ie  = OMAP_HSMMC_READ(host->base, IE);
+
+	if (enable) {
+		OMAP_HSMMC_WRITE(host->base, ISE, ise | CIRQ_ENABLE);
+		OMAP_HSMMC_WRITE(host->base, IE,  ie  | CIRQ_ENABLE);
+	} else {
+		OMAP_HSMMC_WRITE(host->base, ISE, ise & ~CIRQ_ENABLE);
+		OMAP_HSMMC_WRITE(host->base, IE,  ie  & ~CIRQ_ENABLE);
+	}
+
+}
+
 static const struct mmc_host_ops omap_hsmmc_ops = {
 	.enable = omap_hsmmc_enable_fclk,
 	.disable = omap_hsmmc_disable_fclk,
@@ -1519,7 +1557,7 @@ static const struct mmc_host_ops omap_hs
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 static const struct mmc_host_ops omap_hsmmc_ps_ops = {
@@ -1529,7 +1567,7 @@ static const struct mmc_host_ops omap_hs
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1734,7 +1772,7 @@ static int __init omap_hsmmc_probe(struc
 	mmc->max_seg_size = mmc->max_req_size;
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-		     MMC_CAP_WAIT_WHILE_BUSY;
+		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_SDIO_IRQ;
 
 	if (mmc_slot(host).wires >= 8)
 		mmc->caps |= MMC_CAP_8_BIT_DATA;

--------------040106010602090901040504--
