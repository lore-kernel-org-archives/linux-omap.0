From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCH 0/6] OMAPDSS: Misc fixes and cleanups
Date: Tue, 8 May 2012 16:38:52 -0700
Message-ID: <CA+Bv8Xa0KDmf3=DTbWmw2khNNm6DvtZc+4+adVqX-22rNYoeEA@mail.gmail.com>
References: <1336389696-21636-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57767 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853Ab2EHXiy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 19:38:54 -0400
In-Reply-To: <1336389696-21636-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, May 7, 2012 at 4:21 AM, Archit Taneja <archit@ti.com> wrote:
>
> The first patch in this series is a follow up on the previously poste=
d
> series
> 'OMAPDSS: APPLY: Treat overlay manager timings as shadow registers'. =
It is
> required for HDMI and DPI interfaces to work properly, it ensures man=
ager
> timings are applied in the set_timing() ops for these interfaces.
>
> The next 3 patches remove some unnecessary usage of omap_dss_device
> pointer in
> DISPC and APPLY.
>
> The last 2 patches are miscellaneous fixes and are self explanatory.
>
> Reference tree containing this series:
>
> git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git
> mgr_timing_and_fixes
>
> Tested on OMAP4 SDP.
>
> Archit Taneja (6):
> =C2=A0OMAPDSS: DPI/HDMI: Apply manager timings even if panel is disab=
led
> =C2=A0OMAPDSS: APPLY: Remove an unnecessary omap_dss_device pointer
> =C2=A0OMAPDSS: DISPC: Remove omap_dss_device pointer usage from
> =C2=A0 =C2=A0dispc_mgr_pclk_rate()
> =C2=A0OMAPDSS: DISPC: Remove usage of dispc_mgr_get_device()
> =C2=A0OMAPDSS: Fix DSI_FCLK clock source selection
> =C2=A0OMAPDSS: DISPC: Remove Fake VSYNC support
>
> =C2=A0drivers/video/omap2/dss/Kconfig | =C2=A0 =C2=A09 ------
> =C2=A0drivers/video/omap2/dss/apply.c | =C2=A0 =C2=A03 --
> =C2=A0drivers/video/omap2/dss/dispc.c | =C2=A0 61
> +++++++++++++-------------------------
> =C2=A0drivers/video/omap2/dss/dpi.c =C2=A0 | =C2=A0 =C2=A02 +
> =C2=A0drivers/video/omap2/dss/dsi.c =C2=A0 | =C2=A0 =C2=A04 --
> =C2=A0drivers/video/omap2/dss/dss.c =C2=A0 | =C2=A0 =C2=A05 ++-
> =C2=A0drivers/video/omap2/dss/dss.h =C2=A0 | =C2=A0 =C2=A01 -
> =C2=A0drivers/video/omap2/dss/hdmi.c =C2=A0| =C2=A0 =C2=A02 +
> =C2=A08 files changed, 28 insertions(+), 59 deletions(-)

I did a build and boot of each one of the patches on the
mgr_timing_and_fixes branch including these on:

Beagleboard-xM rev C1
Beagleboard rev B4
Mistral AM37x-EVM
Zoom AM3517 EVM
Zoom AM1808 EVM

Tested-by: Russ.Dill@ti.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
