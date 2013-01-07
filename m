From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 01/10] video: da8xx-fb: fb_check_var enhancement
Date: Mon, 7 Jan 2013 10:34:47 +0530
Message-ID: <55042f1892250bb83d66bc17f4ccfdee25a51ba0.1357303978.git.afzal@ti.com>
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

Check whether "struct fb_var_screeninfo" fields are sane, if not
update it to be within allowed limits.

If user sends down buggy "var" values, this will bring those within
allowable limits. And fb_set_par is not supposed to change "var"
values, fb_check_var has to ensure that values are proper.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 drivers/video/da8xx-fb.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 46534e0..89446aa 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -888,6 +888,9 @@ static int fb_check_var(struct fb_var_screeninfo *var,
 			struct fb_info *info)
 {
 	int err = 0;
+	struct da8xx_fb_par *par = info->par;
+	int bpp = var->bits_per_pixel >> 3;
+	unsigned long line_size = var->xres_virtual * bpp;
 
 	if (var->bits_per_pixel > 16 && lcd_revision == LCD_VERSION_1)
 		return -EINVAL;
@@ -955,6 +958,21 @@ static int fb_check_var(struct fb_var_screeninfo *var,
 	var->green.msb_right = 0;
 	var->blue.msb_right = 0;
 	var->transp.msb_right = 0;
+
+	if (line_size * var->yres_virtual > par->vram_size)
+		var->yres_virtual = par->vram_size / line_size;
+
+	if (var->yres > var->yres_virtual)
+		var->yres = var->yres_virtual;
+
+	if (var->xres > var->xres_virtual)
+		var->xres = var->xres_virtual;
+
+	if (var->xres + var->xoffset > var->xres_virtual)
+		var->xoffset = var->xres_virtual - var->xres;
+	if (var->yres + var->yoffset > var->yres_virtual)
+		var->yoffset = var->yres_virtual - var->yres;
+
 	return err;
 }
 
-- 
1.7.9.5
