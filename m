From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/10] ARM: OMAP: Fix DMA CCR programming for request
	line > 63, v2
Date: Thu, 15 Jan 2009 14:08:52 +0200
Message-ID: <20090115120849.GA4128@atomide.com>
References: <20090112144453.24205.18451.stgit@localhost> <5A47E75E594F054BAF48C5E4FC4B92AB02E678260F@dbde02.ent.ti.com> <20090112153526.GN9373@atomide.com> <20090112160114.GB6152@n2100.arm.linux.org.uk> <20090112161052.GO9373@atomide.com> <20090112161629.GC6152@n2100.arm.linux.org.uk> <20090112164044.GQ9373@atomide.com> <20090112164237.GD6152@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63516 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764671AbZAOMI4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 07:08:56 -0500
Content-Disposition: inline
In-Reply-To: <20090112164237.GD6152@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090112 18:46]:
> On Mon, Jan 12, 2009 at 06:40:45PM +0200, Tony Lindgren wrote:
> > How about this? Of course the bits should be defined for
> > DMA_SYNCHRO_CONTROL_UPPER and DMA_SYNCHRO_CONTROL, but that may not
> > count as a fix..
> 
> Ok.

One more update to fix compile on omap1 as noted by Russell.

Tony

--TB36FDmn/VVEgNH/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mcbsp-ccr-v3.patch"

>From 3127f8f8595a064b3f1a1837fea2177902589ac3 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <Lopez>
Date: Thu, 15 Jan 2009 13:09:54 +0200
Subject: [PATCH] ARM: OMAP: Fix ASoC by enabling writes to XCCR and RCCR McBSP registers, v3

This patch enables writing to McBSP Transmit Configuration Control
Register (XCCR) and Receive Configuration Control Register (RCCR)
for 2430/34xx platforms. It also adds XCCR, RCCR entries in McBSP
register configuration structure and bit definitions for both
registers.

If we enable the writing to CCR registers for 2430/34xx and don't
set the default values (setting 0 as a consequence) in ASoC driver,
the Transmit/Receive DMA mode gets disabled and the the
transmission/reception doesn't happen, ending with a
"write error: Input/Output error" when playing with 'aplay'.

Also define dummy CCR registers for omap1.

Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 6a0d1a0..eef873d 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -87,6 +87,10 @@
 #define OMAP_MCBSP_REG_XCERG	0x3A
 #define OMAP_MCBSP_REG_XCERH	0x3C
 
+/* Dummy defines, these are not available on omap1 */
+#define OMAP_MCBSP_REG_XCCR	0x00
+#define OMAP_MCBSP_REG_RCCR	0x00
+
 #define AUDIO_MCBSP_DATAWRITE	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1)
 #define AUDIO_MCBSP_DATAREAD	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1)
 
@@ -231,11 +235,16 @@
 #define XPBBLK(value)		((value)<<7)	/* Bits 7:8 */
 
 /*********************** McBSP XCCR bit definitions *************************/
+#define EXTCLKGATE		0x8000
+#define PPCONNECT		0x4000
+#define DXENDLY(value)		((value)<<12)	/* Bits 12:13 */
+#define XFULL_CYCLE		0x0800
 #define DILB			0x0020
 #define XDMAEN			0x0008
 #define XDISABLE		0x0001
 
 /********************** McBSP RCCR bit definitions *************************/
+#define RFULL_CYCLE		0x0800
 #define RDMAEN			0x0008
 #define RDISABLE		0x0001
 
@@ -267,6 +276,8 @@ struct omap_mcbsp_reg_cfg {
 	u16 rcerh;
 	u16 xcerg;
 	u16 xcerh;
+	u16 xccr;
+	u16 rccr;
 };
 
 typedef enum {
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index af33fc7..f2401a8 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -173,6 +173,10 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 	OMAP_MCBSP_WRITE(io_base, MCR2, config->mcr2);
 	OMAP_MCBSP_WRITE(io_base, MCR1, config->mcr1);
 	OMAP_MCBSP_WRITE(io_base, PCR0, config->pcr0);
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		OMAP_MCBSP_WRITE(io_base, XCCR, config->xccr);
+		OMAP_MCBSP_WRITE(io_base, RCCR, config->rccr);
+	}
 }
 EXPORT_SYMBOL(omap_mcbsp_config);
 

--TB36FDmn/VVEgNH/--
