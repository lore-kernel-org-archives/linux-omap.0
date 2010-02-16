From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: PATCH[V2 1/3]: Update Platform files for SPI
Date: Tue, 16 Feb 2010 20:08:13 +0530 (IST)
Message-ID: <45106.10.24.255.18.1266331093.squirrel@dbdmail.itg.ti.com>
References: <9629.10.24.255.17.1265192505.squirrel@dbdmail.itg.ti.com>
    <20100209222513.GJ21755@atomide.com>
    <fa686aa41002091440p588ad328i14d0fb28390b2672@mail.gmail.com>
    <20100209230710.GL21755@atomide.com>
    <20100212214825.GV21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41451 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055Ab0BPOi2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 09:38:28 -0500
In-Reply-To: <20100212214825.GV21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net

> * Tony Lindgren <tony@atomide.com> [100209 15:03]:
>> * Grant Likely <grant.likely@secretlab.ca> [100209 14:38]:
>> > On Tue, Feb 9, 2010 at 3:25 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > > * Hemanth V <hemanthv@ti.com> [100203 02:19]:
>> > >> From ee48142ddc43129a21676dbb56a83e3e7d8063de Mon Sep 17 00:00:00 2001
>> > >> From: Hemanth V <hemanthv@ti.com>
>> > >> Date: Fri, 27 Nov 2009 14:22:30 +0530
>> > >> Subject: [PATCH] Update platform files
>> > >>
>> > >> This patch updates platform files for
>> > >> fifo, slave support
>> > >>
>> > >> Signed-off-by: Hemanth V <hemanthv@ti.com>
>> > >
>> > > This should get merged via the spi-devel list with the other patches.
>> > >
>> > > Acked-by: Tony Lindgren <tony@atomide.com>
>> >
>> > Personally, I prefer not to carry arch/* changes in my next-spi
>> > branch, since it means that my pull requests are less obvious for
>> > Linus and there is greater chance of conflict.
>> >
>> > But if you still really want me to merge it through my tree, (or if
>> > getting the patches out of order will break things) then I'll pick it
>> > up.  Just let me know.
>>
>> OK, if you ack it, I'll add the header into omap for-next. That
>> might break git bisect for some configurations depending in which
>> order the patches get pulled by Linus..
>>
>> I guess eventually this header should not live under plat.
>
> Hemanth, the patch is missing line breaks so it won't apply:
>
> http://patchwork.kernel.org/patch/76675/
>
> Please resend, I'm not editing patches manually any longer thanks.
>
> Regards,
>
> Tony
>
Pl find the patches attached, hopefully it doesnot get corrupted this
time

>From ee48142ddc43129a21676dbb56a83e3e7d8063de Mon Sep 17 00:00:00 2001
From: Hemanth V <hemanthv@ti.com>
Date: Fri, 27 Nov 2009 14:22:30 +0530
Subject: [PATCH] Update platform files

This patch updates platform files for
fifo, slave support

Signed-off-by: Hemanth V <hemanthv@ti.com>
---
 arch/arm/mach-omap2/devices.c           |    5 +++++
 arch/arm/plat-omap/include/plat/mcspi.h |   29 ++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 733d3dc..79b5396 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -282,6 +282,7 @@ static inline void omap_init_sti(void) {}

 static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
 	.num_cs		= 4,
+	.force_cs_mode	= 1,
 };

 static struct resource omap2_mcspi1_resources[] = {
@@ -304,6 +305,10 @@ static struct platform_device omap2_mcspi1 = {

 static struct omap2_mcspi_platform_config omap2_mcspi2_config = {
 	.num_cs		= 2,
+	.mode		= OMAP2_MCSPI_MASTER,
+	.dma_mode	= 0,
+	.force_cs_mode	= 0,
+	.fifo_depth	= 0,
 };

 static struct resource omap2_mcspi2_resources[] = {
diff --git a/arch/arm/plat-omap/include/plat/mcspi.h
b/arch/arm/plat-omap/include/plat/mcspi.h
index 1254e49..ffda0a1 100644
--- a/arch/arm/plat-omap/include/plat/mcspi.h
+++ b/arch/arm/plat-omap/include/plat/mcspi.h
@@ -1,8 +1,35 @@
 #ifndef _OMAP2_MCSPI_H
 #define _OMAP2_MCSPI_H

+#define OMAP2_MCSPI_MASTER		0
+#define OMAP2_MCSPI_SLAVE		1
+
+/**
+ * struct omap2_mcspi_platform_config - McSPI controller configuration
+ * @num_cs: Number of chip selects or channels supported
+ * @mode: SPI is master or slave
+ * @dma_mode: Use only DMA for data transfers
+ * @force_cs_mode: Use force chip select mode or auto chip select mode
+ * @fifo_depth: FIFO depth in bytes, max value 64
+ *
+ * @dma_mode when set to 1 uses only dma for data transfers
+ * else the default behaviour is to use PIO mode for transfer
+ * size of 8 bytes or less. This mode is useful when mcspi
+ * is configured as slave
+ *
+ * @force_cs_mode when set to 1 allows continuous transfer of multiple
+ * spi words without toggling the chip select line.
+ *
+ * @fifo_depth when set to non zero values enables FIFO. fifo_depth
+ * should be set as a multiple of buffer size used for read/write.
+ */
+
 struct omap2_mcspi_platform_config {
-	unsigned short	num_cs;
+	u8	num_cs;
+	u8	mode;
+	u8	dma_mode;
+	u8	force_cs_mode;
+	unsigned short fifo_depth;
 };

 struct omap2_mcspi_device_config {
-- 
1.5.6.3



