From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/2] video:omap2:dss: fix timings for VENC to match what omapdrm expects
Date: Sun, 13 Dec 2015 19:41:24 +0100
Message-ID: <5BB301DB-5429-422E-B672-E7A508441C45@goldelico.com>
References: <cover.1447410543.git.hns@goldelico.com> <20ebf7491377ccba18c734c22ae9f361d7fdc165.1447410544.git.hns@goldelico.com> <5667E3D0.8010600@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5667E3D0.8010600@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, gta04-owner@goldelico.com, notasas@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

Am 09.12.2015 um 09:18 schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:

> 
> On 13/11/15 12:29, H. Nikolaus Schaller wrote:
>> Otherwise check_timings fails and we get a "has no modes" message
>> from xrandr.
>> 
>> This fix makes the venc assume PAL and NTSC timings that match the
>> timings synthetized by copy_timings_drm_to_omap() from omapdrm
>> mode settings so that check_timings() succeeds.
>> 
>> Tested on: BeagleBoard XM, GTA04 and OpenPandora
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/video/fbdev/omap2/dss/venc.c | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
> 
> I've picked this up.

Thanks!

> 
> With this patch and the one below I can get tv-out working on my very old
> beagleboard, and it seems to work with X also. It doesn't start automatically
> as the connection state is unknown, but doing "xrandr --output None-1 --auto"
> was all I needed to enable it.

Great that you did find the real reason of the problem.

I have tested it on the GTA04 and it also works.

Will the patches arrive in 4.5?

So thanks a lot,
Nikolaus

> 
> Tomi
> 
> From a4274600a5a67256b91266b0d2624b9c9028909b Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Tue, 8 Dec 2015 18:32:14 +0200
> Subject: [PATCH] drm/omap: fix fbdev pix format to support all platforms
> 
> omap_fbdev always creates a framebuffer with ARGB8888 pixel format. On
> OMAP3 we have VIDEO1 overlay that does not support ARGB8888, and on
> OMAP2 none of the overlays support ARGB888.
> 
> This patch changes the omap_fbdev's fb to XRGB8888, which is supported
> by all platforms.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
> index b8e4cdec28c3..24f92bea39c7 100644
> --- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
> +++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
> @@ -112,11 +112,8 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
> 	dma_addr_t paddr;
> 	int ret;
> 
> -	/* only doing ARGB32 since this is what is needed to alpha-blend
> -	 * with video overlays:
> -	 */
> 	sizes->surface_bpp = 32;
> -	sizes->surface_depth = 32;
> +	sizes->surface_depth = 24;
> 
> 	DBG("create fbdev: %dx%d@%d (%dx%d)", sizes->surface_width,
> 			sizes->surface_height, sizes->surface_bpp,
> 
