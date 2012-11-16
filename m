From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 00/32] OMAPDSS: create compat layer
Date: Fri, 16 Nov 2012 12:35:35 +0530
Message-ID: <50A5E5BF.40405@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38718 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab2KPHF5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 02:05:57 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rob Clark <rob@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 15 November 2012 09:28 PM, Tomi Valkeinen wrote:
> Hi,
>
> This series is about improving omapdss API for omapdrm.
>
> We have two separate, exclusive, users of omapdss: 1) omapfb + omap_vout and 2)
> omapdrm. Because omapfb and omap_vout are independent drivers, we've built
> layers in omapdss to manage the two simultaneous callers. These layers are not
> needed for omapdrm, as omapdrm is the sole user of omapdss, and these layers in
> fact only create trouble for omapdrm.
>
> The simple option to improve omapdrm situation would be to copy the omapdss
> code for omapdrm. We are trying to avoid this, as omapdss and the panel drivers
> are quite a lot of code together, and most of the code would be used without
> change.
>
> Thus this series helps the situation by moving the omapdss code required by
> omapfb + omap_vout to separate files, creating a distinct layer used only by
> omapfb + omap_vout. We call this layer "compat layer". This compat layer then
> uses the core omapdss driver to operate the hardware. omapdrm will use the core
> omapdss directly, without any layers in between.
>
> After this series, omapfb, omap_vout and omapdrm can all be compiled at the
> same time. Obviously omapdrm and omapfb+omap_vout cannot be run at the same
> time (the first one to start will "win"), so compiling them at the same time is
> only sensible as modules for testing purposes. Normal users should only compile
> one of those.
>
> This series does not make omapdrm use the core omapdss API, that will happen in
> a separate series for omapdrm.
>
> The series is based on current omapdss master, and can also be found from:
> git://gitorious.org/linux-omap-dss2/linux.git work/apply-test-9

Series looks fine to me. Will test it out.

Archit

>
>   Tomi
>
> Tomi Valkeinen (32):
>    OMAPDSS: remove declarations for non-existing functions
>    OMAPDSS: DPI: fix crash with dpi_verify_dsi_pll()
>    OMAPDSS: don't WARN if there's no DSI device
>    OMAPDSS: DISPC: add no_framedone_tv feat
>    OMAPDSS: DISPC: use get_framedone_irq in disable_digit_out
>    OMAPDSS: DISPC: Remove blocking code from dispc_wb_enable()
>    OMAPDSS: cleanup WB enable/is_enabled functions
>    OMAPDSS: DISPC: use WARN_ON() in dispc_mgr_go
>    OMAPDSS: DISPC: pclk & lclk rates for writeback
>    OMAPDSS: DISPC: pass pclk to calc_core_clk()
>    OMAPDSS: DISPC: pass pclk & lclk to check_horiz_timing_omap3
>    OMAPDSS: DISPC: pass pclk & lclk to calc_scaling
>    OMAPDSS: DISPC: pass pclk & lclk to dispc_ovl_calc_scaling
>    OMAPDSS: create display-sysfs.c
>    OMAPDSS: add dss_get_core_pdev()
>    OMAPDSS: add omapdss_compat_init()
>    OMAPDSS: move ovl & ovl-mgr init to apply.c
>    OMAPDSS: move ovl-mgr function setup to apply.c
>    OMAPDSS: move ovl function setup to apply.c
>    OMAPDSS: add manager ops
>    OMAPDSS: manage framedone irq with mgr ops
>    OMAPDSS: move blocking mgr enable/disable to compat layer
>    OMAPDSS: move omap_dispc_wait_for_irq_interruptible_timeout to
>      dispc-compat.c
>    OMAPDSS: move irq handling to dispc-compat
>    OMAPDSS: DISPC: add dispc_ovl_check()
>    OMAPDSS: DPI: use dispc's check_timings
>    OMAPDSS: move display sysfs init to compat layer
>    OMAPDSS: separate compat files in the Makefile
>    OMAPDSS: export dss_mgr_ops functions
>    OMAPDSS: export dss_feat functions
>    OMAPDSS: export dispc functions
>    OMAPDSS: use omapdss_compat_init() in other drivers
>
>   drivers/media/platform/omap/omap_vout.c  |   17 +-
>   drivers/staging/omapdrm/omap_drv.c       |   11 +
>   drivers/video/omap2/dss/Makefile         |    6 +-
>   drivers/video/omap2/dss/apply.c          |  245 ++++++++-
>   drivers/video/omap2/dss/core.c           |   13 +-
>   drivers/video/omap2/dss/dispc-compat.c   |  667 +++++++++++++++++++++++
>   drivers/video/omap2/dss/dispc-compat.h   |   30 ++
>   drivers/video/omap2/dss/dispc.c          |  863 +++++-------------------------
>   drivers/video/omap2/dss/display-sysfs.c  |  321 +++++++++++
>   drivers/video/omap2/dss/display.c        |  285 +---------
>   drivers/video/omap2/dss/dpi.c            |    4 +-
>   drivers/video/omap2/dss/dsi.c            |   26 +-
>   drivers/video/omap2/dss/dss.h            |   75 +--
>   drivers/video/omap2/dss/dss_features.c   |    5 +
>   drivers/video/omap2/dss/dss_features.h   |    4 -
>   drivers/video/omap2/dss/manager.c        |   39 --
>   drivers/video/omap2/dss/output.c         |   65 +++
>   drivers/video/omap2/dss/overlay.c        |   17 -
>   drivers/video/omap2/dss/rfbi.c           |   12 +-
>   drivers/video/omap2/omapfb/omapfb-main.c |    6 +
>   include/video/omapdss.h                  |   80 ++-
>   21 files changed, 1582 insertions(+), 1209 deletions(-)
>   create mode 100644 drivers/video/omap2/dss/dispc-compat.c
>   create mode 100644 drivers/video/omap2/dss/dispc-compat.h
>   create mode 100644 drivers/video/omap2/dss/display-sysfs.c
>

