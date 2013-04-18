From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH] OMAPDSS: DPI: add dependency to DSI
Date: Thu, 18 Apr 2013 10:37:05 +0200
Message-ID: <1366274225.4085.44.camel@mars>
References: <516BDD35.4000807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:48891 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966354Ab3DRIhK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 04:37:10 -0400
Received: by mail-bk0-f51.google.com with SMTP id y8so1149128bkt.10
        for <linux-omap@vger.kernel.org>; Thu, 18 Apr 2013 01:37:09 -0700 (PDT)
In-Reply-To: <516BDD35.4000807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Dave Airlie <airlied@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

Hi Tomi

On Mon, 2013-04-15 at 13:57 +0300, Tomi Valkeinen wrote:
> Tomi Valkeinen (38):
>       OMAPDSS: add fields to panels' platform data
>       OMAPDSS: DSI: remove DSI & DISPC clk divisors from dssdev
>       OMAPDSS: HDMI: remove HDMI clk divisors from dssdev
>       OMAPDSS: DPI: remove omap_dss_device uses
>       OMAPDSS: DSI: remove omap_dss_device uses
>       OMAPDSS: Taal: remove multi-panel support
>       OMAPDSS: APPLY: remove dssdev from dss_mgr_wait_for_vsync
>       OMAPDSS: add missing export for omap_dss_get_output()
>       OMAPDSS: HDMI: init output earlier
>       OMAPDSS: add output->name
>       OMAPDSS: add output->dispc_channel
>       OMAPDSS: DSI: delay dispc initialization
>       OMAPDSS: DSI: fix DSI channel source initialization
>       OMAPDSS: Taal: remove rotate & mirror support
>       OMAPDSS: DPI: fix dpi_get_dsidev() for omap5
>       OMAPDSS: DISPC: store core clk rate
>       OMAPDSS: DSI: fix wrong unsigned long long use
>       OMAPDSS: DSI: simplify dsi configuration
>       OMAPDSS: DSI: get line buffer size at probe
>       OMAPDSS: DSI: add enum omap_dss_dsi_trans_mode
>       OMAPDSS: DSI remove unneeded clk source setup code
>       OMAPDSS: DISPC: add new clock calculation code
>       OMAPDSS: DSS: add new clock calculation code
>       OMAPDSS: DSI: add new clock calculation code
>       OMAPDSS: SDI: use new clock calculation code
>       OMAPDSS: DPI: use new clock calculation code

With linux-next this patch breaks compiling here because DPI now depend=
s
on DSI - but my omap3 board here doesn't use DSI at all:

drivers/video/omap2/dss/dpi.c: In function =E2=80=98dpi_calc_pll_cb=E2=80=
=99:
drivers/video/omap2/dss/dpi.c:181: error: implicit declaration of funct=
ion =E2=80=98dsi_hsdiv_calc=E2=80=99
drivers/video/omap2/dss/dpi.c: In function =E2=80=98dpi_dsi_clk_calc=E2=
=80=99:
drivers/video/omap2/dss/dpi.c:201: error: implicit declaration of funct=
ion =E2=80=98dsi_get_pll_clkin=E2=80=99
drivers/video/omap2/dss/dpi.c:212: error: implicit declaration of funct=
ion =E2=80=98dsi_pll_calc=E2=80=99

Enabling OMAP2_DSS_DSI fixes this. This is my proposed patch. You may b=
e want to merge it?

=46rom: Christoph Fritz <chf.fritz@googlemail.com>
Date: Thu, 18 Apr 2013 10:26:54 +0200
Subject: [PATCH] OMAPDSS: DPI: add dependency to DSI

A dependency from DPI to DSI is introduced by commit 100c82623
"OMAPDSS: DPI: use new clock calculation code".
This patch adds the dependency also on Kconfig-Level.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/video/omap2/dss/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/=
Kconfig
index cb0f145..b4211c5 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -36,6 +36,7 @@ config OMAP2_DSS_COLLECT_IRQ_STATS
 config OMAP2_DSS_DPI
 	bool "DPI support"
 	default y
+	select OMAP2_DSS_DSI
 	help
 	  DPI Interface. This is the Parallel Display Interface.
=20
--=20
1.7.10.4



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
