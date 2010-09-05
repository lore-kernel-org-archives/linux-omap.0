From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 0/2] V4L/DVB: OMAP_VOUT: Allow omap_vout to build
 without VRFB
Date: Mon, 6 Sep 2010 00:44:33 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404687B222E@dbde02.ent.ti.com>
References: <1283589705-6723-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1283589705-6723-1-git-send-email-archit@ti.com>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Taneja, Archit
> Sent: Saturday, September 04, 2010 2:12 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; linux-media@vger.kernel.org; Taneja,
> Archit
> Subject: [PATCH 0/2] V4L/DVB: OMAP_VOUT: Allow omap_vout to build without
> VRFB
> 
> This lets omap_vout driver build and run without VRFB. It works along the
> lines of the following patch series:
> OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build without VRFB
> https://patchwork.kernel.org/patch/105371/
> 
> A variable rotation_type is introduced in omapvideo_info like the way in
> omapfb_info to make both vrfb and non vrfb rotation possible.
> 
[Hiremath, Vaibhav] Archit,

Currently omap_vout driver only supports VRFB based rotation, it doesn't support SDMA based rotation (unlike OMAPFB) and neither you patch adds it.

Thanks,
Vaibhav

> Since VRFB is tightly coupled with the omap_vout driver, a handful of
> vrfb-specific functions have been defined and placed in omap_vout_vrfb.c
> 
> This series applies along with the previously submitted patch:
> https://patchwork.kernel.org/patch/146401/
> 
> Archit Taneja (2):
>   V4L/DVB: OMAP_VOUT: Create a seperate vrfb functions library
>   V4L/DVB: OMAP_VOUT: Use rotation_type to choose between vrfb and
>     sdram rotation
> 
>  drivers/media/video/omap/Kconfig          |    1 -
>  drivers/media/video/omap/Makefile         |    1 +
>  drivers/media/video/omap/omap_vout.c      |  502 ++++++------------------
> -----
>  drivers/media/video/omap/omap_vout_vrfb.c |  417 ++++++++++++++++++++++++
>  drivers/media/video/omap/omap_vout_vrfb.h |   40 +++
>  drivers/media/video/omap/omap_voutdef.h   |   26 ++
>  6 files changed, 582 insertions(+), 405 deletions(-)
>  create mode 100644 drivers/media/video/omap/omap_vout_vrfb.c
>  create mode 100644 drivers/media/video/omap/omap_vout_vrfb.h
