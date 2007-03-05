From: Imre Deak <imre.deak@solidboot.com>
Subject: [PATCH] FB: Blizzard: sync with N800 tree
Date: Mon, 5 Mar 2007 14:50:01 +0200
Message-ID: <20070305124959.GA29208@bitbox.mine.nu>
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

- support for per window scaling / color format attribute in
  window updates
- save / restore registers over a suspend / resume, do a full screen
  background update after resume to start with a clean state

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 drivers/video/omap/blizzard.c |  341 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 282 insertions(+), 59 deletions(-)

diff --git a/drivers/video/omap/blizzard.c b/drivers/video/omap/blizzard.c
index ee88063..7905d13 100644
--- a/drivers/video/omap/blizzard.c
+++ b/drivers/video/omap/blizzard.c
@@ -65,10 +65,15 @@
 /* For S1D13745 */
 #define BLIZZARD_SRC_WRITE_LCD_BACKGROUND	0x00
 #define BLIZZARD_SRC_WRITE_LCD_DESTRUCTIVE	0x01
+#define BLIZZARD_SRC_WRITE_OVERLAY_ENABLE	0x04
+#define BLIZZARD_SRC_DISABLE_OVERLAY		0x05
 /* For S1D13744 */
 #define BLIZZARD_SRC_WRITE_LCD			0x00
 #define BLIZZARD_SRC_BLT_LCD			0x06
 
+#define BLIZZARD_COLOR_RGB565			0x01
+#define BLIZZARD_COLOR_YUV420			0x09
+
 #define BLIZZARD_VERSION_S1D13745		0x01	/* Hailstorm */
 #define BLIZZARD_VERSION_S1D13744		0x02	/* Blizzard */
 
@@ -83,10 +88,43 @@
 #define REQ_COMPLETE	0
 #define REQ_PENDING	1
 
+struct blizzard_reg_list {
+	int	start;
+	int	end;
+};
+
+/* These need to be saved / restored separately from the rest. */
+static struct blizzard_reg_list blizzard_pll_regs[] = {
+	{
+		.start	= 0x04,		/* Don't save PLL ctrl (0x0C) */
+		.end	= 0x0a,
+	},
+	{
+		.start	= 0x0e,		/* Clock configuration */
+		.end	= 0x0e,
+	},
+};
+
+static struct blizzard_reg_list blizzard_gen_regs[] = {
+	{
+		.start	= 0x18,		/* SDRAM control */
+		.end	= 0x20,
+	},
+	{
+		.start	= 0x28,		/* LCD Panel configuration */
+		.end	= 0x5a,		/* HSSI interface, TV configuration */
+	},
+};
+
+static u8 blizzard_reg_cache[0x5a / 2];
+
 struct update_param {
 	int	plane;
 	int	x, y, width, height;
+	int	out_x, out_y;
+	int	out_width, out_height;
 	int	color_mode;
+	int	bpp;
 	int	flags;
 };
 
@@ -124,6 +162,8 @@ struct blizzard_struct {
 	int			enabled_planes;
 	int			vid_nonstd_color;
 	int			vid_scaled;
+	int			last_color_mode;
+	int			zoom_on;
 	int			screen_width;
 	int			screen_height;
 	unsigned		te_connected:1;
@@ -216,9 +256,33 @@ static void blizzard_wait_line_buffer(void)
 	}
 }
 
-static void set_window_regs(int x_start, int y_start, int x_end, int y_end)
+/* Wait until the YYC color space converter is idle. */
+static void blizzard_wait_yyc(void)
 {
-	u8 tmp[8];
+	unsigned long tmo = jiffies + msecs_to_jiffies(30);
+
+	while (blizzard_read_reg(BLIZZARD_NDISP_CTRL_STATUS) & (1 << 4)) {
+		if (time_after(jiffies, tmo)) {
+			if (printk_ratelimit())
+				dev_err(blizzard.fbdev->dev,
+					"s1d1374x: YYC not ready\n");
+			break;
+		}
+	}
+}
+
+static void disable_overlay(void)
+{
+	blizzard_write_reg(BLIZZARD_DATA_SOURCE_SELECT,
+				BLIZZARD_SRC_DISABLE_OVERLAY);
+}
+
+static void set_window_regs(int x_start, int y_start, int x_end, int y_end,
+			    int x_out_start, int y_out_start,
+			    int x_out_end, int y_out_end, int color_mode,
+			    int zoom_off, int flags)
+{
+	u8 tmp[18];
 	u8 cmd;
 
 	x_end--;
@@ -232,21 +296,35 @@ static void set_window_regs(int x_start, int y_start, int x_end, int y_end)
 	tmp[6] = y_end;
 	tmp[7] = y_end >> 8;
 
+	x_out_end--;
+	y_out_end--;
+	tmp[8]  = x_out_start;
+	tmp[9]  = x_out_start >> 8;
+	tmp[10] = y_out_start;
+	tmp[11] = y_out_start >> 8;
+	tmp[12] = x_out_end;
+	tmp[13] = x_out_end >> 8;
+	tmp[14] = y_out_end;
+	tmp[15] = y_out_end >> 8;
+
+	tmp[16] = color_mode;
+	if (zoom_off && blizzard.version == BLIZZARD_VERSION_S1D13745)
+		tmp[17] = BLIZZARD_SRC_WRITE_LCD_BACKGROUND;
+	else if (flags & OMAPFB_FORMAT_FLAG_ENABLE_OVERLAY)
+		tmp[17] = BLIZZARD_SRC_WRITE_OVERLAY_ENABLE;
+	else
+		tmp[17] = blizzard.version == BLIZZARD_VERSION_S1D13744 ?
+				BLIZZARD_SRC_WRITE_LCD :
+				BLIZZARD_SRC_WRITE_LCD_DESTRUCTIVE;
+
 	blizzard.extif->set_bits_per_cycle(8);
 	cmd = BLIZZARD_INPUT_WIN_X_START_0;
 	blizzard.extif->write_command(&cmd, 1);
-	blizzard.extif->write_data(tmp, 8);
-	blizzard.extif->write_data(tmp, 8);
-
-	tmp[0] = 0x01;
-	tmp[1] = blizzard.version == BLIZZARD_VERSION_S1D13744 ?
-				BLIZZARD_SRC_WRITE_LCD :
-				BLIZZARD_SRC_WRITE_LCD_DESTRUCTIVE;
-	blizzard.extif->write_data(tmp, 2);
+	blizzard.extif->write_data(tmp, 18);
 }
 
 static void enable_tearsync(int y, int width, int height, int screen_height,
-			    int force_vsync)
+			    int out_height, int force_vsync)
 {
 	u8 b;
 
@@ -265,7 +343,7 @@ static void enable_tearsync(int y, int width, int height, int screen_height,
 	}
 
 	if ((width * blizzard.pix_tx_time / 1000) * height <
-	    (y + height) * (blizzard.line_upd_time / 1000)) {
+	    (y + out_height) * (blizzard.line_upd_time / 1000)) {
 		blizzard.extif->enable_tearsync(1, 0);
 		return;
 	}
@@ -417,11 +495,15 @@ static int do_full_screen_update(struct blizzard_request *req)
 		enable_tearsync(0, blizzard.screen_width,
 				blizzard.screen_height,
 				blizzard.screen_height,
+				blizzard.screen_height,
 				flags & OMAPFB_FORMAT_FLAG_FORCE_VSYNC);
 	else
 		disable_tearsync();
 
-	set_window_regs(0, 0, blizzard.screen_width, blizzard.screen_height);
+	set_window_regs(0, 0, blizzard.screen_width, blizzard.screen_height,
+			0, 0, blizzard.screen_width, blizzard.screen_height,
+			BLIZZARD_COLOR_RGB565, blizzard.zoom_on, flags);
+	blizzard.zoom_on = 0;
 
 	blizzard.extif->set_bits_per_cycle(16);
 	/* set_window_regs has left the register index at the right
@@ -435,11 +517,16 @@ static int do_full_screen_update(struct blizzard_request *req)
 
 /* Setup all planes with an overlapping area with the update window. */
 static int do_partial_update(struct blizzard_request *req, int plane,
-			     int x, int y, int w, int h)
+			     int x, int y, int w, int h,
+			     int x_out, int y_out, int w_out, int h_out,
+			     int wnd_color_mode, int bpp)
 {
 	int i;
 	int gx1, gy1, gx2, gy2;
+	int gx1_out, gy1_out, gx2_out, gy2_out;
+	int color_mode;
 	int flags;
+	int zoom_off;
 
 	/* Global coordinates, relative to pixel 0,0 of the LCD */
 	gx1 = x + blizzard.plane[plane].pos_x;
@@ -447,6 +534,23 @@ static int do_partial_update(struct blizzard_request *req, int plane,
 	gx2 = gx1 + w;
 	gy2 = gy1 + h;
 
+	flags = req->par.update.flags;
+	if (flags & OMAPFB_FORMAT_FLAG_DOUBLE) {
+		gx1_out = gx1;
+		gy1_out = gy1;
+		gx2_out = gx1 + w * 2;
+		gy2_out = gy1 + h * 2;
+	} else {
+		gx1_out = x_out + blizzard.plane[plane].pos_x;
+		gy1_out = y_out + blizzard.plane[plane].pos_y;
+		gx2_out = gx1_out + w_out;
+		gy2_out = gy1_out + h_out;
+	}
+	zoom_off = blizzard.zoom_on && gx1 == 0 && gy1 == 0 &&
+		w == blizzard.screen_width && h == blizzard.screen_height;
+	blizzard.zoom_on = (!zoom_off && blizzard.zoom_on) ||
+			   (w < w_out || h < h_out);
+
 	for (i = 0; i < OMAPFB_PLANE_NUM; i++) {
 		struct plane_info *p = &blizzard.plane[i];
 		int px1, py1;
@@ -455,7 +559,8 @@ static int do_partial_update(struct blizzard_request *req, int plane,
 		int pposx, pposy;
 		unsigned long offset;
 
-		if (!(blizzard.enabled_planes & (1 << i))) {
+		if (!(blizzard.enabled_planes & (1 << i))  ||
+		    (wnd_color_mode && i != plane)) {
 			blizzard.int_ctrl->enable_plane(i, 0);
 			continue;
 		}
@@ -503,6 +608,12 @@ static int do_partial_update(struct blizzard_request *req, int plane,
 		pw = px2 - px1;
 		ph = py2 - py1;
 		offset = p->offset + (p->scr_width * py1 + px1) * p->bpp / 8;
+		if (wnd_color_mode)
+			/* Window embedded in the plane with a differing
+			 * color mode / bpp. Calculate the number of DMA
+			 * transfer elements in terms of the plane's bpp.
+			 */
+			pw = (pw + 1) * bpp / p->bpp;
 #ifdef VERBOSE
 		dev_dbg(blizzard.fbdev->dev,
 			"plane %d offset %#08lx pposx %d pposy %d "
@@ -518,16 +629,34 @@ static int do_partial_update(struct blizzard_request *req, int plane,
 		blizzard.int_ctrl->enable_plane(i, 1);
 	}
 
+	switch (wnd_color_mode) {
+	case OMAPFB_COLOR_YUV420:
+		color_mode = BLIZZARD_COLOR_YUV420;
+		/* Currently only the 16 bits/pixel cycle format is
+		 * supported on the external interface. Adjust the number
+		 * of transfer elements per line for 12bpp format.
+		 */
+		w = (w + 1) * 3 / 4;
+		break;
+	default:
+		color_mode = BLIZZARD_COLOR_RGB565;
+		break;
+	}
+
 	blizzard_wait_line_buffer();
-	flags = req->par.update.flags;
+	if (blizzard.last_color_mode == BLIZZARD_COLOR_YUV420)
+		blizzard_wait_yyc();
+	blizzard.last_color_mode = color_mode;
 	if (flags & OMAPFB_FORMAT_FLAG_TEARSYNC)
-		enable_tearsync(gy1, gx2 - gx1, gy2 - gy1,
+		enable_tearsync(gy1, w, h,
 				blizzard.screen_height,
+				h_out,
 				flags & OMAPFB_FORMAT_FLAG_FORCE_VSYNC);
 	else
 		disable_tearsync();
 
-	set_window_regs(gx1, gy1, gx2, gy2);
+	set_window_regs(gx1, gy1, gx2, gy2, gx1_out, gy1_out, gx2_out, gy2_out,
+			color_mode, zoom_off, flags);
 
 	blizzard.extif->set_bits_per_cycle(16);
 	/* set_window_regs has left the register index at the right
@@ -545,79 +674,102 @@ static int send_frame_handler(struct blizzard_request *req)
 
 #ifdef VERBOSE
 	dev_dbg(blizzard.fbdev->dev,
-		"send_frame: x %d y %d w %d h %d color_mode %04x flags %04x "
-		"planes %01x\n",
+		"send_frame: x %d y %d w %d h %d "
+		"x_out %d y_out %d w_out %d h_out %d "
+		"color_mode %04x flags %04x planes %01x\n",
 		par->x, par->y, par->width, par->height,
+		par->out_x, par->out_y, par->out_width, par->out_height,
 		par->color_mode, par->flags, blizzard.enabled_planes);
 #endif
+	if (par->flags & OMAPFB_FORMAT_FLAG_DISABLE_OVERLAY)
+		disable_overlay();
 
 	if ((blizzard.enabled_planes & blizzard.vid_nonstd_color) ||
 	     (blizzard.enabled_planes & blizzard.vid_scaled))
 		return do_full_screen_update(req);
 
 	return do_partial_update(req, plane, par->x, par->y,
-				 par->width, par->height);
+				 par->width, par->height,
+				 par->out_x, par->out_y,
+				 par->out_width, par->out_height,
+				 par->color_mode, par->bpp);
 }
 
 static void send_frame_complete(void *data)
 {
 }
 
-#define ADD_PREQ(_x, _y, _w, _h) do {		\
+#define ADD_PREQ(_x, _y, _w, _h, _x_out, _y_out, _w_out, _h_out) do {	\
 	req = alloc_req();			\
 	req->handler	= send_frame_handler;	\
 	req->complete	= send_frame_complete;	\
-	req->par.update.plane = plane;		\
+	req->par.update.plane = plane_idx;	\
 	req->par.update.x = _x;			\
 	req->par.update.y = _y;			\
 	req->par.update.width  = _w;		\
 	req->par.update.height = _h;		\
+	req->par.update.out_x = _x_out;		\
+	req->par.update.out_y = _y_out;		\
+	req->par.update.out_width = _w_out;	\
+	req->par.update.out_height = _h_out;	\
+	req->par.update.bpp = bpp;		\
 	req->par.update.color_mode = color_mode;\
 	req->par.update.flags	  = flags;	\
 	list_add_tail(&req->entry, req_head);	\
 } while(0)
 
-static void create_req_list(int plane,
+static void create_req_list(int plane_idx,
 			    struct omapfb_update_window *win,
 			    struct list_head *req_head)
 {
 	struct blizzard_request *req;
-	int x = (win->x & ~0x07);
-	int y = (win->y & ~0x07);
-	int width = ((win->x + win->width + 7) & ~0x07) - x;
-	int height = ((win->y + win->height + 7) & ~0x07) - y;
+	int x = win->x;
+	int y = win->y;
+	int width = win->width;
+	int height = win->height;
+	int x_out = win->out_x;
+	int y_out = win->out_y;
+	int width_out = win->out_width;
+	int height_out = win->out_height;
 	int color_mode;
+	int bpp;
 	int flags;
+	unsigned int ystart = y;
+	unsigned int yspan = height;
+	unsigned int ystart_out = y_out;
+	unsigned int yspan_out = height_out;
 
 	flags = win->format & ~OMAPFB_FORMAT_MASK;
 	color_mode = win->format & OMAPFB_FORMAT_MASK;
-
-	if (x & 1) {
-		ADD_PREQ(x, y, 1, height);
-		width--;
-		x++;
-		flags &= ~OMAPFB_FORMAT_FLAG_TEARSYNC;
+	switch (color_mode) {
+	case OMAPFB_COLOR_YUV420:
+		/* Embedded window with different color mode */
+		bpp = 12;
+		/* X, Y, height must be aligned at 2, width at 4 pixels */
+		x &= ~1;
+		y &= ~1;
+		height = yspan = height & ~1;
+		width = width & ~3;
+		break;
+	default:
+		/* Same as the plane color mode */
+		bpp = blizzard.plane[plane_idx].bpp;
+		break;
 	}
-	if (width & ~1) {
-		unsigned int xspan = width & ~1;
-		unsigned int ystart = y;
-		unsigned int yspan = height;
-
-		if (xspan * height * 2 > blizzard.max_transmit_size) {
-			yspan = blizzard.max_transmit_size / (xspan * 2);
-			ADD_PREQ(x, ystart, xspan, yspan);
-			ystart += yspan;
-			yspan = height - yspan;
-			flags &= ~OMAPFB_FORMAT_FLAG_TEARSYNC;
-		}
-
-		ADD_PREQ(x, ystart, xspan, yspan);
-		x += xspan;
-		width -= xspan;
+	if (width * height * bpp / 8 > blizzard.max_transmit_size) {
+		yspan = blizzard.max_transmit_size / (width * bpp / 8);
+		yspan_out = yspan * height_out / height;
+		ADD_PREQ(x, ystart, width, yspan, x_out, ystart_out,
+			 width_out, yspan_out);
+		ystart += yspan;
+		ystart_out += yspan_out;
+		yspan = height - yspan;
+		yspan_out = height_out - yspan_out;
 		flags &= ~OMAPFB_FORMAT_FLAG_TEARSYNC;
 	}
-	if (width)
-		ADD_PREQ(x, y, 1, height);
+
+	ADD_PREQ(x, ystart, width, yspan, x_out, ystart_out,
+		 width_out, yspan_out);
 }
 
 static void auto_update_complete(void *data)
@@ -671,6 +823,13 @@ int blizzard_update_window_async(struct fb_info *fbi,
 }
 EXPORT_SYMBOL(blizzard_update_window_async);
 
+static int update_full_screen(void)
+{
+	return blizzard_update_window_async(blizzard.fbdev->fb_info[0],
+				     &blizzard.auto_update_window, NULL, NULL);
+
+}
+
 static int blizzard_setup_plane(int plane, int channel_out,
 				  unsigned long offset, int screen_width,
 				  int pos_x, int pos_y, int width, int height,
@@ -693,7 +852,7 @@ static int blizzard_setup_plane(int plane, int channel_out,
 	case OMAPFB_COLOR_YUV422:
 	case OMAPFB_COLOR_YUY422:
 		p->bpp = 16;
-		blizzard.vid_nonstd_color |= 1 << plane;
+		blizzard.vid_nonstd_color &= ~(1 << plane);
 		break;
 	case OMAPFB_COLOR_YUV420:
 		p->bpp = 12;
@@ -786,6 +945,7 @@ static void blizzard_sync(void)
 	wait_for_completion(&comp);
 }
 
+
 static void blizzard_bind_client(struct omapfb_notifier_block *nb)
 {
 	if (blizzard.update_mode == OMAPFB_MANUAL_UPDATE) {
@@ -1121,14 +1281,55 @@ static int setup_tearsync(unsigned long pix_clk, int extif_div)
 					      extif_div);
 }
 
-static unsigned long blizzard_get_caps(void)
+static void blizzard_get_caps(int plane, struct omapfb_caps *caps)
 {
-	unsigned long caps;
-
-	caps = OMAPFB_CAPS_MANUAL_UPDATE;
+	blizzard.int_ctrl->get_caps(plane, caps);
+	caps->ctrl |= OMAPFB_CAPS_MANUAL_UPDATE |
+		OMAPFB_CAPS_WINDOW_PIXEL_DOUBLE |
+		OMAPFB_CAPS_WINDOW_SCALE |
+		OMAPFB_CAPS_WINDOW_OVERLAY;
 	if (blizzard.te_connected)
-		caps |= OMAPFB_CAPS_TEARSYNC;
-	return caps;
+		caps->ctrl |= OMAPFB_CAPS_TEARSYNC;
+	caps->wnd_color |= (1 << OMAPFB_COLOR_RGB565) |
+			   (1 << OMAPFB_COLOR_YUV420);
+}
+
+static void _save_regs(struct blizzard_reg_list *list, int cnt)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++, list++) {
+		int reg;
+		for (reg = list->start; reg <= list->end; reg += 2)
+			blizzard_reg_cache[reg / 2] = blizzard_read_reg(reg);
+	}
+}
+
+static void _restore_regs(struct blizzard_reg_list *list, int cnt)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++, list++) {
+		int reg;
+		for (reg = list->start; reg <= list->end; reg += 2)
+			blizzard_write_reg(reg, blizzard_reg_cache[reg / 2]);
+	}
+}
+
+static void blizzard_save_all_regs(void)
+{
+	_save_regs(blizzard_pll_regs, ARRAY_SIZE(blizzard_pll_regs));
+	_save_regs(blizzard_gen_regs, ARRAY_SIZE(blizzard_gen_regs));
+}
+
+static void blizzard_restore_pll_regs(void)
+{
+	_restore_regs(blizzard_pll_regs, ARRAY_SIZE(blizzard_pll_regs));
+}
+
+static void blizzard_restore_gen_regs(void)
+{
+	_restore_regs(blizzard_gen_regs, ARRAY_SIZE(blizzard_gen_regs));
 }
 
 static void blizzard_suspend(void)
@@ -1136,10 +1337,16 @@ static void blizzard_suspend(void)
 	u32 l;
 	unsigned long tmo;
 
+	if (blizzard.last_color_mode) {
+		update_full_screen();
+		blizzard_sync();
+	}
 	blizzard.update_mode_before_suspend = blizzard.update_mode;
 	/* the following will disable clocks as well */
 	blizzard_set_update_mode(OMAPFB_UPDATE_DISABLED);
 
+	blizzard_save_all_regs();
+
 	blizzard_stop_sdram();
 
 	l = blizzard_read_reg(BLIZZARD_POWER_SAVE);
@@ -1178,6 +1385,7 @@ static void blizzard_resume(void)
 	l &= ~0x03;
 	blizzard_write_reg(BLIZZARD_POWER_SAVE, l);
 
+	blizzard_restore_pll_regs();
 	l = blizzard_read_reg(BLIZZARD_PLL_MODE);
 	l &= ~0x03;
 	/* Enable PLL, counter function */
@@ -1186,12 +1394,21 @@ static void blizzard_resume(void)
 
 	while (!(blizzard_read_reg(BLIZZARD_PLL_DIV) & (1 << 7)))
 		msleep(1);
+
 	blizzard_restart_sdram();
+
+	blizzard_restore_gen_regs();
+
 	/* Enable display */
 	blizzard_write_reg(BLIZZARD_DISPLAY_MODE, 0x01);
 
 	/* the following will enable clocks as necessary */
 	blizzard_set_update_mode(blizzard.update_mode_before_suspend);
+
+	/* Force a background update */
+	blizzard.zoom_on = 1;
+	update_full_screen();
+	blizzard_sync();
 }
 
 static int blizzard_init(struct omapfb_device *fbdev, int ext_mode,
@@ -1234,6 +1451,8 @@ static int blizzard_init(struct omapfb_device *fbdev, int ext_mode,
 
 	blizzard_ctrl.set_color_key = blizzard.int_ctrl->set_color_key;
 	blizzard_ctrl.get_color_key = blizzard.int_ctrl->get_color_key;
+	blizzard_ctrl.setup_mem = blizzard.int_ctrl->setup_mem;
+	blizzard_ctrl.mmap = blizzard.int_ctrl->mmap;
 
 	ext_clk = ctrl_conf->get_clock_rate(fbdev->dev);
 	if ((r = calc_extif_timings(ext_clk, &extif_div)) < 0)
@@ -1292,6 +1511,10 @@ static int blizzard_init(struct omapfb_device *fbdev, int ext_mode,
 	blizzard.auto_update_window.y = 0;
 	blizzard.auto_update_window.width = fbdev->panel->x_res;
 	blizzard.auto_update_window.height = fbdev->panel->y_res;
+	blizzard.auto_update_window.out_x = 0;
+	blizzard.auto_update_window.out_x = 0;
+	blizzard.auto_update_window.out_width = fbdev->panel->x_res;
+	blizzard.auto_update_window.out_height = fbdev->panel->y_res;
 	blizzard.auto_update_window.format = 0;
 
 	blizzard.screen_width = fbdev->panel->x_res;
-- 
1.4.4.3.GIT
