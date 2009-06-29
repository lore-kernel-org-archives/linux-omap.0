From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 3/4] OMAP3 McSPI: Adds context save/restore
Date: Mon, 29 Jun 2009 17:25:05 +0300
Message-ID: <4A48CEC1.10203@nokia.com>
References: <1245965646-20070-1-git-send-email-khilman@deeprootsystems.com> <1245965646-20070-2-git-send-email-khilman@deeprootsystems.com> <1245965646-20070-3-git-send-email-khilman@deeprootsystems.com> <1245965646-20070-4-git-send-email-khilman@deeprootsystems.com> <4A44B8D7.8020508@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080106070806090604030504"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30840 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbZF2OZU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 10:25:20 -0400
In-Reply-To: <4A44B8D7.8020508@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hemanth V <hemanthv@ti.com>, "Hogander Jouni (Nokia-D/Tampere)" <jouni.hogander@nokia.com>

This is a multi-part message in MIME format.
--------------080106070806090604030504
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Koskinen Aaro (Nokia-D/Helsinki) wrote:
> I'm afraid this patch needs more work. The optimized restoration of
> chconf can cause occasionally errors with off mode if multiple chip
> selects are in use. In practice it is needed to restore all CHxCONF
> registers, not just the one by a specific chip select.
> 
> ext Kevin Hilman wrote:
>> From: Hemanth V <hemanthv@ti.com>
>>
>> This patch adds context save/restore feature to McSPI driver.
>> This includes fixes by Aaro Koskinen
>>
>> Signed-off-by: Hemanth V <hemanthv@ti.com>
>> Reviewed-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>>  drivers/spi/omap2_mcspi.c |  134 +++++++++++++++++++++++++++++++++-----------
>>  1 files changed, 100 insertions(+), 34 deletions(-)

Here's a patch on top of PM branch that restores all the registers. This 
is basically the same what Jouni originally suggested 
(http://marc.info/?l=linux-omap&m=123366825525879&w=2).

A.

--------------080106070806090604030504
Content-Type: text/x-diff;
 name="0001-PM-OMAP-SPI-Restore-all-CHxCONF-registers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-PM-OMAP-SPI-Restore-all-CHxCONF-registers.patch"

>From 92ee5d91385e96a358d44b0e59ae3484d4191786 Mon Sep 17 00:00:00 2001
From: Aaro Koskinen <aaro.koskinen@nokia.com>
Date: Mon, 29 Jun 2009 14:20:49 +0300
Subject: [PATCH] PM: OMAP: SPI: Restore all CHxCONF registers

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/spi/omap2_mcspi.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index a75c546..264bd21 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -43,6 +43,7 @@
 
 /* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
 #define OMAP2_MCSPI_MAX_CTRL 		4
+#define OMAP2_MCSPI_MAX_CS 		4
 
 #define OMAP2_MCSPI_REVISION		0x00
 #define OMAP2_MCSPI_SYSCONFIG		0x10
@@ -134,8 +135,6 @@ struct omap2_mcspi_cs {
 	void __iomem		*base;
 	unsigned long		phys;
 	int			word_len;
-	/* Context save and restore shadow register */
-	u32			chconf0;
 };
 
 /* used for context save and restore, structure members to be updated whenever
@@ -145,6 +144,8 @@ struct omap2_mcspi_regs {
 	u32 sysconfig;
 	u32 modulctrl;
 	u32 wakeupenable;
+	/* Context save and restore shadow register for each chipselect */
+	u32 chconf0[OMAP2_MCSPI_MAX_CS];
 };
 
 static struct omap2_mcspi_regs omap2_mcspi_ctx[OMAP2_MCSPI_MAX_CTRL];
@@ -190,16 +191,16 @@ static inline u32 mcspi_read_cs_reg(const struct spi_device *spi, int idx)
 
 static inline u32 mcspi_cached_chconf0(const struct spi_device *spi)
 {
-	struct omap2_mcspi_cs *cs = spi->controller_state;
+	int cs = spi->chip_select;
 
-	return cs->chconf0;
+	return omap2_mcspi_ctx[spi->master->bus_num - 1].chconf0[cs];
 }
 
 static inline void mcspi_write_chconf0(const struct spi_device *spi, u32 val)
 {
-	struct omap2_mcspi_cs *cs = spi->controller_state;
+	int cs = spi->chip_select;
 
-	cs->chconf0 = val;
+	omap2_mcspi_ctx[spi->master->bus_num - 1].chconf0[cs] = val;
 	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, val);
 }
 
@@ -255,6 +256,8 @@ static void omap2_mcspi_set_master_mode(struct spi_master *master)
 static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 {
 	struct spi_master *spi_cntrl;
+	int cs;
+
 	spi_cntrl = mcspi->master;
 
 	/* McSPI: context restore */
@@ -266,6 +269,11 @@ static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 
 	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
 			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
+
+	for (cs = 0; cs < spi_cntrl->num_chipselect; cs++)
+		mcspi_write_reg(spi_cntrl,
+			cs * 0x14 + OMAP2_MCSPI_CHCONF0,
+			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0[cs]);
 }
 static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
 {
@@ -704,7 +712,6 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 			return -ENOMEM;
 		cs->base = mcspi->base + spi->chip_select * 0x14;
 		cs->phys = mcspi->phys + spi->chip_select * 0x14;
-		cs->chconf0 = 0;
 		spi->controller_state = cs;
 	}
 
-- 
1.5.4.3


--------------080106070806090604030504--
