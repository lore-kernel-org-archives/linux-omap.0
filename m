From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 158/493] video: remove use of __devinit
Date: Tue, 20 Nov 2012 01:58:21 +0000 (GMT)
Message-ID: <18550095.678601353376700883.JavaMail.weblogic@epml04>
Reply-To: jg1.han@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
MIME-version: 1.0
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Michal Januszewski <spock@gentoo.org>, Paul Mackerras <paulus@samba.org>, "linux-nvidia@lists.surfsouth.com" <linux-nvidia@lists.surfsouth.com>, Daniel Walker <dwalker@fifo99.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Wan ZongShun <mcuos.com@gmail.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Jingoo Han <jg1.han@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Brown <davidb@codeaurora.org>, Jaya Kumar <jayalk@intworks.biz>, "cbe-oss-dev@lists.ozlabs.org" <cbe-oss-dev@lists.ozlabs.org>, Antonino Daplas <adaplas@gmail.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Thomas Winischhofer <thomas@winischhofer.net>, linux-geode@lists.infradead.
List-Id: linux-omap@vger.kernel.org

On Tuesday, November 20, 2012 3:22 AM, Bill Pemberton wrote
> 
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: Jaya Kumar <jayalk@intworks.biz>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Maik Broemme <mbroemme@plusserver.de>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Thomas Winischhofer <thomas@winischhofer.net>
> Cc: Michal Januszewski <spock@gentoo.org>
> Cc: Tony Prisk <linux@prisktech.co.nz>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-geode@lists.infradead.org
> Cc: linux-nvidia@lists.surfsouth.com
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: cbe-oss-dev@lists.ozlabs.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: xen-devel@lists.xensource.com
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/video/acornfb.c                            | 14 ++--
>  drivers/video/arcfb.c                              |  2 +-
>  drivers/video/arkfb.c                              |  2 +-
>  drivers/video/asiliantfb.c                         |  6 +-
>  drivers/video/aty/aty128fb.c                       | 22 +++---
>  drivers/video/aty/atyfb_base.c                     | 22 +++---
>  drivers/video/aty/mach64_ct.c                      |  4 +-
>  drivers/video/aty/mach64_cursor.c                  |  2 +-
>  drivers/video/aty/radeon_base.c                    | 14 ++--
>  drivers/video/aty/radeon_monitor.c                 | 16 ++---
>  drivers/video/au1100fb.c                           |  2 +-
>  drivers/video/au1200fb.c                           |  2 +-
>  drivers/video/auo_k1900fb.c                        |  2 +-
>  drivers/video/auo_k1901fb.c                        |  2 +-
>  drivers/video/auo_k190x.c                          |  2 +-
>  drivers/video/bf537-lq035.c                        |  6 +-
>  drivers/video/bf54x-lq043fb.c                      |  2 +-
>  drivers/video/bfin-lq035q1-fb.c                    |  6 +-
>  drivers/video/bfin-t350mcqb-fb.c                   |  2 +-
>  drivers/video/bfin_adv7393fb.c                     |  2 +-
>  drivers/video/broadsheetfb.c                       |  8 +--
>  drivers/video/bw2.c                                |  6 +-
>  drivers/video/carminefb.c                          |  4 +-
>  drivers/video/cg14.c                               |  4 +-
>  drivers/video/cg3.c                                |  8 +--
>  drivers/video/cg6.c                                |  8 +--
>  drivers/video/chipsfb.c                            |  4 +-
>  drivers/video/cirrusfb.c                           | 10 +--
>  drivers/video/cobalt_lcdfb.c                       |  2 +-
>  drivers/video/console/sticore.c                    | 47 ++++++-------
>  drivers/video/cyber2000fb.c                        | 12 ++--
>  drivers/video/da8xx-fb.c                           |  2 +-
>  drivers/video/dnfb.c                               |  2 +-
>  drivers/video/ep93xx-fb.c                          |  4 +-
>  drivers/video/exynos/exynos_dp_core.c              |  2 +-
>  drivers/video/ffb.c                                |  2 +-
>  drivers/video/fm2fb.c                              |  4 +-
>  drivers/video/fsl-diu-fb.c                         |  4 +-
>  drivers/video/gbefb.c                              |  4 +-
>  drivers/video/geode/gx1fb_core.c                   |  6 +-
>  drivers/video/geode/gxfb_core.c                    | 10 +--
>  drivers/video/geode/lxfb_core.c                    | 10 +--
>  drivers/video/grvga.c                              |  4 +-
>  drivers/video/gxt4500.c                            |  4 +-
>  drivers/video/hecubafb.c                           |  2 +-
>  drivers/video/hgafb.c                              |  4 +-
>  drivers/video/hitfb.c                              |  2 +-
>  drivers/video/hpfb.c                               |  4 +-
>  drivers/video/i740fb.c                             |  4 +-
>  drivers/video/i810/i810_main.c                     | 26 +++----
>  drivers/video/i810/i810_main.h                     |  2 +-
>  drivers/video/imsttfb.c                            |  4 +-
>  drivers/video/intelfb/intelfbdrv.c                 | 16 ++---
>  drivers/video/jz4740_fb.c                          |  2 +-
>  drivers/video/kyro/fbdev.c                         |  2 +-
>  drivers/video/leo.c                                |  2 +-
>  drivers/video/mb862xx/mb862xxfbdrv.c               |  6 +-
>  drivers/video/mbx/mbxdebugfs.c                     |  2 +-
>  drivers/video/mbx/mbxfb.c                          | 10 +--
>  drivers/video/metronomefb.c                        | 12 ++--
>  drivers/video/msm/mddi.c                           |  6 +-
>  drivers/video/mxsfb.c                              |  6 +-
>  drivers/video/neofb.c                              | 12 ++--
>  drivers/video/nuc900fb.c                           |  4 +-
>  drivers/video/nvidia/nvidia.c                      | 12 ++--
>  .../omap2/displays/panel-lgphilips-lb035q02.c      |  2 +-
>  drivers/video/p9100.c                              |  2 +-
>  drivers/video/platinumfb.c                         |  6 +-
>  drivers/video/pm2fb.c                              |  2 +-
>  drivers/video/pm3fb.c                              |  4 +-
>  drivers/video/pmag-ba-fb.c                         |  2 +-
>  drivers/video/pmagb-b-fb.c                         |  6 +-
>  drivers/video/ps3fb.c                              |  2 +-
>  drivers/video/pvr2fb.c                             |  6 +-
>  drivers/video/pxa168fb.c                           |  4 +-
>  drivers/video/pxa3xx-gcu.c                         |  2 +-
>  drivers/video/pxafb.c                              | 20 +++---
>  drivers/video/q40fb.c                              |  2 +-
>  drivers/video/riva/fbdev.c                         | 20 +++---
>  drivers/video/riva/rivafb-i2c.c                    |  6 +-
>  drivers/video/s1d13xxxfb.c                         |  4 +-
>  drivers/video/s3c-fb.c                             |  6 +-
>  drivers/video/s3c2410fb.c                          |  8 +--
>  drivers/video/s3fb.c                               |  6 +-
>  drivers/video/sa1100fb.c                           |  6 +-
>  drivers/video/savage/savagefb_driver.c             |  8 +--
>  drivers/video/sgivwfb.c                            |  2 +-
>  drivers/video/sh7760fb.c                           |  2 +-
>  drivers/video/sh_mobile_lcdcfb.c                   | 16 ++---
>  drivers/video/sh_mobile_meram.c                    |  2 +-
>  drivers/video/sis/sis_main.c                       | 82 +++++++++++-----------
>  drivers/video/skeletonfb.c                         |  2 +-
>  drivers/video/sm501fb.c                            |  8 +--
>  drivers/video/sstfb.c                              | 18 ++---
>  drivers/video/sunxvr1000.c                         |  6 +-
>  drivers/video/sunxvr2500.c                         |  6 +-
>  drivers/video/sunxvr500.c                          |  6 +-
>  drivers/video/tcx.c                                |  2 +-
>  drivers/video/tdfxfb.c                             | 10 +--
>  drivers/video/tgafb.c                              | 16 ++---
>  drivers/video/tmiofb.c                             |  2 +-
>  drivers/video/tridentfb.c                          |  8 +--
>  drivers/video/uvesafb.c                            | 30 ++++----
>  drivers/video/vermilion/vermilion.c                |  2 +-
>  drivers/video/vfb.c                                |  2 +-
>  drivers/video/vga16fb.c                            |  2 +-
>  drivers/video/via/dvi.c                            |  8 +--
>  drivers/video/via/dvi.h                            |  4 +-
>  drivers/video/via/hw.c                             | 16 ++---
>  drivers/video/via/hw.h                             |  4 +-
>  drivers/video/via/lcd.c                            | 10 +--
>  drivers/video/via/lcd.h                            |  6 +-
>  drivers/video/via/via-core.c                       | 10 +--
>  drivers/video/via/via-gpio.c                       |  2 +-
>  drivers/video/via/viafbdev.c                       | 10 +--
>  drivers/video/vt8500lcdfb.c                        |  2 +-
>  drivers/video/vt8623fb.c                           |  2 +-
>  drivers/video/w100fb.c                             |  6 +-
>  drivers/video/wm8505fb.c                           |  2 +-
>  drivers/video/wmt_ge_rops.c                        |  2 +-
>  drivers/video/xen-fbfront.c                        |  4 +-
>  drivers/video/xilinxfb.c                           |  2 +-
>  122 files changed, 438 insertions(+), 443 deletions(-)
> 

For drivers/video/s3c-fb.c, drivers/video/exynos/exynos_dp_core.c

Acked-by: Jingoo Han <jg1.han@samsung.com>


Best regards,
Jingoo Han
