From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Thu, 14 Jun 2012 10:39:33 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
References: <cover.1339419244.git.afzal@ti.com>
 <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
 <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com> <20120613115445.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42674 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615Ab2FNKjk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 06:39:40 -0400
In-Reply-To: <20120614101901.GI12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Thu, Jun 14, 2012 at 15:49:02, Tony Lindgren wrote:

> Well I took a look at the values, and it seems the only difference is the
> static GPMC_CONFIG1_CLKACTIVATIONTIME(1) that your patch now overwrites 0.

It seems change below should be part of $subject.

Please let me know your comments

Regards
Afzal

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index fd4c48d..938896c 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -321,6 +321,8 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
        t.rd_cycle = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div +
                     ticks_cez);

+       t.clk_activation = fclk_offset_ns;
+
        /* Write */
        if (sync_write) {
                t.adv_wr_off = t.adv_rd_off;
@@ -354,7 +356,6 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
                          (sync_read ? GPMC_CONFIG1_READTYPE_SYNC : 0) |
                          (sync_write ? GPMC_CONFIG1_WRITEMULTIPLE_SUPP : 0) |
                          (sync_write ? GPMC_CONFIG1_WRITETYPE_SYNC : 0) |
-                         GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
                          GPMC_CONFIG1_PAGE_LEN(2) |
                          (cpu_is_omap34xx() ? 0 :
                                (GPMC_CONFIG1_WAIT_READ_MON |
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index db84a46..5c98755 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -174,6 +174,8 @@ static int tusb_set_sync_mode(unsigned sysclk_ps, unsigned fclk_ps)
        tmp = t.cs_wr_off * 1000 + 7000 /* t_scsn_rdy_z */;
        t.wr_cycle = next_clk(t.cs_wr_off, tmp, fclk_ps);

+       t.clk_activation = gpmc_ticks_to_ns(1);
+
        return gpmc_cs_set_timings(sync_cs, &t);
 }

@@ -283,7 +285,6 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
                        | GPMC_CONFIG1_READTYPE_SYNC
                        | GPMC_CONFIG1_WRITEMULTIPLE_SUPP
                        | GPMC_CONFIG1_WRITETYPE_SYNC
-                       | GPMC_CONFIG1_CLKACTIVATIONTIME(1)
                        | GPMC_CONFIG1_PAGE_LEN(2)
                        | GPMC_CONFIG1_WAIT_READ_MON
                        | GPMC_CONFIG1_WAIT_WRITE_MON
