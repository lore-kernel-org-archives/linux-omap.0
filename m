From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 06/10] video: da8xx-fb: store clk rate even if !CPUFREQ
Date: Mon, 7 Jan 2013 10:35:37 +0530
Message-ID: <619b7f8d9cbdd7e6f89fdbcb94bc4ce91d269fdd.1357303978.git.afzal@ti.com>
References: <cover.1357303978.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <cover.1357303978.git.afzal-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, hvaibhav-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

store lcd clk rate always, i.e. irrespective of whether CPUFREQ is
enabled or not. This can be used to get clk rate directly instead of
enquiring with clock framework with clk handle every time.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 drivers/video/da8xx-fb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 072074d..e858438 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -178,8 +178,8 @@ struct da8xx_fb_par {
 	unsigned int		which_dma_channel_done;
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
-	unsigned int		lcd_fck_rate;
 #endif
+	unsigned int		lcd_fck_rate;
 	void (*panel_power_ctrl)(int);
 	u32 pseudo_palette[16];
 	struct fb_videomode	mode;
@@ -1306,9 +1306,7 @@ static int __devinit fb_probe(struct platform_device *device)
 
 	par = da8xx_fb_info->par;
 	par->lcdc_clk = fb_clk;
-#ifdef CONFIG_CPU_FREQ
 	par->lcd_fck_rate = clk_get_rate(fb_clk);
-#endif
 	par->pxl_clk = lcdc_info->pixclock;
 	if (fb_pdata->panel_power_ctrl) {
 		par->panel_power_ctrl = fb_pdata->panel_power_ctrl;
-- 
1.7.9.5
