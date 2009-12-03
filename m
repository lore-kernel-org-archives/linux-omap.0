From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 3/4 v4] OMAP: McBSP: Introduce caching in register write operations
Date: Thu, 3 Dec 2009 13:30:42 +0100
Message-ID: <200912031330.43464.jkrzyszt@tis.icnet.pl>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl> <200912010415.52570.jkrzyszt@tis.icnet.pl> <20091203094921.1106827a.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:41030 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbZLCMan (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Dec 2009 07:30:43 -0500
In-Reply-To: <20091203094921.1106827a.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Reserve space inside omap_mcbsp structure for storing cached copies of McBSP
register values.
Modify the MCBSP_WRITE() macro to update the cache with every register write
operation.
Introduce a new macro that reads from the cache instead of hardware.

Applies on top of patch 2 from this series:
[PATCH v3 2/4] OMAP: McBSP: Prepare register read/write macros API for caching

Tested on OMAP1510 based Amstrad Delta using linux-omap for-next,
commit 4421752e331cfb1d942b47ffdb26e451a8da58a0.
Compile-tested with omap_3430sdp_defconfig.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
Thursday 03 December 2009 08:49:21 Jarkko Nikula wrote:
> On Tue, 1 Dec 2009 04:15:50 +0100
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> >  #define MCBSP_WRITE(mcbsp, reg, val) \
> > -		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, val)
> > +		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, \
> > +		mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1] \
> > +			= val)
> > +#define MCBSP_READ_CACHE(mcbsp, reg) \
> > +		(mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1])
>
> These divisions by DDR1 are confusing. Use rather sizeof:
>
> reg_cache[OMAP_MCBSP_REG_##reg / sizeof(*mcbsp->reg_cache)]

Done.

Jarkko, many thanks for your cooperation :).

Janusz

 arch/arm/plat-omap/include/plat/mcbsp.h |    5 +++++
 arch/arm/plat-omap/mcbsp.c              |    7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

--- git/arch/arm/plat-omap/include/plat/mcbsp.h.orig	2009-11-27 11:53:45.000000000 +0100
+++ git/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-01 03:37:21.000000000 +0100
@@ -415,6 +415,11 @@ struct omap_mcbsp {
 	u16 max_tx_thres;
 	u16 max_rx_thres;
 #endif
+#ifdef CONFIG_ARCH_OMAP1
+	u16 reg_cache[OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1];
+#else
+	u32 reg_cache[OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1];
+#endif
 };
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count;
--- git/arch/arm/plat-omap/mcbsp.c.orig	2009-12-01 03:19:56.000000000 +0100
+++ git/arch/arm/plat-omap/mcbsp.c	2009-12-03 11:37:21.000000000 +0100
@@ -49,7 +49,12 @@ int omap_mcbsp_read(void __iomem *io_bas
 #define MCBSP_READ(mcbsp, reg) \
 		omap_mcbsp_read(mcbsp->io_base, OMAP_MCBSP_REG_##reg)
 #define MCBSP_WRITE(mcbsp, reg, val) \
-		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, val)
+		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, \
+		mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / \
+				 sizeof(*mcbsp->reg_cache)] = val)
+#define MCBSP_READ_CACHE(mcbsp, reg) \
+		(mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / \
+				  sizeof(*mcbsp->reg_cache)])
 
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
