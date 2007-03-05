From: Imre Deak <imre.deak@solidboot.com>
Subject: [PATCH 2/4] FB: sync with N800 tree (generic FB code)
Date: Mon, 5 Mar 2007 14:09:52 +0200
Message-ID: <20070305120950.GB4435@bitbox.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

- dynamic relocation of FB mem to SRAM, SDRAM
- support for per window resizing in window updates
- fix locking in plane reconfiguration
- extended capability query for separate plane / window attributes,
  and supported color formats

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 drivers/video/omap/omapfb_main.c   |  385 +++++++++++++++++++++++++++++-------
 include/asm-arm/arch-omap/omapfb.h |   45 ++++-
 2 files changed, 349 insertions(+), 81 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 24709b7..52de408 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -53,15 +53,34 @@ static struct platform_device	*fbdev_pdev;
 static struct lcd_panel		*fbdev_panel;
 static struct omapfb_device	*omapfb_dev;
 
-static struct caps_table_struct {
+struct caps_table_struct {
         unsigned long flag;
         const char *name;
-} omapfb_caps_table[] = {
+};
+
+static struct caps_table_struct ctrl_caps[] = {
 	{ OMAPFB_CAPS_MANUAL_UPDATE, "manual update" },
 	{ OMAPFB_CAPS_TEARSYNC,      "tearing synchronization" },
+	{ OMAPFB_CAPS_PLANE_RELOCATE_MEM, "relocate plane memory" },
+	{ OMAPFB_CAPS_PLANE_SCALE,   "scale plane" },
+	{ OMAPFB_CAPS_WINDOW_PIXEL_DOUBLE, "pixel double window" },
+	{ OMAPFB_CAPS_WINDOW_SCALE,  "scale window" },
+	{ OMAPFB_CAPS_WINDOW_OVERLAY,"overlay window" },
 	{ OMAPFB_CAPS_SET_BACKLIGHT, "backlight setting" },
 };
 
+static struct caps_table_struct color_caps[] = {
+	{ 1 << OMAPFB_COLOR_RGB565,	"RGB565", },
+	{ 1 << OMAPFB_COLOR_YUV422,	"YUV422", },
+	{ 1 << OMAPFB_COLOR_YUV420,	"YUV420", },
+	{ 1 << OMAPFB_COLOR_CLUT_8BPP,	"CLUT8", },
+	{ 1 << OMAPFB_COLOR_CLUT_4BPP,	"CLUT4", },
+	{ 1 << OMAPFB_COLOR_CLUT_2BPP,	"CLUT2", },
+	{ 1 << OMAPFB_COLOR_CLUT_1BPP,	"CLUT1", },
+	{ 1 << OMAPFB_COLOR_RGB444,	"RGB444", },
+	{ 1 << OMAPFB_COLOR_YUY422,	"YUY422", },
+};
+
 /*
  * ---------------------------------------------------------------------------
  * LCD panel
@@ -132,7 +151,8 @@ static int ctrl_init(struct omapfb_device *fbdev)
 	/* kernel/module vram parameters override boot tags/board config */
 	if (def_vram_cnt) {
 		for (i = 0; i < def_vram_cnt; i++)
-			fbdev->mem_desc.region[i].size = def_vram[i];
+			fbdev->mem_desc.region[i].size =
+				PAGE_ALIGN(def_vram[i]);
 		fbdev->mem_desc.region_cnt = i;
 	} else {
 		struct omapfb_platform_data *conf;
@@ -151,7 +171,7 @@ static int ctrl_init(struct omapfb_device *fbdev)
 			bpp = 16;
 		def_size = def_vxres * def_vyres * bpp / 8;
 		fbdev->mem_desc.region_cnt = 1;
-		fbdev->mem_desc.region[0].size = def_size;
+		fbdev->mem_desc.region[0].size = PAGE_ALIGN(def_size);
 	}
 	r = fbdev->ctrl->init(fbdev, 0, &fbdev->mem_desc);
 	if (r < 0) {
@@ -176,6 +196,7 @@ static void ctrl_cleanup(struct omapfb_device *fbdev)
 	fbdev->ctrl->cleanup();
 }
 
+/* Must be called with fbdev->rqueue_mutex held. */
 static int ctrl_change_mode(struct fb_info *fbi)
 {
 	int r;
@@ -187,7 +208,8 @@ static int ctrl_change_mode(struct fb_info *fbi)
 	offset = var->yoffset * fbi->fix.line_length +
 		 var->xoffset * var->bits_per_pixel / 8;
 
-	omapfb_rqueue_lock(fbdev);
+	if (fbdev->ctrl->sync)
+		fbdev->ctrl->sync();
 	r = fbdev->ctrl->setup_plane(plane->idx, plane->info.channel_out,
 				 offset, var->xres_virtual,
 				 plane->info.pos_x, plane->info.pos_y,
@@ -197,7 +219,6 @@ static int ctrl_change_mode(struct fb_info *fbi)
 				   var->xres, var->yres,
 				   plane->info.out_width,
 				   plane->info.out_height);
-	omapfb_rqueue_unlock(fbdev);
 
 	return r;
 }
@@ -364,8 +385,15 @@ static void set_fb_fix(struct fb_info *fbi)
 {
 	struct fb_fix_screeninfo *fix = &fbi->fix;
 	struct fb_var_screeninfo *var = &fbi->var;
+	struct omapfb_plane_struct *plane = fbi->par;
+	struct omapfb_mem_region *rg;
 	int bpp;
 
+	rg = &plane->fbdev->mem_desc.region[plane->idx];
+	fbi->screen_base	= (char __iomem *)rg->vaddr;
+	fix->smem_start		= rg->paddr;
+	fix->smem_len		= rg->size;
+
 	fix->type = FB_TYPE_PACKED_PIXELS;
 	bpp = var->bits_per_pixel;
 	if (var->nonstd)
@@ -509,6 +537,13 @@ static int set_fb_var(struct fb_info *fbi,
 			line_size = var->xres * bpp / 8;
 			var->yres_virtual = max_frame_size / line_size;
 		}
+		/* Recheck this, as the virtual size changed. */
+		if (var->xres_virtual < var->xres)
+			var->xres = var->xres_virtual;
+		if (var->yres_virtual < var->yres)
+			var->yres = var->yres_virtual;
+		if (var->xres < xres_min || var->yres < yres_min)
+			return -EINVAL;
 	}
 	if (var->xres + var->xoffset > var->xres_virtual)
 		var->xoffset = var->xres_virtual - var->xres;
@@ -552,20 +587,26 @@ static int set_fb_var(struct fb_info *fbi,
 	return 0;
 }
 
-static struct fb_var_screeninfo new_var;
 
 /* Set rotation (0, 90, 180, 270 degree), and switch to the new mode. */
 static void omapfb_rotate(struct fb_info *fbi, int rotate)
 {
+	struct omapfb_plane_struct *plane = fbi->par;
+	struct omapfb_device *fbdev = plane->fbdev;
+
+	omapfb_rqueue_lock(fbdev);
 	if (cpu_is_omap15xx() && rotate != fbi->var.rotate) {
-		memcpy(&new_var, &fbi->var, sizeof(new_var));
-		new_var.rotate = rotate;
-		if (set_fb_var(fbi, &new_var) == 0 &&
-		    memcmp(&new_var, &fbi->var, sizeof(new_var))) {
-			memcpy(&fbi->var, &new_var, sizeof(new_var));
+		struct fb_var_screeninfo *new_var = &fbdev->new_var;
+
+		memcpy(new_var, &fbi->var, sizeof(*new_var));
+		new_var->rotate = rotate;
+		if (set_fb_var(fbi, new_var) == 0 &&
+		    memcmp(new_var, &fbi->var, sizeof(*new_var))) {
+			memcpy(&fbi->var, new_var, sizeof(*new_var));
 			ctrl_change_mode(fbi);
 		}
 	}
+	omapfb_rqueue_unlock(fbdev);
 }
 
 /* Set new x,y offsets in the virtual display for the visible area and switch
@@ -574,20 +615,26 @@ static void omapfb_rotate(struct fb_info *fbi, int rotate)
 static int omapfb_pan_display(struct fb_var_screeninfo *var,
 			       struct fb_info *fbi)
 {
+	struct omapfb_plane_struct *plane = fbi->par;
+	struct omapfb_device *fbdev = plane->fbdev;
 	int r = 0;
 
+	omapfb_rqueue_lock(fbdev);
 	if (var->xoffset != fbi->var.xoffset ||
 	    var->yoffset != fbi->var.yoffset) {
-		memcpy(&new_var, &fbi->var, sizeof(new_var));
-		new_var.xoffset = var->xoffset;
-		new_var.yoffset = var->yoffset;
-		if (set_fb_var(fbi, &new_var))
+		struct fb_var_screeninfo *new_var = &fbdev->new_var;
+
+		memcpy(new_var, &fbi->var, sizeof(*new_var));
+		new_var->xoffset = var->xoffset;
+		new_var->yoffset = var->yoffset;
+		if (set_fb_var(fbi, new_var))
 			r = -EINVAL;
 		else {
-			memcpy(&fbi->var, &new_var, sizeof(new_var));
+			memcpy(&fbi->var, new_var, sizeof(*new_var));
 			ctrl_change_mode(fbi);
 		}
 	}
+	omapfb_rqueue_unlock(fbdev);
 
 	return r;
 }
@@ -596,8 +643,10 @@ static int omapfb_pan_display(struct fb_var_screeninfo *var,
 static int omapfb_mirror(struct fb_info *fbi, int mirror)
 {
 	struct omapfb_plane_struct *plane = fbi->par;
+	struct omapfb_device *fbdev = plane->fbdev;
 	int r = 0;
 
+	omapfb_rqueue_lock(fbdev);
 	mirror = mirror ? 1 : 0;
 	if (cpu_is_omap15xx())
 		r = -EINVAL;
@@ -605,6 +654,7 @@ static int omapfb_mirror(struct fb_info *fbi, int mirror)
 		plane->info.mirror = mirror;
 		r = ctrl_change_mode(fbi);
 	}
+	omapfb_rqueue_unlock(fbdev);
 
 	return r;
 }
@@ -614,7 +664,17 @@ static int omapfb_mirror(struct fb_info *fbi, int mirror)
  */
 static int omapfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fbi)
 {
-	return set_fb_var(fbi, var);
+	struct omapfb_plane_struct *plane = fbi->par;
+	struct omapfb_device *fbdev = plane->fbdev;
+	int r;
+
+	omapfb_rqueue_lock(fbdev);
+	if (fbdev->ctrl->sync != NULL)
+		fbdev->ctrl->sync();
+	r = set_fb_var(fbi, var);
+	omapfb_rqueue_unlock(fbdev);
+
+	return r;
 }
 
 /* Switch to a new mode. The parameters for it has been check already by
@@ -622,8 +682,16 @@ static int omapfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fbi)
  */
 static int omapfb_set_par(struct fb_info *fbi)
 {
+	struct omapfb_plane_struct *plane = fbi->par;
+	struct omapfb_device *fbdev = plane->fbdev;
+	int r = 0;
+
+	omapfb_rqueue_lock(fbdev);
 	set_fb_fix(fbi);
-	return ctrl_change_mode(fbi);
+	r = ctrl_change_mode(fbi);
+	omapfb_rqueue_unlock(fbdev);
+
+	return r;
 }
 
 int omapfb_update_window_async(struct fb_info *fbi,
@@ -631,18 +699,13 @@ int omapfb_update_window_async(struct fb_info *fbi,
 				void (*callback)(void *),
 				void *callback_data)
 {
-	struct omapfb_plane_struct *plane;
-	struct omapfb_device *fbdev;
+	struct omapfb_plane_struct *plane = fbi->par;
+	struct omapfb_device *fbdev = plane->fbdev;
 	struct fb_var_screeninfo *var;
 
-	if (!fbi)
-		return -EINVAL;
-
-	plane = fbi->par;
-	fbdev = plane->fbdev;
 	var = &fbi->var;
-
-	if (win->x >= var->xres || win->y >= var->yres)
+	if (win->x >= var->xres || win->y >= var->yres ||
+	    win->out_x > var->xres || win->out_y >= var->yres)
 		return -EINVAL;
 
 	if (!fbdev->ctrl->update_window ||
@@ -653,7 +716,12 @@ int omapfb_update_window_async(struct fb_info *fbi,
 		win->width = var->xres - win->x;
 	if (win->y + win->height >= var->yres)
 		win->height = var->yres - win->y;
-	if (!win->width || !win->height)
+	/* The out sizes should be cropped to the LCD size */
+	if (win->out_x + win->out_width > fbdev->panel->x_res)
+		win->out_width = fbdev->panel->x_res - win->out_x;
+	if (win->out_y + win->out_height > fbdev->panel->y_res)
+		win->out_height = fbdev->panel->y_res - win->out_y;
+	if (!win->width || !win->height || !win->out_width || !win->out_height)
 		return 0;
 
 	return fbdev->ctrl->update_window(fbi, win, callback, callback_data);
@@ -702,17 +770,38 @@ static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 	struct omapfb_plane_struct *plane = fbi->par;
 	struct omapfb_device *fbdev = plane->fbdev;
 	struct lcd_panel *panel = fbdev->panel;
-	int r;
+	struct omapfb_plane_info old_info;
+	int r = 0;
 
 	if (pi->pos_x + pi->out_width > panel->x_res ||
 	    pi->pos_y + pi->out_height > panel->y_res)
 		return -EINVAL;
 
+	omapfb_rqueue_lock(fbdev);
+	if (pi->enabled && !fbdev->mem_desc.region[plane->idx].size) {
+		/* This plane's memory was freed, can't enable it
+		 * until it's reallocated.
+		 */
+		r = -EINVAL;
+		goto out;
+	}
+	old_info = plane->info;
 	plane->info = *pi;
-	r = ctrl_change_mode(fbi);
-	if (r < 0)
-		return r;
-	return fbdev->ctrl->enable_plane(plane->idx, pi->enabled);
+	if (pi->enabled) {
+		r = ctrl_change_mode(fbi);
+		if (r < 0) {
+			plane->info = old_info;
+			goto out;
+		}
+	}
+	r = fbdev->ctrl->enable_plane(plane->idx, pi->enabled);
+	if (r < 0) {
+		plane->info = old_info;
+		goto out;
+	}
+out:
+	omapfb_rqueue_unlock(fbdev);
+	return r;
 }
 
 static int omapfb_query_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
@@ -723,6 +812,92 @@ static int omapfb_query_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 	return 0;
 }
 
+static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
+{
+	struct omapfb_plane_struct *plane = fbi->par;
+	struct omapfb_device *fbdev = plane->fbdev;
+	struct omapfb_mem_region *rg = &fbdev->mem_desc.region[plane->idx];
+	size_t size;
+	int r = 0;
+
+	if (fbdev->ctrl->setup_mem == NULL)
+		return -ENODEV;
+	if (mi->type > OMAPFB_MEMTYPE_MAX)
+		return -EINVAL;
+
+	size = PAGE_ALIGN(mi->size);
+	omapfb_rqueue_lock(fbdev);
+	if (plane->info.enabled) {
+		r = -EBUSY;
+		goto out;
+	}
+	if (rg->size != size || rg->type != mi->type) {
+		struct fb_var_screeninfo *new_var = &fbdev->new_var;
+		unsigned long old_size = rg->size;
+		u8	      old_type = rg->type;
+		unsigned long paddr;
+
+		rg->size = size;
+		rg->type = mi->type;
+		/* size == 0 is a special case, for which we
+		 * don't check / adjust the screen parameters.
+		 * This isn't a problem since the plane can't
+		 * be reenabled unless its size is > 0.
+		 */
+		if (old_size != size && size) {
+			if (size) {
+				memcpy(new_var, &fbi->var, sizeof(*new_var));
+				r = set_fb_var(fbi, new_var);
+				if (r < 0)
+					goto out;
+			}
+		}
+
+		if (fbdev->ctrl->sync)
+			fbdev->ctrl->sync();
+		r = fbdev->ctrl->setup_mem(plane->idx, size, mi->type, &paddr);
+		if (r < 0) {
+			/* Revert changes. */
+			rg->size = old_size;
+			rg->type = old_type;
+			goto out;
+		}
+		rg->paddr = paddr;
+
+		if (old_size != size) {
+			if (size) {
+				memcpy(&fbi->var, new_var, sizeof(fbi->var));
+				set_fb_fix(fbi);
+			} else {
+				/* Set these explicitly to indicate that the
+				 * plane memory is dealloce'd, the other
+				 * screen parameters in var / fix are invalid.
+				 */
+				fbi->fix.smem_start = 0;
+				fbi->fix.smem_len = 0;
+			}
+		}
+	}
+out:
+	omapfb_rqueue_unlock(fbdev);
+
+	return r;
+}
+
+static int omapfb_query_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
+{
+	struct omapfb_plane_struct *plane = fbi->par;
+	struct omapfb_device *fbdev = plane->fbdev;
+	struct omapfb_mem_region *rg;
+
+	rg = &fbdev->mem_desc.region[plane->idx];
+	memset(mi, 0, sizeof(*mi));
+	mi->size = rg->size;
+	mi->type = rg->type;
+
+	return 0;
+}
+
 static int omapfb_set_color_key(struct omapfb_device *fbdev,
 				struct omapfb_color_key *ck)
 {
@@ -839,14 +1014,12 @@ static enum omapfb_update_mode omapfb_get_update_mode(struct omapfb_device *fbde
 	return r;
 }
 
-static unsigned long omapfb_get_caps(struct omapfb_device *fbdev)
+static void omapfb_get_caps(struct omapfb_device *fbdev, int plane,
+				     struct omapfb_caps *caps)
 {
-	unsigned long caps;
-
-	caps = 0;
-	caps |= fbdev->panel->get_caps(fbdev->panel);
-	caps |= fbdev->ctrl->get_caps();
-	return caps;
+	memset(caps, 0, sizeof(*caps));
+	fbdev->ctrl->get_caps(plane, caps);
+	caps->ctrl |= fbdev->panel->get_caps(fbdev->panel);
 }
 
 /* For lcd testing */
@@ -857,11 +1030,11 @@ void omapfb_write_first_pixel(struct omapfb_device *fbdev, u16 pixval)
 	if (fbdev->ctrl->get_update_mode() == OMAPFB_MANUAL_UPDATE) {
 		struct omapfb_update_window win;
 
-		win.x = 0;
-		win.y = 0;
-		win.width = 1;
-		win.height = 1;
-		win.format = 0;
+		memset(&win, 0, sizeof(win));
+		win.width = 2;
+		win.height = 2;
+		win.out_width = 2;
+		win.out_height = 2;
 		fbdev->ctrl->update_window(fbdev->fb_info[0], &win, NULL, 0);
 	}
 	omapfb_rqueue_unlock(fbdev);
@@ -880,9 +1053,10 @@ static int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd,
 	union {
 		struct omapfb_update_window	update_window;
 		struct omapfb_plane_info	plane_info;
+		struct omapfb_mem_info		mem_info;
 		struct omapfb_color_key		color_key;
 		enum omapfb_update_mode		update_mode;
-		unsigned long		caps;
+		struct omapfb_caps		caps;
 		unsigned int		mirror;
 		int			plane_out;
 		int			enable_plane;
@@ -920,8 +1094,13 @@ static int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd,
 				   sizeof(struct omapfb_update_window_old)))
 			r = -EFAULT;
 		else {
-			p.update_window.format = 0;
-			r = omapfb_update_win(fbi, &p.update_window);
+			struct omapfb_update_window *u = &p.update_window;
+			u->out_x = u->x;
+			u->out_y = u->y;
+			u->out_width = u->width;
+			u->out_height = u->height;
+			memset(u->reserved, 0, sizeof(u->reserved));
+			r = omapfb_update_win(fbi, u);
 		}
 		break;
 	case OMAPFB_UPDATE_WINDOW:
@@ -945,6 +1124,20 @@ static int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd,
 				   sizeof(p.plane_info)))
 			r = -EFAULT;
 		break;
+	case OMAPFB_SETUP_MEM:
+		if (copy_from_user(&p.mem_info, (void __user *)arg,
+				   sizeof(p.mem_info)))
+			r = -EFAULT;
+		else
+			r = omapfb_setup_mem(fbi, &p.mem_info);
+		break;
+	case OMAPFB_QUERY_MEM:
+		if ((r = omapfb_query_mem(fbi, &p.mem_info)) < 0)
+			break;
+		if (copy_to_user((void __user *)arg, &p.mem_info,
+				   sizeof(p.mem_info)))
+			r = -EFAULT;
+		break;
 	case OMAPFB_SET_COLOR_KEY:
 		if (copy_from_user(&p.color_key, (void __user *)arg,
 				   sizeof(p.color_key)))
@@ -960,8 +1153,8 @@ static int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd,
 			r = -EFAULT;
 		break;
 	case OMAPFB_GET_CAPS:
-		p.caps = omapfb_get_caps(fbdev);
-		if (put_user(p.caps, (unsigned long __user *)arg))
+		omapfb_get_caps(fbdev, plane->idx, &p.caps);
+		if (copy_to_user((void __user *)arg, &p.caps, sizeof(p.caps)))
 			r = -EFAULT;
 		break;
 	case OMAPFB_LCD_TEST:
@@ -1001,6 +1194,19 @@ static int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd,
 	return r;
 }
 
+static int omapfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
+{
+	struct omapfb_plane_struct *plane = info->par;
+	struct omapfb_device *fbdev = plane->fbdev;
+	int r;
+
+	omapfb_rqueue_lock(fbdev);
+	r = fbdev->ctrl->mmap(info, vma);
+	omapfb_rqueue_unlock(fbdev);
+
+	return r;
+}
+
 /* Callback table for the frame buffer framework. Some of these pointers
  * will be changed according to the current setting of fb_info->accel_flags.
  */
@@ -1027,28 +1233,67 @@ static struct fb_ops omapfb_ops = {
  * ---------------------------------------------------------------------------
  */
 /* omapfbX sysfs entries */
-static ssize_t omapfb_show_caps_num(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t omapfb_show_caps_num(struct device *dev,
+				    struct device_attribute *attr, char *buf)
 {
 	struct omapfb_device *fbdev = (struct omapfb_device *)dev->driver_data;
-
-	return snprintf(buf, PAGE_SIZE, "%#010lx\n", omapfb_get_caps(fbdev));
+	int plane;
+	size_t size;
+	struct omapfb_caps caps;
+
+	plane = 0;
+	size = 0;
+	while (size < PAGE_SIZE && plane < OMAPFB_PLANE_NUM) {
+		omapfb_get_caps(fbdev, plane, &caps);
+		size += snprintf(&buf[size], PAGE_SIZE - size,
+			"plane#%d %#010x %#010x %#010x\n",
+			plane, caps.ctrl, caps.plane_color, caps.wnd_color);
+		plane++;
+	}
+	return size;
 }
 
-static ssize_t omapfb_show_caps_text(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t omapfb_show_caps_text(struct device *dev,
+				     struct device_attribute *attr, char *buf)
 {
 	struct omapfb_device *fbdev = (struct omapfb_device *)dev->driver_data;
-	int pos = 0;
 	int i;
-	unsigned long caps;
-
-	caps = omapfb_get_caps(fbdev);
-	for (i = 0; i < ARRAY_SIZE(omapfb_caps_table) && pos < PAGE_SIZE; i++) {
-		if (omapfb_caps_table[i].flag & caps) {
-			pos += snprintf(&buf[pos], PAGE_SIZE - pos, "%s\n",
-					omapfb_caps_table[i].name);
+	struct omapfb_caps caps;
+	int plane;
+	size_t size;
+
+	plane = 0;
+	size = 0;
+	while (size < PAGE_SIZE && plane < OMAPFB_PLANE_NUM) {
+		omapfb_get_caps(fbdev, plane, &caps);
+		size += snprintf(&buf[size], PAGE_SIZE - size,
+				 "plane#%d:\n", plane);
+		for (i = 0; i < ARRAY_SIZE(ctrl_caps) &&
+		     size < PAGE_SIZE; i++) {
+			if (ctrl_caps[i].flag & caps.ctrl)
+				size += snprintf(&buf[size], PAGE_SIZE - size,
+					" %s\n", ctrl_caps[i].name);
+		}
+		size += snprintf(&buf[size], PAGE_SIZE - size,
+				 " plane colors:\n");
+		for (i = 0; i < ARRAY_SIZE(color_caps) &&
+		     size < PAGE_SIZE; i++) {
+			if (color_caps[i].flag & caps.plane_color)
+				size += snprintf(&buf[size], PAGE_SIZE - size,
+					"  %s\n", color_caps[i].name);
 		}
+		size += snprintf(&buf[size], PAGE_SIZE - size,
+				 " window colors:\n");
+		for (i = 0; i < ARRAY_SIZE(color_caps) &&
+		     size < PAGE_SIZE; i++) {
+			if (color_caps[i].flag & caps.wnd_color)
+				size += snprintf(&buf[size], PAGE_SIZE - size,
+					"  %s\n", color_caps[i].name);
+		}
+
+		plane++;
 	}
-	return min((int)PAGE_SIZE, pos);
+	return size;
 }
 
 static DEVICE_ATTR(caps_num, 0444, omapfb_show_caps_num, NULL);
@@ -1195,8 +1440,7 @@ static void omapfb_unregister_sysfs(struct omapfb_device *fbdev)
 /* Initialize system fb_info object and set the default video mode.
  * The frame buffer memory already allocated by lcddma_init
  */
-static int fbinfo_init(struct omapfb_device *fbdev, struct fb_info *info,
-			struct omapfb_mem_region *region)
+static int fbinfo_init(struct omapfb_device *fbdev, struct fb_info *info)
 {
 	struct fb_var_screeninfo	*var = &info->var;
 	struct fb_fix_screeninfo	*fix = &info->fix;
@@ -1207,10 +1451,6 @@ static int fbinfo_init(struct omapfb_device *fbdev, struct fb_info *info,
 
 	strncpy(fix->id, MODULE_NAME, sizeof(fix->id));
 
-	info->screen_base	= (char __iomem *)region->vaddr;
-	fix->smem_start		= region->paddr;
-	fix->smem_len		= region->size;
-
 	info->pseudo_palette = fbdev->pseudo_palette;
 
 	var->accel_flags  = def_accel ? FB_ACCELF_TEXT : 0;
@@ -1271,8 +1511,7 @@ static int planes_init(struct omapfb_device *fbdev)
 		plane->info.mirror = def_mirror;
 		fbdev->fb_info[i] = fbi;
 
-		if ((r = fbinfo_init(fbdev, fbi,
-					&fbdev->mem_desc.region[i])) < 0) {
+		if ((r = fbinfo_init(fbdev, fbi)) < 0) {
 			framebuffer_release(fbi);
 			planes_cleanup(fbdev);
 			return r;
@@ -1446,6 +1685,8 @@ static int omapfb_do_probe(struct platform_device *pdev, struct lcd_panel *panel
 	r = ctrl_init(fbdev);
 	if (r)
 		goto cleanup;
+	if (fbdev->ctrl->mmap != NULL)
+		omapfb_ops.fb_mmap = omapfb_mmap;
 	init_state++;
 
 	check_required_callbacks(fbdev);
diff --git a/include/asm-arm/arch-omap/omapfb.h b/include/asm-arm/arch-omap/omapfb.h
index d2ba9f4..46d7a4f 100644
--- a/include/asm-arm/arch-omap/omapfb.h
+++ b/include/asm-arm/arch-omap/omapfb.h
@@ -38,16 +38,18 @@
 #define OMAPFB_SYNC_GFX		OMAP_IO(37)
 #define OMAPFB_VSYNC		OMAP_IO(38)
 #define OMAPFB_SET_UPDATE_MODE	OMAP_IOW(40, int)
-#define OMAPFB_UPDATE_WINDOW_OLD OMAP_IOW(41, struct omapfb_update_window_old)
-#define OMAPFB_GET_CAPS		OMAP_IOR(42, unsigned long)
+#define OMAPFB_GET_CAPS		OMAP_IOR(42, struct omapfb_caps)
 #define OMAPFB_GET_UPDATE_MODE	OMAP_IOW(43, int)
 #define OMAPFB_LCD_TEST		OMAP_IOW(45, int)
 #define OMAPFB_CTRL_TEST	OMAP_IOW(46, int)
-#define OMAPFB_UPDATE_WINDOW	OMAP_IOW(47, struct omapfb_update_window)
+#define OMAPFB_UPDATE_WINDOW_OLD OMAP_IOW(47, struct omapfb_update_window_old)
 #define OMAPFB_SET_COLOR_KEY	OMAP_IOW(50, struct omapfb_color_key)
 #define OMAPFB_GET_COLOR_KEY	OMAP_IOW(51, struct omapfb_color_key)
 #define OMAPFB_SETUP_PLANE	OMAP_IOW(52, struct omapfb_plane_info)
 #define OMAPFB_QUERY_PLANE	OMAP_IOW(53, struct omapfb_plane_info)
+#define OMAPFB_UPDATE_WINDOW	OMAP_IOW(54, struct omapfb_update_window)
+#define OMAPFB_SETUP_MEM	OMAP_IOW(55, struct omapfb_mem_info)
+#define OMAPFB_QUERY_MEM	OMAP_IOW(56, struct omapfb_mem_info)
 
 #define OMAPFB_CAPS_GENERIC_MASK	0x00000fff
 #define OMAPFB_CAPS_LCDC_MASK		0x00fff000
@@ -55,6 +57,11 @@
 
 #define OMAPFB_CAPS_MANUAL_UPDATE	0x00001000
 #define OMAPFB_CAPS_TEARSYNC		0x00002000
+#define OMAPFB_CAPS_PLANE_RELOCATE_MEM	0x00004000
+#define OMAPFB_CAPS_PLANE_SCALE		0x00008000
+#define OMAPFB_CAPS_WINDOW_PIXEL_DOUBLE	0x00010000
+#define OMAPFB_CAPS_WINDOW_SCALE	0x00020000
+#define OMAPFB_CAPS_WINDOW_OVERLAY	0x00040000
 #define OMAPFB_CAPS_SET_BACKLIGHT	0x01000000
 
 /* Values from DSP must map to lower 16-bits */
@@ -62,6 +69,8 @@
 #define OMAPFB_FORMAT_FLAG_DOUBLE	0x0100
 #define OMAPFB_FORMAT_FLAG_TEARSYNC	0x0200
 #define OMAPFB_FORMAT_FLAG_FORCE_VSYNC	0x0400
+#define OMAPFB_FORMAT_FLAG_ENABLE_OVERLAY	0x0800
+#define OMAPFB_FORMAT_FLAG_DISABLE_OVERLAY	0x1000
 
 #define OMAPFB_EVENT_READY	1
 #define OMAPFB_EVENT_DISABLED	2
@@ -86,11 +95,15 @@ struct omapfb_update_window {
 	__u32 x, y;
 	__u32 width, height;
 	__u32 format;
+	__u32 out_x, out_y;
+	__u32 out_width, out_height;
+	__u32 reserved[8];
 };
 
 struct omapfb_update_window_old {
 	__u32 x, y;
 	__u32 width, height;
+	__u32 format;
 };
 
 enum omapfb_plane {
@@ -116,6 +129,18 @@ struct omapfb_plane_info {
 	__u32 reserved2[12];
 };
 
+struct omapfb_mem_info {
+	__u32 size;
+	__u8  type;
+	__u8  reserved[3];
+};
+
+struct omapfb_caps {
+	__u32 ctrl;
+	__u32 plane_color;
+	__u32 wnd_color;
+};
+
 enum omapfb_color_key_type {
 	OMAPFB_COLOR_KEY_DISABLED = 0,
 	OMAPFB_COLOR_KEY_GFX_DST,
@@ -199,8 +224,6 @@ struct lcd_panel {
 	int		(*run_test)	(struct lcd_panel *panel, int test_num);
 };
 
-struct omapfb_device;
-
 struct extif_timings {
 	int cs_on_time;
 	int cs_off_time;
@@ -256,7 +279,8 @@ struct omapfb_mem_region {
 	void		*vaddr;
 	unsigned long	size;
 	u8		type;		/* OMAPFB_PLANE_MEM_* */
-	int		alloc:1;
+	unsigned	alloc:1;	/* allocated by the driver */
+	unsigned	map:1;		/* kernel mapped by the driver */
 };
 
 struct omapfb_mem_desc {
@@ -273,7 +297,7 @@ struct lcd_ctrl {
 					   struct omapfb_mem_desc *req_md);
 	void		(*cleanup)	  (void);
 	void		(*bind_client)	  (struct omapfb_notifier_block *nb);
-	unsigned long	(*get_caps)	  (void);
+	void		(*get_caps)	  (int plane, struct omapfb_caps *caps);
 	int		(*set_update_mode)(enum omapfb_update_mode mode);
 	enum omapfb_update_mode (*get_update_mode)(void);
 	int		(*setup_plane)	  (int plane, int channel_out,
@@ -281,6 +305,10 @@ struct lcd_ctrl {
 					   int screen_width,
 					   int pos_x, int pos_y, int width,
 					   int height, int color_mode);
+	int		(*setup_mem)	  (int plane, size_t size,
+					   int mem_type, unsigned long *paddr);
+	int		(*mmap)		  (struct fb_info *info,
+					   struct vm_area_struct *vma);
 	int		(*set_scale)	  (int plane,
 					   int orig_width, int orig_height,
 					   int out_width, int out_height);
@@ -298,7 +326,6 @@ struct lcd_ctrl {
 					   int update_hw_mem);
 	int		(*set_color_key)  (struct omapfb_color_key *ck);
 	int		(*get_color_key)  (struct omapfb_color_key *ck);
-
 };
 
 enum omapfb_state {
@@ -329,6 +356,7 @@ struct omapfb_device {
 	struct lcd_ctrl_extif	*ext_if;		/* LCD ctrl external
 							   interface */
 	struct device		*dev;
+	struct fb_var_screeninfo	new_var;	/* for mode changes */
 
 	struct omapfb_mem_desc		mem_desc;
 	struct fb_info			*fb_info[OMAPFB_PLANE_NUM];
@@ -360,7 +388,6 @@ extern int  omapfb_update_window_async(struct fb_info *fbi,
 				       void *callback_data);
 
 /* in arch/arm/plat-omap/fb.c */
-extern void omapfb_reserve_mem(void);
 extern void omapfb_set_ctrl_platform_data(void *pdata);
 
 #endif /* __KERNEL__ */
-- 
1.4.4.3.GIT
