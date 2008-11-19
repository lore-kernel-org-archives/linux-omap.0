From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] OMAP: MCSPI: Enable mcspi wake-up
Date: Wed, 19 Nov 2008 09:57:33 +0200
Message-ID: <87skpof8r6.fsf@trdhcp146196.ntc.nokia.com>
References: <1227013237-13650-1-git-send-email-jouni.hogander@nokia.com>
	<20081118133209.GY20808@gandalf.research.nokia.com>
	<200811180915.35230.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46133 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbYKSH5o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 02:57:44 -0500
In-Reply-To: <200811180915.35230.david-b@pacbell.net> (ext David Brownell's
	message of "Tue, 18 Nov 2008 09:15:34 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dbrownell@users.sourceforge.net
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org

"ext David Brownell" <david-b@pacbell.net> writes:

> On Tuesday 18 November 2008, Felipe Balbi wrote:
>> > +#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0(0x2 << 3)
>> > +#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0(0x1 << 2)
>>=20
>> could you follow the convention below and use (1 << offset) ??
>
> Or even BIT(offset).

I'm usually not too willing to do changes more than what is needed to
do the job. Just to reduce amount of patch versions from me:)
Average for me is something like 0.2 version/changed line:) Patch below
would mean something like 6 versions:

=46rom 721bf914c53feb4fbcc9cd1d5dcc8597067519c9 Mon Sep 17 00:00:00 200=
1
=46rom: Jouni Hogander <jouni.hogander@nokia.com>
Date: Wed, 19 Nov 2008 09:41:11 +0200
Subject: [PATCH] OMAP: MCSPI: Convert bit shifted values into BIT forma=
t


Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 drivers/spi/omap2_mcspi.c |   50 ++++++++++++++++++++++---------------=
-------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index d7e519c..aa93e46 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -59,40 +59,40 @@
=20
 /* per-register bitmasks: */
=20
-#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE	(2 << 3)
-#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP	(1 << 2)
-#define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	(1 << 0)
-#define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	(1 << 1)
+#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE	BIT(4)
+#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP	BIT(2)
+#define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	BIT(0)
+#define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	BIT(1)
=20
-#define OMAP2_MCSPI_SYSSTATUS_RESETDONE	(1 << 0)
+#define OMAP2_MCSPI_SYSSTATUS_RESETDONE	BIT(0)
=20
-#define OMAP2_MCSPI_MODULCTRL_SINGLE	(1 << 0)
-#define OMAP2_MCSPI_MODULCTRL_MS	(1 << 2)
-#define OMAP2_MCSPI_MODULCTRL_STEST	(1 << 3)
+#define OMAP2_MCSPI_MODULCTRL_SINGLE	BIT(0)
+#define OMAP2_MCSPI_MODULCTRL_MS	BIT(2)
+#define OMAP2_MCSPI_MODULCTRL_STEST	BIT(3)
=20
-#define OMAP2_MCSPI_CHCONF_PHA		(1 << 0)
-#define OMAP2_MCSPI_CHCONF_POL		(1 << 1)
+#define OMAP2_MCSPI_CHCONF_PHA		BIT(0)
+#define OMAP2_MCSPI_CHCONF_POL		BIT(1)
 #define OMAP2_MCSPI_CHCONF_CLKD_MASK	(0x0f << 2)
-#define OMAP2_MCSPI_CHCONF_EPOL		(1 << 6)
+#define OMAP2_MCSPI_CHCONF_EPOL		BIT(6)
 #define OMAP2_MCSPI_CHCONF_WL_MASK	(0x1f << 7)
-#define OMAP2_MCSPI_CHCONF_TRM_RX_ONLY	(0x01 << 12)
-#define OMAP2_MCSPI_CHCONF_TRM_TX_ONLY	(0x02 << 12)
+#define OMAP2_MCSPI_CHCONF_TRM_RX_ONLY	BIT(12)
+#define OMAP2_MCSPI_CHCONF_TRM_TX_ONLY	BIT(13)
 #define OMAP2_MCSPI_CHCONF_TRM_MASK	(0x03 << 12)
-#define OMAP2_MCSPI_CHCONF_DMAW		(1 << 14)
-#define OMAP2_MCSPI_CHCONF_DMAR		(1 << 15)
-#define OMAP2_MCSPI_CHCONF_DPE0		(1 << 16)
-#define OMAP2_MCSPI_CHCONF_DPE1		(1 << 17)
-#define OMAP2_MCSPI_CHCONF_IS		(1 << 18)
-#define OMAP2_MCSPI_CHCONF_TURBO	(1 << 19)
-#define OMAP2_MCSPI_CHCONF_FORCE	(1 << 20)
+#define OMAP2_MCSPI_CHCONF_DMAW		BIT(14)
+#define OMAP2_MCSPI_CHCONF_DMAR		BIT(15)
+#define OMAP2_MCSPI_CHCONF_DPE0		BIT(16)
+#define OMAP2_MCSPI_CHCONF_DPE1		BIT(17)
+#define OMAP2_MCSPI_CHCONF_IS		BIT(18)
+#define OMAP2_MCSPI_CHCONF_TURBO	BIT(19)
+#define OMAP2_MCSPI_CHCONF_FORCE	BIT(20)
=20
-#define OMAP2_MCSPI_CHSTAT_RXS		(1 << 0)
-#define OMAP2_MCSPI_CHSTAT_TXS		(1 << 1)
-#define OMAP2_MCSPI_CHSTAT_EOT		(1 << 2)
+#define OMAP2_MCSPI_CHSTAT_RXS		BIT(0)
+#define OMAP2_MCSPI_CHSTAT_TXS		BIT(1)
+#define OMAP2_MCSPI_CHSTAT_EOT		BIT(2)
=20
-#define OMAP2_MCSPI_CHCTRL_EN		(1 << 0)
+#define OMAP2_MCSPI_CHCTRL_EN		BIT(0)
=20
-#define OMAP2_MCSPI_WAKEUPENABLE_WKEN	(1 << 0)
+#define OMAP2_MCSPI_WAKEUPENABLE_WKEN	BIT(0)
=20
 /* We have 2 DMA channels per CS, one for RX and one for TX */
 struct omap2_mcspi_dma {
--=20
1.6.0.1

=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
