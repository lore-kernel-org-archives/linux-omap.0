From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 121/493] video: remove use of __devexit_p
Date: Tue, 20 Nov 2012 01:56:06 +0000 (GMT)
Message-ID: <8164879.678381353376557564.JavaMail.weblogic@epml04>
Reply-To: jg1.han@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
MIME-version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "linux-nvidia@lists.surfsouth.com" <linux-nvidia@lists.surfsouth.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Jingoo Han <jg1.han@samsung.com>, Donghwa Lee <dh09.lee@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jaya Kumar <jayalk@intworks.biz>, Antonino Daplas <adaplas@gmail.com>, Thomas Winischhofer <thomas@winischhofer.net>, "linux-geode@lists.infradead.org" <linux-geode@lists.infradead.org>, In-Ki Dae <inki.dae@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday, November 20, 2012 3:21 AM, Bill Pemberton wrote
> 
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Jaya Kumar <jayalk@intworks.biz>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Donghwa Lee <dh09.lee@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Maik Broemme <mbroemme@plusserver.de>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Thomas Winischhofer <thomas@winischhofer.net>
> Cc: Tony Prisk <linux@prisktech.co.nz>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-geode@lists.infradead.org
> Cc: linux-nvidia@lists.surfsouth.com
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> ---
>  drivers/video/arcfb.c                                   | 2 +-
>  drivers/video/arkfb.c                                   | 2 +-
>  drivers/video/asiliantfb.c                              | 2 +-
>  drivers/video/aty/aty128fb.c                            | 2 +-
>  drivers/video/aty/atyfb_base.c                          | 2 +-
>  drivers/video/aty/radeon_base.c                         | 2 +-
>  drivers/video/au1200fb.c                                | 2 +-
>  drivers/video/auo_k1900fb.c                             | 2 +-
>  drivers/video/auo_k1901fb.c                             | 2 +-
>  drivers/video/bf537-lq035.c                             | 4 ++--
>  drivers/video/bf54x-lq043fb.c                           | 2 +-
>  drivers/video/bfin-lq035q1-fb.c                         | 4 ++--
>  drivers/video/bfin-t350mcqb-fb.c                        | 2 +-
>  drivers/video/bfin_adv7393fb.c                          | 2 +-
>  drivers/video/broadsheetfb.c                            | 2 +-
>  drivers/video/bw2.c                                     | 2 +-
>  drivers/video/carminefb.c                               | 2 +-
>  drivers/video/cg14.c                                    | 2 +-
>  drivers/video/cg3.c                                     | 2 +-
>  drivers/video/cg6.c                                     | 2 +-
>  drivers/video/chipsfb.c                                 | 2 +-
>  drivers/video/cirrusfb.c                                | 4 ++--
>  drivers/video/cobalt_lcdfb.c                            | 2 +-
>  drivers/video/cyber2000fb.c                             | 2 +-
>  drivers/video/da8xx-fb.c                                | 2 +-
>  drivers/video/ep93xx-fb.c                               | 2 +-
>  drivers/video/exynos/exynos_dp_core.c                   | 2 +-
>  drivers/video/exynos/exynos_mipi_dsi.c                  | 2 +-
>  drivers/video/ffb.c                                     | 2 +-
>  drivers/video/gbefb.c                                   | 2 +-
>  drivers/video/geode/gx1fb_core.c                        | 2 +-
>  drivers/video/grvga.c                                   | 2 +-
>  drivers/video/gxt4500.c                                 | 2 +-
>  drivers/video/hecubafb.c                                | 2 +-
>  drivers/video/hgafb.c                                   | 2 +-
>  drivers/video/hitfb.c                                   | 2 +-
>  drivers/video/i740fb.c                                  | 2 +-
>  drivers/video/imsttfb.c                                 | 2 +-
>  drivers/video/imxfb.c                                   | 2 +-
>  drivers/video/intelfb/intelfbdrv.c                      | 2 +-
>  drivers/video/jz4740_fb.c                               | 2 +-
>  drivers/video/kyro/fbdev.c                              | 2 +-
>  drivers/video/leo.c                                     | 2 +-
>  drivers/video/mb862xx/mb862xxfbdrv.c                    | 4 ++--
>  drivers/video/mbx/mbxfb.c                               | 2 +-
>  drivers/video/metronomefb.c                             | 2 +-
>  drivers/video/mxsfb.c                                   | 2 +-
>  drivers/video/neofb.c                                   | 2 +-
>  drivers/video/nvidia/nvidia.c                           | 2 +-
>  drivers/video/omap/lcd_mipid.c                          | 2 +-
>  drivers/video/omap2/displays/panel-acx565akm.c          | 2 +-
>  drivers/video/omap2/displays/panel-lgphilips-lb035q02.c | 2 +-
>  drivers/video/omap2/displays/panel-n8x0.c               | 2 +-
>  drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c | 2 +-
>  drivers/video/omap2/displays/panel-tpo-td043mtea1.c     | 2 +-
>  drivers/video/p9100.c                                   | 2 +-
>  drivers/video/platinumfb.c                              | 2 +-
>  drivers/video/pm2fb.c                                   | 2 +-
>  drivers/video/pm3fb.c                                   | 2 +-
>  drivers/video/pvr2fb.c                                  | 2 +-
>  drivers/video/pxa168fb.c                                | 2 +-
>  drivers/video/pxa3xx-gcu.c                              | 2 +-
>  drivers/video/pxafb.c                                   | 2 +-
>  drivers/video/riva/fbdev.c                              | 2 +-
>  drivers/video/s3c-fb.c                                  | 2 +-
>  drivers/video/s3c2410fb.c                               | 4 ++--
>  drivers/video/s3fb.c                                    | 2 +-
>  drivers/video/savage/savagefb_driver.c                  | 2 +-
>  drivers/video/sgivwfb.c                                 | 2 +-
>  drivers/video/sh7760fb.c                                | 2 +-
>  drivers/video/sh_mipi_dsi.c                             | 2 +-
>  drivers/video/sis/sis_main.c                            | 2 +-
>  drivers/video/skeletonfb.c                              | 2 +-
>  drivers/video/sstfb.c                                   | 2 +-
>  drivers/video/sunxvr1000.c                              | 2 +-
>  drivers/video/sunxvr2500.c                              | 2 +-
>  drivers/video/sunxvr500.c                               | 2 +-
>  drivers/video/tcx.c                                     | 2 +-
>  drivers/video/tdfxfb.c                                  | 2 +-
>  drivers/video/tgafb.c                                   | 4 ++--
>  drivers/video/tmiofb.c                                  | 2 +-
>  drivers/video/tridentfb.c                               | 2 +-
>  drivers/video/vermilion/vermilion.c                     | 2 +-
>  drivers/video/vga16fb.c                                 | 2 +-
>  drivers/video/via/via-core.c                            | 2 +-
>  drivers/video/vt8500lcdfb.c                             | 2 +-
>  drivers/video/vt8623fb.c                                | 2 +-
>  drivers/video/w100fb.c                                  | 2 +-
>  drivers/video/wm8505fb.c                                | 2 +-
>  drivers/video/wmt_ge_rops.c                             | 2 +-
>  drivers/video/xilinxfb.c                                | 2 +-
>  91 files changed, 97 insertions(+), 97 deletions(-)
> 

For drivers/video/s3c-fb.c, drivers/video/exynos/exynos_dp_core.c

Acked-by: Jingoo Han <jg1.han@samsung.com>


Best regards,
Jingoo Han
