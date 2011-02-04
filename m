From: Felipe Balbi <balbi@ti.com>
Subject: World writeable MUX
Date: Fri, 4 Feb 2011 14:43:52 +0200
Message-ID: <20110204124352.GH30543@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35974 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751586Ab1BDMnz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 07:43:55 -0500
Received: by mail-fx0-f47.google.com with SMTP id 17so2342181fxm.34
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 04:43:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tony,

I saw a few patches floating around regarding world writeable sysfs
files and decided to grep around arch/arm/*omap* to try and see if we
were safe. Turns out anyone can change MUX entries via the debugfs
interface:

static void __init omap_mux_dbg_create_entry(
				struct omap_mux_partition *partition,
				struct dentry *mux_dbg_dir)
{
	struct omap_mux_entry *e;

	list_for_each_entry(e, &partition->muxmodes, node) {
		struct omap_mux *m = &e->mux;

		(void)debugfs_create_file(m->muxnames[0], S_IWUGO, mux_dbg_dir,
					  m, &omap_mux_dbg_signal_fops);
	}
}

is that really expected ? I guess not, attached there's a small patch to
fix that one.

-- 
balbi

--l76fUT7nc3MelDdI
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-arm-omap2-fix-a-world-writeable-debugfs-file.diff"

>From d3e0b6d3ddd82b1f9ab0299105cb8bf29d142ac4 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Fri, 4 Feb 2011 14:42:16 +0200
Subject: [PATCH] arm: omap2: fix a world writeable debugfs file
Organization: Texas Instruments\n

don't allow anyone to fiddle with the mux settings.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/mux.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index fae49d1..2727e58 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -605,7 +605,7 @@ static void __init omap_mux_dbg_create_entry(
 	list_for_each_entry(e, &partition->muxmodes, node) {
 		struct omap_mux *m = &e->mux;
 
-		(void)debugfs_create_file(m->muxnames[0], S_IWUGO, mux_dbg_dir,
+		(void)debugfs_create_file(m->muxnames[0], S_IWUSR, mux_dbg_dir,
 					  m, &omap_mux_dbg_signal_fops);
 	}
 }
-- 
1.7.4.rc2


--l76fUT7nc3MelDdI--
