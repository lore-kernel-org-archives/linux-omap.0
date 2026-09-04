Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A9A470425
	for <linux-omap@vger.kernel.org>; Fri,  4 Sep 2026 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520445; cv=none; b=ghc5RyYOzmJJ5aK9OVYXtr53ezCY0mIx7efF8qZ2PFNWVDv1YK3K+W5GLAQkQMvupjshcHbVjIH/IeQiGMMdmdh5BGt+eHnHMcjGMjklPSLsYlrfjfp2q+UktBtURigv7YeqLg0seftpEUDidKdV7g+cBQLpEl4DpLWCnRQCFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520445; c=relaxed/simple;
	bh=jCIhAKe7wnLDSlElO3bSuA12dUGjruc8bVQ68QBuEc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t2Zj2ogBlBZXJT3fWxCkrRk8hUYq+5igRR8VTi67ItgUylWD+5j3aDIyEyXdERnMHGB9Pki3kZ5XcwIAsiBhL4bdgHzGcJlVcCD0gdBkUTjYNb0OhlY5HxJpFZaJySPNcTysD9aMJMz5eh9Wr+e8dEiVtwXM7LH7Nk0wqcCkFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgdmSGVo; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgdmSGVo"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so1085567a12.3
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2026 04:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520441; x=1789125241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vfrdoUnoIuhUy7m0yBcreTek5MieQGNFQjYU/Vb71Ek=;
        b=EgdmSGVo1uN3J/sx0rUIR9I5tahbw7MWBoVOKP5+D/mIj7xRVXZjpblbSvCAijyR/c
         7EjeGOxrgY9eLagGk6DQSpAfbJy4+hWvU92MHKLXAYyx14y1CNqG15jPzJ6TjnJn3Zzj
         z8fwg6xr3jq4txYRycENlyZH9IBiMCF7NiC4/jHpnx4I8xomSotXEZ6geGts43fIu8zw
         3LVcWF5Jm5iNVfoeWi9/yDE7JYa2uDV7nIB675+aObUZTE36gFo8yltoNmSkEzOH+Tu5
         /Ju6e/2e+nHIz/2U2j6lijySzI7v3Z/dqXuwSLvziiUTrHSAT7epG3dlDnSwD5435uwA
         G+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520441; x=1789125241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vfrdoUnoIuhUy7m0yBcreTek5MieQGNFQjYU/Vb71Ek=;
        b=QA+AtH+JchaXGeEBdLvayyboA0l7et6Z1mfIfNMv3m/tePODahMEjAKEaN/6D2qevr
         RWp9wGLqHpPWInX47JMxkfH1RoyPfr8gG6iWhTO+ahXQWidke0Esab75N9rwQQKBahVO
         SSOSpwe1isJ2633ivZBiHmdra6ceeYQJvZnuUIUAh+JYa0pmBzztMp+zgsyPPKGgDGRj
         rP7clLmXUyezp7VrnVtWFw/p38zHp4LISQULEMyyV/oQX/0VWFArqQWFt9Z942xiZucC
         8ZEmvEP69OkIV6U4ZL7Dgel36E66ThQQb6V4pOukBRUB+FY1CaXcIL3fZXNvWQUTucIA
         NXfA==
X-Forwarded-Encrypted: i=1; AKwUvBySfneGBduCi7Vp+iVUiCRTleAP//kf7rG8o/xWvLaPRXQaGR63zWt9FZwB2W1GijODMBibnoRF/84R@vger.kernel.org
X-Gm-Message-State: AFuF++nBuJeW1cekmBx/Q8hJRlWo0t9MpB5u8V3vOpjnsC0XFyFh9tpD
	xoo9KXuYkow9Rdi5yWzUpX6YCW75oBtdrl1AP/GRWMjCpomt1JnNKfa3
X-Gm-Gg: AYBFou24upyEkXHctI5+vUCOQFaEjjxWFpCDzqzvPll1L+wlPtLl0cy9z5j4rvwyGEY
	z2aSH+Vhs16Mf4GFAg1fPU3cFc9JzSA+BQD8fre1+9F5tctuaFo+JqYUBr/EhnO4hxT5DN2F9lQ
	NNJ+iFrHVBpKySYhO/JjM0sp3l/uEcGqa2jiFWZf2MpqgHknzqSYS2815ctVvlvKeGAiSca08o5
	jf1oX1URj4GwFS/9aEDWcTka0GZj1nm0ppAEpNDJJOeZEUTP+oAYLAx703FpNZegArlnXuQKqME
	ZlDIpA4/2UrsHc4JALawKsjPaowRZR8OmdA4ANDIMIostpOEvhxwf1h1lVA4pdf78VEkR8aKRiv
	hWgU3TQ2NBIRxszyaQ0CmwiXCPeEZPozvIIdxi5+o+hnDYIS7lBVMGgcgxiJdp67Ez9y3dcbeLQ
	eJyuVc+fqa71UcWT7P6mkXL3Ik0aDc/p+qXMPqEnas4hekuqAjH1W4MWpXuYAQS6otklJKQwIPZ
	DHrfdqI4tYT0Z8=
X-Received: by 2002:a17:90b:3a8e:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-39b260d2eb3mr7940595a91.7.1788520440953;
        Fri, 04 Sep 2026 04:14:00 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a62be87sm5391413eec.6.2026.09.04.04.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:14:00 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Peter Jones <pjones@redhat.com>,
	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-omap@vger.kernel.org
Subject: [PATCH] fbdev: fix typos in comments
Date: Fri,  4 Sep 2026 16:43:43 +0530
Message-ID: <20260904111355.25780-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/video/fbdev/aty/aty128fb.c              | 2 +-
 drivers/video/fbdev/aty/atyfb_base.c            | 4 ++--
 drivers/video/fbdev/aty/mach64_cursor.c         | 2 +-
 drivers/video/fbdev/aty/radeon_base.c           | 4 ++--
 drivers/video/fbdev/aty/radeon_monitor.c        | 4 ++--
 drivers/video/fbdev/aty/radeonfb.h              | 2 +-
 drivers/video/fbdev/au1100fb.c                  | 2 +-
 drivers/video/fbdev/efifb.c                     | 4 ++--
 drivers/video/fbdev/grvga.c                     | 2 +-
 drivers/video/fbdev/kyro/STG4000OverlayDevice.c | 2 +-
 drivers/video/fbdev/maxinefb.c                  | 2 +-
 drivers/video/fbdev/mmp/core.c                  | 2 +-
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c           | 4 ++--
 drivers/video/fbdev/mmp/hw/mmp_ctrl.h           | 4 ++--
 drivers/video/fbdev/mmp/hw/mmp_spi.c            | 2 +-
 drivers/video/fbdev/ocfb.c                      | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c    | 4 ++--
 drivers/video/fbdev/pm2fb.c                     | 2 +-
 drivers/video/fbdev/skeletonfb.c                | 6 +++---
 drivers/video/fbdev/sstfb.c                     | 2 +-
 drivers/video/fbdev/tgafb.c                     | 6 +++---
 drivers/video/fbdev/tridentfb.c                 | 2 +-
 drivers/video/fbdev/via/dvi.c                   | 6 +++---
 drivers/video/fbdev/via/hw.c                    | 2 +-
 drivers/video/fbdev/via/viafbdev.c              | 4 ++--
 drivers/video/sticore.c                         | 2 +-
 include/video/mmp_disp.h                        | 6 +++---
 27 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index c349a1711ff5..6f71c3c6307e 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -753,7 +753,7 @@ static u32 depth_to_dst(u32 depth)
 }
 
 /*
- * PLL informations retreival
+ * PLL information retreival
  */
 
 
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 97cc8b6a9361..b1f33642e722 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2966,7 +2966,7 @@ static int atyfb_setup_sparc(struct pci_dev *pdev, struct fb_info *info,
 
 	/*
 	 * Figure mmap addresses from PCI config space.
-	 * Split Framebuffer in big- and little-endian halfs.
+	 * Split Framebuffer in big- and little-endian halves.
 	 */
 	for (i = 0; i < 6 && pdev->resource[i].start; i++)
 		/* nothing */ ;
@@ -3387,7 +3387,7 @@ static int init_from_bios(struct atyfb_par *par)
 
 		PRINTKI("Mach64 BIOS is located at %x, mapped at %x.\n", rom_addr, bios_base);
 
-		/* check for frequncy table */
+		/* check for frequency table */
 		bios_ptr = (u8*)bios_base;
 		rom_table_offset = (u16)(bios_ptr[0x48] | (bios_ptr[0x49] << 8));
 		freq_table_offset = bios_ptr[rom_table_offset + 16] | (bios_ptr[rom_table_offset + 17] << 8);
diff --git a/drivers/video/fbdev/aty/mach64_cursor.c b/drivers/video/fbdev/aty/mach64_cursor.c
index e826cb7dd55d..60abb9666395 100644
--- a/drivers/video/fbdev/aty/mach64_cursor.c
+++ b/drivers/video/fbdev/aty/mach64_cursor.c
@@ -43,7 +43,7 @@
  *
  *
  * The Screen position of the top left corner of the displayed
- * cursor is specificed by CURS_HORZ_VERT_POSN. Care must be taken
+ * cursor is specified by CURS_HORZ_VERT_POSN. Care must be taken
  * when the cursor hot spot is not the top left corner and the
  * physical cursor position becomes negative. It will be displayed
  * if either the horizontal or vertical cursor position is negative
diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index b6b058cee751..387bc5f96765 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -779,7 +779,7 @@ static void radeon_get_pllinfo(struct radeonfb_info *rinfo)
 #endif /* CONFIG_PPC || CONFIG_SPARC */
 
 	/*
-	 * Check out if we have an X86 which gave us some PLL informations
+	 * Check out if we have an X86 which gave us some PLL information
 	 * and if yes, retrieve them
 	 */
 	if (!force_measure_pll && rinfo->bios_seg) {
@@ -2407,7 +2407,7 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	if (rinfo->bios_seg == NULL && rinfo->is_mobility)
 		radeon_map_ROM(rinfo, pdev);
 
-	/* Get informations about the board's PLL */
+	/* Get information about the board's PLL */
 	radeon_get_pllinfo(rinfo);
 
 #ifdef CONFIG_FB_RADEON_I2C
diff --git a/drivers/video/fbdev/aty/radeon_monitor.c b/drivers/video/fbdev/aty/radeon_monitor.c
index 621d13a1a1d9..775888c43ef0 100644
--- a/drivers/video/fbdev/aty/radeon_monitor.c
+++ b/drivers/video/fbdev/aty/radeon_monitor.c
@@ -58,7 +58,7 @@ static char *radeon_get_mon_name(int type)
 
 #if defined(CONFIG_PPC) || defined(CONFIG_SPARC)
 /*
- * Try to find monitor informations & EDID data out of the Open Firmware
+ * Try to find monitor information & EDID data out of the Open Firmware
  * device-tree. This also contains some "hacks" to work around a few machine
  * models with broken OF probing by hard-coding known EDIDs for some Mac
  * laptops internal LVDS panel. (XXX: not done yet)
@@ -248,7 +248,7 @@ static int radeon_get_panel_info_BIOS(struct radeonfb_info *rinfo)
 	return 0;
 }
 
-/* Try to extract the connector informations from the BIOS. This
+/* Try to extract the connector information from the BIOS. This
  * doesn't quite work yet, but it's output is still useful for
  * debugging
  */
diff --git a/drivers/video/fbdev/aty/radeonfb.h b/drivers/video/fbdev/aty/radeonfb.h
index 91d81b576231..0781caea2c71 100644
--- a/drivers/video/fbdev/aty/radeonfb.h
+++ b/drivers/video/fbdev/aty/radeonfb.h
@@ -148,7 +148,7 @@ struct pll_info {
  * This structure contains the various registers manipulated by this
  * driver for setting or restoring a mode. It's mostly copied from
  * XFree's RADEONSaveRec structure. A few chip settings might still be
- * tweaked without beeing reflected or saved in these registers though
+ * tweaked without being reflected or saved in these registers though
  */
 struct radeon_regs {
 	/* Common registers */
diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 39f86ffb1ae3..01c836cb5205 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -528,7 +528,7 @@ static int au1100fb_setmode(struct au1100fb_device *fbdev)
 	if (!info->var.rotate || (info->var.rotate == 180)) {
 		words *= info->var.yres_virtual;
 		if (info->var.rotate /* 180 */) {
-			words -= (words % 8); /* should be divisable by 8 */
+			words -= (words % 8); /* should be divisible by 8 */
 		}
 	}
 	fbdev->regs->lcd_words = LCD_WRD_WRDS_N(words);
diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index ad8dec7807c3..e1c764854004 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -97,7 +97,7 @@ static int efifb_setcolreg(unsigned regno, unsigned red, unsigned green,
 }
 
 /*
- * If fbcon deffered console takeover is configured, the intent is for the
+ * If fbcon deferred console takeover is configured, the intent is for the
  * framebuffer to show the boot graphics (e.g. vendor logo) until there is some
  * (error) message to display. But the boot graphics may have been destroyed by
  * e.g. option ROM output, detect this and restore the boot graphics.
@@ -421,7 +421,7 @@ static int efifb_probe(struct platform_device *dev)
 	size_vmode = efifb_defined.yres * efifb_fix.line_length;
 
 	/*   size_total -- all video memory we have. Used for
-	 *                 entries, ressource allocation and bounds
+	 *                 entries, resource allocation and bounds
 	 *                 checking. */
 	size_total = si->lfb_size;
 	if (size_total < size_vmode)
diff --git a/drivers/video/fbdev/grvga.c b/drivers/video/fbdev/grvga.c
index a6594bcd74e8..771d9491b49e 100644
--- a/drivers/video/fbdev/grvga.c
+++ b/drivers/video/fbdev/grvga.c
@@ -432,7 +432,7 @@ static int grvga_probe(struct platform_device *dev)
 			retval = -ENOMEM;
 			goto dealloc_cmap;
 		}
-	} else {	/* Allocate frambuffer memory */
+	} else {	/* Allocate framebuffer memory */
 
 		unsigned long page;
 
diff --git a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
index 9fde0e3b69ec..a54a8a9197e5 100644
--- a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
@@ -60,7 +60,7 @@ typedef struct _OVRL_SRC_DEST {
 	u32 ulDstX2;
 	u32 ulDstY2;
 
-	/*clipped pixel pos of source data within buffer thses need to be 128 bit word aligned */
+	/*clipped pixel pos of source data within buffer these need to be 128 bit word aligned */
 	u32 ulSrcX1;
 	u32 ulSrcY1;
 	u32 ulSrcX2;
diff --git a/drivers/video/fbdev/maxinefb.c b/drivers/video/fbdev/maxinefb.c
index 67d4bd881041..88aec13a98fb 100644
--- a/drivers/video/fbdev/maxinefb.c
+++ b/drivers/video/fbdev/maxinefb.c
@@ -98,7 +98,7 @@ static int maxinefb_setcolreg(unsigned regno, unsigned red, unsigned green,
 		return 1;
 
 	red   >>= 8;    /* The cmap fields are 16 bits    */
-	green >>= 8;    /* wide, but the harware colormap */
+	green >>= 8;    /* wide, but the hardware colormap */
 	blue  >>= 8;    /* registers are only 8 bits wide */
 
 	hw_colorvalue = (blue << 16) + (green << 8) + (red);
diff --git a/drivers/video/fbdev/mmp/core.c b/drivers/video/fbdev/mmp/core.c
index 3c35b0a3ea09..9d4fda2fc83f 100644
--- a/drivers/video/fbdev/mmp/core.c
+++ b/drivers/video/fbdev/mmp/core.c
@@ -65,7 +65,7 @@ static DEFINE_MUTEX(disp_lock);
  * @p: panel to be registered
  *
  * this function provides interface for panel drivers to register panel
- * to panel_list and connect to path which matchs panel->plat_path_name.
+ * to panel_list and connect to path which matches panel->plat_path_name.
  * no error returns when no matching path is found as path register after
  * panel register is permitted.
  */
diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index 2c457da67a9f..3db608e5aef1 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -325,7 +325,7 @@ static void ctrl_set_default(struct mmphw_ctrl *ctrl)
 	u32 tmp, irq_mask;
 
 	/*
-	 * LCD Global control(LCD_TOP_CTRL) should be configed before
+	 * LCD Global control(LCD_TOP_CTRL) should be configured before
 	 * any other LCD registers read/write, or there maybe issues.
 	 */
 	tmp = readl_relaxed(ctrl->reg_base + LCD_TOP_CTRL);
@@ -521,7 +521,7 @@ static int mmphw_probe(struct platform_device *pdev)
 	/* init global regs */
 	ctrl_set_default(ctrl);
 
-	/* init pathes from machine info and register them */
+	/* init paths from machine info and register them */
 	for (i = 0; i < ctrl->path_num; i++) {
 		/* get from config and machine info */
 		path_plat = &ctrl->path_plats[i];
diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
index 719b99a9bc77..80aefe5cace1 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
@@ -1404,7 +1404,7 @@ struct mmphw_ctrl {
 	int status;
 	struct mutex access_ok;
 
-	/*pathes*/
+	/*paths*/
 	int path_num;
 	struct mmphw_path_plat path_plats[] __counted_by(path_num);
 };
@@ -1434,7 +1434,7 @@ static inline void __iomem *ctrl_regs(struct mmp_path *path)
 	return path_to_ctrl(path)->reg_base;
 }
 
-/* path regs, for regs symmetrical for both pathes */
+/* path regs, for regs symmetrical for both paths */
 static inline struct lcd_regs *path_regs(struct mmp_path *path)
 {
 	if (path->id == PATH_PN)
diff --git a/drivers/video/fbdev/mmp/hw/mmp_spi.c b/drivers/video/fbdev/mmp/hw/mmp_spi.c
index 3f253f4271ac..8e6e8be441d2 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_spi.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_spi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * linux/drivers/video/mmp/hw/mmp_spi.c
- * using the spi in LCD controler for commands send
+ * using the spi in LCD controller for commands send
  *
  * Copyright (C) 2012 Marvell Technology Group Ltd.
  * Authors:  Guoqing Li <ligq@marvell.com>
diff --git a/drivers/video/fbdev/ocfb.c b/drivers/video/fbdev/ocfb.c
index 893888260c21..c16e907e5710 100644
--- a/drivers/video/fbdev/ocfb.c
+++ b/drivers/video/fbdev/ocfb.c
@@ -115,7 +115,7 @@ static int ocfb_setupfb(struct ocfb_dev *fbdev)
 	fbdev->little_endian = 0;
 	ocfb_writereg(fbdev, OCFB_VBARA, fbdev->fb_phys);
 
-	/* Detect endianess */
+	/* Detect endianness */
 	if (ocfb_readreg(fbdev, OCFB_VBARA) != fbdev->fb_phys) {
 		fbdev->little_endian = 1;
 		ocfb_writereg(fbdev, OCFB_VBARA, fbdev->fb_phys);
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index 1dc70c96d813..cbe3cc545131 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -2119,7 +2119,7 @@ static int check_horiz_timing_omap3(unsigned long pclk, unsigned long lclk,
 
 	/*
 	 * Pixel data should be prepared before visible display point starts.
-	 * So, atleast DS-2 lines must have already been fetched by DISPC
+	 * So, at least DS-2 lines must have already been fetched by DISPC
 	 * during nonactive - pos_x period.
 	 */
 	val = div_u64((u64)(nonactive - pos_x) * lclk, pclk);
@@ -2130,7 +2130,7 @@ static int check_horiz_timing_omap3(unsigned long pclk, unsigned long lclk,
 
 	/*
 	 * All lines need to be refilled during the nonactive period of which
-	 * only one line can be loaded during the active period. So, atleast
+	 * only one line can be loaded during the active period. So, at least
 	 * DS - 1 lines should be loaded during nonactive period.
 	 */
 	val =  div_u64((u64)nonactive * lclk, pclk);
diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index 058075a34c5d..f287c9059489 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -428,7 +428,7 @@ static void set_aperture(struct pm2fb_par *p, u32 depth)
 	}
 #endif
 
-	/* We don't use aperture two, so this may be superflous */
+	/* We don't use aperture two, so this may be superfluous */
 	pm2_WR(p, PM2R_APERTURE_TWO, PM2F_APERTURE_STANDARD);
 }
 
diff --git a/drivers/video/fbdev/skeletonfb.c b/drivers/video/fbdev/skeletonfb.c
index 7e98850d9bde..bbfbf55cdab8 100644
--- a/drivers/video/fbdev/skeletonfb.c
+++ b/drivers/video/fbdev/skeletonfb.c
@@ -478,7 +478,7 @@ static int xxxfb_blank(int blank_mode, struct fb_info *info)
 
 /**
  *      xxxfb_fillrect - REQUIRED function. Can use generic routines if
- *		 	 non acclerated hardware and packed pixel based.
+ *		 	 non accelerated hardware and packed pixel based.
  *			 Draws a rectangle on the screen.
  *
  *      @info: frame buffer structure that represents a single frame buffer
@@ -505,7 +505,7 @@ void xxxfb_fillrect(struct fb_info *p, const struct fb_fillrect *region)
 
 /**
  *      xxxfb_copyarea - REQUIRED function. Can use generic routines if
- *                       non acclerated hardware and packed pixel based.
+ *                       non accelerated hardware and packed pixel based.
  *                       Copies one area of the screen to another area.
  *
  *      @info: frame buffer structure that represents a single frame buffer
@@ -530,7 +530,7 @@ void xxxfb_copyarea(struct fb_info *p, const struct fb_copyarea *area)
 
 /**
  *      xxxfb_imageblit - REQUIRED function. Can use generic routines if
- *                        non acclerated hardware and packed pixel based.
+ *                        non accelerated hardware and packed pixel based.
  *                        Copies a image from system memory to the screen.
  *
  *      @info: frame buffer structure that represents a single frame buffer
diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index 2745557822f7..0c048f9fee68 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -15,7 +15,7 @@
  * 09/2002 Helge Deller    <deller@gmx.de>
  *	(enable driver on big-endian machines (hppa), ioctl fixes)
  * 12/2002 Helge Deller    <deller@gmx.de>
- *	(port driver to new frambuffer infrastructure)
+ *	(port driver to new framebuffer infrastructure)
  * 01/2003 Helge Deller    <deller@gmx.de>
  *	(initial work on fb hardware acceleration for voodoo2)
  * 08/2006 Alan Cox 	   <alan@redhat.com>
diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
index dccfc38cfbd5..32296f926196 100644
--- a/drivers/video/fbdev/tgafb.c
+++ b/drivers/video/fbdev/tgafb.c
@@ -884,7 +884,7 @@ tgafb_clut_imageblit(struct fb_info *info, const struct fb_image *image)
 
 /**
  *      tgafb_imageblit - REQUIRED function. Can use generic routines if
- *                        non acclerated hardware and packed pixel based.
+ *                        non accelerated hardware and packed pixel based.
  *                        Copies a image from system memory to the screen.
  *
  *      @info: frame buffer structure that represents a single frame buffer
@@ -921,7 +921,7 @@ tgafb_imageblit(struct fb_info *info, const struct fb_image *image)
 
 /**
  *      tgafb_fillrect - REQUIRED function. Can use generic routines if
- *                       non acclerated hardware and packed pixel based.
+ *                       non accelerated hardware and packed pixel based.
  *                       Draws a rectangle on the screen.
  *
  *      @info: frame buffer structure that represents a single frame buffer
@@ -1047,7 +1047,7 @@ tgafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 
 /*
  *      tgafb_copyarea - REQUIRED function. Can use generic routines if
- *                       non acclerated hardware and packed pixel based.
+ *                       non accelerated hardware and packed pixel based.
  *                       Copies on area of the screen to another area.
  *
  *      @info: frame buffer structure that represents a single frame buffer
diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index 9f055ba776c8..6501f6e2615a 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -58,7 +58,7 @@ static struct fb_fix_screeninfo tridentfb_fix = {
 	.accel = FB_ACCEL_NONE,
 };
 
-/* defaults which are normally overriden by user values */
+/* defaults which are normally overridden by user values */
 
 /* video mode */
 static char *mode_option;
diff --git a/drivers/video/fbdev/via/dvi.c b/drivers/video/fbdev/via/dvi.c
index 27990a73bfa3..47cacdbec830 100644
--- a/drivers/video/fbdev/via/dvi.c
+++ b/drivers/video/fbdev/via/dvi.c
@@ -399,7 +399,7 @@ void viafb_dvi_enable(void)
 			tmds_register_write(0x88, 0x3b);
 		else
 			/*clear CR91[5] to direct on display period
-			   in the secondary diplay path */
+			   in the secondary display path */
 			via_write_reg_mask(VIACR, 0x91, 0x00, 0x20);
 		break;
 
@@ -407,12 +407,12 @@ void viafb_dvi_enable(void)
 		if (viaparinfo->chip_info->gfx_chip_name == UNICHROME_CLE266)
 			viafb_write_reg_mask(CR93, VIACR, 0x21, BIT0 + BIT5);
 
-		/*fix dvi cann't be enabled with MB VT5718C4 - Al Zhang */
+		/*fix dvi can't be enabled with MB VT5718C4 - Al Zhang */
 		if (viaparinfo->chip_info->gfx_chip_name == UNICHROME_CLE266)
 			tmds_register_write(0x88, 0x3b);
 		else
 			/*clear CR91[5] to direct on display period
-			  in the secondary diplay path */
+			  in the secondary display path */
 			via_write_reg_mask(VIACR, 0x91, 0x00, 0x20);
 
 		/*fix DVI cannot enable on EPIA-M board */
diff --git a/drivers/video/fbdev/via/hw.c b/drivers/video/fbdev/via/hw.c
index 66afd7be00cc..e9d0fac8fb17 100644
--- a/drivers/video/fbdev/via/hw.c
+++ b/drivers/video/fbdev/via/hw.c
@@ -1542,7 +1542,7 @@ static void init_gfx_chip_info(int chip_type)
 		else
 			viaparinfo->chip_info->gfx_chip_revision =
 			CLE266_REVISION_CX;
-		/* restore orignal CR4F value */
+		/* restore original CR4F value */
 		viafb_write_reg(CR4F, VIACR, tmp);
 	}
 
diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index dd9374e8ad09..2c67a18d16ad 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -190,7 +190,7 @@ static int viafb_check_var(struct fb_var_screeninfo *var,
 
 	DEBUG_MSG(KERN_INFO "viafb_check_var!\n");
 	/* Sanity check */
-	/* HW neither support interlacte nor double-scaned mode */
+	/* HW neither support interlacte nor double-scanned mode */
 	if (var->vmode & FB_VMODE_INTERLACED || var->vmode & FB_VMODE_DOUBLE)
 		return -EINVAL;
 
@@ -765,7 +765,7 @@ static int viafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	if (info->flags & FBINFO_HWACCEL_DISABLED || info != viafbinfo)
 		return -ENODEV;
 
-	/* LCD ouput does not support hw cursors (at least on VN896) */
+	/* LCD output does not support hw cursors (at least on VN896) */
 	if ((chip_name == UNICHROME_CLE266 && viapar->iga_path == IGA2) ||
 		viafb_LCD_ON)
 		return -ENODEV;
diff --git a/drivers/video/sticore.c b/drivers/video/sticore.c
index 1d4477f20450..6876a03c464a 100644
--- a/drivers/video/sticore.c
+++ b/drivers/video/sticore.c
@@ -389,7 +389,7 @@ static int sti_font_setup(char *str)
  *	- sti_font=<number>	(<number> = 1,2,3,...)
  *		most STI ROMs have built-in HP specific fonts, which can be selected
  *		by giving the desired number to the sticon driver.
- *		NOTE: This number is machine and STI ROM dependend.
+ *		NOTE: This number is machine and STI ROM dependent.
  *	- sti_font=<height>x<width>  (e.g. sti_font=16x8)
  *		<height> and <width> gives hints to the height and width of the
  *		font which the user wants. The sticon driver will try to use
diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
index 41354bd49895..88358527d11b 100644
--- a/include/video/mmp_disp.h
+++ b/include/video/mmp_disp.h
@@ -172,7 +172,7 @@ struct mmp_panel {
 	/* use node to register to list */
 	struct list_head node;
 	const char *name;
-	/* path name used to connect to proper path configed */
+	/* path name used to connect to proper path configured */
 	const char *plat_path_name;
 	struct device *dev;
 	int panel_type;
@@ -291,7 +291,7 @@ static inline int mmp_overlay_set_addr(struct mmp_overlay *overlay,
  * it defined a common interface that plat driver need to implement
  */
 struct mmp_path_info {
-	/* driver data, set when registed*/
+	/* driver data, set when registered*/
 	const char *name;
 	struct device *dev;
 	int id;
@@ -309,7 +309,7 @@ extern void mmp_unregister_path(struct mmp_path *path);
 extern void mmp_register_panel(struct mmp_panel *panel);
 extern void mmp_unregister_panel(struct mmp_panel *panel);
 
-/* defintions for platform data */
+/* definitions for platform data */
 /* interface for buffer driver */
 struct mmp_buffer_driver_mach_info {
 	const char	*name;
-- 
2.48.1

