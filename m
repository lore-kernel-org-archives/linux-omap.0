From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 04/10] video: da8xx-fb: remove unneeded "var" initialization
Date: Mon, 7 Jan 2013 10:35:12 +0530
Message-ID: <9352c8257da9dbe4962b61ab1722022f1ea21c06.1357303978.git.afzal@ti.com>
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

modedb helper now updates "var" information based on the detected
panel, remove the unnecessary initialization.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 drivers/video/da8xx-fb.c |   18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 0c404ed..79862ff 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -184,23 +184,7 @@ struct da8xx_fb_par {
 	u32 pseudo_palette[16];
 };
 
-/* Variable Screen Information */
-static struct fb_var_screeninfo da8xx_fb_var __devinitdata = {
-	.xoffset = 0,
-	.yoffset = 0,
-	.transp = {0, 0, 0},
-	.nonstd = 0,
-	.activate = 0,
-	.height = -1,
-	.width = -1,
-	.accel_flags = 0,
-	.left_margin = LEFT_MARGIN,
-	.right_margin = RIGHT_MARGIN,
-	.upper_margin = UPPER_MARGIN,
-	.lower_margin = LOWER_MARGIN,
-	.sync = 0,
-	.vmode = FB_VMODE_NONINTERLACED
-};
+static struct fb_var_screeninfo da8xx_fb_var;
 
 static struct fb_fix_screeninfo da8xx_fb_fix __devinitdata = {
 	.id = "DA8xx FB Drv",
-- 
1.7.9.5
