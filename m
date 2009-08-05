From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 06/15] OMAP: DSS2: Display Subsystem
	Driver core
Date: Wed,  5 Aug 2009 17:15:32 +0300
Message-ID: <1249481741-14008-7-git-send-email-tomi.valkeinen@nokia.com>
References: <1249481741-14008-1-git-send-email-tomi.valkeinen@nokia.com>
	<1249481741-14008-2-git-send-email-tomi.valkeinen@nokia.com>
	<1249481741-14008-3-git-send-email-tomi.valkeinen@nokia.com>
	<1249481741-14008-4-git-send-email-tomi.valkeinen@nokia.com>
	<1249481741-14008-5-git-send-email-tomi.valkeinen@nokia.com>
	<1249481741-14008-6-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1249481741-14008-6-git-send-email-tomi.valkeinen@nokia.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/mach/display.h |  542 +++++
 drivers/video/Kconfig                     |    1 +
 drivers/video/Makefile                    |    1 +
 drivers/video/omap2/Kconfig               |    2 +
 drivers/video/omap2/Makefile              |    2 +
 drivers/video/omap2/displays/Kconfig      |    4 +
 drivers/video/omap2/dss/Kconfig           |   89 +
 drivers/video/omap2/dss/Makefile          |    6 +
 drivers/video/omap2/dss/core.c            |  917 +++++++++
 drivers/video/omap2/dss/dispc.c           | 3177 +++++++++++++++++++++++++++++
 drivers/video/omap2/dss/display.c         |  658 ++++++
 drivers/video/omap2/dss/dpi.c             |  388 ++++
 drivers/video/omap2/dss/dss.c             |  347 ++++
 drivers/video/omap2/dss/dss.h             |  356 ++++
 drivers/video/omap2/dss/manager.c         | 1487 ++++++++++++++
 drivers/video/omap2/dss/overlay.c         |  673 ++++++
 16 files changed, 8650 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/mach/display.h
 create mode 100644 drivers/video/omap2/Kconfig
 create mode 100644 drivers/video/omap2/Makefile
 create mode 100644 drivers/video/omap2/displays/Kconfig
 create mode 100644 drivers/video/omap2/displays/Makefile
 create mode 100644 drivers/video/omap2/dss/Kconfig
 create mode 100644 drivers/video/omap2/dss/Makefile
 create mode 100644 drivers/video/omap2/dss/core.c
 create mode 100644 drivers/video/omap2/dss/dispc.c
 create mode 100644 drivers/video/omap2/dss/display.c
 create mode 100644 drivers/video/omap2/dss/dpi.c
 create mode 100644 drivers/video/omap2/dss/dss.c
 create mode 100644 drivers/video/omap2/dss/dss.h
 create mode 100644 drivers/video/omap2/dss/manager.c
 create mode 100644 drivers/video/omap2/dss/overlay.c

diff --git a/arch/arm/plat-omap/include/mach/display.h b/arch/arm/plat-omap/include/mach/display.h
new file mode 100644
index 0000000..a84425a
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/display.h
@@ -0,0 +1,542 @@
+/*
+ * linux/include/asm-arm/arch-omap/display.h
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_ARCH_OMAP_DISPLAY_H
+#define __ASM_ARCH_OMAP_DISPLAY_H
+
+#include <linux/list.h>
+#include <linux/kobject.h>
+#include <linux/device.h>
+#include <asm/atomic.h>
+
+#define DISPC_IRQ_FRAMEDONE		(1 << 0)
+#define DISPC_IRQ_VSYNC			(1 << 1)
+#define DISPC_IRQ_EVSYNC_EVEN		(1 << 2)
+#define DISPC_IRQ_EVSYNC_ODD		(1 << 3)
+#define DISPC_IRQ_ACBIAS_COUNT_STAT	(1 << 4)
+#define DISPC_IRQ_PROG_LINE_NUM		(1 << 5)
+#define DISPC_IRQ_GFX_FIFO_UNDERFLOW	(1 << 6)
+#define DISPC_IRQ_GFX_END_WIN		(1 << 7)
+#define DISPC_IRQ_PAL_GAMMA_MASK	(1 << 8)
+#define DISPC_IRQ_OCP_ERR		(1 << 9)
+#define DISPC_IRQ_VID1_FIFO_UNDERFLOW	(1 << 10)
+#define DISPC_IRQ_VID1_END_WIN		(1 << 11)
+#define DISPC_IRQ_VID2_FIFO_UNDERFLOW	(1 << 12)
+#define DISPC_IRQ_VID2_END_WIN		(1 << 13)
+#define DISPC_IRQ_SYNC_LOST		(1 << 14)
+#define DISPC_IRQ_SYNC_LOST_DIGIT	(1 << 15)
+#define DISPC_IRQ_WAKEUP		(1 << 16)
+
+struct omap_dss_device;
+struct omap_overlay_manager;
+
+enum omap_display_type {
+	OMAP_DISPLAY_TYPE_NONE		= 0,
+	OMAP_DISPLAY_TYPE_DPI		= 1 << 0,
+	OMAP_DISPLAY_TYPE_DBI		= 1 << 1,
+	OMAP_DISPLAY_TYPE_SDI		= 1 << 2,
+	OMAP_DISPLAY_TYPE_DSI		= 1 << 3,
+	OMAP_DISPLAY_TYPE_VENC		= 1 << 4,
+};
+
+enum omap_plane {
+	OMAP_DSS_GFX	= 0,
+	OMAP_DSS_VIDEO1	= 1,
+	OMAP_DSS_VIDEO2	= 2
+};
+
+enum omap_channel {
+	OMAP_DSS_CHANNEL_LCD	= 0,
+	OMAP_DSS_CHANNEL_DIGIT	= 1,
+};
+
+enum omap_color_mode {
+	OMAP_DSS_COLOR_CLUT1	= 1 << 0,  /* BITMAP 1 */
+	OMAP_DSS_COLOR_CLUT2	= 1 << 1,  /* BITMAP 2 */
+	OMAP_DSS_COLOR_CLUT4	= 1 << 2,  /* BITMAP 4 */
+	OMAP_DSS_COLOR_CLUT8	= 1 << 3,  /* BITMAP 8 */
+	OMAP_DSS_COLOR_RGB12U	= 1 << 4,  /* RGB12, 16-bit container */
+	OMAP_DSS_COLOR_ARGB16	= 1 << 5,  /* ARGB16 */
+	OMAP_DSS_COLOR_RGB16	= 1 << 6,  /* RGB16 */
+	OMAP_DSS_COLOR_RGB24U	= 1 << 7,  /* RGB24, 32-bit container */
+	OMAP_DSS_COLOR_RGB24P	= 1 << 8,  /* RGB24, 24-bit container */
+	OMAP_DSS_COLOR_YUV2	= 1 << 9,  /* YUV2 4:2:2 co-sited */
+	OMAP_DSS_COLOR_UYVY	= 1 << 10, /* UYVY 4:2:2 co-sited */
+	OMAP_DSS_COLOR_ARGB32	= 1 << 11, /* ARGB32 */
+	OMAP_DSS_COLOR_RGBA32	= 1 << 12, /* RGBA32 */
+	OMAP_DSS_COLOR_RGBX32	= 1 << 13, /* RGBx32 */
+
+	OMAP_DSS_COLOR_GFX_OMAP3 =
+		OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
+		OMAP_DSS_COLOR_CLUT4 | OMAP_DSS_COLOR_CLUT8 |
+		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
+		OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
+		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_ARGB32 |
+		OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
+
+	OMAP_DSS_COLOR_VID_OMAP3 =
+		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
+		OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
+		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_ARGB32 |
+		OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32 |
+		OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_UYVY,
+};
+
+enum omap_lcd_display_type {
+	OMAP_DSS_LCD_DISPLAY_STN,
+	OMAP_DSS_LCD_DISPLAY_TFT,
+};
+
+enum omap_dss_load_mode {
+	OMAP_DSS_LOAD_CLUT_AND_FRAME	= 0,
+	OMAP_DSS_LOAD_CLUT_ONLY		= 1,
+	OMAP_DSS_LOAD_FRAME_ONLY	= 2,
+	OMAP_DSS_LOAD_CLUT_ONCE_FRAME	= 3,
+};
+
+enum omap_dss_trans_key_type {
+	OMAP_DSS_COLOR_KEY_GFX_DST = 0,
+	OMAP_DSS_COLOR_KEY_VID_SRC = 1,
+};
+
+enum omap_rfbi_te_mode {
+	OMAP_DSS_RFBI_TE_MODE_1 = 1,
+	OMAP_DSS_RFBI_TE_MODE_2 = 2,
+};
+
+enum omap_panel_config {
+	OMAP_DSS_LCD_IVS		= 1<<0,
+	OMAP_DSS_LCD_IHS		= 1<<1,
+	OMAP_DSS_LCD_IPC		= 1<<2,
+	OMAP_DSS_LCD_IEO		= 1<<3,
+	OMAP_DSS_LCD_RF			= 1<<4,
+	OMAP_DSS_LCD_ONOFF		= 1<<5,
+
+	OMAP_DSS_LCD_TFT		= 1<<20,
+};
+
+enum omap_dss_venc_type {
+	OMAP_DSS_VENC_TYPE_COMPOSITE,
+	OMAP_DSS_VENC_TYPE_SVIDEO,
+};
+
+enum omap_display_caps {
+	OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE = 1 << 0,
+};
+
+enum omap_dss_update_mode {
+	OMAP_DSS_UPDATE_DISABLED = 0,
+	OMAP_DSS_UPDATE_AUTO,
+	OMAP_DSS_UPDATE_MANUAL,
+};
+
+enum omap_dss_display_state {
+	OMAP_DSS_DISPLAY_DISABLED = 0,
+	OMAP_DSS_DISPLAY_ACTIVE,
+	OMAP_DSS_DISPLAY_SUSPENDED,
+};
+
+/* XXX perhaps this should be removed */
+enum omap_dss_overlay_managers {
+	OMAP_DSS_OVL_MGR_LCD,
+	OMAP_DSS_OVL_MGR_TV,
+};
+
+enum omap_dss_rotation_type {
+	OMAP_DSS_ROT_DMA = 0,
+	OMAP_DSS_ROT_VRFB = 1,
+};
+
+enum omap_overlay_caps {
+	OMAP_DSS_OVL_CAP_SCALE = 1 << 0,
+	OMAP_DSS_OVL_CAP_DISPC = 1 << 1,
+};
+
+enum omap_overlay_manager_caps {
+	OMAP_DSS_OVL_MGR_CAP_DISPC = 1 << 0,
+};
+
+/* RFBI */
+
+struct rfbi_timings {
+	int cs_on_time;
+	int cs_off_time;
+	int we_on_time;
+	int we_off_time;
+	int re_on_time;
+	int re_off_time;
+	int we_cycle_time;
+	int re_cycle_time;
+	int cs_pulse_width;
+	int access_time;
+
+	int clk_div;
+
+	u32 tim[5];             /* set by rfbi_convert_timings() */
+
+	int converted;
+};
+
+void omap_rfbi_write_command(const void *buf, u32 len);
+void omap_rfbi_read_data(void *buf, u32 len);
+void omap_rfbi_write_data(const void *buf, u32 len);
+void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
+		u16 x, u16 y,
+		u16 w, u16 h);
+int omap_rfbi_enable_te(bool enable, unsigned line);
+int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
+			     unsigned hs_pulse_time, unsigned vs_pulse_time,
+			     int hs_pol_inv, int vs_pol_inv, int extif_div);
+
+/* DSI */
+void dsi_bus_lock(void);
+void dsi_bus_unlock(void);
+int dsi_vc_dcs_write(int channel, u8 *data, int len);
+int dsi_vc_dcs_write_nosync(int channel, u8 *data, int len);
+int dsi_vc_dcs_read(int channel, u8 dcs_cmd, u8 *buf, int buflen);
+int dsi_vc_set_max_rx_packet_size(int channel, u16 len);
+int dsi_vc_send_null(int channel);
+int dsi_vc_send_bta_sync(int channel);
+
+/* Board specific data */
+struct omap_dss_board_info {
+	int (*get_last_off_on_transaction_id)(struct device *dev);
+	int num_devices;
+	struct omap_dss_device **devices;
+	struct omap_dss_device *default_device;
+};
+
+struct omap_video_timings {
+	/* Unit: pixels */
+	u16 x_res;
+	/* Unit: pixels */
+	u16 y_res;
+	/* Unit: KHz */
+	u32 pixel_clock;
+	/* Unit: pixel clocks */
+	u16 hsw;	/* Horizontal synchronization pulse width */
+	/* Unit: pixel clocks */
+	u16 hfp;	/* Horizontal front porch */
+	/* Unit: pixel clocks */
+	u16 hbp;	/* Horizontal back porch */
+	/* Unit: line clocks */
+	u16 vsw;	/* Vertical synchronization pulse width */
+	/* Unit: line clocks */
+	u16 vfp;	/* Vertical front porch */
+	/* Unit: line clocks */
+	u16 vbp;	/* Vertical back porch */
+};
+
+#ifdef CONFIG_OMAP2_DSS_VENC
+/* Hardcoded timings for tv modes. Venc only uses these to
+ * identify the mode, and does not actually use the configs
+ * itself. However, the configs should be something that
+ * a normal monitor can also show */
+const extern struct omap_video_timings omap_dss_pal_timings;
+const extern struct omap_video_timings omap_dss_ntsc_timings;
+#endif
+
+struct omap_overlay_info {
+	bool enabled;
+
+	u32 paddr;
+	void __iomem *vaddr;
+	u16 screen_width;
+	u16 width;
+	u16 height;
+	enum omap_color_mode color_mode;
+	u8 rotation;
+	enum omap_dss_rotation_type rotation_type;
+	bool mirror;
+
+	u16 pos_x;
+	u16 pos_y;
+	u16 out_width;	/* if 0, out_width == width */
+	u16 out_height;	/* if 0, out_height == height */
+	u8 global_alpha;
+};
+
+struct omap_overlay {
+	struct kobject kobj;
+	struct list_head list;
+
+	/* static fields */
+	const char *name;
+	int id;
+	enum omap_color_mode supported_modes;
+	enum omap_overlay_caps caps;
+
+	/* dynamic fields */
+	struct omap_overlay_manager *manager;
+	struct omap_overlay_info info;
+
+	/* if true, info has been changed, but not applied() yet */
+	bool info_dirty;
+
+	int (*set_manager)(struct omap_overlay *ovl,
+		struct omap_overlay_manager *mgr);
+	int (*unset_manager)(struct omap_overlay *ovl);
+
+	int (*set_overlay_info)(struct omap_overlay *ovl,
+			struct omap_overlay_info *info);
+	void (*get_overlay_info)(struct omap_overlay *ovl,
+			struct omap_overlay_info *info);
+
+	int (*wait_for_go)(struct omap_overlay *ovl);
+};
+
+struct omap_overlay_manager_info {
+	u32 default_color;
+
+	enum omap_dss_trans_key_type trans_key_type;
+	u32 trans_key;
+	bool trans_enabled;
+
+	bool alpha_enabled;
+};
+
+struct omap_overlay_manager {
+	struct kobject kobj;
+	struct list_head list;
+
+	/* static fields */
+	const char *name;
+	int id;
+	enum omap_overlay_manager_caps caps;
+	int num_overlays;
+	struct omap_overlay **overlays;
+	enum omap_display_type supported_displays;
+
+	/* dynamic fields */
+	struct omap_dss_device *device;
+	struct omap_overlay_manager_info info;
+
+	bool device_changed;
+	/* if true, info has been changed but not applied() yet */
+	bool info_dirty;
+
+	int (*set_device)(struct omap_overlay_manager *mgr,
+		struct omap_dss_device *dssdev);
+	int (*unset_device)(struct omap_overlay_manager *mgr);
+
+	int (*set_manager_info)(struct omap_overlay_manager *mgr,
+			struct omap_overlay_manager_info *info);
+	void (*get_manager_info)(struct omap_overlay_manager *mgr,
+			struct omap_overlay_manager_info *info);
+
+	int (*apply)(struct omap_overlay_manager *mgr);
+	int (*wait_for_go)(struct omap_overlay_manager *mgr);
+};
+
+struct omap_dss_device {
+	struct device dev;
+
+	enum omap_display_type type;
+
+	union {
+		struct {
+			u8 data_lines;
+		} dpi;
+
+		struct {
+			u8 channel;
+			u8 data_lines;
+		} rfbi;
+
+		struct {
+			u8 datapairs;
+			unsigned pad_off_pe:1; /* pull pads if disabled */
+			unsigned pad_off_pu:1; /* pull up */
+		} sdi;
+
+		struct {
+			u8 clk_lane;
+			u8 clk_pol;
+			u8 data1_lane;
+			u8 data1_pol;
+			u8 data2_lane;
+			u8 data2_pol;
+			unsigned long lp_clk_hz;
+			unsigned long ddr_clk_hz;
+
+			bool ext_te;
+			u8 ext_te_gpio;
+		} dsi;
+
+		struct {
+			enum omap_dss_venc_type type;
+			bool invert_polarity;
+		} venc;
+	} phy;
+
+	struct {
+		struct omap_video_timings timings;
+
+		int acbi;	/* ac-bias pin transitions per interrupt */
+		/* Unit: line clocks */
+		int acb;	/* ac-bias pin frequency */
+
+		enum omap_panel_config config;
+
+		u8 recommended_bpp;
+
+		struct omap_dss_device *ctrl;
+	} panel;
+
+	struct {
+		u8 pixel_size;
+		struct rfbi_timings rfbi_timings;
+		struct omap_dss_device *panel;
+	} ctrl;
+
+	int reset_gpio;
+
+	int max_backlight_level;
+
+	const char *name;
+
+	/* used to match device to driver */
+	const char *driver_name;
+
+	void *data;
+
+	struct omap_dss_driver *driver;
+
+	/* helper variable for driver suspend/resume */
+	bool activate_after_resume;
+
+	enum omap_display_caps caps;
+
+	struct omap_overlay_manager *manager;
+
+	enum omap_dss_display_state state;
+
+	int (*enable)(struct omap_dss_device *dssdev);
+	void (*disable)(struct omap_dss_device *dssdev);
+
+	int (*suspend)(struct omap_dss_device *dssdev);
+	int (*resume)(struct omap_dss_device *dssdev);
+
+	void (*get_resolution)(struct omap_dss_device *dssdev,
+			u16 *xres, u16 *yres);
+	int (*get_recommended_bpp)(struct omap_dss_device *dssdev);
+
+	int (*check_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+	void (*set_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+	void (*get_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+	int (*update)(struct omap_dss_device *dssdev,
+			       u16 x, u16 y, u16 w, u16 h);
+	int (*sync)(struct omap_dss_device *dssdev);
+	int (*wait_vsync)(struct omap_dss_device *dssdev);
+
+	int (*set_update_mode)(struct omap_dss_device *dssdev,
+			enum omap_dss_update_mode);
+	enum omap_dss_update_mode (*get_update_mode)
+		(struct omap_dss_device *dssdev);
+
+	int (*enable_te)(struct omap_dss_device *dssdev, bool enable);
+	int (*get_te)(struct omap_dss_device *dssdev);
+
+	u8 (*get_rotate)(struct omap_dss_device *dssdev);
+	int (*set_rotate)(struct omap_dss_device *dssdev, u8 rotate);
+
+	bool (*get_mirror)(struct omap_dss_device *dssdev);
+	int (*set_mirror)(struct omap_dss_device *dssdev, bool enable);
+
+	int (*run_test)(struct omap_dss_device *dssdev, int test);
+	int (*memory_read)(struct omap_dss_device *dssdev,
+			void *buf, size_t size,
+			u16 x, u16 y, u16 w, u16 h);
+
+	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
+	u32 (*get_wss)(struct omap_dss_device *dssdev);
+
+	/* platform specific  */
+	int (*platform_enable)(struct omap_dss_device *dssdev);
+	void (*platform_disable)(struct omap_dss_device *dssdev);
+	int (*set_backlight)(struct omap_dss_device *dssdev, int level);
+	int (*get_backlight)(struct omap_dss_device *dssdev);
+};
+
+struct omap_dss_driver {
+	struct device_driver driver;
+
+	int (*probe)(struct omap_dss_device *);
+	void (*remove)(struct omap_dss_device *);
+
+	int (*enable)(struct omap_dss_device *display);
+	void (*disable)(struct omap_dss_device *display);
+	int (*suspend)(struct omap_dss_device *display);
+	int (*resume)(struct omap_dss_device *display);
+	int (*run_test)(struct omap_dss_device *display, int test);
+
+	void (*setup_update)(struct omap_dss_device *dssdev,
+			u16 x, u16 y, u16 w, u16 h);
+
+	int (*enable_te)(struct omap_dss_device *dssdev, bool enable);
+	int (*wait_for_te)(struct omap_dss_device *dssdev);
+
+	u8 (*get_rotate)(struct omap_dss_device *dssdev);
+	int (*set_rotate)(struct omap_dss_device *dssdev, u8 rotate);
+
+	bool (*get_mirror)(struct omap_dss_device *dssdev);
+	int (*set_mirror)(struct omap_dss_device *dssdev, bool enable);
+
+	int (*memory_read)(struct omap_dss_device *dssdev,
+			void *buf, size_t size,
+			u16 x, u16 y, u16 w, u16 h);
+};
+
+int omap_dss_register_driver(struct omap_dss_driver *);
+void omap_dss_unregister_driver(struct omap_dss_driver *);
+
+int omap_dss_register_device(struct omap_dss_device *);
+void omap_dss_unregister_device(struct omap_dss_device *);
+
+void omap_dss_get_device(struct omap_dss_device *dssdev);
+void omap_dss_put_device(struct omap_dss_device *dssdev);
+#define for_each_dss_dev(d) while ((d = omap_dss_get_next_device(d)) != NULL)
+struct omap_dss_device *omap_dss_get_next_device(struct omap_dss_device *from);
+struct omap_dss_device *omap_dss_find_device(void *data,
+		int (*match)(struct omap_dss_device *dssdev, void *data));
+
+int omap_dss_start_device(struct omap_dss_device *dssdev);
+void omap_dss_stop_device(struct omap_dss_device *dssdev);
+
+int omap_dss_get_num_overlay_managers(void);
+struct omap_overlay_manager *omap_dss_get_overlay_manager(int num);
+
+int omap_dss_get_num_overlays(void);
+struct omap_overlay *omap_dss_get_overlay(int num);
+
+typedef void (*omap_dispc_isr_t) (void *arg, u32 mask);
+int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
+int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
+
+int omap_dispc_wait_for_irq_timeout(u32 irqmask, unsigned long timeout);
+int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
+		unsigned long timeout);
+
+#define to_dss_driver(x) container_of((x), struct omap_dss_driver, driver)
+#define to_dss_device(x) container_of((x), struct omap_dss_device, dev)
+
+#endif
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index d6d65ef..95e03fd 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2146,6 +2146,7 @@ config FB_BROADSHEET
 	  a bridge adapter.
 
 source "drivers/video/omap/Kconfig"
+source "drivers/video/omap2/Kconfig"
 
 source "drivers/video/backlight/Kconfig"
 source "drivers/video/display/Kconfig"
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 01a819f..01bf7a5 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_FB_SM501)            += sm501fb.o
 obj-$(CONFIG_FB_XILINX)           += xilinxfb.o
 obj-$(CONFIG_FB_SH_MOBILE_LCDC)	  += sh_mobile_lcdcfb.o
 obj-$(CONFIG_FB_OMAP)             += omap/
+obj-$(CONFIG_OMAP2_DSS)           += omap2/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
 obj-$(CONFIG_FB_CARMINE)          += carminefb.o
 obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
diff --git a/drivers/video/omap2/Kconfig b/drivers/video/omap2/Kconfig
new file mode 100644
index 0000000..244b80d
--- /dev/null
+++ b/drivers/video/omap2/Kconfig
@@ -0,0 +1,2 @@
+source "drivers/video/omap2/dss/Kconfig"
+source "drivers/video/omap2/displays/Kconfig"
diff --git a/drivers/video/omap2/Makefile b/drivers/video/omap2/Makefile
new file mode 100644
index 0000000..2d2c83e
--- /dev/null
+++ b/drivers/video/omap2/Makefile
@@ -0,0 +1,2 @@
+obj-y += dss/
+obj-y += displays/
diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
new file mode 100644
index 0000000..8bdc33c
--- /dev/null
+++ b/drivers/video/omap2/displays/Kconfig
@@ -0,0 +1,4 @@
+menu "OMAP2/3 Display Device Drivers"
+        depends on OMAP2_DSS
+
+endmenu
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
new file mode 100644
index 0000000..71d8dec
--- /dev/null
+++ b/drivers/video/omap2/dss/Kconfig
@@ -0,0 +1,89 @@
+menuconfig OMAP2_DSS
+        tristate "OMAP2/3 Display Subsystem support (EXPERIMENTAL)"
+        depends on ARCH_OMAP2 || ARCH_OMAP3
+        help
+          OMAP2/3 Display Subsystem support.
+
+if OMAP2_DSS
+
+config OMAP2_VRAM_SIZE
+	int "VRAM size (MB)"
+	range 0 32
+	default 0
+	help
+	  The amount of SDRAM to reserve at boot time for video RAM use.
+	  This VRAM will be used by omapfb and other drivers that need
+	  large continuous RAM area for video use.
+
+	  You can also set this with "vram=<bytes>" kernel argument, or
+	  in the board file.
+
+config OMAP2_DSS_DEBUG_SUPPORT
+        bool "Debug support"
+	default y
+	help
+	  This enables debug messages. You need to enable printing
+	  with 'debug' module parameter.
+
+config OMAP2_DSS_RFBI
+	bool "RFBI support"
+        default n
+	help
+	  MIPI DBI, or RFBI (Remote Framebuffer Interface), support.
+
+config OMAP2_DSS_VENC
+	bool "VENC support"
+        default y
+	help
+	  OMAP Video Encoder support.
+
+config OMAP2_DSS_SDI
+	bool "SDI support"
+	depends on ARCH_OMAP3
+        default n
+	help
+	  SDI (Serial Display Interface) support.
+
+config OMAP2_DSS_DSI
+	bool "DSI support"
+	depends on ARCH_OMAP3
+        default n
+	help
+	  MIPI DSI support.
+
+config OMAP2_DSS_USE_DSI_PLL
+	bool "Use DSI PLL for PCLK (EXPERIMENTAL)"
+	default n
+	depends on OMAP2_DSS_DSI
+	help
+	  Use DSI PLL to generate pixel clock.  Currently only for DPI output.
+	  DSI PLL can be used to generate higher and more precise pixel clocks.
+
+config OMAP2_DSS_FAKE_VSYNC
+	bool "Fake VSYNC irq from manual update displays"
+	default n
+	help
+	  If this is selected, DSI will generate a fake DISPC VSYNC interrupt
+	  when DSI has sent a frame. This is only needed with DSI or RFBI
+	  displays using manual mode, and you want VSYNC to, for example,
+	  time animation.
+
+config OMAP2_DSS_MIN_FCK_PER_PCK
+	int "Minimum FCK/PCK ratio (for scaling)"
+	range 0 32
+	default 0
+	help
+	  This can be used to adjust the minimum FCK/PCK ratio.
+
+	  With this you can make sure that DISPC FCK is at least
+	  n x PCK. Video plane scaling requires higher FCK than
+	  normally.
+
+	  If this is set to 0, there's no extra constraint on the
+	  DISPC FCK. However, the FCK will at minimum be
+	  2xPCK (if active matrix) or 3xPCK (if passive matrix).
+
+	  Max FCK is 173MHz, so this doesn't work if your PCK
+	  is very high.
+
+endif
diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
new file mode 100644
index 0000000..980c72c
--- /dev/null
+++ b/drivers/video/omap2/dss/Makefile
@@ -0,0 +1,6 @@
+obj-$(CONFIG_OMAP2_DSS) += omapdss.o
+omapdss-y := core.o dss.o dispc.o dpi.o display.o manager.o overlay.o
+omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
+omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
+omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
+omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
new file mode 100644
index 0000000..e8d430c
--- /dev/null
+++ b/drivers/video/omap2/dss/core.c
@@ -0,0 +1,917 @@
+/*
+ * linux/drivers/video/omap2/dss/core.c
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * Some code and ideas taken from drivers/video/omap/ driver
+ * by Imre Deak.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define DSS_SUBSYS_NAME "CORE"
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <linux/io.h>
+#include <linux/device.h>
+
+#include <mach/display.h>
+#include <mach/clock.h>
+
+#include "dss.h"
+
+static struct {
+	struct platform_device *pdev;
+	int		ctx_id;
+
+	struct clk      *dss_ick;
+	struct clk	*dss1_fck;
+	struct clk	*dss2_fck;
+	struct clk      *dss_54m_fck;
+	struct clk	*dss_96m_fck;
+	unsigned	num_clks_enabled;
+} core;
+
+static void dss_clk_enable_all_no_ctx(void);
+static void dss_clk_disable_all_no_ctx(void);
+static void dss_clk_enable_no_ctx(enum dss_clock clks);
+static void dss_clk_disable_no_ctx(enum dss_clock clks);
+
+static char *def_disp_name;
+module_param_named(def_disp, def_disp_name, charp, 0);
+MODULE_PARM_DESC(def_disp_name, "default display name");
+
+#ifdef DEBUG
+unsigned int dss_debug;
+module_param_named(debug, dss_debug, bool, 0644);
+#endif
+
+/* CONTEXT */
+static int dss_get_ctx_id(void)
+{
+	struct omap_dss_board_info *pdata = core.pdev->dev.platform_data;
+	int r;
+
+	if (!pdata->get_last_off_on_transaction_id)
+		return 0;
+	r = pdata->get_last_off_on_transaction_id(&core.pdev->dev);
+	if (r < 0) {
+		dev_err(&core.pdev->dev, "getting transaction ID failed, "
+				"will force context restore\n");
+		r = -1;
+	}
+	return r;
+}
+
+int dss_need_ctx_restore(void)
+{
+	int id = dss_get_ctx_id();
+
+	if (id < 0 || id != core.ctx_id) {
+		DSSDBG("ctx id %d -> id %d\n",
+				core.ctx_id, id);
+		core.ctx_id = id;
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+static void save_all_ctx(void)
+{
+	DSSDBG("save context\n");
+
+	dss_clk_enable_no_ctx(DSS_CLK_ICK | DSS_CLK_FCK1);
+
+	dss_save_context();
+	dispc_save_context();
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_save_context();
+#endif
+
+	dss_clk_disable_no_ctx(DSS_CLK_ICK | DSS_CLK_FCK1);
+}
+
+static void restore_all_ctx(void)
+{
+	DSSDBG("restore context\n");
+
+	dss_clk_enable_all_no_ctx();
+
+	dss_restore_context();
+	dispc_restore_context();
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_restore_context();
+#endif
+
+	dss_clk_disable_all_no_ctx();
+}
+
+/* CLOCKS */
+void dss_dump_clocks(struct seq_file *s)
+{
+	int i;
+	struct clk *clocks[5] = {
+		core.dss_ick,
+		core.dss1_fck,
+		core.dss2_fck,
+		core.dss_54m_fck,
+		core.dss_96m_fck
+	};
+
+	seq_printf(s, "- dss -\n");
+
+	seq_printf(s, "internal clk count\t%u\n", core.num_clks_enabled);
+
+	for (i = 0; i < 5; i++) {
+		if (!clocks[i])
+			continue;
+		seq_printf(s, "%-15s\t%lu\t%d\n",
+				clocks[i]->name,
+				clk_get_rate(clocks[i]),
+				clocks[i]->usecount);
+	}
+}
+
+static int dss_get_clock(struct clk **clock, const char *clk_name)
+{
+	struct clk *clk;
+
+	clk = clk_get(&core.pdev->dev, clk_name);
+
+	if (IS_ERR(clk)) {
+		DSSERR("can't get clock %s", clk_name);
+		return PTR_ERR(clk);
+	}
+
+	*clock = clk;
+
+	DSSDBG("clk %s, rate %ld\n", clk_name, clk_get_rate(clk));
+
+	return 0;
+}
+
+static int dss_get_clocks(void)
+{
+	int r;
+
+	core.dss_ick = NULL;
+	core.dss1_fck = NULL;
+	core.dss2_fck = NULL;
+	core.dss_54m_fck = NULL;
+	core.dss_96m_fck = NULL;
+
+	r = dss_get_clock(&core.dss_ick, "ick");
+	if (r)
+		goto err;
+
+	r = dss_get_clock(&core.dss1_fck, "dss1_fck");
+	if (r)
+		goto err;
+
+	r = dss_get_clock(&core.dss2_fck, "dss2_fck");
+	if (r)
+		goto err;
+
+	r = dss_get_clock(&core.dss_54m_fck, "tv_fck");
+	if (r)
+		goto err;
+
+	r = dss_get_clock(&core.dss_96m_fck, "video_fck");
+	if (r)
+		goto err;
+
+	return 0;
+
+err:
+	if (core.dss_ick)
+		clk_put(core.dss_ick);
+	if (core.dss1_fck)
+		clk_put(core.dss1_fck);
+	if (core.dss2_fck)
+		clk_put(core.dss2_fck);
+	if (core.dss_54m_fck)
+		clk_put(core.dss_54m_fck);
+	if (core.dss_96m_fck)
+		clk_put(core.dss_96m_fck);
+
+	return r;
+}
+
+static void dss_put_clocks(void)
+{
+	if (core.dss_96m_fck)
+		clk_put(core.dss_96m_fck);
+	clk_put(core.dss_54m_fck);
+	clk_put(core.dss1_fck);
+	clk_put(core.dss2_fck);
+	clk_put(core.dss_ick);
+}
+
+unsigned long dss_clk_get_rate(enum dss_clock clk)
+{
+	switch (clk) {
+	case DSS_CLK_ICK:
+		return clk_get_rate(core.dss_ick);
+	case DSS_CLK_FCK1:
+		return clk_get_rate(core.dss1_fck);
+	case DSS_CLK_FCK2:
+		return clk_get_rate(core.dss2_fck);
+	case DSS_CLK_54M:
+		return clk_get_rate(core.dss_54m_fck);
+	case DSS_CLK_96M:
+		return clk_get_rate(core.dss_96m_fck);
+	}
+
+	BUG();
+	return 0;
+}
+
+static unsigned count_clk_bits(enum dss_clock clks)
+{
+	unsigned num_clks = 0;
+
+	if (clks & DSS_CLK_ICK)
+		++num_clks;
+	if (clks & DSS_CLK_FCK1)
+		++num_clks;
+	if (clks & DSS_CLK_FCK2)
+		++num_clks;
+	if (clks & DSS_CLK_54M)
+		++num_clks;
+	if (clks & DSS_CLK_96M)
+		++num_clks;
+
+	return num_clks;
+}
+
+static void dss_clk_enable_no_ctx(enum dss_clock clks)
+{
+	unsigned num_clks = count_clk_bits(clks);
+
+	if (clks & DSS_CLK_ICK)
+		clk_enable(core.dss_ick);
+	if (clks & DSS_CLK_FCK1)
+		clk_enable(core.dss1_fck);
+	if (clks & DSS_CLK_FCK2)
+		clk_enable(core.dss2_fck);
+	if (clks & DSS_CLK_54M)
+		clk_enable(core.dss_54m_fck);
+	if (clks & DSS_CLK_96M)
+		clk_enable(core.dss_96m_fck);
+
+	core.num_clks_enabled += num_clks;
+}
+
+void dss_clk_enable(enum dss_clock clks)
+{
+	dss_clk_enable_no_ctx(clks);
+
+	if (cpu_is_omap34xx() && dss_need_ctx_restore())
+		restore_all_ctx();
+}
+
+static void dss_clk_disable_no_ctx(enum dss_clock clks)
+{
+	unsigned num_clks = count_clk_bits(clks);
+
+	if (clks & DSS_CLK_ICK)
+		clk_disable(core.dss_ick);
+	if (clks & DSS_CLK_FCK1)
+		clk_disable(core.dss1_fck);
+	if (clks & DSS_CLK_FCK2)
+		clk_disable(core.dss2_fck);
+	if (clks & DSS_CLK_54M)
+		clk_disable(core.dss_54m_fck);
+	if (clks & DSS_CLK_96M)
+		clk_disable(core.dss_96m_fck);
+
+	core.num_clks_enabled -= num_clks;
+}
+
+void dss_clk_disable(enum dss_clock clks)
+{
+	if (cpu_is_omap34xx()) {
+		unsigned num_clks = count_clk_bits(clks);
+
+		BUG_ON(core.num_clks_enabled < num_clks);
+
+		if (core.num_clks_enabled == num_clks)
+			save_all_ctx();
+	}
+
+	dss_clk_disable_no_ctx(clks);
+}
+
+static void dss_clk_enable_all_no_ctx(void)
+{
+	enum dss_clock clks;
+
+	clks = DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_FCK2 | DSS_CLK_54M;
+	if (cpu_is_omap34xx())
+		clks |= DSS_CLK_96M;
+	dss_clk_enable_no_ctx(clks);
+}
+
+static void dss_clk_disable_all_no_ctx(void)
+{
+	enum dss_clock clks;
+
+	clks = DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_FCK2 | DSS_CLK_54M;
+	if (cpu_is_omap34xx())
+		clks |= DSS_CLK_96M;
+	dss_clk_disable_no_ctx(clks);
+}
+
+static void dss_clk_disable_all(void)
+{
+	enum dss_clock clks;
+
+	clks = DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_FCK2 | DSS_CLK_54M;
+	if (cpu_is_omap34xx())
+		clks |= DSS_CLK_96M;
+	dss_clk_disable(clks);
+}
+
+/* DEBUGFS */
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
+static void dss_debug_dump_clocks(struct seq_file *s)
+{
+	dss_dump_clocks(s);
+	dispc_dump_clocks(s);
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_dump_clocks(s);
+#endif
+}
+
+static int dss_debug_show(struct seq_file *s, void *unused)
+{
+	void (*func)(struct seq_file *) = s->private;
+	func(s);
+	return 0;
+}
+
+static int dss_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dss_debug_show, inode->i_private);
+}
+
+static const struct file_operations dss_debug_fops = {
+	.open           = dss_debug_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+static struct dentry *dss_debugfs_dir;
+
+static int dss_initialize_debugfs(void)
+{
+	dss_debugfs_dir = debugfs_create_dir("omapdss", NULL);
+	if (IS_ERR(dss_debugfs_dir)) {
+		int err = PTR_ERR(dss_debugfs_dir);
+		dss_debugfs_dir = NULL;
+		return err;
+	}
+
+	debugfs_create_file("clk", S_IRUGO, dss_debugfs_dir,
+			&dss_debug_dump_clocks, &dss_debug_fops);
+
+	debugfs_create_file("dss", S_IRUGO, dss_debugfs_dir,
+			&dss_dump_regs, &dss_debug_fops);
+	debugfs_create_file("dispc", S_IRUGO, dss_debugfs_dir,
+			&dispc_dump_regs, &dss_debug_fops);
+#ifdef CONFIG_OMAP2_DSS_RFBI
+	debugfs_create_file("rfbi", S_IRUGO, dss_debugfs_dir,
+			&rfbi_dump_regs, &dss_debug_fops);
+#endif
+#ifdef CONFIG_OMAP2_DSS_DSI
+	debugfs_create_file("dsi", S_IRUGO, dss_debugfs_dir,
+			&dsi_dump_regs, &dss_debug_fops);
+#endif
+#ifdef CONFIG_OMAP2_DSS_VENC
+	debugfs_create_file("venc", S_IRUGO, dss_debugfs_dir,
+			&venc_dump_regs, &dss_debug_fops);
+#endif
+	return 0;
+}
+
+static void dss_uninitialize_debugfs(void)
+{
+	if (dss_debugfs_dir)
+		debugfs_remove_recursive(dss_debugfs_dir);
+}
+#endif /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
+
+/* PLATFORM DEVICE */
+static int omap_dss_probe(struct platform_device *pdev)
+{
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
+	int skip_init = 0;
+	int r;
+	int i;
+
+	core.pdev = pdev;
+
+	dss_init_overlay_managers(pdev);
+	dss_init_overlays(pdev);
+
+	r = dss_get_clocks();
+	if (r)
+		goto fail0;
+
+	dss_clk_enable_all_no_ctx();
+
+	core.ctx_id = dss_get_ctx_id();
+	DSSDBG("initial ctx id %u\n", core.ctx_id);
+
+#ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
+	/* DISPC_CONTROL */
+	if (omap_readl(0x48050440) & 1)	/* LCD enabled? */
+		skip_init = 1;
+#endif
+
+	r = dss_init(skip_init);
+	if (r) {
+		DSSERR("Failed to initialize DSS\n");
+		goto fail0;
+	}
+
+#ifdef CONFIG_OMAP2_DSS_RFBI
+	r = rfbi_init();
+	if (r) {
+		DSSERR("Failed to initialize rfbi\n");
+		goto fail0;
+	}
+#endif
+
+	r = dpi_init();
+	if (r) {
+		DSSERR("Failed to initialize dpi\n");
+		goto fail0;
+	}
+
+	r = dispc_init();
+	if (r) {
+		DSSERR("Failed to initialize dispc\n");
+		goto fail0;
+	}
+#ifdef CONFIG_OMAP2_DSS_VENC
+	r = venc_init(pdev);
+	if (r) {
+		DSSERR("Failed to initialize venc\n");
+		goto fail0;
+	}
+#endif
+	if (cpu_is_omap34xx()) {
+#ifdef CONFIG_OMAP2_DSS_SDI
+		r = sdi_init(skip_init);
+		if (r) {
+			DSSERR("Failed to initialize SDI\n");
+			goto fail0;
+		}
+#endif
+#ifdef CONFIG_OMAP2_DSS_DSI
+		r = dsi_init(pdev);
+		if (r) {
+			DSSERR("Failed to initialize DSI\n");
+			goto fail0;
+		}
+#endif
+	}
+
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
+	r = dss_initialize_debugfs();
+	if (r)
+		goto fail0;
+#endif
+
+	for (i = 0; i < pdata->num_devices; ++i) {
+		struct omap_dss_device *dssdev = pdata->devices[i];
+
+		r = omap_dss_register_device(dssdev);
+		if (r)
+			DSSERR("device reg failed %d\n", i);
+
+		if (def_disp_name && strcmp(def_disp_name, dssdev->name) == 0)
+			pdata->default_device = dssdev;
+	}
+
+	dss_clk_disable_all();
+
+	return 0;
+
+	/* XXX fail correctly */
+fail0:
+	return r;
+}
+
+static int omap_dss_remove(struct platform_device *pdev)
+{
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
+	int i;
+	int c;
+
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
+	dss_uninitialize_debugfs();
+#endif
+
+#ifdef CONFIG_OMAP2_DSS_VENC
+	venc_exit();
+#endif
+	dispc_exit();
+	dpi_exit();
+#ifdef CONFIG_OMAP2_DSS_RFBI
+	rfbi_exit();
+#endif
+	if (cpu_is_omap34xx()) {
+#ifdef CONFIG_OMAP2_DSS_DSI
+		dsi_exit();
+#endif
+#ifdef CONFIG_OMAP2_DSS_SDI
+		sdi_exit();
+#endif
+	}
+
+	dss_exit();
+
+	/* these should be removed at some point */
+	c = core.dss_ick->usecount;
+	if (c > 0) {
+		DSSERR("warning: dss_ick usecount %d, disabling\n", c);
+		while (c-- > 0)
+			clk_disable(core.dss_ick);
+	}
+
+	c = core.dss1_fck->usecount;
+	if (c > 0) {
+		DSSERR("warning: dss1_fck usecount %d, disabling\n", c);
+		while (c-- > 0)
+			clk_disable(core.dss1_fck);
+	}
+
+	c = core.dss2_fck->usecount;
+	if (c > 0) {
+		DSSERR("warning: dss2_fck usecount %d, disabling\n", c);
+		while (c-- > 0)
+			clk_disable(core.dss2_fck);
+	}
+
+	c = core.dss_54m_fck->usecount;
+	if (c > 0) {
+		DSSERR("warning: dss_54m_fck usecount %d, disabling\n", c);
+		while (c-- > 0)
+			clk_disable(core.dss_54m_fck);
+	}
+
+	if (core.dss_96m_fck) {
+		c = core.dss_96m_fck->usecount;
+		if (c > 0) {
+			DSSERR("warning: dss_96m_fck usecount %d, disabling\n",
+					c);
+			while (c-- > 0)
+				clk_disable(core.dss_96m_fck);
+		}
+	}
+
+	dss_put_clocks();
+
+	dss_uninit_overlays(pdev);
+	dss_uninit_overlay_managers(pdev);
+
+	for (i = 0; i < pdata->num_devices; ++i)
+		omap_dss_unregister_device(pdata->devices[i]);
+
+	return 0;
+}
+
+static void omap_dss_shutdown(struct platform_device *pdev)
+{
+	DSSDBG("shutdown\n");
+}
+
+static int omap_dss_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	DSSDBG("suspend %d\n", state.event);
+
+	return dss_suspend_all_devices();
+}
+
+static int omap_dss_resume(struct platform_device *pdev)
+{
+	DSSDBG("resume\n");
+
+	return dss_resume_all_devices();
+}
+
+static struct platform_driver omap_dss_driver = {
+	.probe          = omap_dss_probe,
+	.remove         = omap_dss_remove,
+	.shutdown	= omap_dss_shutdown,
+	.suspend	= omap_dss_suspend,
+	.resume		= omap_dss_resume,
+	.driver         = {
+		.name   = "omapdss",
+		.owner  = THIS_MODULE,
+	},
+};
+
+/* BUS */
+static int dss_bus_match(struct device *dev, struct device_driver *driver)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+
+	DSSDBG("bus_match. dev %s/%s, drv %s\n",
+			dev_name(dev), dssdev->driver_name, driver->name);
+
+	return strcmp(dssdev->driver_name, driver->name) == 0;
+}
+
+static ssize_t device_name_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			dssdev->name ?
+			dssdev->name : "");
+}
+
+static struct device_attribute default_dev_attrs[] = {
+	__ATTR(name, S_IRUGO, device_name_show, NULL),
+	__ATTR_NULL,
+};
+
+static ssize_t driver_name_show(struct device_driver *drv, char *buf)
+{
+	struct omap_dss_driver *dssdrv = to_dss_driver(drv);
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			dssdrv->driver.name ?
+			dssdrv->driver.name : "");
+}
+static struct driver_attribute default_drv_attrs[] = {
+	__ATTR(name, S_IRUGO, driver_name_show, NULL),
+	__ATTR_NULL,
+};
+
+static struct bus_type dss_bus_type = {
+	.name = "omapdss",
+	.match = dss_bus_match,
+	.dev_attrs = default_dev_attrs,
+	.drv_attrs = default_drv_attrs,
+};
+
+static void dss_bus_release(struct device *dev)
+{
+	DSSDBG("bus_release\n");
+}
+
+static struct device dss_bus = {
+	.release = dss_bus_release,
+};
+
+struct bus_type *dss_get_bus(void)
+{
+	return &dss_bus_type;
+}
+
+/* DRIVER */
+static int dss_driver_probe(struct device *dev)
+{
+	int r;
+	struct omap_dss_driver *dssdrv = to_dss_driver(dev->driver);
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_board_info *pdata = core.pdev->dev.platform_data;
+	bool force;
+
+	DSSDBG("driver_probe: dev %s/%s, drv %s\n",
+				dev_name(dev), dssdev->driver_name,
+				dssdrv->driver.name);
+
+	dss_init_device(core.pdev, dssdev);
+
+	/* skip this if the device is behind a ctrl */
+	if (!dssdev->panel.ctrl) {
+		force = pdata->default_device == dssdev;
+		dss_recheck_connections(dssdev, force);
+	}
+
+	r = dssdrv->probe(dssdev);
+
+	if (r) {
+		DSSERR("driver probe failed: %d\n", r);
+		return r;
+	}
+
+	DSSDBG("probe done for device %s\n", dev_name(dev));
+
+	dssdev->driver = dssdrv;
+
+	return 0;
+}
+
+static int dss_driver_remove(struct device *dev)
+{
+	struct omap_dss_driver *dssdrv = to_dss_driver(dev->driver);
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+
+	DSSDBG("driver_remove: dev %s/%s\n", dev_name(dev),
+			dssdev->driver_name);
+
+	dssdrv->remove(dssdev);
+
+	dss_uninit_device(core.pdev, dssdev);
+
+	dssdev->driver = NULL;
+
+	return 0;
+}
+
+int omap_dss_register_driver(struct omap_dss_driver *dssdriver)
+{
+	dssdriver->driver.bus = &dss_bus_type;
+	dssdriver->driver.probe = dss_driver_probe;
+	dssdriver->driver.remove = dss_driver_remove;
+	return driver_register(&dssdriver->driver);
+}
+EXPORT_SYMBOL(omap_dss_register_driver);
+
+void omap_dss_unregister_driver(struct omap_dss_driver *dssdriver)
+{
+	driver_unregister(&dssdriver->driver);
+}
+EXPORT_SYMBOL(omap_dss_unregister_driver);
+
+/* DEVICE */
+static void reset_device(struct device *dev, int check)
+{
+	u8 *dev_p = (u8 *)dev;
+	u8 *dev_end = dev_p + sizeof(*dev);
+	void *saved_pdata;
+
+	saved_pdata = dev->platform_data;
+	if (check) {
+		/*
+		 * Check if there is any other setting than platform_data
+		 * in struct device; warn that these will be reset by our
+		 * init.
+		 */
+		dev->platform_data = NULL;
+		while (dev_p < dev_end) {
+			if (*dev_p) {
+				WARN("%s: struct device fields will be "
+						"discarded\n",
+				     __func__);
+				break;
+			}
+			dev_p++;
+		}
+	}
+	memset(dev, 0, sizeof(*dev));
+	dev->platform_data = saved_pdata;
+}
+
+
+static void omap_dss_dev_release(struct device *dev)
+{
+	reset_device(dev, 0);
+}
+
+int omap_dss_register_device(struct omap_dss_device *dssdev)
+{
+	static int dev_num;
+	static int panel_num;
+	int r;
+
+	WARN_ON(!dssdev->driver_name);
+
+	reset_device(&dssdev->dev, 1);
+	dssdev->dev.bus = &dss_bus_type;
+	dssdev->dev.parent = &dss_bus;
+	dssdev->dev.release = omap_dss_dev_release;
+	dev_set_name(&dssdev->dev, "display%d", dev_num++);
+	r = device_register(&dssdev->dev);
+	if (r)
+		return r;
+
+	if (dssdev->ctrl.panel) {
+		struct omap_dss_device *panel = dssdev->ctrl.panel;
+
+		panel->panel.ctrl = dssdev;
+
+		reset_device(&panel->dev, 1);
+		panel->dev.bus = &dss_bus_type;
+		panel->dev.parent = &dssdev->dev;
+		panel->dev.release = omap_dss_dev_release;
+		dev_set_name(&panel->dev, "panel%d", panel_num++);
+		r = device_register(&panel->dev);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+void omap_dss_unregister_device(struct omap_dss_device *dssdev)
+{
+	device_unregister(&dssdev->dev);
+
+	if (dssdev->ctrl.panel) {
+		struct omap_dss_device *panel = dssdev->ctrl.panel;
+		device_unregister(&panel->dev);
+	}
+}
+
+/* BUS */
+static int omap_dss_bus_register(void)
+{
+	int r;
+
+	r = bus_register(&dss_bus_type);
+	if (r) {
+		DSSERR("bus register failed\n");
+		return r;
+	}
+
+	dev_set_name(&dss_bus, "omapdss");
+	r = device_register(&dss_bus);
+	if (r) {
+		DSSERR("bus driver register failed\n");
+		bus_unregister(&dss_bus_type);
+		return r;
+	}
+
+	return 0;
+}
+
+/* INIT */
+
+#ifdef CONFIG_OMAP2_DSS_MODULE
+static void omap_dss_bus_unregister(void)
+{
+	device_unregister(&dss_bus);
+
+	bus_unregister(&dss_bus_type);
+}
+
+static int __init omap_dss_init(void)
+{
+	int r;
+
+	r = omap_dss_bus_register();
+	if (r)
+		return r;
+
+	r = platform_driver_register(&omap_dss_driver);
+	if (r) {
+		omap_dss_bus_unregister();
+		return r;
+	}
+
+	return 0;
+}
+
+static void __exit omap_dss_exit(void)
+{
+	platform_driver_unregister(&omap_dss_driver);
+
+	omap_dss_bus_unregister();
+}
+
+module_init(omap_dss_init);
+module_exit(omap_dss_exit);
+#else
+static int __init omap_dss_init(void)
+{
+	return omap_dss_bus_register();
+}
+
+static int __init omap_dss_init2(void)
+{
+	return platform_driver_register(&omap_dss_driver);
+}
+
+core_initcall(omap_dss_init);
+device_initcall(omap_dss_init2);
+#endif
+
+MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
+MODULE_DESCRIPTION("OMAP2/3 Display Subsystem");
+MODULE_LICENSE("GPL v2");
+
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
new file mode 100644
index 0000000..d061d75
--- /dev/null
+++ b/drivers/video/omap2/dss/dispc.c
@@ -0,0 +1,3177 @@
+/*
+ * linux/drivers/video/omap2/dss/dispc.c
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * Some code and ideas taken from drivers/video/omap/ driver
+ * by Imre Deak.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define DSS_SUBSYS_NAME "DISPC"
+
+#include <linux/kernel.h>
+#include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/seq_file.h>
+#include <linux/delay.h>
+#include <linux/workqueue.h>
+
+#include <mach/sram.h>
+#include <mach/board.h>
+#include <mach/clock.h>
+
+#include <mach/display.h>
+
+#include "dss.h"
+
+/* DISPC */
+#define DISPC_BASE			0x48050400
+
+#define DISPC_SZ_REGS			SZ_1K
+
+struct dispc_reg { u16 idx; };
+
+#define DISPC_REG(idx)			((const struct dispc_reg) { idx })
+
+/* DISPC common */
+#define DISPC_REVISION			DISPC_REG(0x0000)
+#define DISPC_SYSCONFIG			DISPC_REG(0x0010)
+#define DISPC_SYSSTATUS			DISPC_REG(0x0014)
+#define DISPC_IRQSTATUS			DISPC_REG(0x0018)
+#define DISPC_IRQENABLE			DISPC_REG(0x001C)
+#define DISPC_CONTROL			DISPC_REG(0x0040)
+#define DISPC_CONFIG			DISPC_REG(0x0044)
+#define DISPC_CAPABLE			DISPC_REG(0x0048)
+#define DISPC_DEFAULT_COLOR0		DISPC_REG(0x004C)
+#define DISPC_DEFAULT_COLOR1		DISPC_REG(0x0050)
+#define DISPC_TRANS_COLOR0		DISPC_REG(0x0054)
+#define DISPC_TRANS_COLOR1		DISPC_REG(0x0058)
+#define DISPC_LINE_STATUS		DISPC_REG(0x005C)
+#define DISPC_LINE_NUMBER		DISPC_REG(0x0060)
+#define DISPC_TIMING_H			DISPC_REG(0x0064)
+#define DISPC_TIMING_V			DISPC_REG(0x0068)
+#define DISPC_POL_FREQ			DISPC_REG(0x006C)
+#define DISPC_DIVISOR			DISPC_REG(0x0070)
+#define DISPC_GLOBAL_ALPHA		DISPC_REG(0x0074)
+#define DISPC_SIZE_DIG			DISPC_REG(0x0078)
+#define DISPC_SIZE_LCD			DISPC_REG(0x007C)
+
+/* DISPC GFX plane */
+#define DISPC_GFX_BA0			DISPC_REG(0x0080)
+#define DISPC_GFX_BA1			DISPC_REG(0x0084)
+#define DISPC_GFX_POSITION		DISPC_REG(0x0088)
+#define DISPC_GFX_SIZE			DISPC_REG(0x008C)
+#define DISPC_GFX_ATTRIBUTES		DISPC_REG(0x00A0)
+#define DISPC_GFX_FIFO_THRESHOLD	DISPC_REG(0x00A4)
+#define DISPC_GFX_FIFO_SIZE_STATUS	DISPC_REG(0x00A8)
+#define DISPC_GFX_ROW_INC		DISPC_REG(0x00AC)
+#define DISPC_GFX_PIXEL_INC		DISPC_REG(0x00B0)
+#define DISPC_GFX_WINDOW_SKIP		DISPC_REG(0x00B4)
+#define DISPC_GFX_TABLE_BA		DISPC_REG(0x00B8)
+
+#define DISPC_DATA_CYCLE1		DISPC_REG(0x01D4)
+#define DISPC_DATA_CYCLE2		DISPC_REG(0x01D8)
+#define DISPC_DATA_CYCLE3		DISPC_REG(0x01DC)
+
+#define DISPC_CPR_COEF_R		DISPC_REG(0x0220)
+#define DISPC_CPR_COEF_G		DISPC_REG(0x0224)
+#define DISPC_CPR_COEF_B		DISPC_REG(0x0228)
+
+#define DISPC_GFX_PRELOAD		DISPC_REG(0x022C)
+
+/* DISPC Video plane, n = 0 for VID1 and n = 1 for VID2 */
+#define DISPC_VID_REG(n, idx)		DISPC_REG(0x00BC + (n)*0x90 + idx)
+
+#define DISPC_VID_BA0(n)		DISPC_VID_REG(n, 0x0000)
+#define DISPC_VID_BA1(n)		DISPC_VID_REG(n, 0x0004)
+#define DISPC_VID_POSITION(n)		DISPC_VID_REG(n, 0x0008)
+#define DISPC_VID_SIZE(n)		DISPC_VID_REG(n, 0x000C)
+#define DISPC_VID_ATTRIBUTES(n)		DISPC_VID_REG(n, 0x0010)
+#define DISPC_VID_FIFO_THRESHOLD(n)	DISPC_VID_REG(n, 0x0014)
+#define DISPC_VID_FIFO_SIZE_STATUS(n)	DISPC_VID_REG(n, 0x0018)
+#define DISPC_VID_ROW_INC(n)		DISPC_VID_REG(n, 0x001C)
+#define DISPC_VID_PIXEL_INC(n)		DISPC_VID_REG(n, 0x0020)
+#define DISPC_VID_FIR(n)		DISPC_VID_REG(n, 0x0024)
+#define DISPC_VID_PICTURE_SIZE(n)	DISPC_VID_REG(n, 0x0028)
+#define DISPC_VID_ACCU0(n)		DISPC_VID_REG(n, 0x002C)
+#define DISPC_VID_ACCU1(n)		DISPC_VID_REG(n, 0x0030)
+
+/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
+#define DISPC_VID_FIR_COEF_H(n, i)	DISPC_REG(0x00F0 + (n)*0x90 + (i)*0x8)
+/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
+#define DISPC_VID_FIR_COEF_HV(n, i)	DISPC_REG(0x00F4 + (n)*0x90 + (i)*0x8)
+/* coef index i = {0, 1, 2, 3, 4} */
+#define DISPC_VID_CONV_COEF(n, i)	DISPC_REG(0x0130 + (n)*0x90 + (i)*0x4)
+/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
+#define DISPC_VID_FIR_COEF_V(n, i)	DISPC_REG(0x01E0 + (n)*0x20 + (i)*0x4)
+
+#define DISPC_VID_PRELOAD(n)		DISPC_REG(0x230 + (n)*0x04)
+
+
+#define DISPC_IRQ_MASK_ERROR            (DISPC_IRQ_GFX_FIFO_UNDERFLOW | \
+					 DISPC_IRQ_OCP_ERR | \
+					 DISPC_IRQ_VID1_FIFO_UNDERFLOW | \
+					 DISPC_IRQ_VID2_FIFO_UNDERFLOW | \
+					 DISPC_IRQ_SYNC_LOST | \
+					 DISPC_IRQ_SYNC_LOST_DIGIT)
+
+#define DISPC_MAX_NR_ISRS		8
+
+struct omap_dispc_isr_data {
+	omap_dispc_isr_t	isr;
+	void			*arg;
+	u32			mask;
+};
+
+#define REG_GET(idx, start, end) \
+	FLD_GET(dispc_read_reg(idx), start, end)
+
+#define REG_FLD_MOD(idx, val, start, end)				\
+	dispc_write_reg(idx, FLD_MOD(dispc_read_reg(idx), val, start, end))
+
+static const struct dispc_reg dispc_reg_att[] = { DISPC_GFX_ATTRIBUTES,
+	DISPC_VID_ATTRIBUTES(0),
+	DISPC_VID_ATTRIBUTES(1) };
+
+static struct {
+	void __iomem    *base;
+
+	struct clk	*dpll4_m4_ck;
+
+	unsigned long	cache_req_pck;
+	unsigned long	cache_prate;
+	struct dispc_clock_info cache_cinfo;
+
+	u32	fifo_size[3];
+
+	spinlock_t irq_lock;
+	u32 irq_error_mask;
+	struct omap_dispc_isr_data registered_isr[DISPC_MAX_NR_ISRS];
+	u32 error_irqs;
+	struct work_struct error_work;
+
+	u32		ctx[DISPC_SZ_REGS / sizeof(u32)];
+} dispc;
+
+static void _omap_dispc_set_irqs(void);
+
+static inline void dispc_write_reg(const struct dispc_reg idx, u32 val)
+{
+	__raw_writel(val, dispc.base + idx.idx);
+}
+
+static inline u32 dispc_read_reg(const struct dispc_reg idx)
+{
+	return __raw_readl(dispc.base + idx.idx);
+}
+
+#define SR(reg) \
+	dispc.ctx[(DISPC_##reg).idx / sizeof(u32)] = dispc_read_reg(DISPC_##reg)
+#define RR(reg) \
+	dispc_write_reg(DISPC_##reg, dispc.ctx[(DISPC_##reg).idx / sizeof(u32)])
+
+void dispc_save_context(void)
+{
+	if (cpu_is_omap24xx())
+		return;
+
+	SR(SYSCONFIG);
+	SR(IRQENABLE);
+	SR(CONTROL);
+	SR(CONFIG);
+	SR(DEFAULT_COLOR0);
+	SR(DEFAULT_COLOR1);
+	SR(TRANS_COLOR0);
+	SR(TRANS_COLOR1);
+	SR(LINE_NUMBER);
+	SR(TIMING_H);
+	SR(TIMING_V);
+	SR(POL_FREQ);
+	SR(DIVISOR);
+	SR(GLOBAL_ALPHA);
+	SR(SIZE_DIG);
+	SR(SIZE_LCD);
+
+	SR(GFX_BA0);
+	SR(GFX_BA1);
+	SR(GFX_POSITION);
+	SR(GFX_SIZE);
+	SR(GFX_ATTRIBUTES);
+	SR(GFX_FIFO_THRESHOLD);
+	SR(GFX_ROW_INC);
+	SR(GFX_PIXEL_INC);
+	SR(GFX_WINDOW_SKIP);
+	SR(GFX_TABLE_BA);
+
+	SR(DATA_CYCLE1);
+	SR(DATA_CYCLE2);
+	SR(DATA_CYCLE3);
+
+	SR(CPR_COEF_R);
+	SR(CPR_COEF_G);
+	SR(CPR_COEF_B);
+
+	SR(GFX_PRELOAD);
+
+	/* VID1 */
+	SR(VID_BA0(0));
+	SR(VID_BA1(0));
+	SR(VID_POSITION(0));
+	SR(VID_SIZE(0));
+	SR(VID_ATTRIBUTES(0));
+	SR(VID_FIFO_THRESHOLD(0));
+	SR(VID_ROW_INC(0));
+	SR(VID_PIXEL_INC(0));
+	SR(VID_FIR(0));
+	SR(VID_PICTURE_SIZE(0));
+	SR(VID_ACCU0(0));
+	SR(VID_ACCU1(0));
+
+	SR(VID_FIR_COEF_H(0, 0));
+	SR(VID_FIR_COEF_H(0, 1));
+	SR(VID_FIR_COEF_H(0, 2));
+	SR(VID_FIR_COEF_H(0, 3));
+	SR(VID_FIR_COEF_H(0, 4));
+	SR(VID_FIR_COEF_H(0, 5));
+	SR(VID_FIR_COEF_H(0, 6));
+	SR(VID_FIR_COEF_H(0, 7));
+
+	SR(VID_FIR_COEF_HV(0, 0));
+	SR(VID_FIR_COEF_HV(0, 1));
+	SR(VID_FIR_COEF_HV(0, 2));
+	SR(VID_FIR_COEF_HV(0, 3));
+	SR(VID_FIR_COEF_HV(0, 4));
+	SR(VID_FIR_COEF_HV(0, 5));
+	SR(VID_FIR_COEF_HV(0, 6));
+	SR(VID_FIR_COEF_HV(0, 7));
+
+	SR(VID_CONV_COEF(0, 0));
+	SR(VID_CONV_COEF(0, 1));
+	SR(VID_CONV_COEF(0, 2));
+	SR(VID_CONV_COEF(0, 3));
+	SR(VID_CONV_COEF(0, 4));
+
+	SR(VID_FIR_COEF_V(0, 0));
+	SR(VID_FIR_COEF_V(0, 1));
+	SR(VID_FIR_COEF_V(0, 2));
+	SR(VID_FIR_COEF_V(0, 3));
+	SR(VID_FIR_COEF_V(0, 4));
+	SR(VID_FIR_COEF_V(0, 5));
+	SR(VID_FIR_COEF_V(0, 6));
+	SR(VID_FIR_COEF_V(0, 7));
+
+	SR(VID_PRELOAD(0));
+
+	/* VID2 */
+	SR(VID_BA0(1));
+	SR(VID_BA1(1));
+	SR(VID_POSITION(1));
+	SR(VID_SIZE(1));
+	SR(VID_ATTRIBUTES(1));
+	SR(VID_FIFO_THRESHOLD(1));
+	SR(VID_ROW_INC(1));
+	SR(VID_PIXEL_INC(1));
+	SR(VID_FIR(1));
+	SR(VID_PICTURE_SIZE(1));
+	SR(VID_ACCU0(1));
+	SR(VID_ACCU1(1));
+
+	SR(VID_FIR_COEF_H(1, 0));
+	SR(VID_FIR_COEF_H(1, 1));
+	SR(VID_FIR_COEF_H(1, 2));
+	SR(VID_FIR_COEF_H(1, 3));
+	SR(VID_FIR_COEF_H(1, 4));
+	SR(VID_FIR_COEF_H(1, 5));
+	SR(VID_FIR_COEF_H(1, 6));
+	SR(VID_FIR_COEF_H(1, 7));
+
+	SR(VID_FIR_COEF_HV(1, 0));
+	SR(VID_FIR_COEF_HV(1, 1));
+	SR(VID_FIR_COEF_HV(1, 2));
+	SR(VID_FIR_COEF_HV(1, 3));
+	SR(VID_FIR_COEF_HV(1, 4));
+	SR(VID_FIR_COEF_HV(1, 5));
+	SR(VID_FIR_COEF_HV(1, 6));
+	SR(VID_FIR_COEF_HV(1, 7));
+
+	SR(VID_CONV_COEF(1, 0));
+	SR(VID_CONV_COEF(1, 1));
+	SR(VID_CONV_COEF(1, 2));
+	SR(VID_CONV_COEF(1, 3));
+	SR(VID_CONV_COEF(1, 4));
+
+	SR(VID_FIR_COEF_V(1, 0));
+	SR(VID_FIR_COEF_V(1, 1));
+	SR(VID_FIR_COEF_V(1, 2));
+	SR(VID_FIR_COEF_V(1, 3));
+	SR(VID_FIR_COEF_V(1, 4));
+	SR(VID_FIR_COEF_V(1, 5));
+	SR(VID_FIR_COEF_V(1, 6));
+	SR(VID_FIR_COEF_V(1, 7));
+
+	SR(VID_PRELOAD(1));
+}
+
+void dispc_restore_context(void)
+{
+	RR(SYSCONFIG);
+	RR(IRQENABLE);
+	/*RR(CONTROL);*/
+	RR(CONFIG);
+	RR(DEFAULT_COLOR0);
+	RR(DEFAULT_COLOR1);
+	RR(TRANS_COLOR0);
+	RR(TRANS_COLOR1);
+	RR(LINE_NUMBER);
+	RR(TIMING_H);
+	RR(TIMING_V);
+	RR(POL_FREQ);
+	RR(DIVISOR);
+	RR(GLOBAL_ALPHA);
+	RR(SIZE_DIG);
+	RR(SIZE_LCD);
+
+	RR(GFX_BA0);
+	RR(GFX_BA1);
+	RR(GFX_POSITION);
+	RR(GFX_SIZE);
+	RR(GFX_ATTRIBUTES);
+	RR(GFX_FIFO_THRESHOLD);
+	RR(GFX_ROW_INC);
+	RR(GFX_PIXEL_INC);
+	RR(GFX_WINDOW_SKIP);
+	RR(GFX_TABLE_BA);
+
+	RR(DATA_CYCLE1);
+	RR(DATA_CYCLE2);
+	RR(DATA_CYCLE3);
+
+	RR(CPR_COEF_R);
+	RR(CPR_COEF_G);
+	RR(CPR_COEF_B);
+
+	RR(GFX_PRELOAD);
+
+	/* VID1 */
+	RR(VID_BA0(0));
+	RR(VID_BA1(0));
+	RR(VID_POSITION(0));
+	RR(VID_SIZE(0));
+	RR(VID_ATTRIBUTES(0));
+	RR(VID_FIFO_THRESHOLD(0));
+	RR(VID_ROW_INC(0));
+	RR(VID_PIXEL_INC(0));
+	RR(VID_FIR(0));
+	RR(VID_PICTURE_SIZE(0));
+	RR(VID_ACCU0(0));
+	RR(VID_ACCU1(0));
+
+	RR(VID_FIR_COEF_H(0, 0));
+	RR(VID_FIR_COEF_H(0, 1));
+	RR(VID_FIR_COEF_H(0, 2));
+	RR(VID_FIR_COEF_H(0, 3));
+	RR(VID_FIR_COEF_H(0, 4));
+	RR(VID_FIR_COEF_H(0, 5));
+	RR(VID_FIR_COEF_H(0, 6));
+	RR(VID_FIR_COEF_H(0, 7));
+
+	RR(VID_FIR_COEF_HV(0, 0));
+	RR(VID_FIR_COEF_HV(0, 1));
+	RR(VID_FIR_COEF_HV(0, 2));
+	RR(VID_FIR_COEF_HV(0, 3));
+	RR(VID_FIR_COEF_HV(0, 4));
+	RR(VID_FIR_COEF_HV(0, 5));
+	RR(VID_FIR_COEF_HV(0, 6));
+	RR(VID_FIR_COEF_HV(0, 7));
+
+	RR(VID_CONV_COEF(0, 0));
+	RR(VID_CONV_COEF(0, 1));
+	RR(VID_CONV_COEF(0, 2));
+	RR(VID_CONV_COEF(0, 3));
+	RR(VID_CONV_COEF(0, 4));
+
+	RR(VID_FIR_COEF_V(0, 0));
+	RR(VID_FIR_COEF_V(0, 1));
+	RR(VID_FIR_COEF_V(0, 2));
+	RR(VID_FIR_COEF_V(0, 3));
+	RR(VID_FIR_COEF_V(0, 4));
+	RR(VID_FIR_COEF_V(0, 5));
+	RR(VID_FIR_COEF_V(0, 6));
+	RR(VID_FIR_COEF_V(0, 7));
+
+	RR(VID_PRELOAD(0));
+
+	/* VID2 */
+	RR(VID_BA0(1));
+	RR(VID_BA1(1));
+	RR(VID_POSITION(1));
+	RR(VID_SIZE(1));
+	RR(VID_ATTRIBUTES(1));
+	RR(VID_FIFO_THRESHOLD(1));
+	RR(VID_ROW_INC(1));
+	RR(VID_PIXEL_INC(1));
+	RR(VID_FIR(1));
+	RR(VID_PICTURE_SIZE(1));
+	RR(VID_ACCU0(1));
+	RR(VID_ACCU1(1));
+
+	RR(VID_FIR_COEF_H(1, 0));
+	RR(VID_FIR_COEF_H(1, 1));
+	RR(VID_FIR_COEF_H(1, 2));
+	RR(VID_FIR_COEF_H(1, 3));
+	RR(VID_FIR_COEF_H(1, 4));
+	RR(VID_FIR_COEF_H(1, 5));
+	RR(VID_FIR_COEF_H(1, 6));
+	RR(VID_FIR_COEF_H(1, 7));
+
+	RR(VID_FIR_COEF_HV(1, 0));
+	RR(VID_FIR_COEF_HV(1, 1));
+	RR(VID_FIR_COEF_HV(1, 2));
+	RR(VID_FIR_COEF_HV(1, 3));
+	RR(VID_FIR_COEF_HV(1, 4));
+	RR(VID_FIR_COEF_HV(1, 5));
+	RR(VID_FIR_COEF_HV(1, 6));
+	RR(VID_FIR_COEF_HV(1, 7));
+
+	RR(VID_CONV_COEF(1, 0));
+	RR(VID_CONV_COEF(1, 1));
+	RR(VID_CONV_COEF(1, 2));
+	RR(VID_CONV_COEF(1, 3));
+	RR(VID_CONV_COEF(1, 4));
+
+	RR(VID_FIR_COEF_V(1, 0));
+	RR(VID_FIR_COEF_V(1, 1));
+	RR(VID_FIR_COEF_V(1, 2));
+	RR(VID_FIR_COEF_V(1, 3));
+	RR(VID_FIR_COEF_V(1, 4));
+	RR(VID_FIR_COEF_V(1, 5));
+	RR(VID_FIR_COEF_V(1, 6));
+	RR(VID_FIR_COEF_V(1, 7));
+
+	RR(VID_PRELOAD(1));
+
+	/* enable last, because LCD & DIGIT enable are here */
+	RR(CONTROL);
+}
+
+#undef SR
+#undef RR
+
+static inline void enable_clocks(bool enable)
+{
+	if (enable)
+		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	else
+		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+}
+
+bool dispc_go_busy(enum omap_channel channel)
+{
+	int bit;
+
+	if (channel == OMAP_DSS_CHANNEL_LCD)
+		bit = 5; /* GOLCD */
+	else
+		bit = 6; /* GODIGIT */
+
+	return REG_GET(DISPC_CONTROL, bit, bit) == 1;
+}
+
+void dispc_go(enum omap_channel channel)
+{
+	int bit;
+
+	enable_clocks(1);
+
+	if (channel == OMAP_DSS_CHANNEL_LCD)
+		bit = 0; /* LCDENABLE */
+	else
+		bit = 1; /* DIGITALENABLE */
+
+	/* if the channel is not enabled, we don't need GO */
+	if (REG_GET(DISPC_CONTROL, bit, bit) == 0)
+		goto end;
+
+	if (channel == OMAP_DSS_CHANNEL_LCD)
+		bit = 5; /* GOLCD */
+	else
+		bit = 6; /* GODIGIT */
+
+	if (REG_GET(DISPC_CONTROL, bit, bit) == 1) {
+		DSSERR("GO bit not down for channel %d\n", channel);
+		goto end;
+	}
+
+	DSSDBG("GO %s\n", channel == OMAP_DSS_CHANNEL_LCD ? "LCD" : "DIGIT");
+
+	REG_FLD_MOD(DISPC_CONTROL, 1, bit, bit);
+end:
+	enable_clocks(0);
+}
+
+static void _dispc_write_firh_reg(enum omap_plane plane, int reg, u32 value)
+{
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	dispc_write_reg(DISPC_VID_FIR_COEF_H(plane-1, reg), value);
+}
+
+static void _dispc_write_firhv_reg(enum omap_plane plane, int reg, u32 value)
+{
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	dispc_write_reg(DISPC_VID_FIR_COEF_HV(plane-1, reg), value);
+}
+
+static void _dispc_write_firv_reg(enum omap_plane plane, int reg, u32 value)
+{
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	dispc_write_reg(DISPC_VID_FIR_COEF_V(plane-1, reg), value);
+}
+
+static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
+		int vscaleup, int five_taps)
+{
+	/* Coefficients for horizontal up-sampling */
+	static const u32 coef_hup[8] = {
+		0x00800000,
+		0x0D7CF800,
+		0x1E70F5FF,
+		0x335FF5FE,
+		0xF74949F7,
+		0xF55F33FB,
+		0xF5701EFE,
+		0xF87C0DFF,
+	};
+
+	/* Coefficients for horizontal down-sampling */
+	static const u32 coef_hdown[8] = {
+		0x24382400,
+		0x28371FFE,
+		0x2C361BFB,
+		0x303516F9,
+		0x11343311,
+		0x1635300C,
+		0x1B362C08,
+		0x1F372804,
+	};
+
+	/* Coefficients for horizontal and vertical up-sampling */
+	static const u32 coef_hvup[2][8] = {
+		{
+		0x00800000,
+		0x037B02FF,
+		0x0C6F05FE,
+		0x205907FB,
+		0x00404000,
+		0x075920FE,
+		0x056F0CFF,
+		0x027B0300,
+		},
+		{
+		0x00800000,
+		0x0D7CF8FF,
+		0x1E70F5FE,
+		0x335FF5FB,
+		0xF7404000,
+		0xF55F33FE,
+		0xF5701EFF,
+		0xF87C0D00,
+		},
+	};
+
+	/* Coefficients for horizontal and vertical down-sampling */
+	static const u32 coef_hvdown[2][8] = {
+		{
+		0x24382400,
+		0x28391F04,
+		0x2D381B08,
+		0x3237170C,
+		0x123737F7,
+		0x173732F9,
+		0x1B382DFB,
+		0x1F3928FE,
+		},
+		{
+		0x24382400,
+		0x28371F04,
+		0x2C361B08,
+		0x3035160C,
+		0x113433F7,
+		0x163530F9,
+		0x1B362CFB,
+		0x1F3728FE,
+		},
+	};
+
+	/* Coefficients for vertical up-sampling */
+	static const u32 coef_vup[8] = {
+		0x00000000,
+		0x0000FF00,
+		0x0000FEFF,
+		0x0000FBFE,
+		0x000000F7,
+		0x0000FEFB,
+		0x0000FFFE,
+		0x000000FF,
+	};
+
+
+	/* Coefficients for vertical down-sampling */
+	static const u32 coef_vdown[8] = {
+		0x00000000,
+		0x000004FE,
+		0x000008FB,
+		0x00000CF9,
+		0x0000F711,
+		0x0000F90C,
+		0x0000FB08,
+		0x0000FE04,
+	};
+
+	const u32 *h_coef;
+	const u32 *hv_coef;
+	const u32 *hv_coef_mod;
+	const u32 *v_coef;
+	int i;
+
+	if (hscaleup)
+		h_coef = coef_hup;
+	else
+		h_coef = coef_hdown;
+
+	if (vscaleup) {
+		hv_coef = coef_hvup[five_taps];
+		v_coef = coef_vup;
+
+		if (hscaleup)
+			hv_coef_mod = NULL;
+		else
+			hv_coef_mod = coef_hvdown[five_taps];
+	} else {
+		hv_coef = coef_hvdown[five_taps];
+		v_coef = coef_vdown;
+
+		if (hscaleup)
+			hv_coef_mod = coef_hvup[five_taps];
+		else
+			hv_coef_mod = NULL;
+	}
+
+	for (i = 0; i < 8; i++) {
+		u32 h, hv;
+
+		h = h_coef[i];
+
+		hv = hv_coef[i];
+
+		if (hv_coef_mod) {
+			hv &= 0xffffff00;
+			hv |= (hv_coef_mod[i] & 0xff);
+		}
+
+		_dispc_write_firh_reg(plane, i, h);
+		_dispc_write_firhv_reg(plane, i, hv);
+	}
+
+	if (!five_taps)
+		return;
+
+	for (i = 0; i < 8; i++) {
+		u32 v;
+		v = v_coef[i];
+		_dispc_write_firv_reg(plane, i, v);
+	}
+}
+
+static void _dispc_setup_color_conv_coef(void)
+{
+	const struct color_conv_coef {
+		int  ry,  rcr,  rcb,   gy,  gcr,  gcb,   by,  bcr,  bcb;
+		int  full_range;
+	}  ctbl_bt601_5 = {
+		298,  409,    0,  298, -208, -100,  298,    0,  517, 0,
+	};
+
+	const struct color_conv_coef *ct;
+
+#define CVAL(x, y) (FLD_VAL(x, 26, 16) | FLD_VAL(y, 10, 0))
+
+	ct = &ctbl_bt601_5;
+
+	dispc_write_reg(DISPC_VID_CONV_COEF(0, 0), CVAL(ct->rcr, ct->ry));
+	dispc_write_reg(DISPC_VID_CONV_COEF(0, 1), CVAL(ct->gy,	 ct->rcb));
+	dispc_write_reg(DISPC_VID_CONV_COEF(0, 2), CVAL(ct->gcb, ct->gcr));
+	dispc_write_reg(DISPC_VID_CONV_COEF(0, 3), CVAL(ct->bcr, ct->by));
+	dispc_write_reg(DISPC_VID_CONV_COEF(0, 4), CVAL(0,       ct->bcb));
+
+	dispc_write_reg(DISPC_VID_CONV_COEF(1, 0), CVAL(ct->rcr, ct->ry));
+	dispc_write_reg(DISPC_VID_CONV_COEF(1, 1), CVAL(ct->gy,	 ct->rcb));
+	dispc_write_reg(DISPC_VID_CONV_COEF(1, 2), CVAL(ct->gcb, ct->gcr));
+	dispc_write_reg(DISPC_VID_CONV_COEF(1, 3), CVAL(ct->bcr, ct->by));
+	dispc_write_reg(DISPC_VID_CONV_COEF(1, 4), CVAL(0,       ct->bcb));
+
+#undef CVAL
+
+	REG_FLD_MOD(DISPC_VID_ATTRIBUTES(0), ct->full_range, 11, 11);
+	REG_FLD_MOD(DISPC_VID_ATTRIBUTES(1), ct->full_range, 11, 11);
+}
+
+
+static void _dispc_set_plane_ba0(enum omap_plane plane, u32 paddr)
+{
+	const struct dispc_reg ba0_reg[] = { DISPC_GFX_BA0,
+		DISPC_VID_BA0(0),
+		DISPC_VID_BA0(1) };
+
+	dispc_write_reg(ba0_reg[plane], paddr);
+}
+
+static void _dispc_set_plane_ba1(enum omap_plane plane, u32 paddr)
+{
+	const struct dispc_reg ba1_reg[] = { DISPC_GFX_BA1,
+				      DISPC_VID_BA1(0),
+				      DISPC_VID_BA1(1) };
+
+	dispc_write_reg(ba1_reg[plane], paddr);
+}
+
+static void _dispc_set_plane_pos(enum omap_plane plane, int x, int y)
+{
+	const struct dispc_reg pos_reg[] = { DISPC_GFX_POSITION,
+				      DISPC_VID_POSITION(0),
+				      DISPC_VID_POSITION(1) };
+
+	u32 val = FLD_VAL(y, 26, 16) | FLD_VAL(x, 10, 0);
+	dispc_write_reg(pos_reg[plane], val);
+}
+
+static void _dispc_set_pic_size(enum omap_plane plane, int width, int height)
+{
+	const struct dispc_reg siz_reg[] = { DISPC_GFX_SIZE,
+				      DISPC_VID_PICTURE_SIZE(0),
+				      DISPC_VID_PICTURE_SIZE(1) };
+	u32 val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
+	dispc_write_reg(siz_reg[plane], val);
+}
+
+static void _dispc_set_vid_size(enum omap_plane plane, int width, int height)
+{
+	u32 val;
+	const struct dispc_reg vsi_reg[] = { DISPC_VID_SIZE(0),
+				      DISPC_VID_SIZE(1) };
+
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
+	dispc_write_reg(vsi_reg[plane-1], val);
+}
+
+static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
+{
+
+	BUG_ON(plane == OMAP_DSS_VIDEO1);
+
+	if (plane == OMAP_DSS_GFX)
+		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, 7, 0);
+	else if (plane == OMAP_DSS_VIDEO2)
+		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, 23, 16);
+}
+
+static void _dispc_set_pix_inc(enum omap_plane plane, s32 inc)
+{
+	const struct dispc_reg ri_reg[] = { DISPC_GFX_PIXEL_INC,
+				     DISPC_VID_PIXEL_INC(0),
+				     DISPC_VID_PIXEL_INC(1) };
+
+	dispc_write_reg(ri_reg[plane], inc);
+}
+
+static void _dispc_set_row_inc(enum omap_plane plane, s32 inc)
+{
+	const struct dispc_reg ri_reg[] = { DISPC_GFX_ROW_INC,
+				     DISPC_VID_ROW_INC(0),
+				     DISPC_VID_ROW_INC(1) };
+
+	dispc_write_reg(ri_reg[plane], inc);
+}
+
+static void _dispc_set_color_mode(enum omap_plane plane,
+		enum omap_color_mode color_mode)
+{
+	u32 m = 0;
+
+	switch (color_mode) {
+	case OMAP_DSS_COLOR_CLUT1:
+		m = 0x0; break;
+	case OMAP_DSS_COLOR_CLUT2:
+		m = 0x1; break;
+	case OMAP_DSS_COLOR_CLUT4:
+		m = 0x2; break;
+	case OMAP_DSS_COLOR_CLUT8:
+		m = 0x3; break;
+	case OMAP_DSS_COLOR_RGB12U:
+		m = 0x4; break;
+	case OMAP_DSS_COLOR_ARGB16:
+		m = 0x5; break;
+	case OMAP_DSS_COLOR_RGB16:
+		m = 0x6; break;
+	case OMAP_DSS_COLOR_RGB24U:
+		m = 0x8; break;
+	case OMAP_DSS_COLOR_RGB24P:
+		m = 0x9; break;
+	case OMAP_DSS_COLOR_YUV2:
+		m = 0xa; break;
+	case OMAP_DSS_COLOR_UYVY:
+		m = 0xb; break;
+	case OMAP_DSS_COLOR_ARGB32:
+		m = 0xc; break;
+	case OMAP_DSS_COLOR_RGBA32:
+		m = 0xd; break;
+	case OMAP_DSS_COLOR_RGBX32:
+		m = 0xe; break;
+	default:
+		BUG(); break;
+	}
+
+	REG_FLD_MOD(dispc_reg_att[plane], m, 4, 1);
+}
+
+static void _dispc_set_channel_out(enum omap_plane plane,
+		enum omap_channel channel)
+{
+	int shift;
+	u32 val;
+
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		shift = 8;
+		break;
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		shift = 16;
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	val = dispc_read_reg(dispc_reg_att[plane]);
+	val = FLD_MOD(val, channel, shift, shift);
+	dispc_write_reg(dispc_reg_att[plane], val);
+}
+
+void dispc_set_burst_size(enum omap_plane plane,
+		enum omap_burst_size burst_size)
+{
+	int shift;
+	u32 val;
+
+	enable_clocks(1);
+
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		shift = 6;
+		break;
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		shift = 14;
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	val = dispc_read_reg(dispc_reg_att[plane]);
+	val = FLD_MOD(val, burst_size, shift+1, shift);
+	dispc_write_reg(dispc_reg_att[plane], val);
+
+	enable_clocks(0);
+}
+
+static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
+{
+	u32 val;
+
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	val = dispc_read_reg(dispc_reg_att[plane]);
+	val = FLD_MOD(val, enable, 9, 9);
+	dispc_write_reg(dispc_reg_att[plane], val);
+}
+
+void dispc_enable_replication(enum omap_plane plane, bool enable)
+{
+	int bit;
+
+	if (plane == OMAP_DSS_GFX)
+		bit = 5;
+	else
+		bit = 10;
+
+	enable_clocks(1);
+	REG_FLD_MOD(dispc_reg_att[plane], enable, bit, bit);
+	enable_clocks(0);
+}
+
+void dispc_set_lcd_size(u16 width, u16 height)
+{
+	u32 val;
+	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
+	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
+	enable_clocks(1);
+	dispc_write_reg(DISPC_SIZE_LCD, val);
+	enable_clocks(0);
+}
+
+void dispc_set_digit_size(u16 width, u16 height)
+{
+	u32 val;
+	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
+	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
+	enable_clocks(1);
+	dispc_write_reg(DISPC_SIZE_DIG, val);
+	enable_clocks(0);
+}
+
+static void dispc_read_plane_fifo_sizes(void)
+{
+	const struct dispc_reg fsz_reg[] = { DISPC_GFX_FIFO_SIZE_STATUS,
+				      DISPC_VID_FIFO_SIZE_STATUS(0),
+				      DISPC_VID_FIFO_SIZE_STATUS(1) };
+	u32 size;
+	int plane;
+
+	enable_clocks(1);
+
+	for (plane = 0; plane < ARRAY_SIZE(dispc.fifo_size); ++plane) {
+		if (cpu_is_omap24xx())
+			size = FLD_GET(dispc_read_reg(fsz_reg[plane]), 8, 0);
+		else if (cpu_is_omap34xx())
+			size = FLD_GET(dispc_read_reg(fsz_reg[plane]), 10, 0);
+		else
+			BUG();
+
+		dispc.fifo_size[plane] = size;
+	}
+
+	enable_clocks(0);
+}
+
+u32 dispc_get_plane_fifo_size(enum omap_plane plane)
+{
+	return dispc.fifo_size[plane];
+}
+
+void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high)
+{
+	const struct dispc_reg ftrs_reg[] = { DISPC_GFX_FIFO_THRESHOLD,
+				       DISPC_VID_FIFO_THRESHOLD(0),
+				       DISPC_VID_FIFO_THRESHOLD(1) };
+	enable_clocks(1);
+
+	DSSDBG("fifo(%d) low/high old %u/%u, new %u/%u\n",
+			plane,
+			REG_GET(ftrs_reg[plane], 11, 0),
+			REG_GET(ftrs_reg[plane], 27, 16),
+			low, high);
+
+	if (cpu_is_omap24xx())
+		dispc_write_reg(ftrs_reg[plane],
+				FLD_VAL(high, 24, 16) | FLD_VAL(low, 8, 0));
+	else
+		dispc_write_reg(ftrs_reg[plane],
+				FLD_VAL(high, 27, 16) | FLD_VAL(low, 11, 0));
+
+	enable_clocks(0);
+}
+
+void dispc_enable_fifomerge(bool enable)
+{
+	enable_clocks(1);
+
+	DSSDBG("FIFO merge %s\n", enable ? "enabled" : "disabled");
+	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 14, 14);
+
+	enable_clocks(0);
+}
+
+static void _dispc_set_fir(enum omap_plane plane, int hinc, int vinc)
+{
+	u32 val;
+	const struct dispc_reg fir_reg[] = { DISPC_VID_FIR(0),
+				      DISPC_VID_FIR(1) };
+
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	if (cpu_is_omap24xx())
+		val = FLD_VAL(vinc, 27, 16) | FLD_VAL(hinc, 11, 0);
+	else
+		val = FLD_VAL(vinc, 28, 16) | FLD_VAL(hinc, 12, 0);
+	dispc_write_reg(fir_reg[plane-1], val);
+}
+
+static void _dispc_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
+{
+	u32 val;
+	const struct dispc_reg ac0_reg[] = { DISPC_VID_ACCU0(0),
+				      DISPC_VID_ACCU0(1) };
+
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	val = FLD_VAL(vaccu, 25, 16) | FLD_VAL(haccu, 9, 0);
+	dispc_write_reg(ac0_reg[plane-1], val);
+}
+
+static void _dispc_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
+{
+	u32 val;
+	const struct dispc_reg ac1_reg[] = { DISPC_VID_ACCU1(0),
+				      DISPC_VID_ACCU1(1) };
+
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	val = FLD_VAL(vaccu, 25, 16) | FLD_VAL(haccu, 9, 0);
+	dispc_write_reg(ac1_reg[plane-1], val);
+}
+
+
+static void _dispc_set_scaling(enum omap_plane plane,
+		u16 orig_width, u16 orig_height,
+		u16 out_width, u16 out_height,
+		bool ilace, bool five_taps,
+		bool fieldmode)
+{
+	int fir_hinc;
+	int fir_vinc;
+	int hscaleup, vscaleup;
+	int accu0 = 0;
+	int accu1 = 0;
+	u32 l;
+
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	hscaleup = orig_width <= out_width;
+	vscaleup = orig_height <= out_height;
+
+	_dispc_set_scale_coef(plane, hscaleup, vscaleup, five_taps);
+
+	if (!orig_width || orig_width == out_width)
+		fir_hinc = 0;
+	else
+		fir_hinc = 1024 * orig_width / out_width;
+
+	if (!orig_height || orig_height == out_height)
+		fir_vinc = 0;
+	else
+		fir_vinc = 1024 * orig_height / out_height;
+
+	_dispc_set_fir(plane, fir_hinc, fir_vinc);
+
+	l = dispc_read_reg(dispc_reg_att[plane]);
+	l &= ~((0x0f << 5) | (0x3 << 21));
+
+	l |= fir_hinc ? (1 << 5) : 0;
+	l |= fir_vinc ? (1 << 6) : 0;
+
+	l |= hscaleup ? 0 : (1 << 7);
+	l |= vscaleup ? 0 : (1 << 8);
+
+	l |= five_taps ? (1 << 21) : 0;
+	l |= five_taps ? (1 << 22) : 0;
+
+	dispc_write_reg(dispc_reg_att[plane], l);
+
+	/*
+	 * field 0 = even field = bottom field
+	 * field 1 = odd field = top field
+	 */
+	if (ilace && !fieldmode) {
+		accu1 = 0;
+		accu0 = (fir_vinc / 2) & 0x3ff;
+		if (accu0 >= 1024/2) {
+			accu1 = 1024/2;
+			accu0 -= accu1;
+		}
+	}
+
+	_dispc_set_vid_accu0(plane, 0, accu0);
+	_dispc_set_vid_accu1(plane, 0, accu1);
+}
+
+static void _dispc_set_rotation_attrs(enum omap_plane plane, u8 rotation,
+		bool mirroring, enum omap_color_mode color_mode)
+{
+	if (color_mode == OMAP_DSS_COLOR_YUV2 ||
+			color_mode == OMAP_DSS_COLOR_UYVY) {
+		int vidrot = 0;
+
+		if (mirroring) {
+			switch (rotation) {
+			case 0:
+				vidrot = 2;
+				break;
+			case 1:
+				vidrot = 1;
+				break;
+			case 2:
+				vidrot = 0;
+				break;
+			case 3:
+				vidrot = 3;
+				break;
+			}
+		} else {
+			switch (rotation) {
+			case 0:
+				vidrot = 0;
+				break;
+			case 1:
+				vidrot = 1;
+				break;
+			case 2:
+				vidrot = 2;
+				break;
+			case 3:
+				vidrot = 3;
+				break;
+			}
+		}
+
+		REG_FLD_MOD(dispc_reg_att[plane], vidrot, 13, 12);
+
+		if (rotation == 1 || rotation == 3)
+			REG_FLD_MOD(dispc_reg_att[plane], 0x1, 18, 18);
+		else
+			REG_FLD_MOD(dispc_reg_att[plane], 0x0, 18, 18);
+	} else {
+		REG_FLD_MOD(dispc_reg_att[plane], 0, 13, 12);
+		REG_FLD_MOD(dispc_reg_att[plane], 0, 18, 18);
+	}
+}
+
+static s32 pixinc(int pixels, u8 ps)
+{
+	if (pixels == 1)
+		return 1;
+	else if (pixels > 1)
+		return 1 + (pixels - 1) * ps;
+	else if (pixels < 0)
+		return 1 - (-pixels + 1) * ps;
+	else
+		BUG();
+}
+
+static void calc_vrfb_rotation_offset(u8 rotation, bool mirror,
+		u16 screen_width,
+		u16 width, u16 height,
+		enum omap_color_mode color_mode, bool fieldmode,
+		unsigned int field_offset,
+		unsigned *offset0, unsigned *offset1,
+		s32 *row_inc, s32 *pix_inc)
+{
+	u8 ps;
+
+	switch (color_mode) {
+	case OMAP_DSS_COLOR_RGB16:
+	case OMAP_DSS_COLOR_ARGB16:
+		ps = 2;
+		break;
+
+	case OMAP_DSS_COLOR_RGB24P:
+		ps = 3;
+		break;
+
+	case OMAP_DSS_COLOR_RGB24U:
+	case OMAP_DSS_COLOR_ARGB32:
+	case OMAP_DSS_COLOR_RGBA32:
+	case OMAP_DSS_COLOR_RGBX32:
+	case OMAP_DSS_COLOR_YUV2:
+	case OMAP_DSS_COLOR_UYVY:
+		ps = 4;
+		break;
+
+	default:
+		BUG();
+		return;
+	}
+
+	DSSDBG("calc_rot(%d): scrw %d, %dx%d\n", rotation, screen_width,
+			width, height);
+
+	/*
+	 * field 0 = even field = bottom field
+	 * field 1 = odd field = top field
+	 */
+	switch (rotation + mirror * 4) {
+	case 0:
+	case 2:
+		/*
+		 * If the pixel format is YUV or UYVY divide the width
+		 * of the image by 2 for 0 and 180 degree rotation.
+		 */
+		if (color_mode == OMAP_DSS_COLOR_YUV2 ||
+			color_mode == OMAP_DSS_COLOR_UYVY)
+			width = width >> 1;
+	case 1:
+	case 3:
+		*offset1 = 0;
+		if (field_offset)
+			*offset0 = field_offset * screen_width * ps;
+		else
+			*offset0 = 0;
+
+		*row_inc = pixinc(1 + (screen_width - width) +
+				(fieldmode ? screen_width : 0),
+				ps);
+		*pix_inc = pixinc(1, ps);
+		break;
+
+	case 4:
+	case 6:
+		/* If the pixel format is YUV or UYVY divide the width
+		 * of the image by 2  for 0 degree and 180 degree
+		 */
+		if (color_mode == OMAP_DSS_COLOR_YUV2 ||
+			color_mode == OMAP_DSS_COLOR_UYVY)
+			width = width >> 1;
+	case 5:
+	case 7:
+		*offset1 = 0;
+		if (field_offset)
+			*offset0 = field_offset * screen_width * ps;
+		else
+			*offset0 = 0;
+		*row_inc = pixinc(1 - (screen_width + width) -
+				(fieldmode ? screen_width : 0),
+				ps);
+		*pix_inc = pixinc(1, ps);
+		break;
+
+	default:
+		BUG();
+	}
+}
+
+static void calc_dma_rotation_offset(u8 rotation, bool mirror,
+		u16 screen_width,
+		u16 width, u16 height,
+		enum omap_color_mode color_mode, bool fieldmode,
+		unsigned int field_offset,
+		unsigned *offset0, unsigned *offset1,
+		s32 *row_inc, s32 *pix_inc)
+{
+	u8 ps;
+	u16 fbw, fbh;
+
+	switch (color_mode) {
+	case OMAP_DSS_COLOR_RGB16:
+	case OMAP_DSS_COLOR_ARGB16:
+		ps = 2;
+		break;
+
+	case OMAP_DSS_COLOR_RGB24P:
+		ps = 3;
+		break;
+
+	case OMAP_DSS_COLOR_RGB24U:
+	case OMAP_DSS_COLOR_ARGB32:
+	case OMAP_DSS_COLOR_RGBA32:
+	case OMAP_DSS_COLOR_RGBX32:
+		ps = 4;
+		break;
+
+	case OMAP_DSS_COLOR_YUV2:
+	case OMAP_DSS_COLOR_UYVY:
+		ps = 2;
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	DSSDBG("calc_rot(%d): scrw %d, %dx%d\n", rotation, screen_width,
+			width, height);
+
+	/* width & height are overlay sizes, convert to fb sizes */
+
+	if (rotation == 0 || rotation == 2) {
+		fbw = width;
+		fbh = height;
+	} else {
+		fbw = height;
+		fbh = width;
+	}
+
+	/*
+	 * field 0 = even field = bottom field
+	 * field 1 = odd field = top field
+	 */
+	switch (rotation + mirror * 4) {
+	case 0:
+		*offset1 = 0;
+		if (field_offset)
+			*offset0 = *offset1 + field_offset * screen_width * ps;
+		else
+			*offset0 = *offset1;
+		*row_inc = pixinc(1 + (screen_width - fbw) +
+				(fieldmode ? screen_width : 0),
+				ps);
+		*pix_inc = pixinc(1, ps);
+		break;
+	case 1:
+		*offset1 = screen_width * (fbh - 1) * ps;
+		if (field_offset)
+			*offset0 = *offset1 + field_offset * ps;
+		else
+			*offset0 = *offset1;
+		*row_inc = pixinc(screen_width * (fbh - 1) + 1 +
+				(fieldmode ? 1 : 0), ps);
+		*pix_inc = pixinc(-screen_width, ps);
+		break;
+	case 2:
+		*offset1 = (screen_width * (fbh - 1) + fbw - 1) * ps;
+		if (field_offset)
+			*offset0 = *offset1 - field_offset * screen_width * ps;
+		else
+			*offset0 = *offset1;
+		*row_inc = pixinc(-1 -
+				(screen_width - fbw) -
+				(fieldmode ? screen_width : 0),
+				ps);
+		*pix_inc = pixinc(-1, ps);
+		break;
+	case 3:
+		*offset1 = (fbw - 1) * ps;
+		if (field_offset)
+			*offset0 = *offset1 - field_offset * ps;
+		else
+			*offset0 = *offset1;
+		*row_inc = pixinc(-screen_width * (fbh - 1) - 1 -
+				(fieldmode ? 1 : 0), ps);
+		*pix_inc = pixinc(screen_width, ps);
+		break;
+
+	/* mirroring */
+	case 0 + 4:
+		*offset1 = (fbw - 1) * ps;
+		if (field_offset)
+			*offset0 = *offset1 + field_offset * screen_width * ps;
+		else
+			*offset0 = *offset1;
+		*row_inc = pixinc(screen_width * 2 - 1 +
+				(fieldmode ? screen_width : 0),
+				ps);
+		*pix_inc = pixinc(-1, ps);
+		break;
+
+	case 1 + 4:
+		*offset1 = 0;
+		if (field_offset)
+			*offset0 = *offset1 + field_offset * ps;
+		else
+			*offset0 = *offset1;
+		*row_inc = pixinc(-screen_width * (fbh - 1) + 1 +
+				(fieldmode ? 1 : 0),
+				ps);
+		*pix_inc = pixinc(screen_width, ps);
+		break;
+
+	case 2 + 4:
+		*offset1 = screen_width * (fbh - 1) * ps;
+		if (field_offset)
+			*offset0 = *offset1 - field_offset * screen_width * ps;
+		else
+			*offset0 = *offset1;
+		*row_inc = pixinc(1 - screen_width * 2 -
+				(fieldmode ? screen_width : 0),
+				ps);
+		*pix_inc = pixinc(1, ps);
+		break;
+
+	case 3 + 4:
+		*offset1 = (screen_width * (fbh - 1) + fbw - 1) * ps;
+		if (field_offset)
+			*offset0 = *offset1 - field_offset * ps;
+		else
+			*offset0 = *offset1;
+		*row_inc = pixinc(screen_width * (fbh - 1) - 1 -
+				(fieldmode ? 1 : 0),
+				ps);
+		*pix_inc = pixinc(-screen_width, ps);
+		break;
+
+	default:
+		BUG();
+	}
+}
+
+static unsigned long calc_fclk_five_taps(u16 width, u16 height,
+		u16 out_width, u16 out_height, enum omap_color_mode color_mode)
+{
+	u32 fclk = 0;
+	/* FIXME venc pclk? */
+	u64 tmp, pclk = dispc_pclk_rate();
+
+	if (height > out_height) {
+		/* FIXME get real display PPL */
+		unsigned int ppl = 800;
+
+		tmp = pclk * height * out_width;
+		do_div(tmp, 2 * out_height * ppl);
+		fclk = tmp;
+
+		if (height > 2 * out_height && ppl != out_width) {
+			tmp = pclk * (height - 2 * out_height) * out_width;
+			do_div(tmp, 2 * out_height * (ppl - out_width));
+			fclk = max(fclk, (u32) tmp);
+		}
+	}
+
+	if (width > out_width) {
+		tmp = pclk * width;
+		do_div(tmp, out_width);
+		fclk = max(fclk, (u32) tmp);
+
+		if (color_mode == OMAP_DSS_COLOR_RGB24U)
+			fclk <<= 1;
+	}
+
+	return fclk;
+}
+
+static unsigned long calc_fclk(u16 width, u16 height,
+		u16 out_width, u16 out_height)
+{
+	unsigned int hf, vf;
+
+	/*
+	 * FIXME how to determine the 'A' factor
+	 * for the no downscaling case ?
+	 */
+
+	if (width > 3 * out_width)
+		hf = 4;
+	else if (width > 2 * out_width)
+		hf = 3;
+	else if (width > out_width)
+		hf = 2;
+	else
+		hf = 1;
+
+	if (height > out_height)
+		vf = 2;
+	else
+		vf = 1;
+
+	/* FIXME venc pclk? */
+	return dispc_pclk_rate() * vf * hf;
+}
+
+void dispc_set_channel_out(enum omap_plane plane, enum omap_channel channel_out)
+{
+	enable_clocks(1);
+	_dispc_set_channel_out(plane, channel_out);
+	enable_clocks(0);
+}
+
+static int _dispc_setup_plane(enum omap_plane plane,
+		u32 paddr, u16 screen_width,
+		u16 pos_x, u16 pos_y,
+		u16 width, u16 height,
+		u16 out_width, u16 out_height,
+		enum omap_color_mode color_mode,
+		bool ilace,
+		enum omap_dss_rotation_type rotation_type,
+		u8 rotation, int mirror,
+		u8 global_alpha)
+{
+	const int maxdownscale = cpu_is_omap34xx() ? 4 : 2;
+	bool five_taps = 0;
+	bool fieldmode = 0;
+	int cconv = 0;
+	unsigned offset0, offset1;
+	s32 row_inc;
+	s32 pix_inc;
+	u16 frame_height = height;
+	unsigned int field_offset = 0;
+
+	if (paddr == 0)
+		return -EINVAL;
+
+	if (ilace && height == out_height)
+		fieldmode = 1;
+
+	if (ilace) {
+		if (fieldmode)
+			height /= 2;
+		pos_y /= 2;
+		out_height /= 2;
+
+		DSSDBG("adjusting for ilace: height %d, pos_y %d, "
+				"out_height %d\n",
+				height, pos_y, out_height);
+	}
+
+	if (plane == OMAP_DSS_GFX) {
+		if (width != out_width || height != out_height)
+			return -EINVAL;
+
+		switch (color_mode) {
+		case OMAP_DSS_COLOR_ARGB16:
+		case OMAP_DSS_COLOR_RGB16:
+		case OMAP_DSS_COLOR_RGB24P:
+		case OMAP_DSS_COLOR_RGB24U:
+		case OMAP_DSS_COLOR_ARGB32:
+		case OMAP_DSS_COLOR_RGBA32:
+		case OMAP_DSS_COLOR_RGBX32:
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	} else {
+		/* video plane */
+
+		unsigned long fclk = 0;
+
+		if (out_width < width / maxdownscale ||
+		   out_width > width * 8)
+			return -EINVAL;
+
+		if (out_height < height / maxdownscale ||
+		   out_height > height * 8)
+			return -EINVAL;
+
+		switch (color_mode) {
+		case OMAP_DSS_COLOR_RGB16:
+		case OMAP_DSS_COLOR_RGB24P:
+		case OMAP_DSS_COLOR_RGB24U:
+		case OMAP_DSS_COLOR_RGBX32:
+			break;
+
+		case OMAP_DSS_COLOR_ARGB16:
+		case OMAP_DSS_COLOR_ARGB32:
+		case OMAP_DSS_COLOR_RGBA32:
+			if (plane == OMAP_DSS_VIDEO1)
+				return -EINVAL;
+			break;
+
+		case OMAP_DSS_COLOR_YUV2:
+		case OMAP_DSS_COLOR_UYVY:
+			cconv = 1;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+		/* Must use 5-tap filter? */
+		five_taps = height > out_height * 2;
+
+		if (!five_taps) {
+			fclk = calc_fclk(width, height,
+					out_width, out_height);
+
+			/* Try 5-tap filter if 3-tap fclk is too high */
+			if (cpu_is_omap34xx() && height > out_height &&
+					fclk > dispc_fclk_rate())
+				five_taps = true;
+		}
+
+		if (width > (2048 >> five_taps))
+			return -EINVAL;
+
+		if (five_taps)
+			fclk = calc_fclk_five_taps(width, height,
+					out_width, out_height, color_mode);
+
+		DSSDBG("required fclk rate = %lu Hz\n", fclk);
+		DSSDBG("current fclk rate = %lu Hz\n", dispc_fclk_rate());
+
+		if (fclk > dispc_fclk_rate())
+			return -EINVAL;
+	}
+
+	if (ilace && !fieldmode) {
+		/*
+		 * when downscaling the bottom field may have to start several
+		 * source lines below the top field. Unfortunately ACCUI
+		 * registers will only hold the fractional part of the offset
+		 * so the integer part must be added to the base address of the
+		 * bottom field.
+		 */
+		if (!height || height == out_height)
+			field_offset = 0;
+		else
+			field_offset = height / out_height / 2;
+	}
+
+	/* Fields are independent but interleaved in memory. */
+	if (fieldmode)
+		field_offset = 1;
+
+	if (rotation_type == OMAP_DSS_ROT_DMA)
+		calc_dma_rotation_offset(rotation, mirror,
+				screen_width, width, frame_height, color_mode,
+				fieldmode, field_offset,
+				&offset0, &offset1, &row_inc, &pix_inc);
+	else
+		calc_vrfb_rotation_offset(rotation, mirror,
+				screen_width, width, frame_height, color_mode,
+				fieldmode, field_offset,
+				&offset0, &offset1, &row_inc, &pix_inc);
+
+	DSSDBG("offset0 %u, offset1 %u, row_inc %d, pix_inc %d\n",
+			offset0, offset1, row_inc, pix_inc);
+
+	_dispc_set_color_mode(plane, color_mode);
+
+	_dispc_set_plane_ba0(plane, paddr + offset0);
+	_dispc_set_plane_ba1(plane, paddr + offset1);
+
+	_dispc_set_row_inc(plane, row_inc);
+	_dispc_set_pix_inc(plane, pix_inc);
+
+	DSSDBG("%d,%d %dx%d -> %dx%d\n", pos_x, pos_y, width, height,
+			out_width, out_height);
+
+	_dispc_set_plane_pos(plane, pos_x, pos_y);
+
+	_dispc_set_pic_size(plane, width, height);
+
+	if (plane != OMAP_DSS_GFX) {
+		_dispc_set_scaling(plane, width, height,
+				   out_width, out_height,
+				   ilace, five_taps, fieldmode);
+		_dispc_set_vid_size(plane, out_width, out_height);
+		_dispc_set_vid_color_conv(plane, cconv);
+	}
+
+	_dispc_set_rotation_attrs(plane, rotation, mirror, color_mode);
+
+	if (plane != OMAP_DSS_VIDEO1)
+		_dispc_setup_global_alpha(plane, global_alpha);
+
+	return 0;
+}
+
+static void _dispc_enable_plane(enum omap_plane plane, bool enable)
+{
+	REG_FLD_MOD(dispc_reg_att[plane], enable ? 1 : 0, 0, 0);
+}
+
+static void dispc_disable_isr(void *data, u32 mask)
+{
+	struct completion *compl = data;
+	complete(compl);
+}
+
+static void _enable_lcd_out(bool enable)
+{
+	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 0, 0);
+}
+
+void dispc_enable_lcd_out(bool enable)
+{
+	struct completion frame_done_completion;
+	bool is_on;
+	int r;
+
+	enable_clocks(1);
+
+	/* When we disable LCD output, we need to wait until frame is done.
+	 * Otherwise the DSS is still working, and turning off the clocks
+	 * prevents DSS from going to OFF mode */
+	is_on = REG_GET(DISPC_CONTROL, 0, 0);
+
+	if (!enable && is_on) {
+		init_completion(&frame_done_completion);
+
+		r = omap_dispc_register_isr(dispc_disable_isr,
+				&frame_done_completion,
+				DISPC_IRQ_FRAMEDONE);
+
+		if (r)
+			DSSERR("failed to register FRAMEDONE isr\n");
+	}
+
+	_enable_lcd_out(enable);
+
+	if (!enable && is_on) {
+		if (!wait_for_completion_timeout(&frame_done_completion,
+					msecs_to_jiffies(100)))
+			DSSERR("timeout waiting for FRAME DONE\n");
+
+		r = omap_dispc_unregister_isr(dispc_disable_isr,
+				&frame_done_completion,
+				DISPC_IRQ_FRAMEDONE);
+
+		if (r)
+			DSSERR("failed to unregister FRAMEDONE isr\n");
+	}
+
+	enable_clocks(0);
+}
+
+static void _enable_digit_out(bool enable)
+{
+	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 1, 1);
+}
+
+void dispc_enable_digit_out(bool enable)
+{
+	struct completion frame_done_completion;
+	int r;
+
+	enable_clocks(1);
+
+	if (REG_GET(DISPC_CONTROL, 1, 1) == enable) {
+		enable_clocks(0);
+		return;
+	}
+
+	if (enable) {
+		unsigned long flags;
+		/* When we enable digit output, we'll get an extra digit
+		 * sync lost interrupt, that we need to ignore */
+		spin_lock_irqsave(&dispc.irq_lock, flags);
+		dispc.irq_error_mask &= ~DISPC_IRQ_SYNC_LOST_DIGIT;
+		_omap_dispc_set_irqs();
+		spin_unlock_irqrestore(&dispc.irq_lock, flags);
+	}
+
+	/* When we disable digit output, we need to wait until fields are done.
+	 * Otherwise the DSS is still working, and turning off the clocks
+	 * prevents DSS from going to OFF mode. And when enabling, we need to
+	 * wait for the extra sync losts */
+	init_completion(&frame_done_completion);
+
+	r = omap_dispc_register_isr(dispc_disable_isr, &frame_done_completion,
+			DISPC_IRQ_EVSYNC_EVEN | DISPC_IRQ_EVSYNC_ODD);
+	if (r)
+		DSSERR("failed to register EVSYNC isr\n");
+
+	_enable_digit_out(enable);
+
+	/* XXX I understand from TRM that we should only wait for the
+	 * current field to complete. But it seems we have to wait
+	 * for both fields */
+	if (!wait_for_completion_timeout(&frame_done_completion,
+				msecs_to_jiffies(100)))
+		DSSERR("timeout waiting for EVSYNC\n");
+
+	if (!wait_for_completion_timeout(&frame_done_completion,
+				msecs_to_jiffies(100)))
+		DSSERR("timeout waiting for EVSYNC\n");
+
+	r = omap_dispc_unregister_isr(dispc_disable_isr,
+			&frame_done_completion,
+			DISPC_IRQ_EVSYNC_EVEN | DISPC_IRQ_EVSYNC_ODD);
+	if (r)
+		DSSERR("failed to unregister EVSYNC isr\n");
+
+	if (enable) {
+		unsigned long flags;
+		spin_lock_irqsave(&dispc.irq_lock, flags);
+		dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
+		dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
+		_omap_dispc_set_irqs();
+		spin_unlock_irqrestore(&dispc.irq_lock, flags);
+	}
+
+	enable_clocks(0);
+}
+
+void dispc_lcd_enable_signal_polarity(bool act_high)
+{
+	enable_clocks(1);
+	REG_FLD_MOD(DISPC_CONTROL, act_high ? 1 : 0, 29, 29);
+	enable_clocks(0);
+}
+
+void dispc_lcd_enable_signal(bool enable)
+{
+	enable_clocks(1);
+	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 28, 28);
+	enable_clocks(0);
+}
+
+void dispc_pck_free_enable(bool enable)
+{
+	enable_clocks(1);
+	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 27, 27);
+	enable_clocks(0);
+}
+
+void dispc_enable_fifohandcheck(bool enable)
+{
+	enable_clocks(1);
+	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 16, 16);
+	enable_clocks(0);
+}
+
+
+void dispc_set_lcd_display_type(enum omap_lcd_display_type type)
+{
+	int mode;
+
+	switch (type) {
+	case OMAP_DSS_LCD_DISPLAY_STN:
+		mode = 0;
+		break;
+
+	case OMAP_DSS_LCD_DISPLAY_TFT:
+		mode = 1;
+		break;
+
+	default:
+		BUG();
+		return;
+	}
+
+	enable_clocks(1);
+	REG_FLD_MOD(DISPC_CONTROL, mode, 3, 3);
+	enable_clocks(0);
+}
+
+void dispc_set_loadmode(enum omap_dss_load_mode mode)
+{
+	enable_clocks(1);
+	REG_FLD_MOD(DISPC_CONFIG, mode, 2, 1);
+	enable_clocks(0);
+}
+
+
+void dispc_set_default_color(enum omap_channel channel, u32 color)
+{
+	const struct dispc_reg def_reg[] = { DISPC_DEFAULT_COLOR0,
+				DISPC_DEFAULT_COLOR1 };
+
+	enable_clocks(1);
+	dispc_write_reg(def_reg[channel], color);
+	enable_clocks(0);
+}
+
+u32 dispc_get_default_color(enum omap_channel channel)
+{
+	const struct dispc_reg def_reg[] = { DISPC_DEFAULT_COLOR0,
+				DISPC_DEFAULT_COLOR1 };
+	u32 l;
+
+	BUG_ON(channel != OMAP_DSS_CHANNEL_DIGIT &&
+	       channel != OMAP_DSS_CHANNEL_LCD);
+
+	enable_clocks(1);
+	l = dispc_read_reg(def_reg[channel]);
+	enable_clocks(0);
+
+	return l;
+}
+
+void dispc_set_trans_key(enum omap_channel ch,
+		enum omap_dss_trans_key_type type,
+		u32 trans_key)
+{
+	const struct dispc_reg tr_reg[] = {
+		DISPC_TRANS_COLOR0, DISPC_TRANS_COLOR1 };
+
+	enable_clocks(1);
+	if (ch == OMAP_DSS_CHANNEL_LCD)
+		REG_FLD_MOD(DISPC_CONFIG, type, 11, 11);
+	else /* OMAP_DSS_CHANNEL_DIGIT */
+		REG_FLD_MOD(DISPC_CONFIG, type, 13, 13);
+
+	dispc_write_reg(tr_reg[ch], trans_key);
+	enable_clocks(0);
+}
+
+void dispc_get_trans_key(enum omap_channel ch,
+		enum omap_dss_trans_key_type *type,
+		u32 *trans_key)
+{
+	const struct dispc_reg tr_reg[] = {
+		DISPC_TRANS_COLOR0, DISPC_TRANS_COLOR1 };
+
+	enable_clocks(1);
+	if (type) {
+		if (ch == OMAP_DSS_CHANNEL_LCD)
+			*type = REG_GET(DISPC_CONFIG, 11, 11);
+		else if (ch == OMAP_DSS_CHANNEL_DIGIT)
+			*type = REG_GET(DISPC_CONFIG, 13, 13);
+		else
+			BUG();
+	}
+
+	if (trans_key)
+		*trans_key = dispc_read_reg(tr_reg[ch]);
+	enable_clocks(0);
+}
+
+void dispc_enable_trans_key(enum omap_channel ch, bool enable)
+{
+	enable_clocks(1);
+	if (ch == OMAP_DSS_CHANNEL_LCD)
+		REG_FLD_MOD(DISPC_CONFIG, enable, 10, 10);
+	else /* OMAP_DSS_CHANNEL_DIGIT */
+		REG_FLD_MOD(DISPC_CONFIG, enable, 12, 12);
+	enable_clocks(0);
+}
+void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
+{
+	enable_clocks(1);
+	if (ch == OMAP_DSS_CHANNEL_LCD)
+		REG_FLD_MOD(DISPC_CONFIG, enable, 18, 18);
+	else /* OMAP_DSS_CHANNEL_DIGIT */
+		REG_FLD_MOD(DISPC_CONFIG, enable, 19, 19);
+	enable_clocks(0);
+}
+bool dispc_alpha_blending_enabled(enum omap_channel ch)
+{
+	bool enabled;
+
+	enable_clocks(1);
+	if (ch == OMAP_DSS_CHANNEL_LCD)
+		enabled = REG_GET(DISPC_CONFIG, 18, 18);
+	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
+		enabled = REG_GET(DISPC_CONFIG, 18, 18);
+	else
+		BUG();
+	enable_clocks(0);
+
+	return enabled;
+
+}
+
+
+bool dispc_trans_key_enabled(enum omap_channel ch)
+{
+	bool enabled;
+
+	enable_clocks(1);
+	if (ch == OMAP_DSS_CHANNEL_LCD)
+		enabled = REG_GET(DISPC_CONFIG, 10, 10);
+	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
+		enabled = REG_GET(DISPC_CONFIG, 12, 12);
+	else
+		BUG();
+	enable_clocks(0);
+
+	return enabled;
+}
+
+
+void dispc_set_tft_data_lines(u8 data_lines)
+{
+	int code;
+
+	switch (data_lines) {
+	case 12:
+		code = 0;
+		break;
+	case 16:
+		code = 1;
+		break;
+	case 18:
+		code = 2;
+		break;
+	case 24:
+		code = 3;
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	enable_clocks(1);
+	REG_FLD_MOD(DISPC_CONTROL, code, 9, 8);
+	enable_clocks(0);
+}
+
+void dispc_set_parallel_interface_mode(enum omap_parallel_interface_mode mode)
+{
+	u32 l;
+	int stallmode;
+	int gpout0 = 1;
+	int gpout1;
+
+	switch (mode) {
+	case OMAP_DSS_PARALLELMODE_BYPASS:
+		stallmode = 0;
+		gpout1 = 1;
+		break;
+
+	case OMAP_DSS_PARALLELMODE_RFBI:
+		stallmode = 1;
+		gpout1 = 0;
+		break;
+
+	case OMAP_DSS_PARALLELMODE_DSI:
+		stallmode = 1;
+		gpout1 = 1;
+		break;
+
+	default:
+		BUG();
+		return;
+	}
+
+	enable_clocks(1);
+
+	l = dispc_read_reg(DISPC_CONTROL);
+
+	l = FLD_MOD(l, stallmode, 11, 11);
+	l = FLD_MOD(l, gpout0, 15, 15);
+	l = FLD_MOD(l, gpout1, 16, 16);
+
+	dispc_write_reg(DISPC_CONTROL, l);
+
+	enable_clocks(0);
+}
+
+static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
+		int vsw, int vfp, int vbp)
+{
+	if (cpu_is_omap24xx() || omap_rev() < OMAP3430_REV_ES3_0) {
+		if (hsw < 1 || hsw > 64 ||
+				hfp < 1 || hfp > 256 ||
+				hbp < 1 || hbp > 256 ||
+				vsw < 1 || vsw > 64 ||
+				vfp < 0 || vfp > 255 ||
+				vbp < 0 || vbp > 255)
+			return false;
+	} else {
+		if (hsw < 1 || hsw > 256 ||
+				hfp < 1 || hfp > 4096 ||
+				hbp < 1 || hbp > 4096 ||
+				vsw < 1 || vsw > 256 ||
+				vfp < 0 || vfp > 4095 ||
+				vbp < 0 || vbp > 4095)
+			return false;
+	}
+
+	return true;
+}
+
+bool dispc_lcd_timings_ok(struct omap_video_timings *timings)
+{
+	return _dispc_lcd_timings_ok(timings->hsw, timings->hfp,
+			timings->hbp, timings->vsw,
+			timings->vfp, timings->vbp);
+}
+
+static void _dispc_set_lcd_timings(int hsw, int hfp, int hbp,
+				   int vsw, int vfp, int vbp)
+{
+	u32 timing_h, timing_v;
+
+	if (cpu_is_omap24xx() || omap_rev() < OMAP3430_REV_ES3_0) {
+		timing_h = FLD_VAL(hsw-1, 5, 0) | FLD_VAL(hfp-1, 15, 8) |
+			FLD_VAL(hbp-1, 27, 20);
+
+		timing_v = FLD_VAL(vsw-1, 5, 0) | FLD_VAL(vfp, 15, 8) |
+			FLD_VAL(vbp, 27, 20);
+	} else {
+		timing_h = FLD_VAL(hsw-1, 7, 0) | FLD_VAL(hfp-1, 19, 8) |
+			FLD_VAL(hbp-1, 31, 20);
+
+		timing_v = FLD_VAL(vsw-1, 7, 0) | FLD_VAL(vfp, 19, 8) |
+			FLD_VAL(vbp, 31, 20);
+	}
+
+	enable_clocks(1);
+	dispc_write_reg(DISPC_TIMING_H, timing_h);
+	dispc_write_reg(DISPC_TIMING_V, timing_v);
+	enable_clocks(0);
+}
+
+/* change name to mode? */
+void dispc_set_lcd_timings(struct omap_video_timings *timings)
+{
+	unsigned xtot, ytot;
+	unsigned long ht, vt;
+
+	if (!_dispc_lcd_timings_ok(timings->hsw, timings->hfp,
+				timings->hbp, timings->vsw,
+				timings->vfp, timings->vbp))
+		BUG();
+
+	_dispc_set_lcd_timings(timings->hsw, timings->hfp, timings->hbp,
+			timings->vsw, timings->vfp, timings->vbp);
+
+	dispc_set_lcd_size(timings->x_res, timings->y_res);
+
+	xtot = timings->x_res + timings->hfp + timings->hsw + timings->hbp;
+	ytot = timings->y_res + timings->vfp + timings->vsw + timings->vbp;
+
+	ht = (timings->pixel_clock * 1000) / xtot;
+	vt = (timings->pixel_clock * 1000) / xtot / ytot;
+
+	DSSDBG("xres %u yres %u\n", timings->x_res, timings->y_res);
+	DSSDBG("pck %u\n", timings->pixel_clock);
+	DSSDBG("hsw %d hfp %d hbp %d vsw %d vfp %d vbp %d\n",
+			timings->hsw, timings->hfp, timings->hbp,
+			timings->vsw, timings->vfp, timings->vbp);
+
+	DSSDBG("hsync %luHz, vsync %luHz\n", ht, vt);
+}
+
+void dispc_set_lcd_divisor(u16 lck_div, u16 pck_div)
+{
+	BUG_ON(lck_div < 1);
+	BUG_ON(pck_div < 2);
+
+	enable_clocks(1);
+	dispc_write_reg(DISPC_DIVISOR,
+			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
+	enable_clocks(0);
+}
+
+static void dispc_get_lcd_divisor(int *lck_div, int *pck_div)
+{
+	u32 l;
+	l = dispc_read_reg(DISPC_DIVISOR);
+	*lck_div = FLD_GET(l, 23, 16);
+	*pck_div = FLD_GET(l, 7, 0);
+}
+
+unsigned long dispc_fclk_rate(void)
+{
+	unsigned long r = 0;
+
+	if (dss_get_dispc_clk_source() == 0)
+		r = dss_clk_get_rate(DSS_CLK_FCK1);
+	else
+#ifdef CONFIG_OMAP2_DSS_DSI
+		r = dsi_get_dsi1_pll_rate();
+#else
+	BUG();
+#endif
+	return r;
+}
+
+unsigned long dispc_lclk_rate(void)
+{
+	int lcd;
+	unsigned long r;
+	u32 l;
+
+	l = dispc_read_reg(DISPC_DIVISOR);
+
+	lcd = FLD_GET(l, 23, 16);
+
+	r = dispc_fclk_rate();
+
+	return r / lcd;
+}
+
+unsigned long dispc_pclk_rate(void)
+{
+	int lcd, pcd;
+	unsigned long r;
+	u32 l;
+
+	l = dispc_read_reg(DISPC_DIVISOR);
+
+	lcd = FLD_GET(l, 23, 16);
+	pcd = FLD_GET(l, 7, 0);
+
+	r = dispc_fclk_rate();
+
+	return r / lcd / pcd;
+}
+
+void dispc_dump_clocks(struct seq_file *s)
+{
+	int lcd, pcd;
+
+	enable_clocks(1);
+
+	dispc_get_lcd_divisor(&lcd, &pcd);
+
+	seq_printf(s, "- dispc -\n");
+
+	seq_printf(s, "dispc fclk source = %s\n",
+			dss_get_dispc_clk_source() == 0 ?
+			"dss1_alwon_fclk" : "dsi1_pll_fclk");
+
+	seq_printf(s, "pixel clk = %lu / %d / %d = %lu\n",
+			dispc_fclk_rate(),
+			lcd, pcd,
+			dispc_pclk_rate());
+
+	enable_clocks(0);
+}
+
+void dispc_dump_regs(struct seq_file *s)
+{
+#define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dispc_read_reg(r))
+
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+
+	DUMPREG(DISPC_REVISION);
+	DUMPREG(DISPC_SYSCONFIG);
+	DUMPREG(DISPC_SYSSTATUS);
+	DUMPREG(DISPC_IRQSTATUS);
+	DUMPREG(DISPC_IRQENABLE);
+	DUMPREG(DISPC_CONTROL);
+	DUMPREG(DISPC_CONFIG);
+	DUMPREG(DISPC_CAPABLE);
+	DUMPREG(DISPC_DEFAULT_COLOR0);
+	DUMPREG(DISPC_DEFAULT_COLOR1);
+	DUMPREG(DISPC_TRANS_COLOR0);
+	DUMPREG(DISPC_TRANS_COLOR1);
+	DUMPREG(DISPC_LINE_STATUS);
+	DUMPREG(DISPC_LINE_NUMBER);
+	DUMPREG(DISPC_TIMING_H);
+	DUMPREG(DISPC_TIMING_V);
+	DUMPREG(DISPC_POL_FREQ);
+	DUMPREG(DISPC_DIVISOR);
+	DUMPREG(DISPC_GLOBAL_ALPHA);
+	DUMPREG(DISPC_SIZE_DIG);
+	DUMPREG(DISPC_SIZE_LCD);
+
+	DUMPREG(DISPC_GFX_BA0);
+	DUMPREG(DISPC_GFX_BA1);
+	DUMPREG(DISPC_GFX_POSITION);
+	DUMPREG(DISPC_GFX_SIZE);
+	DUMPREG(DISPC_GFX_ATTRIBUTES);
+	DUMPREG(DISPC_GFX_FIFO_THRESHOLD);
+	DUMPREG(DISPC_GFX_FIFO_SIZE_STATUS);
+	DUMPREG(DISPC_GFX_ROW_INC);
+	DUMPREG(DISPC_GFX_PIXEL_INC);
+	DUMPREG(DISPC_GFX_WINDOW_SKIP);
+	DUMPREG(DISPC_GFX_TABLE_BA);
+
+	DUMPREG(DISPC_DATA_CYCLE1);
+	DUMPREG(DISPC_DATA_CYCLE2);
+	DUMPREG(DISPC_DATA_CYCLE3);
+
+	DUMPREG(DISPC_CPR_COEF_R);
+	DUMPREG(DISPC_CPR_COEF_G);
+	DUMPREG(DISPC_CPR_COEF_B);
+
+	DUMPREG(DISPC_GFX_PRELOAD);
+
+	DUMPREG(DISPC_VID_BA0(0));
+	DUMPREG(DISPC_VID_BA1(0));
+	DUMPREG(DISPC_VID_POSITION(0));
+	DUMPREG(DISPC_VID_SIZE(0));
+	DUMPREG(DISPC_VID_ATTRIBUTES(0));
+	DUMPREG(DISPC_VID_FIFO_THRESHOLD(0));
+	DUMPREG(DISPC_VID_FIFO_SIZE_STATUS(0));
+	DUMPREG(DISPC_VID_ROW_INC(0));
+	DUMPREG(DISPC_VID_PIXEL_INC(0));
+	DUMPREG(DISPC_VID_FIR(0));
+	DUMPREG(DISPC_VID_PICTURE_SIZE(0));
+	DUMPREG(DISPC_VID_ACCU0(0));
+	DUMPREG(DISPC_VID_ACCU1(0));
+
+	DUMPREG(DISPC_VID_BA0(1));
+	DUMPREG(DISPC_VID_BA1(1));
+	DUMPREG(DISPC_VID_POSITION(1));
+	DUMPREG(DISPC_VID_SIZE(1));
+	DUMPREG(DISPC_VID_ATTRIBUTES(1));
+	DUMPREG(DISPC_VID_FIFO_THRESHOLD(1));
+	DUMPREG(DISPC_VID_FIFO_SIZE_STATUS(1));
+	DUMPREG(DISPC_VID_ROW_INC(1));
+	DUMPREG(DISPC_VID_PIXEL_INC(1));
+	DUMPREG(DISPC_VID_FIR(1));
+	DUMPREG(DISPC_VID_PICTURE_SIZE(1));
+	DUMPREG(DISPC_VID_ACCU0(1));
+	DUMPREG(DISPC_VID_ACCU1(1));
+
+	DUMPREG(DISPC_VID_FIR_COEF_H(0, 0));
+	DUMPREG(DISPC_VID_FIR_COEF_H(0, 1));
+	DUMPREG(DISPC_VID_FIR_COEF_H(0, 2));
+	DUMPREG(DISPC_VID_FIR_COEF_H(0, 3));
+	DUMPREG(DISPC_VID_FIR_COEF_H(0, 4));
+	DUMPREG(DISPC_VID_FIR_COEF_H(0, 5));
+	DUMPREG(DISPC_VID_FIR_COEF_H(0, 6));
+	DUMPREG(DISPC_VID_FIR_COEF_H(0, 7));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 0));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 1));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 2));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 3));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 4));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 5));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 6));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 7));
+	DUMPREG(DISPC_VID_CONV_COEF(0, 0));
+	DUMPREG(DISPC_VID_CONV_COEF(0, 1));
+	DUMPREG(DISPC_VID_CONV_COEF(0, 2));
+	DUMPREG(DISPC_VID_CONV_COEF(0, 3));
+	DUMPREG(DISPC_VID_CONV_COEF(0, 4));
+	DUMPREG(DISPC_VID_FIR_COEF_V(0, 0));
+	DUMPREG(DISPC_VID_FIR_COEF_V(0, 1));
+	DUMPREG(DISPC_VID_FIR_COEF_V(0, 2));
+	DUMPREG(DISPC_VID_FIR_COEF_V(0, 3));
+	DUMPREG(DISPC_VID_FIR_COEF_V(0, 4));
+	DUMPREG(DISPC_VID_FIR_COEF_V(0, 5));
+	DUMPREG(DISPC_VID_FIR_COEF_V(0, 6));
+	DUMPREG(DISPC_VID_FIR_COEF_V(0, 7));
+
+	DUMPREG(DISPC_VID_FIR_COEF_H(1, 0));
+	DUMPREG(DISPC_VID_FIR_COEF_H(1, 1));
+	DUMPREG(DISPC_VID_FIR_COEF_H(1, 2));
+	DUMPREG(DISPC_VID_FIR_COEF_H(1, 3));
+	DUMPREG(DISPC_VID_FIR_COEF_H(1, 4));
+	DUMPREG(DISPC_VID_FIR_COEF_H(1, 5));
+	DUMPREG(DISPC_VID_FIR_COEF_H(1, 6));
+	DUMPREG(DISPC_VID_FIR_COEF_H(1, 7));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 0));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 1));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 2));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 3));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 4));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 5));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 6));
+	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 7));
+	DUMPREG(DISPC_VID_CONV_COEF(1, 0));
+	DUMPREG(DISPC_VID_CONV_COEF(1, 1));
+	DUMPREG(DISPC_VID_CONV_COEF(1, 2));
+	DUMPREG(DISPC_VID_CONV_COEF(1, 3));
+	DUMPREG(DISPC_VID_CONV_COEF(1, 4));
+	DUMPREG(DISPC_VID_FIR_COEF_V(1, 0));
+	DUMPREG(DISPC_VID_FIR_COEF_V(1, 1));
+	DUMPREG(DISPC_VID_FIR_COEF_V(1, 2));
+	DUMPREG(DISPC_VID_FIR_COEF_V(1, 3));
+	DUMPREG(DISPC_VID_FIR_COEF_V(1, 4));
+	DUMPREG(DISPC_VID_FIR_COEF_V(1, 5));
+	DUMPREG(DISPC_VID_FIR_COEF_V(1, 6));
+	DUMPREG(DISPC_VID_FIR_COEF_V(1, 7));
+
+	DUMPREG(DISPC_VID_PRELOAD(0));
+	DUMPREG(DISPC_VID_PRELOAD(1));
+
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+#undef DUMPREG
+}
+
+static void _dispc_set_pol_freq(bool onoff, bool rf, bool ieo, bool ipc,
+				bool ihs, bool ivs, u8 acbi, u8 acb)
+{
+	u32 l = 0;
+
+	DSSDBG("onoff %d rf %d ieo %d ipc %d ihs %d ivs %d acbi %d acb %d\n",
+			onoff, rf, ieo, ipc, ihs, ivs, acbi, acb);
+
+	l |= FLD_VAL(onoff, 17, 17);
+	l |= FLD_VAL(rf, 16, 16);
+	l |= FLD_VAL(ieo, 15, 15);
+	l |= FLD_VAL(ipc, 14, 14);
+	l |= FLD_VAL(ihs, 13, 13);
+	l |= FLD_VAL(ivs, 12, 12);
+	l |= FLD_VAL(acbi, 11, 8);
+	l |= FLD_VAL(acb, 7, 0);
+
+	enable_clocks(1);
+	dispc_write_reg(DISPC_POL_FREQ, l);
+	enable_clocks(0);
+}
+
+void dispc_set_pol_freq(enum omap_panel_config config, u8 acbi, u8 acb)
+{
+	_dispc_set_pol_freq((config & OMAP_DSS_LCD_ONOFF) != 0,
+			(config & OMAP_DSS_LCD_RF) != 0,
+			(config & OMAP_DSS_LCD_IEO) != 0,
+			(config & OMAP_DSS_LCD_IPC) != 0,
+			(config & OMAP_DSS_LCD_IHS) != 0,
+			(config & OMAP_DSS_LCD_IVS) != 0,
+			acbi, acb);
+}
+
+void find_lck_pck_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
+		u16 *lck_div, u16 *pck_div)
+{
+	u16 pcd_min = is_tft ? 2 : 3;
+	unsigned long best_pck;
+	u16 best_ld, cur_ld;
+	u16 best_pd, cur_pd;
+
+	best_pck = 0;
+	best_ld = 0;
+	best_pd = 0;
+
+	for (cur_ld = 1; cur_ld <= 255; ++cur_ld) {
+		unsigned long lck = fck / cur_ld;
+
+		for (cur_pd = pcd_min; cur_pd <= 255; ++cur_pd) {
+			unsigned long pck = lck / cur_pd;
+			long old_delta = abs(best_pck - req_pck);
+			long new_delta = abs(pck - req_pck);
+
+			if (best_pck == 0 || new_delta < old_delta) {
+				best_pck = pck;
+				best_ld = cur_ld;
+				best_pd = cur_pd;
+
+				if (pck == req_pck)
+					goto found;
+			}
+
+			if (pck < req_pck)
+				break;
+		}
+
+		if (lck / pcd_min < req_pck)
+			break;
+	}
+
+found:
+	*lck_div = best_ld;
+	*pck_div = best_pd;
+}
+
+int dispc_calc_clock_div(bool is_tft, unsigned long req_pck,
+		struct dispc_clock_info *cinfo)
+{
+	unsigned long prate;
+	struct dispc_clock_info cur, best;
+	int match = 0;
+	int min_fck_per_pck;
+	unsigned long fck_rate = dss_clk_get_rate(DSS_CLK_FCK1);
+
+	if (cpu_is_omap34xx())
+		prate = clk_get_rate(clk_get_parent(dispc.dpll4_m4_ck));
+	else
+		prate = 0;
+
+	if (req_pck == dispc.cache_req_pck &&
+			((cpu_is_omap34xx() && prate == dispc.cache_prate) ||
+			 dispc.cache_cinfo.fck == fck_rate)) {
+		DSSDBG("dispc clock info found from cache.\n");
+		*cinfo = dispc.cache_cinfo;
+		return 0;
+	}
+
+	min_fck_per_pck = CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK;
+
+	if (min_fck_per_pck &&
+		req_pck * min_fck_per_pck > DISPC_MAX_FCK) {
+		DSSERR("Requested pixel clock not possible with the current "
+				"OMAP2_DSS_MIN_FCK_PER_PCK setting. Turning "
+				"the constraint off.\n");
+		min_fck_per_pck = 0;
+	}
+
+retry:
+	memset(&cur, 0, sizeof(cur));
+	memset(&best, 0, sizeof(best));
+
+	if (cpu_is_omap24xx()) {
+		/* XXX can we change the clock on omap2? */
+		cur.fck = dss_clk_get_rate(DSS_CLK_FCK1);
+		cur.fck_div = 1;
+
+		match = 1;
+
+		find_lck_pck_divs(is_tft, req_pck, cur.fck,
+				&cur.lck_div, &cur.pck_div);
+
+		cur.lck = cur.fck / cur.lck_div;
+		cur.pck = cur.lck / cur.pck_div;
+
+		best = cur;
+
+		goto found;
+	} else if (cpu_is_omap34xx()) {
+		for (cur.fck_div = 16; cur.fck_div > 0; --cur.fck_div) {
+			cur.fck = prate / cur.fck_div * 2;
+
+			if (cur.fck > DISPC_MAX_FCK)
+				continue;
+
+			if (min_fck_per_pck &&
+					cur.fck < req_pck * min_fck_per_pck)
+				continue;
+
+			match = 1;
+
+			find_lck_pck_divs(is_tft, req_pck, cur.fck,
+					&cur.lck_div, &cur.pck_div);
+
+			cur.lck = cur.fck / cur.lck_div;
+			cur.pck = cur.lck / cur.pck_div;
+
+			if (abs(cur.pck - req_pck) < abs(best.pck - req_pck)) {
+				best = cur;
+
+				if (cur.pck == req_pck)
+					goto found;
+			}
+		}
+	} else {
+		BUG();
+	}
+
+found:
+	if (!match) {
+		if (min_fck_per_pck) {
+			DSSERR("Could not find suitable clock settings.\n"
+					"Turning FCK/PCK constraint off and"
+					"trying again.\n");
+			min_fck_per_pck = 0;
+			goto retry;
+		}
+
+		DSSERR("Could not find suitable clock settings.\n");
+
+		return -EINVAL;
+	}
+
+	if (cinfo)
+		*cinfo = best;
+
+	dispc.cache_req_pck = req_pck;
+	dispc.cache_prate = prate;
+	dispc.cache_cinfo = best;
+
+	return 0;
+}
+
+int dispc_set_clock_div(struct dispc_clock_info *cinfo)
+{
+	unsigned long prate;
+	int r;
+
+	if (cpu_is_omap34xx()) {
+		prate = clk_get_rate(clk_get_parent(dispc.dpll4_m4_ck));
+		DSSDBG("dpll4_m4 = %ld\n", prate);
+	}
+
+	DSSDBG("fck = %ld (%d)\n", cinfo->fck, cinfo->fck_div);
+	DSSDBG("lck = %ld (%d)\n", cinfo->lck, cinfo->lck_div);
+	DSSDBG("pck = %ld (%d)\n", cinfo->pck, cinfo->pck_div);
+
+	if (cpu_is_omap34xx()) {
+		r = clk_set_rate(dispc.dpll4_m4_ck, prate / cinfo->fck_div);
+		if (r)
+			return r;
+	}
+
+	dispc_set_lcd_divisor(cinfo->lck_div, cinfo->pck_div);
+
+	return 0;
+}
+
+int dispc_get_clock_div(struct dispc_clock_info *cinfo)
+{
+	cinfo->fck = dss_clk_get_rate(DSS_CLK_FCK1);
+
+	if (cpu_is_omap34xx()) {
+		unsigned long prate;
+		prate = clk_get_rate(clk_get_parent(dispc.dpll4_m4_ck));
+		cinfo->fck_div = prate / (cinfo->fck / 2);
+	} else {
+		cinfo->fck_div = 0;
+	}
+
+	cinfo->lck_div = REG_GET(DISPC_DIVISOR, 23, 16);
+	cinfo->pck_div = REG_GET(DISPC_DIVISOR, 7, 0);
+
+	cinfo->lck = cinfo->fck / cinfo->lck_div;
+	cinfo->pck = cinfo->lck / cinfo->pck_div;
+
+	return 0;
+}
+
+/* dispc.irq_lock has to be locked by the caller */
+static void _omap_dispc_set_irqs(void)
+{
+	u32 mask;
+	u32 old_mask;
+	int i;
+	struct omap_dispc_isr_data *isr_data;
+
+	mask = dispc.irq_error_mask;
+
+	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
+		isr_data = &dispc.registered_isr[i];
+
+		if (isr_data->isr == NULL)
+			continue;
+
+		mask |= isr_data->mask;
+	}
+
+	enable_clocks(1);
+
+	old_mask = dispc_read_reg(DISPC_IRQENABLE);
+	/* clear the irqstatus for newly enabled irqs */
+	dispc_write_reg(DISPC_IRQSTATUS, (mask ^ old_mask) & mask);
+
+	dispc_write_reg(DISPC_IRQENABLE, mask);
+
+	enable_clocks(0);
+}
+
+int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
+{
+	int i;
+	int ret;
+	unsigned long flags;
+	struct omap_dispc_isr_data *isr_data;
+
+	if (isr == NULL)
+		return -EINVAL;
+
+	spin_lock_irqsave(&dispc.irq_lock, flags);
+
+	/* check for duplicate entry */
+	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
+		isr_data = &dispc.registered_isr[i];
+		if (isr_data->isr == isr && isr_data->arg == arg &&
+				isr_data->mask == mask) {
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
+	isr_data = NULL;
+	ret = -EBUSY;
+
+	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
+		isr_data = &dispc.registered_isr[i];
+
+		if (isr_data->isr != NULL)
+			continue;
+
+		isr_data->isr = isr;
+		isr_data->arg = arg;
+		isr_data->mask = mask;
+		ret = 0;
+
+		break;
+	}
+
+	_omap_dispc_set_irqs();
+
+	spin_unlock_irqrestore(&dispc.irq_lock, flags);
+
+	return 0;
+err:
+	spin_unlock_irqrestore(&dispc.irq_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(omap_dispc_register_isr);
+
+int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
+{
+	int i;
+	unsigned long flags;
+	int ret = -EINVAL;
+	struct omap_dispc_isr_data *isr_data;
+
+	spin_lock_irqsave(&dispc.irq_lock, flags);
+
+	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
+		isr_data = &dispc.registered_isr[i];
+		if (isr_data->isr != isr || isr_data->arg != arg ||
+				isr_data->mask != mask)
+			continue;
+
+		/* found the correct isr */
+
+		isr_data->isr = NULL;
+		isr_data->arg = NULL;
+		isr_data->mask = 0;
+
+		ret = 0;
+		break;
+	}
+
+	if (ret == 0)
+		_omap_dispc_set_irqs();
+
+	spin_unlock_irqrestore(&dispc.irq_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(omap_dispc_unregister_isr);
+
+#ifdef DEBUG
+static void print_irq_status(u32 status)
+{
+	if ((status & dispc.irq_error_mask) == 0)
+		return;
+
+	printk(KERN_DEBUG "DISPC IRQ: 0x%x: ", status);
+
+#define PIS(x) \
+	if (status & DISPC_IRQ_##x) \
+		printk(#x " ");
+	PIS(GFX_FIFO_UNDERFLOW);
+	PIS(OCP_ERR);
+	PIS(VID1_FIFO_UNDERFLOW);
+	PIS(VID2_FIFO_UNDERFLOW);
+	PIS(SYNC_LOST);
+	PIS(SYNC_LOST_DIGIT);
+#undef PIS
+
+	printk("\n");
+}
+#endif
+
+/* Called from dss.c. Note that we don't touch clocks here,
+ * but we presume they are on because we got an IRQ. However,
+ * an irq handler may turn the clocks off, so we may not have
+ * clock later in the function. */
+void dispc_irq_handler(void)
+{
+	int i;
+	u32 irqstatus;
+	u32 handledirqs = 0;
+	u32 unhandled_errors;
+	struct omap_dispc_isr_data *isr_data;
+	struct omap_dispc_isr_data registered_isr[DISPC_MAX_NR_ISRS];
+
+	spin_lock(&dispc.irq_lock);
+
+	irqstatus = dispc_read_reg(DISPC_IRQSTATUS);
+
+#ifdef DEBUG
+	if (dss_debug)
+		print_irq_status(irqstatus);
+#endif
+	/* Ack the interrupt. Do it here before clocks are possibly turned
+	 * off */
+	dispc_write_reg(DISPC_IRQSTATUS, irqstatus);
+
+	/* make a copy and unlock, so that isrs can unregister
+	 * themselves */
+	memcpy(registered_isr, dispc.registered_isr,
+			sizeof(registered_isr));
+
+	spin_unlock(&dispc.irq_lock);
+
+	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
+		isr_data = &registered_isr[i];
+
+		if (!isr_data->isr)
+			continue;
+
+		if (isr_data->mask & irqstatus) {
+			isr_data->isr(isr_data->arg, irqstatus);
+			handledirqs |= isr_data->mask;
+		}
+	}
+
+	spin_lock(&dispc.irq_lock);
+
+	unhandled_errors = irqstatus & ~handledirqs & dispc.irq_error_mask;
+
+	if (unhandled_errors) {
+		dispc.error_irqs |= unhandled_errors;
+
+		dispc.irq_error_mask &= ~unhandled_errors;
+		_omap_dispc_set_irqs();
+
+		schedule_work(&dispc.error_work);
+	}
+
+	spin_unlock(&dispc.irq_lock);
+}
+
+static void dispc_error_worker(struct work_struct *work)
+{
+	int i;
+	u32 errors;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dispc.irq_lock, flags);
+	errors = dispc.error_irqs;
+	dispc.error_irqs = 0;
+	spin_unlock_irqrestore(&dispc.irq_lock, flags);
+
+	if (errors & DISPC_IRQ_GFX_FIFO_UNDERFLOW) {
+		DSSERR("GFX_FIFO_UNDERFLOW, disabling GFX\n");
+		for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+			struct omap_overlay *ovl;
+			ovl = omap_dss_get_overlay(i);
+
+			if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
+				continue;
+
+			if (ovl->id == 0) {
+				dispc_enable_plane(ovl->id, 0);
+				dispc_go(ovl->manager->id);
+				mdelay(50);
+				break;
+			}
+		}
+	}
+
+	if (errors & DISPC_IRQ_VID1_FIFO_UNDERFLOW) {
+		DSSERR("VID1_FIFO_UNDERFLOW, disabling VID1\n");
+		for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+			struct omap_overlay *ovl;
+			ovl = omap_dss_get_overlay(i);
+
+			if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
+				continue;
+
+			if (ovl->id == 1) {
+				dispc_enable_plane(ovl->id, 0);
+				dispc_go(ovl->manager->id);
+				mdelay(50);
+				break;
+			}
+		}
+	}
+
+	if (errors & DISPC_IRQ_VID2_FIFO_UNDERFLOW) {
+		DSSERR("VID2_FIFO_UNDERFLOW, disabling VID2\n");
+		for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+			struct omap_overlay *ovl;
+			ovl = omap_dss_get_overlay(i);
+
+			if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
+				continue;
+
+			if (ovl->id == 2) {
+				dispc_enable_plane(ovl->id, 0);
+				dispc_go(ovl->manager->id);
+				mdelay(50);
+				break;
+			}
+		}
+	}
+
+	if (errors & DISPC_IRQ_SYNC_LOST) {
+		struct omap_overlay_manager *manager = NULL;
+		bool enable = false;
+
+		DSSERR("SYNC_LOST, disabling LCD\n");
+
+		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
+			struct omap_overlay_manager *mgr;
+			mgr = omap_dss_get_overlay_manager(i);
+
+			if (mgr->id == OMAP_DSS_CHANNEL_LCD) {
+				manager = mgr;
+				enable = mgr->device->state ==
+						OMAP_DSS_DISPLAY_ACTIVE;
+				mgr->device->disable(mgr->device);
+				break;
+			}
+		}
+
+		if (manager) {
+			for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+				struct omap_overlay *ovl;
+				ovl = omap_dss_get_overlay(i);
+
+				if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
+					continue;
+
+				if (ovl->id != 0 && ovl->manager == manager)
+					dispc_enable_plane(ovl->id, 0);
+			}
+
+			dispc_go(manager->id);
+			mdelay(50);
+			if (enable)
+				manager->device->enable(manager->device);
+		}
+	}
+
+	if (errors & DISPC_IRQ_SYNC_LOST_DIGIT) {
+		struct omap_overlay_manager *manager = NULL;
+		bool enable = false;
+
+		DSSERR("SYNC_LOST_DIGIT, disabling TV\n");
+
+		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
+			struct omap_overlay_manager *mgr;
+			mgr = omap_dss_get_overlay_manager(i);
+
+			if (mgr->id == OMAP_DSS_CHANNEL_DIGIT) {
+				manager = mgr;
+				enable = mgr->device->state ==
+						OMAP_DSS_DISPLAY_ACTIVE;
+				mgr->device->disable(mgr->device);
+				break;
+			}
+		}
+
+		if (manager) {
+			for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+				struct omap_overlay *ovl;
+				ovl = omap_dss_get_overlay(i);
+
+				if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
+					continue;
+
+				if (ovl->id != 0 && ovl->manager == manager)
+					dispc_enable_plane(ovl->id, 0);
+			}
+
+			dispc_go(manager->id);
+			mdelay(50);
+			if (enable)
+				manager->device->enable(manager->device);
+		}
+	}
+
+	if (errors & DISPC_IRQ_OCP_ERR) {
+		DSSERR("OCP_ERR\n");
+		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
+			struct omap_overlay_manager *mgr;
+			mgr = omap_dss_get_overlay_manager(i);
+
+			if (mgr->caps & OMAP_DSS_OVL_CAP_DISPC)
+				mgr->device->disable(mgr->device);
+		}
+	}
+
+	spin_lock_irqsave(&dispc.irq_lock, flags);
+	dispc.irq_error_mask |= errors;
+	_omap_dispc_set_irqs();
+	spin_unlock_irqrestore(&dispc.irq_lock, flags);
+}
+
+int omap_dispc_wait_for_irq_timeout(u32 irqmask, unsigned long timeout)
+{
+	void dispc_irq_wait_handler(void *data, u32 mask)
+	{
+		complete((struct completion *)data);
+	}
+
+	int r;
+	DECLARE_COMPLETION_ONSTACK(completion);
+
+	r = omap_dispc_register_isr(dispc_irq_wait_handler, &completion,
+			irqmask);
+
+	if (r)
+		return r;
+
+	timeout = wait_for_completion_timeout(&completion, timeout);
+
+	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask);
+
+	if (timeout == 0)
+		return -ETIMEDOUT;
+
+	if (timeout == -ERESTARTSYS)
+		return -ERESTARTSYS;
+
+	return 0;
+}
+
+int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
+		unsigned long timeout)
+{
+	void dispc_irq_wait_handler(void *data, u32 mask)
+	{
+		complete((struct completion *)data);
+	}
+
+	int r;
+	DECLARE_COMPLETION_ONSTACK(completion);
+
+	r = omap_dispc_register_isr(dispc_irq_wait_handler, &completion,
+			irqmask);
+
+	if (r)
+		return r;
+
+	timeout = wait_for_completion_interruptible_timeout(&completion,
+			timeout);
+
+	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask);
+
+	if (timeout == 0)
+		return -ETIMEDOUT;
+
+	if (timeout == -ERESTARTSYS)
+		return -ERESTARTSYS;
+
+	return 0;
+}
+
+#ifdef CONFIG_OMAP2_DSS_FAKE_VSYNC
+void dispc_fake_vsync_irq(void)
+{
+	u32 irqstatus = DISPC_IRQ_VSYNC;
+	int i;
+
+	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
+		struct omap_dispc_isr_data *isr_data;
+		isr_data = &dispc.registered_isr[i];
+
+		if (!isr_data->isr)
+			continue;
+
+		if (isr_data->mask & irqstatus)
+			isr_data->isr(isr_data->arg, irqstatus);
+	}
+}
+#endif
+
+static void _omap_dispc_initialize_irq(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dispc.irq_lock, flags);
+
+	memset(dispc.registered_isr, 0, sizeof(dispc.registered_isr));
+
+	dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
+
+	/* there's SYNC_LOST_DIGIT waiting after enabling the DSS,
+	 * so clear it */
+	dispc_write_reg(DISPC_IRQSTATUS, dispc_read_reg(DISPC_IRQSTATUS));
+
+	_omap_dispc_set_irqs();
+
+	spin_unlock_irqrestore(&dispc.irq_lock, flags);
+}
+
+void dispc_enable_sidle(void)
+{
+	REG_FLD_MOD(DISPC_SYSCONFIG, 2, 4, 3);	/* SIDLEMODE: smart idle */
+}
+
+void dispc_disable_sidle(void)
+{
+	REG_FLD_MOD(DISPC_SYSCONFIG, 1, 4, 3);	/* SIDLEMODE: no idle */
+}
+
+static void _omap_dispc_initial_config(void)
+{
+	u32 l;
+
+	l = dispc_read_reg(DISPC_SYSCONFIG);
+	l = FLD_MOD(l, 2, 13, 12);	/* MIDLEMODE: smart standby */
+	l = FLD_MOD(l, 2, 4, 3);	/* SIDLEMODE: smart idle */
+	l = FLD_MOD(l, 1, 2, 2);	/* ENWAKEUP */
+	l = FLD_MOD(l, 1, 0, 0);	/* AUTOIDLE */
+	dispc_write_reg(DISPC_SYSCONFIG, l);
+
+	/* FUNCGATED */
+	REG_FLD_MOD(DISPC_CONFIG, 1, 9, 9);
+
+	/* L3 firewall setting: enable access to OCM RAM */
+	if (cpu_is_omap24xx())
+		__raw_writel(0x402000b0, IO_ADDRESS(0x680050a0));
+
+	_dispc_setup_color_conv_coef();
+
+	dispc_set_loadmode(OMAP_DSS_LOAD_FRAME_ONLY);
+
+	dispc_read_plane_fifo_sizes();
+}
+
+int dispc_init(void)
+{
+	u32 rev;
+
+	spin_lock_init(&dispc.irq_lock);
+
+	INIT_WORK(&dispc.error_work, dispc_error_worker);
+
+	dispc.base = ioremap(DISPC_BASE, DISPC_SZ_REGS);
+	if (!dispc.base) {
+		DSSERR("can't ioremap DISPC\n");
+		return -ENOMEM;
+	}
+
+	if (cpu_is_omap34xx()) {
+		dispc.dpll4_m4_ck = clk_get(NULL, "dpll4_m4_ck");
+		if (IS_ERR(dispc.dpll4_m4_ck)) {
+			DSSERR("Failed to get dpll4_m4_ck\n");
+			return -ENODEV;
+		}
+	}
+
+	enable_clocks(1);
+
+	_omap_dispc_initial_config();
+
+	_omap_dispc_initialize_irq();
+
+	dispc_save_context();
+
+	rev = dispc_read_reg(DISPC_REVISION);
+	printk(KERN_INFO "OMAP DISPC rev %d.%d\n",
+	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
+
+	enable_clocks(0);
+
+	return 0;
+}
+
+void dispc_exit(void)
+{
+	if (cpu_is_omap34xx())
+		clk_put(dispc.dpll4_m4_ck);
+	iounmap(dispc.base);
+}
+
+int dispc_enable_plane(enum omap_plane plane, bool enable)
+{
+	DSSDBG("dispc_enable_plane %d, %d\n", plane, enable);
+
+	enable_clocks(1);
+	_dispc_enable_plane(plane, enable);
+	enable_clocks(0);
+
+	return 0;
+}
+
+int dispc_setup_plane(enum omap_plane plane,
+		       u32 paddr, u16 screen_width,
+		       u16 pos_x, u16 pos_y,
+		       u16 width, u16 height,
+		       u16 out_width, u16 out_height,
+		       enum omap_color_mode color_mode,
+		       bool ilace,
+		       enum omap_dss_rotation_type rotation_type,
+		       u8 rotation, bool mirror, u8 global_alpha)
+{
+	int r = 0;
+
+	DSSDBG("dispc_setup_plane %d, pa %x, sw %d, %d,%d, %dx%d -> "
+	       "%dx%d, ilace %d, cmode %x, rot %d, mir %d\n",
+	       plane, paddr, screen_width, pos_x, pos_y,
+	       width, height,
+	       out_width, out_height,
+	       ilace, color_mode,
+	       rotation, mirror);
+
+	enable_clocks(1);
+
+	r = _dispc_setup_plane(plane,
+			   paddr, screen_width,
+			   pos_x, pos_y,
+			   width, height,
+			   out_width, out_height,
+			   color_mode, ilace,
+			   rotation_type,
+			   rotation, mirror,
+			   global_alpha);
+
+	enable_clocks(0);
+
+	return r;
+}
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
new file mode 100644
index 0000000..6b5d0cf
--- /dev/null
+++ b/drivers/video/omap2/dss/display.c
@@ -0,0 +1,658 @@
+/*
+ * linux/drivers/video/omap2/dss/display.c
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * Some code and ideas taken from drivers/video/omap/ driver
+ * by Imre Deak.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define DSS_SUBSYS_NAME "DISPLAY"
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/list.h>
+#include <linux/platform_device.h>
+
+#include <mach/display.h>
+#include "dss.h"
+
+static LIST_HEAD(display_list);
+
+static ssize_t display_enabled_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	bool enabled = dssdev->state != OMAP_DSS_DISPLAY_DISABLED;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", enabled);
+}
+
+static ssize_t display_enabled_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	bool enabled, r;
+
+	enabled = simple_strtoul(buf, NULL, 10);
+
+	if (enabled != (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)) {
+		if (enabled) {
+			r = dssdev->enable(dssdev);
+			if (r)
+				return r;
+		} else {
+			dssdev->disable(dssdev);
+		}
+	}
+
+	return size;
+}
+
+static ssize_t display_upd_mode_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	enum omap_dss_update_mode mode = OMAP_DSS_UPDATE_AUTO;
+	if (dssdev->get_update_mode)
+		mode = dssdev->get_update_mode(dssdev);
+	return snprintf(buf, PAGE_SIZE, "%d\n", mode);
+}
+
+static ssize_t display_upd_mode_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	int val, r;
+	enum omap_dss_update_mode mode;
+
+	val = simple_strtoul(buf, NULL, 10);
+
+	switch (val) {
+	case OMAP_DSS_UPDATE_DISABLED:
+	case OMAP_DSS_UPDATE_AUTO:
+	case OMAP_DSS_UPDATE_MANUAL:
+		mode = (enum omap_dss_update_mode)val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	r = dssdev->set_update_mode(dssdev, mode);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t display_tear_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			dssdev->get_te ? dssdev->get_te(dssdev) : 0);
+}
+
+static ssize_t display_tear_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	unsigned long te;
+	int r;
+
+	if (!dssdev->enable_te || !dssdev->get_te)
+		return -ENOENT;
+
+	te = simple_strtoul(buf, NULL, 0);
+
+	r = dssdev->enable_te(dssdev, te);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t display_timings_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_video_timings t;
+
+	if (!dssdev->get_timings)
+		return -ENOENT;
+
+	dssdev->get_timings(dssdev, &t);
+
+	return snprintf(buf, PAGE_SIZE, "%u,%u/%u/%u/%u,%u/%u/%u/%u\n",
+			t.pixel_clock,
+			t.x_res, t.hfp, t.hbp, t.hsw,
+			t.y_res, t.vfp, t.vbp, t.vsw);
+}
+
+static ssize_t display_timings_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_video_timings t;
+	int r, found;
+
+	if (!dssdev->set_timings || !dssdev->check_timings)
+		return -ENOENT;
+
+	found = 0;
+#ifdef CONFIG_OMAP2_DSS_VENC
+	if (strncmp("pal", buf, 3) == 0) {
+		t = omap_dss_pal_timings;
+		found = 1;
+	} else if (strncmp("ntsc", buf, 4) == 0) {
+		t = omap_dss_ntsc_timings;
+		found = 1;
+	}
+#endif
+	if (!found && sscanf(buf, "%u,%hu/%hu/%hu/%hu,%hu/%hu/%hu/%hu",
+				&t.pixel_clock,
+				&t.x_res, &t.hfp, &t.hbp, &t.hsw,
+				&t.y_res, &t.vfp, &t.vbp, &t.vsw) != 9)
+		return -EINVAL;
+
+	r = dssdev->check_timings(dssdev, &t);
+	if (r)
+		return r;
+
+	dssdev->set_timings(dssdev, &t);
+
+	return size;
+}
+
+static ssize_t display_rotate_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	int rotate;
+	if (!dssdev->get_rotate)
+		return -ENOENT;
+	rotate = dssdev->get_rotate(dssdev);
+	return snprintf(buf, PAGE_SIZE, "%u\n", rotate);
+}
+
+static ssize_t display_rotate_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	unsigned long rot;
+	int r;
+
+	if (!dssdev->set_rotate || !dssdev->get_rotate)
+		return -ENOENT;
+
+	rot = simple_strtoul(buf, NULL, 0);
+
+	r = dssdev->set_rotate(dssdev, rot);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t display_mirror_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	int mirror;
+	if (!dssdev->get_mirror)
+		return -ENOENT;
+	mirror = dssdev->get_mirror(dssdev);
+	return snprintf(buf, PAGE_SIZE, "%u\n", mirror);
+}
+
+static ssize_t display_mirror_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	unsigned long mirror;
+	int r;
+
+	if (!dssdev->set_mirror || !dssdev->get_mirror)
+		return -ENOENT;
+
+	mirror = simple_strtoul(buf, NULL, 0);
+
+	r = dssdev->set_mirror(dssdev, mirror);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t display_wss_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	unsigned int wss;
+
+	if (!dssdev->get_wss)
+		return -ENOENT;
+
+	wss = dssdev->get_wss(dssdev);
+
+	return snprintf(buf, PAGE_SIZE, "0x%05x\n", wss);
+}
+
+static ssize_t display_wss_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	unsigned long wss;
+	int r;
+
+	if (!dssdev->get_wss || !dssdev->set_wss)
+		return -ENOENT;
+
+	if (strict_strtoul(buf, 0, &wss))
+		return -EINVAL;
+
+	if (wss > 0xfffff)
+		return -EINVAL;
+
+	r = dssdev->set_wss(dssdev, wss);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static DEVICE_ATTR(enabled, S_IRUGO|S_IWUSR,
+		display_enabled_show, display_enabled_store);
+static DEVICE_ATTR(update_mode, S_IRUGO|S_IWUSR,
+		display_upd_mode_show, display_upd_mode_store);
+static DEVICE_ATTR(tear_elim, S_IRUGO|S_IWUSR,
+		display_tear_show, display_tear_store);
+static DEVICE_ATTR(timings, S_IRUGO|S_IWUSR,
+		display_timings_show, display_timings_store);
+static DEVICE_ATTR(rotate, S_IRUGO|S_IWUSR,
+		display_rotate_show, display_rotate_store);
+static DEVICE_ATTR(mirror, S_IRUGO|S_IWUSR,
+		display_mirror_show, display_mirror_store);
+static DEVICE_ATTR(wss, S_IRUGO|S_IWUSR,
+		display_wss_show, display_wss_store);
+
+static struct device_attribute *display_sysfs_attrs[] = {
+	&dev_attr_enabled,
+	&dev_attr_update_mode,
+	&dev_attr_tear_elim,
+	&dev_attr_timings,
+	&dev_attr_rotate,
+	&dev_attr_mirror,
+	&dev_attr_wss,
+	NULL
+};
+
+static void default_get_resolution(struct omap_dss_device *dssdev,
+			u16 *xres, u16 *yres)
+{
+	*xres = dssdev->panel.timings.x_res;
+	*yres = dssdev->panel.timings.y_res;
+}
+
+void default_get_overlay_fifo_thresholds(enum omap_plane plane,
+		u32 fifo_size, enum omap_burst_size *burst_size,
+		u32 *fifo_low, u32 *fifo_high)
+{
+	unsigned burst_size_bytes;
+
+	*burst_size = OMAP_DSS_BURST_16x32;
+	burst_size_bytes = 16 * 32 / 8;
+
+	*fifo_high = fifo_size - 1;
+	*fifo_low = fifo_size - burst_size_bytes;
+}
+
+static int default_wait_vsync(struct omap_dss_device *dssdev)
+{
+	unsigned long timeout = msecs_to_jiffies(500);
+	u32 irq;
+
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC)
+		irq = DISPC_IRQ_EVSYNC_ODD;
+	else
+		irq = DISPC_IRQ_VSYNC;
+
+	return omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
+}
+
+static int default_get_recommended_bpp(struct omap_dss_device *dssdev)
+{
+	if (dssdev->panel.recommended_bpp)
+		return dssdev->panel.recommended_bpp;
+
+	switch (dssdev->type) {
+	case OMAP_DISPLAY_TYPE_DPI:
+		if (dssdev->phy.dpi.data_lines == 24)
+			return 24;
+		else
+			return 16;
+
+	case OMAP_DISPLAY_TYPE_DBI:
+	case OMAP_DISPLAY_TYPE_DSI:
+		if (dssdev->ctrl.pixel_size == 24)
+			return 24;
+		else
+			return 16;
+	case OMAP_DISPLAY_TYPE_VENC:
+	case OMAP_DISPLAY_TYPE_SDI:
+		return 24;
+		return 24;
+	default:
+		BUG();
+	}
+}
+
+/* Checks if replication logic should be used. Only use for active matrix,
+ * when overlay is in RGB12U or RGB16 mode, and LCD interface is
+ * 18bpp or 24bpp */
+bool dss_use_replication(struct omap_dss_device *dssdev,
+		enum omap_color_mode mode)
+{
+	int bpp;
+
+	if (mode != OMAP_DSS_COLOR_RGB12U && mode != OMAP_DSS_COLOR_RGB16)
+		return false;
+
+	if (dssdev->type == OMAP_DISPLAY_TYPE_DPI &&
+			(dssdev->panel.config & OMAP_DSS_LCD_TFT) == 0)
+		return false;
+
+	switch (dssdev->type) {
+	case OMAP_DISPLAY_TYPE_DPI:
+		bpp = dssdev->phy.dpi.data_lines;
+		break;
+	case OMAP_DISPLAY_TYPE_VENC:
+	case OMAP_DISPLAY_TYPE_SDI:
+		bpp = 24;
+		break;
+	case OMAP_DISPLAY_TYPE_DBI:
+	case OMAP_DISPLAY_TYPE_DSI:
+		bpp = dssdev->ctrl.pixel_size;
+		break;
+	default:
+		BUG();
+	}
+
+	return bpp > 16;
+}
+
+void dss_init_device(struct platform_device *pdev,
+		struct omap_dss_device *dssdev)
+{
+	struct device_attribute *attr;
+	int i;
+	int r;
+
+	switch (dssdev->type) {
+	case OMAP_DISPLAY_TYPE_DPI:
+#ifdef CONFIG_OMAP2_DSS_RFBI
+	case OMAP_DISPLAY_TYPE_DBI:
+#endif
+#ifdef CONFIG_OMAP2_DSS_SDI
+	case OMAP_DISPLAY_TYPE_SDI:
+#endif
+#ifdef CONFIG_OMAP2_DSS_DSI
+	case OMAP_DISPLAY_TYPE_DSI:
+#endif
+#ifdef CONFIG_OMAP2_DSS_VENC
+	case OMAP_DISPLAY_TYPE_VENC:
+#endif
+		break;
+	default:
+		DSSERR("Support for display '%s' not compiled in.\n",
+				dssdev->name);
+		return;
+	}
+
+	dssdev->get_resolution = default_get_resolution;
+	dssdev->get_recommended_bpp = default_get_recommended_bpp;
+	dssdev->wait_vsync = default_wait_vsync;
+
+	switch (dssdev->type) {
+	case OMAP_DISPLAY_TYPE_DPI:
+		r = dpi_init_display(dssdev);
+		break;
+#ifdef CONFIG_OMAP2_DSS_RFBI
+	case OMAP_DISPLAY_TYPE_DBI:
+		r = rfbi_init_display(dssdev);
+		break;
+#endif
+#ifdef CONFIG_OMAP2_DSS_VENC
+	case OMAP_DISPLAY_TYPE_VENC:
+		r = venc_init_display(dssdev);
+		break;
+#endif
+#ifdef CONFIG_OMAP2_DSS_SDI
+	case OMAP_DISPLAY_TYPE_SDI:
+		r = sdi_init_display(dssdev);
+		break;
+#endif
+#ifdef CONFIG_OMAP2_DSS_DSI
+	case OMAP_DISPLAY_TYPE_DSI:
+		r = dsi_init_display(dssdev);
+		break;
+#endif
+	default:
+		BUG();
+	}
+
+	if (r) {
+		DSSERR("failed to init display %s\n", dssdev->name);
+		return;
+	}
+
+	/* create device sysfs files */
+	i = 0;
+	while ((attr = display_sysfs_attrs[i++]) != NULL) {
+		r = device_create_file(&dssdev->dev, attr);
+		if (r)
+			DSSERR("failed to create sysfs file\n");
+	}
+
+	/* create display? sysfs links */
+	r = sysfs_create_link(&pdev->dev.kobj, &dssdev->dev.kobj,
+			dev_name(&dssdev->dev));
+	if (r)
+		DSSERR("failed to create sysfs display link\n");
+}
+
+void dss_uninit_device(struct platform_device *pdev,
+		struct omap_dss_device *dssdev)
+{
+	struct device_attribute *attr;
+	int i = 0;
+
+	sysfs_remove_link(&pdev->dev.kobj, dev_name(&dssdev->dev));
+
+	while ((attr = display_sysfs_attrs[i++]) != NULL)
+		device_remove_file(&dssdev->dev, attr);
+
+	if (dssdev->manager)
+		dssdev->manager->unset_device(dssdev->manager);
+}
+
+static int dss_suspend_device(struct device *dev, void *data)
+{
+	int r;
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
+		dssdev->activate_after_resume = false;
+		return 0;
+	}
+
+	if (!dssdev->suspend) {
+		DSSERR("display '%s' doesn't implement suspend\n",
+				dssdev->name);
+		return -ENOSYS;
+	}
+
+	r = dssdev->suspend(dssdev);
+	if (r)
+		return r;
+
+	dssdev->activate_after_resume = true;
+
+	return 0;
+}
+
+int dss_suspend_all_devices(void)
+{
+	int r;
+	struct bus_type *bus = dss_get_bus();
+
+	r = bus_for_each_dev(bus, NULL, NULL, dss_suspend_device);
+	if (r) {
+		/* resume all displays that were suspended */
+		dss_resume_all_devices();
+		return r;
+	}
+
+	return 0;
+}
+
+static int dss_resume_device(struct device *dev, void *data)
+{
+	int r;
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+
+	if (dssdev->activate_after_resume && dssdev->resume) {
+		r = dssdev->resume(dssdev);
+		if (r)
+			return r;
+	}
+
+	dssdev->activate_after_resume = false;
+
+	return 0;
+}
+
+int dss_resume_all_devices(void)
+{
+	struct bus_type *bus = dss_get_bus();
+
+	return bus_for_each_dev(bus, NULL, NULL, dss_resume_device);
+}
+
+
+void omap_dss_get_device(struct omap_dss_device *dssdev)
+{
+	get_device(&dssdev->dev);
+}
+EXPORT_SYMBOL(omap_dss_get_device);
+
+void omap_dss_put_device(struct omap_dss_device *dssdev)
+{
+	put_device(&dssdev->dev);
+}
+EXPORT_SYMBOL(omap_dss_put_device);
+
+/* ref count of the found device is incremented. ref count
+ * of from-device is decremented. */
+struct omap_dss_device *omap_dss_get_next_device(struct omap_dss_device *from)
+{
+	struct device *dev;
+	struct device *dev_start = NULL;
+	struct omap_dss_device *dssdev = NULL;
+
+	int match(struct device *dev, void *data)
+	{
+		/* skip panels connected to controllers */
+		if (to_dss_device(dev)->panel.ctrl)
+			return 0;
+
+		return 1;
+	}
+
+	if (from)
+		dev_start = &from->dev;
+	dev = bus_find_device(dss_get_bus(), dev_start, NULL, match);
+	if (dev)
+		dssdev = to_dss_device(dev);
+	if (from)
+		put_device(&from->dev);
+
+	return dssdev;
+}
+EXPORT_SYMBOL(omap_dss_get_next_device);
+
+struct omap_dss_device *omap_dss_find_device(void *data,
+		int (*match)(struct omap_dss_device *dssdev, void *data))
+{
+	struct omap_dss_device *dssdev = NULL;
+
+	while ((dssdev = omap_dss_get_next_device(dssdev)) != NULL) {
+		if (match(dssdev, data))
+			return dssdev;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(omap_dss_find_device);
+
+int omap_dss_start_device(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	if (!dssdev->driver) {
+		DSSDBG("no driver\n");
+		r = -ENODEV;
+		goto err0;
+	}
+
+	if (dssdev->ctrl.panel && !dssdev->ctrl.panel->driver) {
+		DSSDBG("no panel driver\n");
+		r = -ENODEV;
+		goto err0;
+	}
+
+	if (!try_module_get(dssdev->dev.driver->owner)) {
+		r = -ENODEV;
+		goto err0;
+	}
+
+	if (dssdev->ctrl.panel) {
+		if (!try_module_get(dssdev->ctrl.panel->dev.driver->owner)) {
+			r = -ENODEV;
+			goto err1;
+		}
+	}
+
+	return 0;
+err1:
+	module_put(dssdev->dev.driver->owner);
+err0:
+	return r;
+}
+EXPORT_SYMBOL(omap_dss_start_device);
+
+void omap_dss_stop_device(struct omap_dss_device *dssdev)
+{
+	if (dssdev->ctrl.panel)
+		module_put(dssdev->ctrl.panel->dev.driver->owner);
+
+	module_put(dssdev->dev.driver->owner);
+}
+EXPORT_SYMBOL(omap_dss_stop_device);
+
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
new file mode 100644
index 0000000..b6543c8
--- /dev/null
+++ b/drivers/video/omap2/dss/dpi.c
@@ -0,0 +1,388 @@
+/*
+ * linux/drivers/video/omap2/dss/dpi.c
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * Some code and ideas taken from drivers/video/omap/ driver
+ * by Imre Deak.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define DSS_SUBSYS_NAME "DPI"
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+
+#include <mach/board.h>
+#include <mach/display.h>
+#include <mach/cpu.h>
+
+#include "dss.h"
+
+static struct {
+	int update_enabled;
+} dpi;
+
+#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
+static int dpi_set_dsi_clk(bool is_tft, unsigned long pck_req,
+		unsigned long *fck, int *lck_div, int *pck_div)
+{
+	struct dsi_clock_info cinfo;
+	int r;
+
+	r = dsi_pll_calc_pck(is_tft, pck_req, &cinfo);
+	if (r)
+		return r;
+
+	r = dsi_pll_program(&cinfo);
+	if (r)
+		return r;
+
+	dss_select_clk_source(0, 1);
+
+	dispc_set_lcd_divisor(cinfo.lck_div, cinfo.pck_div);
+
+	*fck = cinfo.dsi1_pll_fclk;
+	*lck_div = cinfo.lck_div;
+	*pck_div = cinfo.pck_div;
+
+	return 0;
+}
+#else
+static int dpi_set_dispc_clk(bool is_tft, unsigned long pck_req,
+		unsigned long *fck, int *lck_div, int *pck_div)
+{
+	struct dispc_clock_info cinfo;
+	int r;
+
+	r = dispc_calc_clock_div(is_tft, pck_req, &cinfo);
+	if (r)
+		return r;
+
+	r = dispc_set_clock_div(&cinfo);
+	if (r)
+		return r;
+
+	*fck = cinfo.fck;
+	*lck_div = cinfo.lck_div;
+	*pck_div = cinfo.pck_div;
+
+	return 0;
+}
+#endif
+
+static int dpi_set_mode(struct omap_dss_device *dssdev)
+{
+	struct omap_video_timings *t = &dssdev->panel.timings;
+	int lck_div, pck_div;
+	unsigned long fck;
+	unsigned long pck;
+	bool is_tft;
+	int r = 0;
+
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+
+	dispc_set_pol_freq(dssdev->panel.config, dssdev->panel.acbi,
+			dssdev->panel.acb);
+
+	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
+
+#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
+	r = dpi_set_dsi_clk(is_tft, t->pixel_clock * 1000,
+			&fck, &lck_div, &pck_div);
+#else
+	r = dpi_set_dispc_clk(is_tft, t->pixel_clock * 1000,
+			&fck, &lck_div, &pck_div);
+#endif
+	if (r)
+		goto err0;
+
+	pck = fck / lck_div / pck_div / 1000;
+
+	if (pck != t->pixel_clock) {
+		DSSWARN("Could not find exact pixel clock. "
+				"Requested %d kHz, got %lu kHz\n",
+				t->pixel_clock, pck);
+
+		t->pixel_clock = pck;
+	}
+
+	dispc_set_lcd_timings(t);
+
+err0:
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	return r;
+}
+
+static int dpi_basic_init(struct omap_dss_device *dssdev)
+{
+	bool is_tft;
+
+	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
+
+	dispc_set_parallel_interface_mode(OMAP_DSS_PARALLELMODE_BYPASS);
+	dispc_set_lcd_display_type(is_tft ? OMAP_DSS_LCD_DISPLAY_TFT :
+			OMAP_DSS_LCD_DISPLAY_STN);
+	dispc_set_tft_data_lines(dssdev->phy.dpi.data_lines);
+
+	return 0;
+}
+
+static int dpi_display_enable(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	r = omap_dss_start_device(dssdev);
+	if (r) {
+		DSSERR("failed to start device\n");
+		goto err0;
+	}
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
+		DSSERR("display already enabled\n");
+		r = -EINVAL;
+		goto err1;
+	}
+
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+
+	r = dpi_basic_init(dssdev);
+	if (r)
+		goto err2;
+
+#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
+	dss_clk_enable(DSS_CLK_FCK2);
+	r = dsi_pll_init(0, 1);
+	if (r)
+		goto err3;
+#endif
+	r = dpi_set_mode(dssdev);
+	if (r)
+		goto err4;
+
+	mdelay(2);
+
+	dispc_enable_lcd_out(1);
+
+	r = dssdev->driver->enable(dssdev);
+	if (r)
+		goto err5;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+
+err5:
+	dispc_enable_lcd_out(0);
+err4:
+#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
+	dsi_pll_uninit();
+err3:
+	dss_clk_disable(DSS_CLK_FCK2);
+#endif
+err2:
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+err1:
+	omap_dss_stop_device(dssdev);
+err0:
+	return r;
+}
+
+static int dpi_display_resume(struct omap_dss_device *dssdev);
+
+static void dpi_display_disable(struct omap_dss_device *dssdev)
+{
+	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED)
+		return;
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
+		dpi_display_resume(dssdev);
+
+	dssdev->driver->disable(dssdev);
+
+	dispc_enable_lcd_out(0);
+
+#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
+	dss_select_clk_source(0, 0);
+	dsi_pll_uninit();
+	dss_clk_disable(DSS_CLK_FCK2);
+#endif
+
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+
+	omap_dss_stop_device(dssdev);
+}
+
+static int dpi_display_suspend(struct omap_dss_device *dssdev)
+{
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+		return -EINVAL;
+
+	DSSDBG("dpi_display_suspend\n");
+
+	if (dssdev->driver->suspend)
+		dssdev->driver->suspend(dssdev);
+
+	dispc_enable_lcd_out(0);
+
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
+	return 0;
+}
+
+static int dpi_display_resume(struct omap_dss_device *dssdev)
+{
+	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED)
+		return -EINVAL;
+
+	DSSDBG("dpi_display_resume\n");
+
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+
+	dispc_enable_lcd_out(1);
+
+	if (dssdev->driver->resume)
+		dssdev->driver->resume(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void dpi_set_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	DSSDBG("dpi_set_timings\n");
+	dssdev->panel.timings = *timings;
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+		dpi_set_mode(dssdev);
+		dispc_go(OMAP_DSS_CHANNEL_LCD);
+	}
+}
+
+static int dpi_check_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	bool is_tft;
+	int r;
+	int lck_div, pck_div;
+	unsigned long fck;
+	unsigned long pck;
+
+	if (!dispc_lcd_timings_ok(timings))
+		return -EINVAL;
+
+	if (timings->pixel_clock == 0)
+		return -EINVAL;
+
+	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
+
+#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
+	{
+		struct dsi_clock_info cinfo;
+		r = dsi_pll_calc_pck(is_tft, timings->pixel_clock * 1000,
+				&cinfo);
+
+		if (r)
+			return r;
+
+		fck = cinfo.dsi1_pll_fclk;
+		lck_div = cinfo.lck_div;
+		pck_div = cinfo.pck_div;
+	}
+#else
+	{
+		struct dispc_clock_info cinfo;
+		r = dispc_calc_clock_div(is_tft, timings->pixel_clock * 1000,
+				&cinfo);
+
+		if (r)
+			return r;
+
+		fck = cinfo.fck;
+		lck_div = cinfo.lck_div;
+		pck_div = cinfo.pck_div;
+	}
+#endif
+
+	pck = fck / lck_div / pck_div / 1000;
+
+	timings->pixel_clock = pck;
+
+	return 0;
+}
+
+static void dpi_get_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	*timings = dssdev->panel.timings;
+}
+
+static int dpi_display_set_update_mode(struct omap_dss_device *dssdev,
+		enum omap_dss_update_mode mode)
+{
+	if (mode == OMAP_DSS_UPDATE_MANUAL)
+		return -EINVAL;
+
+	if (mode == OMAP_DSS_UPDATE_DISABLED) {
+		dispc_enable_lcd_out(0);
+		dpi.update_enabled = 0;
+	} else {
+		dispc_enable_lcd_out(1);
+		dpi.update_enabled = 1;
+	}
+
+	return 0;
+}
+
+static enum omap_dss_update_mode dpi_display_get_update_mode(
+		struct omap_dss_device *dssdev)
+{
+	return dpi.update_enabled ? OMAP_DSS_UPDATE_AUTO :
+		OMAP_DSS_UPDATE_DISABLED;
+}
+
+int dpi_init_display(struct omap_dss_device *dssdev)
+{
+	DSSDBG("init_display\n");
+
+	dssdev->enable = dpi_display_enable;
+	dssdev->disable = dpi_display_disable;
+	dssdev->suspend = dpi_display_suspend;
+	dssdev->resume = dpi_display_resume;
+	dssdev->set_timings = dpi_set_timings;
+	dssdev->check_timings = dpi_check_timings;
+	dssdev->get_timings = dpi_get_timings;
+	dssdev->set_update_mode = dpi_display_set_update_mode;
+	dssdev->get_update_mode = dpi_display_get_update_mode;
+
+	return 0;
+}
+
+int dpi_init(void)
+{
+	return 0;
+}
+
+void dpi_exit(void)
+{
+}
+
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
new file mode 100644
index 0000000..aab9758
--- /dev/null
+++ b/drivers/video/omap2/dss/dss.c
@@ -0,0 +1,347 @@
+/*
+ * linux/drivers/video/omap2/dss/dss.c
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * Some code and ideas taken from drivers/video/omap/ driver
+ * by Imre Deak.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define DSS_SUBSYS_NAME "DSS"
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/seq_file.h>
+
+#include <mach/display.h>
+#include "dss.h"
+
+#define DSS_BASE			0x48050000
+
+#define DSS_SZ_REGS			SZ_512
+
+struct dss_reg {
+	u16 idx;
+};
+
+#define DSS_REG(idx)			((const struct dss_reg) { idx })
+
+#define DSS_REVISION			DSS_REG(0x0000)
+#define DSS_SYSCONFIG			DSS_REG(0x0010)
+#define DSS_SYSSTATUS			DSS_REG(0x0014)
+#define DSS_IRQSTATUS			DSS_REG(0x0018)
+#define DSS_CONTROL			DSS_REG(0x0040)
+#define DSS_SDI_CONTROL			DSS_REG(0x0044)
+#define DSS_PLL_CONTROL			DSS_REG(0x0048)
+#define DSS_SDI_STATUS			DSS_REG(0x005C)
+
+#define REG_GET(idx, start, end) \
+	FLD_GET(dss_read_reg(idx), start, end)
+
+#define REG_FLD_MOD(idx, val, start, end) \
+	dss_write_reg(idx, FLD_MOD(dss_read_reg(idx), val, start, end))
+
+static struct {
+	void __iomem    *base;
+
+	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
+} dss;
+
+static int _omap_dss_wait_reset(void);
+
+static inline void dss_write_reg(const struct dss_reg idx, u32 val)
+{
+	__raw_writel(val, dss.base + idx.idx);
+}
+
+static inline u32 dss_read_reg(const struct dss_reg idx)
+{
+	return __raw_readl(dss.base + idx.idx);
+}
+
+#define SR(reg) \
+	dss.ctx[(DSS_##reg).idx / sizeof(u32)] = dss_read_reg(DSS_##reg)
+#define RR(reg) \
+	dss_write_reg(DSS_##reg, dss.ctx[(DSS_##reg).idx / sizeof(u32)])
+
+void dss_save_context(void)
+{
+	if (cpu_is_omap24xx())
+		return;
+
+	SR(SYSCONFIG);
+	SR(CONTROL);
+
+#ifdef CONFIG_OMAP2_DSS_SDI
+	SR(SDI_CONTROL);
+	SR(PLL_CONTROL);
+#endif
+}
+
+void dss_restore_context(void)
+{
+	if (_omap_dss_wait_reset())
+		DSSERR("DSS not coming out of reset after sleep\n");
+
+	RR(SYSCONFIG);
+	RR(CONTROL);
+
+#ifdef CONFIG_OMAP2_DSS_SDI
+	RR(SDI_CONTROL);
+	RR(PLL_CONTROL);
+#endif
+}
+
+#undef SR
+#undef RR
+
+void dss_sdi_init(u8 datapairs)
+{
+	u32 l;
+
+	BUG_ON(datapairs > 3 || datapairs < 1);
+
+	l = dss_read_reg(DSS_SDI_CONTROL);
+	l = FLD_MOD(l, 0xf, 19, 15);		/* SDI_PDIV */
+	l = FLD_MOD(l, datapairs-1, 3, 2);	/* SDI_PRSEL */
+	l = FLD_MOD(l, 2, 1, 0);		/* SDI_BWSEL */
+	dss_write_reg(DSS_SDI_CONTROL, l);
+
+	l = dss_read_reg(DSS_PLL_CONTROL);
+	l = FLD_MOD(l, 0x7, 25, 22);	/* SDI_PLL_FREQSEL */
+	l = FLD_MOD(l, 0xb, 16, 11);	/* SDI_PLL_REGN */
+	l = FLD_MOD(l, 0xb4, 10, 1);	/* SDI_PLL_REGM */
+	dss_write_reg(DSS_PLL_CONTROL, l);
+}
+
+void dss_sdi_enable(void)
+{
+	dispc_pck_free_enable(1);
+
+	/* Reset SDI PLL */
+	REG_FLD_MOD(DSS_PLL_CONTROL, 1, 18, 18); /* SDI_PLL_SYSRESET */
+	udelay(1);	/* wait 2x PCLK */
+
+	/* Lock SDI PLL */
+	REG_FLD_MOD(DSS_PLL_CONTROL, 1, 28, 28); /* SDI_PLL_GOBIT */
+
+	/* Waiting for PLL lock request to complete */
+	while (dss_read_reg(DSS_SDI_STATUS) & (1 << 6))
+		;
+
+	/* Clearing PLL_GO bit */
+	REG_FLD_MOD(DSS_PLL_CONTROL, 0, 28, 28);
+
+	/* Waiting for PLL to lock */
+	while (!(dss_read_reg(DSS_SDI_STATUS) & (1 << 5)))
+		;
+
+	dispc_lcd_enable_signal(1);
+
+	/* Waiting for SDI reset to complete */
+	while (!(dss_read_reg(DSS_SDI_STATUS) & (1 << 2)))
+		;
+}
+
+void dss_sdi_disable(void)
+{
+	dispc_lcd_enable_signal(0);
+
+	dispc_pck_free_enable(0);
+
+	/* Reset SDI PLL */
+	REG_FLD_MOD(DSS_PLL_CONTROL, 0, 18, 18); /* SDI_PLL_SYSRESET */
+}
+
+void dss_dump_regs(struct seq_file *s)
+{
+#define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dss_read_reg(r))
+
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+
+	DUMPREG(DSS_REVISION);
+	DUMPREG(DSS_SYSCONFIG);
+	DUMPREG(DSS_SYSSTATUS);
+	DUMPREG(DSS_IRQSTATUS);
+	DUMPREG(DSS_CONTROL);
+	DUMPREG(DSS_SDI_CONTROL);
+	DUMPREG(DSS_PLL_CONTROL);
+	DUMPREG(DSS_SDI_STATUS);
+
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+#undef DUMPREG
+}
+
+void dss_select_clk_source(bool dsi, bool dispc)
+{
+	u32 r;
+	r = dss_read_reg(DSS_CONTROL);
+	r = FLD_MOD(r, dsi, 1, 1);	/* DSI_CLK_SWITCH */
+	r = FLD_MOD(r, dispc, 0, 0);	/* DISPC_CLK_SWITCH */
+	dss_write_reg(DSS_CONTROL, r);
+}
+
+int dss_get_dsi_clk_source(void)
+{
+	return FLD_GET(dss_read_reg(DSS_CONTROL), 1, 1);
+}
+
+int dss_get_dispc_clk_source(void)
+{
+	return FLD_GET(dss_read_reg(DSS_CONTROL), 0, 0);
+}
+
+static irqreturn_t dss_irq_handler_omap2(int irq, void *arg)
+{
+	dispc_irq_handler();
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t dss_irq_handler_omap3(int irq, void *arg)
+{
+	u32 irqstatus;
+
+	irqstatus = dss_read_reg(DSS_IRQSTATUS);
+
+	if (irqstatus & (1<<0))	/* DISPC_IRQ */
+		dispc_irq_handler();
+#ifdef CONFIG_OMAP2_DSS_DSI
+	if (irqstatus & (1<<1))	/* DSI_IRQ */
+		dsi_irq_handler();
+#endif
+
+	return IRQ_HANDLED;
+}
+
+static int _omap_dss_wait_reset(void)
+{
+	unsigned timeout = 1000;
+
+	while (REG_GET(DSS_SYSSTATUS, 0, 0) == 0) {
+		udelay(1);
+		if (!--timeout) {
+			DSSERR("soft reset failed\n");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+static int _omap_dss_reset(void)
+{
+	/* Soft reset */
+	REG_FLD_MOD(DSS_SYSCONFIG, 1, 1, 1);
+	return _omap_dss_wait_reset();
+}
+
+void dss_set_venc_output(enum omap_dss_venc_type type)
+{
+	int l = 0;
+
+	if (type == OMAP_DSS_VENC_TYPE_COMPOSITE)
+		l = 0;
+	else if (type == OMAP_DSS_VENC_TYPE_SVIDEO)
+		l = 1;
+	else
+		BUG();
+
+	/* venc out selection. 0 = comp, 1 = svideo */
+	REG_FLD_MOD(DSS_CONTROL, l, 6, 6);
+}
+
+void dss_set_dac_pwrdn_bgz(bool enable)
+{
+	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
+}
+
+int dss_init(bool skip_init)
+{
+	int r;
+	u32 rev;
+
+	dss.base = ioremap(DSS_BASE, DSS_SZ_REGS);
+	if (!dss.base) {
+		DSSERR("can't ioremap DSS\n");
+		r = -ENOMEM;
+		goto fail0;
+	}
+
+	if (!skip_init) {
+		/* disable LCD and DIGIT output. This seems to fix the synclost
+		 * problem that we get, if the bootloader starts the DSS and
+		 * the kernel resets it */
+		omap_writel(omap_readl(0x48050440) & ~0x3, 0x48050440);
+
+		/* We need to wait here a bit, otherwise we sometimes start to
+		 * get synclost errors, and after that only power cycle will
+		 * restore DSS functionality. I have no idea why this happens.
+		 * And we have to wait _before_ resetting the DSS, but after
+		 * enabling clocks.
+		 */
+		msleep(50);
+
+		_omap_dss_reset();
+	}
+
+	/* autoidle */
+	REG_FLD_MOD(DSS_SYSCONFIG, 1, 0, 0);
+
+	/* Select DPLL */
+	REG_FLD_MOD(DSS_CONTROL, 0, 0, 0);
+
+#ifdef CONFIG_OMAP2_DSS_VENC
+	REG_FLD_MOD(DSS_CONTROL, 1, 4, 4);	/* venc dac demen */
+	REG_FLD_MOD(DSS_CONTROL, 1, 3, 3);	/* venc clock 4x enable */
+	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
+#endif
+
+	r = request_irq(INT_24XX_DSS_IRQ,
+			cpu_is_omap24xx()
+			? dss_irq_handler_omap2
+			: dss_irq_handler_omap3,
+			0, "OMAP DSS", NULL);
+
+	if (r < 0) {
+		DSSERR("omap2 dss: request_irq failed\n");
+		goto fail1;
+	}
+
+	dss_save_context();
+
+	rev = dss_read_reg(DSS_REVISION);
+	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
+			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
+
+	return 0;
+
+fail1:
+	iounmap(dss.base);
+fail0:
+	return r;
+}
+
+void dss_exit(void)
+{
+	free_irq(INT_24XX_DSS_IRQ, NULL);
+
+	iounmap(dss.base);
+}
+
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
new file mode 100644
index 0000000..50f7f5f
--- /dev/null
+++ b/drivers/video/omap2/dss/dss.h
@@ -0,0 +1,356 @@
+/*
+ * linux/drivers/video/omap2/dss/dss.h
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * Some code and ideas taken from drivers/video/omap/ driver
+ * by Imre Deak.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __OMAP2_DSS_H
+#define __OMAP2_DSS_H
+
+#ifdef CONFIG_OMAP2_DSS_DEBUG_SUPPORT
+#define DEBUG
+#endif
+
+#ifdef DEBUG
+extern unsigned int dss_debug;
+#ifdef DSS_SUBSYS_NAME
+#define DSSDBG(format, ...) \
+	if (dss_debug) \
+		printk(KERN_DEBUG "omapdss " DSS_SUBSYS_NAME ": " format, \
+		## __VA_ARGS__)
+#else
+#define DSSDBG(format, ...) \
+	if (dss_debug) \
+		printk(KERN_DEBUG "omapdss: " format, ## __VA_ARGS__)
+#endif
+
+#ifdef DSS_SUBSYS_NAME
+#define DSSDBGF(format, ...) \
+	if (dss_debug) \
+		printk(KERN_DEBUG "omapdss " DSS_SUBSYS_NAME \
+				": %s(" format ")\n", \
+				__func__, \
+				## __VA_ARGS__)
+#else
+#define DSSDBGF(format, ...) \
+	if (dss_debug) \
+		printk(KERN_DEBUG "omapdss: " \
+				": %s(" format ")\n", \
+				__func__, \
+				## __VA_ARGS__)
+#endif
+
+#else /* DEBUG */
+#define DSSDBG(format, ...)
+#define DSSDBGF(format, ...)
+#endif
+
+
+#ifdef DSS_SUBSYS_NAME
+#define DSSERR(format, ...) \
+	printk(KERN_ERR "omapdss " DSS_SUBSYS_NAME " error: " format, \
+	## __VA_ARGS__)
+#else
+#define DSSERR(format, ...) \
+	printk(KERN_ERR "omapdss error: " format, ## __VA_ARGS__)
+#endif
+
+#ifdef DSS_SUBSYS_NAME
+#define DSSINFO(format, ...) \
+	printk(KERN_INFO "omapdss " DSS_SUBSYS_NAME ": " format, \
+	## __VA_ARGS__)
+#else
+#define DSSINFO(format, ...) \
+	printk(KERN_INFO "omapdss: " format, ## __VA_ARGS__)
+#endif
+
+#ifdef DSS_SUBSYS_NAME
+#define DSSWARN(format, ...) \
+	printk(KERN_WARNING "omapdss " DSS_SUBSYS_NAME ": " format, \
+	## __VA_ARGS__)
+#else
+#define DSSWARN(format, ...) \
+	printk(KERN_WARNING "omapdss: " format, ## __VA_ARGS__)
+#endif
+
+/* OMAP TRM gives bitfields as start:end, where start is the higher bit
+   number. For example 7:0 */
+#define FLD_MASK(start, end)	(((1 << (start - end + 1)) - 1) << (end))
+#define FLD_VAL(val, start, end) (((val) << end) & FLD_MASK(start, end))
+#define FLD_GET(val, start, end) (((val) & FLD_MASK(start, end)) >> (end))
+#define FLD_MOD(orig, val, start, end) \
+	(((orig) & ~FLD_MASK(start, end)) | FLD_VAL(val, start, end))
+
+#define DISPC_MAX_FCK 173000000
+
+enum omap_burst_size {
+	OMAP_DSS_BURST_4x32 = 0,
+	OMAP_DSS_BURST_8x32 = 1,
+	OMAP_DSS_BURST_16x32 = 2,
+};
+
+enum omap_parallel_interface_mode {
+	OMAP_DSS_PARALLELMODE_BYPASS,		/* MIPI DPI */
+	OMAP_DSS_PARALLELMODE_RFBI,		/* MIPI DBI */
+	OMAP_DSS_PARALLELMODE_DSI,
+};
+
+enum dss_clock {
+	DSS_CLK_ICK	= 1 << 0,
+	DSS_CLK_FCK1	= 1 << 1,
+	DSS_CLK_FCK2	= 1 << 2,
+	DSS_CLK_54M	= 1 << 3,
+	DSS_CLK_96M	= 1 << 4,
+};
+
+struct dispc_clock_info {
+	/* rates that we get with dividers below */
+	unsigned long fck;
+	unsigned long lck;
+	unsigned long pck;
+
+	/* dividers */
+	u16 fck_div;
+	u16 lck_div;
+	u16 pck_div;
+};
+
+struct dsi_clock_info {
+	/* rates that we get with dividers below */
+	unsigned long fint;
+	unsigned long dsiphy;
+	unsigned long clkin;
+	unsigned long dsi1_pll_fclk;
+	unsigned long dsi2_pll_fclk;
+	unsigned long lck;
+	unsigned long pck;
+
+	/* dividers */
+	u16 regn;
+	u16 regm;
+	u16 regm3;
+	u16 regm4;
+
+	u16 lck_div;
+	u16 pck_div;
+
+	u8 highfreq;
+	bool use_dss2_fck;
+};
+
+struct seq_file;
+struct platform_device;
+
+/* core */
+void dss_clk_enable(enum dss_clock clks);
+void dss_clk_disable(enum dss_clock clks);
+unsigned long dss_clk_get_rate(enum dss_clock clk);
+int dss_need_ctx_restore(void);
+void dss_dump_clocks(struct seq_file *s);
+struct bus_type *dss_get_bus(void);
+
+/* display */
+int dss_suspend_all_devices(void);
+int dss_resume_all_devices(void);
+
+void dss_init_device(struct platform_device *pdev,
+		struct omap_dss_device *dssdev);
+void dss_uninit_device(struct platform_device *pdev,
+		struct omap_dss_device *dssdev);
+bool dss_use_replication(struct omap_dss_device *dssdev,
+		enum omap_color_mode mode);
+void default_get_overlay_fifo_thresholds(enum omap_plane plane,
+		u32 fifo_size, enum omap_burst_size *burst_size,
+		u32 *fifo_low, u32 *fifo_high);
+
+/* manager */
+int dss_init_overlay_managers(struct platform_device *pdev);
+void dss_uninit_overlay_managers(struct platform_device *pdev);
+int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl);
+void dss_setup_partial_planes(struct omap_dss_device *dssdev,
+				u16 *x, u16 *y, u16 *w, u16 *h);
+void dss_start_update(struct omap_dss_device *dssdev);
+
+/* overlay */
+void dss_init_overlays(struct platform_device *pdev);
+void dss_uninit_overlays(struct platform_device *pdev);
+int dss_check_overlay(struct omap_overlay *ovl, struct omap_dss_device *dssdev);
+void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr);
+#ifdef L4_EXAMPLE
+void dss_overlay_setup_l4_manager(struct omap_overlay_manager *mgr);
+#endif
+void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
+
+/* DSS */
+int dss_init(bool skip_init);
+void dss_exit(void);
+
+void dss_save_context(void);
+void dss_restore_context(void);
+
+void dss_dump_regs(struct seq_file *s);
+
+void dss_sdi_init(u8 datapairs);
+void dss_sdi_enable(void);
+void dss_sdi_disable(void);
+
+void dss_select_clk_source(bool dsi, bool dispc);
+int dss_get_dsi_clk_source(void);
+int dss_get_dispc_clk_source(void);
+void dss_set_venc_output(enum omap_dss_venc_type type);
+void dss_set_dac_pwrdn_bgz(bool enable);
+
+/* SDI */
+int sdi_init(bool skip_init);
+void sdi_exit(void);
+int sdi_init_display(struct omap_dss_device *display);
+
+/* DSI */
+int dsi_init(struct platform_device *pdev);
+void dsi_exit(void);
+
+void dsi_dump_clocks(struct seq_file *s);
+void dsi_dump_regs(struct seq_file *s);
+
+void dsi_save_context(void);
+void dsi_restore_context(void);
+
+int dsi_init_display(struct omap_dss_device *display);
+void dsi_irq_handler(void);
+unsigned long dsi_get_dsi1_pll_rate(void);
+unsigned long dsi_get_dsi2_pll_rate(void);
+int dsi_pll_calc_pck(bool is_tft, unsigned long req_pck,
+		struct dsi_clock_info *cinfo);
+int dsi_pll_program(struct dsi_clock_info *cinfo);
+int dsi_pll_init(bool enable_hsclk, bool enable_hsdiv);
+void dsi_pll_uninit(void);
+void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
+		u32 fifo_size, enum omap_burst_size *burst_size,
+		u32 *fifo_low, u32 *fifo_high);
+
+/* DPI */
+int dpi_init(void);
+void dpi_exit(void);
+int dpi_init_display(struct omap_dss_device *dssdev);
+
+/* DISPC */
+int dispc_init(void);
+void dispc_exit(void);
+void dispc_dump_clocks(struct seq_file *s);
+void dispc_dump_regs(struct seq_file *s);
+void dispc_irq_handler(void);
+void dispc_fake_vsync_irq(void);
+
+void dispc_save_context(void);
+void dispc_restore_context(void);
+
+void dispc_enable_sidle(void);
+void dispc_disable_sidle(void);
+
+void dispc_lcd_enable_signal_polarity(bool act_high);
+void dispc_lcd_enable_signal(bool enable);
+void dispc_pck_free_enable(bool enable);
+void dispc_enable_fifohandcheck(bool enable);
+
+void dispc_set_lcd_size(u16 width, u16 height);
+void dispc_set_digit_size(u16 width, u16 height);
+u32 dispc_get_plane_fifo_size(enum omap_plane plane);
+void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high);
+void dispc_enable_fifomerge(bool enable);
+void dispc_set_burst_size(enum omap_plane plane,
+		enum omap_burst_size burst_size);
+
+void dispc_set_plane_ba0(enum omap_plane plane, u32 paddr);
+void dispc_set_plane_ba1(enum omap_plane plane, u32 paddr);
+void dispc_set_plane_pos(enum omap_plane plane, u16 x, u16 y);
+void dispc_set_plane_size(enum omap_plane plane, u16 width, u16 height);
+void dispc_set_channel_out(enum omap_plane plane,
+		enum omap_channel channel_out);
+
+int dispc_setup_plane(enum omap_plane plane,
+		      u32 paddr, u16 screen_width,
+		      u16 pos_x, u16 pos_y,
+		      u16 width, u16 height,
+		      u16 out_width, u16 out_height,
+		      enum omap_color_mode color_mode,
+		      bool ilace,
+		      enum omap_dss_rotation_type rotation_type,
+		      u8 rotation, bool mirror,
+		      u8 global_alpha);
+
+bool dispc_go_busy(enum omap_channel channel);
+void dispc_go(enum omap_channel channel);
+void dispc_enable_lcd_out(bool enable);
+void dispc_enable_digit_out(bool enable);
+int dispc_enable_plane(enum omap_plane plane, bool enable);
+void dispc_enable_replication(enum omap_plane plane, bool enable);
+
+void dispc_set_parallel_interface_mode(enum omap_parallel_interface_mode mode);
+void dispc_set_tft_data_lines(u8 data_lines);
+void dispc_set_lcd_display_type(enum omap_lcd_display_type type);
+void dispc_set_loadmode(enum omap_dss_load_mode mode);
+
+void dispc_set_default_color(enum omap_channel channel, u32 color);
+u32 dispc_get_default_color(enum omap_channel channel);
+void dispc_set_trans_key(enum omap_channel ch,
+		enum omap_dss_trans_key_type type,
+		u32 trans_key);
+void dispc_get_trans_key(enum omap_channel ch,
+		enum omap_dss_trans_key_type *type,
+		u32 *trans_key);
+void dispc_enable_trans_key(enum omap_channel ch, bool enable);
+void dispc_enable_alpha_blending(enum omap_channel ch, bool enable);
+bool dispc_trans_key_enabled(enum omap_channel ch);
+bool dispc_alpha_blending_enabled(enum omap_channel ch);
+
+bool dispc_lcd_timings_ok(struct omap_video_timings *timings);
+void dispc_set_lcd_timings(struct omap_video_timings *timings);
+unsigned long dispc_fclk_rate(void);
+unsigned long dispc_lclk_rate(void);
+unsigned long dispc_pclk_rate(void);
+void dispc_set_pol_freq(enum omap_panel_config config, u8 acbi, u8 acb);
+void find_lck_pck_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
+		u16 *lck_div, u16 *pck_div);
+int dispc_calc_clock_div(bool is_tft, unsigned long req_pck,
+		struct dispc_clock_info *cinfo);
+int dispc_set_clock_div(struct dispc_clock_info *cinfo);
+int dispc_get_clock_div(struct dispc_clock_info *cinfo);
+void dispc_set_lcd_divisor(u16 lck_div, u16 pck_div);
+
+
+/* VENC */
+int venc_init(struct platform_device *pdev);
+void venc_exit(void);
+void venc_dump_regs(struct seq_file *s);
+int venc_init_display(struct omap_dss_device *display);
+
+/* RFBI */
+int rfbi_init(void);
+void rfbi_exit(void);
+void rfbi_dump_regs(struct seq_file *s);
+
+int rfbi_configure(int rfbi_module, int bpp, int lines);
+void rfbi_enable_rfbi(bool enable);
+void rfbi_transfer_area(u16 width, u16 height,
+			     void (callback)(void *data), void *data);
+void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t);
+unsigned long rfbi_get_max_tx_rate(void);
+int rfbi_init_display(struct omap_dss_device *display);
+
+#endif
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
new file mode 100644
index 0000000..7ee0b2b
--- /dev/null
+++ b/drivers/video/omap2/dss/manager.c
@@ -0,0 +1,1487 @@
+/*
+ * linux/drivers/video/omap2/dss/manager.c
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * Some code and ideas taken from drivers/video/omap/ driver
+ * by Imre Deak.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define DSS_SUBSYS_NAME "MANAGER"
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/jiffies.h>
+
+#include <mach/display.h>
+#include <mach/cpu.h>
+
+#include "dss.h"
+
+static int num_managers;
+static struct list_head manager_list;
+
+static ssize_t manager_name_show(struct omap_overlay_manager *mgr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", mgr->name);
+}
+
+static ssize_t manager_display_show(struct omap_overlay_manager *mgr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			mgr->device ? mgr->device->name : "<none>");
+}
+
+static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
+		const char *buf, size_t size)
+{
+	int r = 0;
+	size_t len = size;
+	struct omap_dss_device *dssdev = NULL;
+
+	int match(struct omap_dss_device *dssdev, void *data)
+	{
+		const char *str = data;
+		return sysfs_streq(dssdev->name, str);
+	}
+
+	if (buf[size-1] == '\n')
+		--len;
+
+	if (len > 0)
+		dssdev = omap_dss_find_device((void *)buf, match);
+
+	if (len > 0 && dssdev == NULL)
+		return -EINVAL;
+
+	if (dssdev)
+		DSSDBG("display %s found\n", dssdev->name);
+
+	if (mgr->device) {
+		r = mgr->unset_device(mgr);
+		if (r) {
+			DSSERR("failed to unset display\n");
+			goto put_device;
+		}
+	}
+
+	if (dssdev) {
+		r = mgr->set_device(mgr, dssdev);
+		if (r) {
+			DSSERR("failed to set manager\n");
+			goto put_device;
+		}
+
+		r = mgr->apply(mgr);
+		if (r) {
+			DSSERR("failed to apply dispc config\n");
+			goto put_device;
+		}
+	}
+
+put_device:
+	if (dssdev)
+		omap_dss_put_device(dssdev);
+
+	return r ? r : size;
+}
+
+static ssize_t manager_default_color_show(struct omap_overlay_manager *mgr,
+					  char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", mgr->info.default_color);
+}
+
+static ssize_t manager_default_color_store(struct omap_overlay_manager *mgr,
+					   const char *buf, size_t size)
+{
+	struct omap_overlay_manager_info info;
+	u32 color;
+	int r;
+
+	if (sscanf(buf, "%d", &color) != 1)
+		return -EINVAL;
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.default_color = color;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static const char *trans_key_type_str[] = {
+	"gfx-destination",
+	"video-source",
+};
+
+static ssize_t manager_trans_key_type_show(struct omap_overlay_manager *mgr,
+					   char *buf)
+{
+	enum omap_dss_trans_key_type key_type;
+
+	key_type = mgr->info.trans_key_type;
+	BUG_ON(key_type >= ARRAY_SIZE(trans_key_type_str));
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", trans_key_type_str[key_type]);
+}
+
+static ssize_t manager_trans_key_type_store(struct omap_overlay_manager *mgr,
+					    const char *buf, size_t size)
+{
+	enum omap_dss_trans_key_type key_type;
+	struct omap_overlay_manager_info info;
+	int r;
+
+	for (key_type = OMAP_DSS_COLOR_KEY_GFX_DST;
+			key_type < ARRAY_SIZE(trans_key_type_str); key_type++) {
+		if (sysfs_streq(buf, trans_key_type_str[key_type]))
+			break;
+	}
+
+	if (key_type == ARRAY_SIZE(trans_key_type_str))
+		return -EINVAL;
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.trans_key_type = key_type;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t manager_trans_key_value_show(struct omap_overlay_manager *mgr,
+					    char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", mgr->info.trans_key);
+}
+
+static ssize_t manager_trans_key_value_store(struct omap_overlay_manager *mgr,
+					     const char *buf, size_t size)
+{
+	struct omap_overlay_manager_info info;
+	u32 key_value;
+	int r;
+
+	if (sscanf(buf, "%d", &key_value) != 1)
+		return -EINVAL;
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.trans_key = key_value;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t manager_trans_key_enabled_show(struct omap_overlay_manager *mgr,
+					      char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", mgr->info.trans_enabled);
+}
+
+static ssize_t manager_trans_key_enabled_store(struct omap_overlay_manager *mgr,
+					       const char *buf, size_t size)
+{
+	struct omap_overlay_manager_info info;
+	int enable;
+	int r;
+
+	if (sscanf(buf, "%d", &enable) != 1)
+		return -EINVAL;
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.trans_enabled = enable ? true : false;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t manager_alpha_blending_enabled_show(
+		struct omap_overlay_manager *mgr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", mgr->info.alpha_enabled);
+}
+
+static ssize_t manager_alpha_blending_enabled_store(
+		struct omap_overlay_manager *mgr,
+		const char *buf, size_t size)
+{
+	struct omap_overlay_manager_info info;
+	int enable;
+	int r;
+
+	if (sscanf(buf, "%d", &enable) != 1)
+		return -EINVAL;
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.alpha_enabled = enable ? true : false;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+struct manager_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct omap_overlay_manager *, char *);
+	ssize_t	(*store)(struct omap_overlay_manager *, const char *, size_t);
+};
+
+#define MANAGER_ATTR(_name, _mode, _show, _store) \
+	struct manager_attribute manager_attr_##_name = \
+	__ATTR(_name, _mode, _show, _store)
+
+static MANAGER_ATTR(name, S_IRUGO, manager_name_show, NULL);
+static MANAGER_ATTR(display, S_IRUGO|S_IWUSR,
+		manager_display_show, manager_display_store);
+static MANAGER_ATTR(default_color, S_IRUGO|S_IWUSR,
+		manager_default_color_show, manager_default_color_store);
+static MANAGER_ATTR(trans_key_type, S_IRUGO|S_IWUSR,
+		manager_trans_key_type_show, manager_trans_key_type_store);
+static MANAGER_ATTR(trans_key_value, S_IRUGO|S_IWUSR,
+		manager_trans_key_value_show, manager_trans_key_value_store);
+static MANAGER_ATTR(trans_key_enabled, S_IRUGO|S_IWUSR,
+		manager_trans_key_enabled_show,
+		manager_trans_key_enabled_store);
+static MANAGER_ATTR(alpha_blending_enabled, S_IRUGO|S_IWUSR,
+		manager_alpha_blending_enabled_show,
+		manager_alpha_blending_enabled_store);
+
+
+static struct attribute *manager_sysfs_attrs[] = {
+	&manager_attr_name.attr,
+	&manager_attr_display.attr,
+	&manager_attr_default_color.attr,
+	&manager_attr_trans_key_type.attr,
+	&manager_attr_trans_key_value.attr,
+	&manager_attr_trans_key_enabled.attr,
+	&manager_attr_alpha_blending_enabled.attr,
+	NULL
+};
+
+static ssize_t manager_attr_show(struct kobject *kobj, struct attribute *attr,
+		char *buf)
+{
+	struct omap_overlay_manager *manager;
+	struct manager_attribute *manager_attr;
+
+	manager = container_of(kobj, struct omap_overlay_manager, kobj);
+	manager_attr = container_of(attr, struct manager_attribute, attr);
+
+	if (!manager_attr->show)
+		return -ENOENT;
+
+	return manager_attr->show(manager, buf);
+}
+
+static ssize_t manager_attr_store(struct kobject *kobj, struct attribute *attr,
+		const char *buf, size_t size)
+{
+	struct omap_overlay_manager *manager;
+	struct manager_attribute *manager_attr;
+
+	manager = container_of(kobj, struct omap_overlay_manager, kobj);
+	manager_attr = container_of(attr, struct manager_attribute, attr);
+
+	if (!manager_attr->store)
+		return -ENOENT;
+
+	return manager_attr->store(manager, buf, size);
+}
+
+static struct sysfs_ops manager_sysfs_ops = {
+	.show = manager_attr_show,
+	.store = manager_attr_store,
+};
+
+static struct kobj_type manager_ktype = {
+	.sysfs_ops = &manager_sysfs_ops,
+	.default_attrs = manager_sysfs_attrs,
+};
+
+/*
+ * We have 4 levels of cache for the dispc settings. First two are in SW and
+ * the latter two in HW.
+ *
+ * +--------------------+
+ * |overlay/manager_info|
+ * +--------------------+
+ *          v
+ *        apply()
+ *          v
+ * +--------------------+
+ * |     dss_cache      |
+ * +--------------------+
+ *          v
+ *      configure()
+ *          v
+ * +--------------------+
+ * |  shadow registers  |
+ * +--------------------+
+ *          v
+ * VFP or lcd/digit_enable
+ *          v
+ * +--------------------+
+ * |      registers     |
+ * +--------------------+
+ */
+
+struct overlay_cache_data {
+	/* If true, cache changed, but not written to shadow registers. Set
+	 * in apply(), cleared when registers written. */
+	bool dirty;
+	/* If true, shadow registers contain changed values not yet in real
+	 * registers. Set when writing to shadow registers, cleared at
+	 * VSYNC/EVSYNC */
+	bool shadow_dirty;
+
+	bool enabled;
+
+	u32 paddr;
+	void __iomem *vaddr;
+	u16 screen_width;
+	u16 width;
+	u16 height;
+	enum omap_color_mode color_mode;
+	u8 rotation;
+	enum omap_dss_rotation_type rotation_type;
+	bool mirror;
+
+	u16 pos_x;
+	u16 pos_y;
+	u16 out_width;	/* if 0, out_width == width */
+	u16 out_height;	/* if 0, out_height == height */
+	u8 global_alpha;
+
+	enum omap_channel channel;
+	bool replication;
+	bool ilace;
+
+	enum omap_burst_size burst_size;
+	u32 fifo_low;
+	u32 fifo_high;
+
+	bool manual_update;
+};
+
+struct manager_cache_data {
+	/* If true, cache changed, but not written to shadow registers. Set
+	 * in apply(), cleared when registers written. */
+	bool dirty;
+	/* If true, shadow registers contain changed values not yet in real
+	 * registers. Set when writing to shadow registers, cleared at
+	 * VSYNC/EVSYNC */
+	bool shadow_dirty;
+
+	u32 default_color;
+
+	enum omap_dss_trans_key_type trans_key_type;
+	u32 trans_key;
+	bool trans_enabled;
+
+	bool alpha_enabled;
+
+	bool manual_upd_display;
+	bool manual_update;
+	bool do_manual_update;
+
+	/* manual update region */
+	u16 x, y, w, h;
+};
+
+static struct {
+	spinlock_t lock;
+	struct overlay_cache_data overlay_cache[3];
+	struct manager_cache_data manager_cache[2];
+
+	bool irq_enabled;
+} dss_cache;
+
+
+
+static int omap_dss_set_device(struct omap_overlay_manager *mgr,
+		struct omap_dss_device *dssdev)
+{
+	int i;
+	int r;
+
+	if (dssdev->manager) {
+		DSSERR("display '%s' already has a manager '%s'\n",
+			       dssdev->name, dssdev->manager->name);
+		return -EINVAL;
+	}
+
+	if ((mgr->supported_displays & dssdev->type) == 0) {
+		DSSERR("display '%s' does not support manager '%s'\n",
+			       dssdev->name, mgr->name);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < mgr->num_overlays; i++) {
+		struct omap_overlay *ovl = mgr->overlays[i];
+
+		if (ovl->manager != mgr || !ovl->info.enabled)
+			continue;
+
+		r = dss_check_overlay(ovl, dssdev);
+		if (r)
+			return r;
+	}
+
+	dssdev->manager = mgr;
+	mgr->device = dssdev;
+	mgr->device_changed = true;
+
+	return 0;
+}
+
+static int omap_dss_unset_device(struct omap_overlay_manager *mgr)
+{
+	if (!mgr->device) {
+		DSSERR("failed to unset display, display not set.\n");
+		return -EINVAL;
+	}
+
+	mgr->device->manager = NULL;
+	mgr->device = NULL;
+	mgr->device_changed = true;
+
+	return 0;
+}
+
+static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
+{
+	unsigned long timeout = msecs_to_jiffies(500);
+	struct manager_cache_data *mc;
+	enum omap_channel channel;
+	u32 irq;
+	int r;
+	int i;
+
+	if (!mgr->device)
+		return 0;
+
+	if (mgr->device->type == OMAP_DISPLAY_TYPE_VENC) {
+		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
+		channel = OMAP_DSS_CHANNEL_DIGIT;
+	} else {
+		if (mgr->device->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
+			enum omap_dss_update_mode mode;
+			mode = mgr->device->get_update_mode(mgr->device);
+			if (mode != OMAP_DSS_UPDATE_AUTO)
+				return 0;
+
+			irq = DISPC_IRQ_FRAMEDONE;
+		} else {
+			irq = DISPC_IRQ_VSYNC;
+		}
+		channel = OMAP_DSS_CHANNEL_LCD;
+	}
+
+	mc = &dss_cache.manager_cache[mgr->id];
+	i = 0;
+	while (1) {
+		unsigned long flags;
+		bool shadow_dirty, dirty;
+
+		spin_lock_irqsave(&dss_cache.lock, flags);
+		dirty = mc->dirty;
+		shadow_dirty = mc->shadow_dirty;
+		spin_unlock_irqrestore(&dss_cache.lock, flags);
+
+		if (!dirty && !shadow_dirty) {
+			r = 0;
+			break;
+		}
+
+		/* 4 iterations is the worst case:
+		 * 1 - initial iteration, dirty = true (between VFP and VSYNC)
+		 * 2 - first VSYNC, dirty = true
+		 * 3 - dirty = false, shadow_dirty = true
+		 * 4 - shadow_dirty = false */
+		if (i++ == 3) {
+			DSSERR("mgr(%d)->wait_for_go() not finishing\n",
+					mgr->id);
+			r = 0;
+			break;
+		}
+
+		r = omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
+		if (r == -ERESTARTSYS)
+			break;
+
+		if (r) {
+			DSSERR("mgr(%d)->wait_for_go() timeout\n", mgr->id);
+			break;
+		}
+	}
+
+	return r;
+}
+
+int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
+{
+	unsigned long timeout = msecs_to_jiffies(500);
+	enum omap_channel channel;
+	struct overlay_cache_data *oc;
+	struct omap_dss_device *dssdev;
+	u32 irq;
+	int r;
+	int i;
+
+	if (!ovl->manager || !ovl->manager->device)
+		return 0;
+
+	dssdev = ovl->manager->device;
+
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
+		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
+		channel = OMAP_DSS_CHANNEL_DIGIT;
+	} else {
+		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
+			enum omap_dss_update_mode mode;
+			mode = dssdev->get_update_mode(dssdev);
+			if (mode != OMAP_DSS_UPDATE_AUTO)
+				return 0;
+
+			irq = DISPC_IRQ_FRAMEDONE;
+		} else {
+			irq = DISPC_IRQ_VSYNC;
+		}
+		channel = OMAP_DSS_CHANNEL_LCD;
+	}
+
+	oc = &dss_cache.overlay_cache[ovl->id];
+	i = 0;
+	while (1) {
+		unsigned long flags;
+		bool shadow_dirty, dirty;
+
+		spin_lock_irqsave(&dss_cache.lock, flags);
+		dirty = oc->dirty;
+		shadow_dirty = oc->shadow_dirty;
+		spin_unlock_irqrestore(&dss_cache.lock, flags);
+
+		if (!dirty && !shadow_dirty) {
+			r = 0;
+			break;
+		}
+
+		/* 4 iterations is the worst case:
+		 * 1 - initial iteration, dirty = true (between VFP and VSYNC)
+		 * 2 - first VSYNC, dirty = true
+		 * 3 - dirty = false, shadow_dirty = true
+		 * 4 - shadow_dirty = false */
+		if (i++ == 3) {
+			DSSERR("ovl(%d)->wait_for_go() not finishing\n",
+					ovl->id);
+			r = 0;
+			break;
+		}
+
+		r = omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
+		if (r == -ERESTARTSYS)
+			break;
+
+		if (r) {
+			DSSERR("ovl(%d)->wait_for_go() timeout\n", ovl->id);
+			break;
+		}
+	}
+
+	return r;
+}
+
+static int overlay_enabled(struct omap_overlay *ovl)
+{
+	return ovl->info.enabled && ovl->manager && ovl->manager->device;
+}
+
+/* Is rect1 a subset of rect2? */
+static bool rectangle_subset(int x1, int y1, int w1, int h1,
+		int x2, int y2, int w2, int h2)
+{
+	if (x1 < x2 || y1 < y2)
+		return false;
+
+	if (x1 + w1 > x2 + w2)
+		return false;
+
+	if (y1 + h1 > y2 + h2)
+		return false;
+
+	return true;
+}
+
+/* Do rect1 and rect2 overlap? */
+static bool rectangle_intersects(int x1, int y1, int w1, int h1,
+		int x2, int y2, int w2, int h2)
+{
+	if (x1 >= x2 + w2)
+		return false;
+
+	if (x2 >= x1 + w1)
+		return false;
+
+	if (y1 >= y2 + h2)
+		return false;
+
+	if (y2 >= y1 + h1)
+		return false;
+
+	return true;
+}
+
+static bool dispc_is_overlay_scaled(struct overlay_cache_data *oc)
+{
+	if (oc->out_width != 0 && oc->width != oc->out_width)
+		return true;
+
+	if (oc->out_height != 0 && oc->height != oc->out_height)
+		return true;
+
+	return false;
+}
+
+static int configure_overlay(enum omap_plane plane)
+{
+	struct overlay_cache_data *c;
+	struct manager_cache_data *mc;
+	u16 outw, outh;
+	u16 x, y, w, h;
+	u32 paddr;
+	int r;
+
+	DSSDBGF("%d", plane);
+
+	c = &dss_cache.overlay_cache[plane];
+
+	if (!c->enabled) {
+		dispc_enable_plane(plane, 0);
+		return 0;
+	}
+
+	mc = &dss_cache.manager_cache[c->channel];
+
+	x = c->pos_x;
+	y = c->pos_y;
+	w = c->width;
+	h = c->height;
+	outw = c->out_width == 0 ? c->width : c->out_width;
+	outh = c->out_height == 0 ? c->height : c->out_height;
+	paddr = c->paddr;
+
+	if (c->manual_update && mc->do_manual_update) {
+		unsigned bpp;
+		/* If the overlay is outside the update region, disable it */
+		if (!rectangle_intersects(mc->x, mc->y, mc->w, mc->h,
+					x, y, outw, outh)) {
+			dispc_enable_plane(plane, 0);
+			return 0;
+		}
+
+		switch (c->color_mode) {
+		case OMAP_DSS_COLOR_RGB16:
+		case OMAP_DSS_COLOR_ARGB16:
+		case OMAP_DSS_COLOR_YUV2:
+		case OMAP_DSS_COLOR_UYVY:
+			bpp = 16;
+			break;
+
+		case OMAP_DSS_COLOR_RGB24P:
+			bpp = 24;
+			break;
+
+		case OMAP_DSS_COLOR_RGB24U:
+		case OMAP_DSS_COLOR_ARGB32:
+		case OMAP_DSS_COLOR_RGBA32:
+		case OMAP_DSS_COLOR_RGBX32:
+			bpp = 32;
+			break;
+
+		default:
+			BUG();
+		}
+
+		if (dispc_is_overlay_scaled(c)) {
+			/* If the overlay is scaled, the update area has
+			 * already been enlarged to cover the whole overlay. We
+			 * only need to adjust x/y here */
+			x = c->pos_x - mc->x;
+			y = c->pos_y - mc->y;
+		} else {
+			if (mc->x > c->pos_x) {
+				x = 0;
+				w -= (mc->x - c->pos_x);
+				paddr += (mc->x - c->pos_x) * bpp / 8;
+			} else {
+				x = c->pos_x - mc->x;
+			}
+
+			if (mc->y > c->pos_y) {
+				y = 0;
+				h -= (mc->y - c->pos_y);
+				paddr += (mc->y - c->pos_y) * c->screen_width *
+					bpp / 8;
+			} else {
+				y = c->pos_y - mc->y;
+			}
+
+			if (mc->w < (x+w))
+				w -= (x+w) - (mc->w);
+
+			if (mc->h < (y+h))
+				h -= (y+h) - (mc->h);
+
+			outw = w;
+			outh = h;
+		}
+	}
+
+	r = dispc_setup_plane(plane,
+			paddr,
+			c->screen_width,
+			x, y,
+			w, h,
+			outw, outh,
+			c->color_mode,
+			c->ilace,
+			c->rotation_type,
+			c->rotation,
+			c->mirror,
+			c->global_alpha);
+
+	if (r) {
+		/* this shouldn't happen */
+		DSSERR("dispc_setup_plane failed for ovl %d\n", plane);
+		dispc_enable_plane(plane, 0);
+		return r;
+	}
+
+	dispc_enable_replication(plane, c->replication);
+
+	dispc_set_burst_size(plane, c->burst_size);
+	dispc_setup_plane_fifo(plane, c->fifo_low, c->fifo_high);
+
+	dispc_enable_plane(plane, 1);
+
+	return 0;
+}
+
+static void configure_manager(enum omap_channel channel)
+{
+	struct manager_cache_data *c;
+
+	DSSDBGF("%d", channel);
+
+	c = &dss_cache.manager_cache[channel];
+
+	dispc_set_trans_key(channel, c->trans_key_type, c->trans_key);
+	dispc_enable_trans_key(channel, c->trans_enabled);
+	dispc_enable_alpha_blending(channel, c->alpha_enabled);
+}
+
+/* configure_dispc() tries to write values from cache to shadow registers.
+ * It writes only to those managers/overlays that are not busy.
+ * returns 0 if everything could be written to shadow registers.
+ * returns 1 if not everything could be written to shadow registers. */
+static int configure_dispc(void)
+{
+	struct overlay_cache_data *oc;
+	struct manager_cache_data *mc;
+	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
+	const int num_mgrs = ARRAY_SIZE(dss_cache.manager_cache);
+	int i;
+	int r;
+	bool mgr_busy[2];
+	bool mgr_go[2];
+	bool busy;
+
+	r = 0;
+	busy = false;
+
+	mgr_busy[0] = dispc_go_busy(0);
+	mgr_busy[1] = dispc_go_busy(1);
+	mgr_go[0] = false;
+	mgr_go[1] = false;
+
+	/* Commit overlay settings */
+	for (i = 0; i < num_ovls; ++i) {
+		oc = &dss_cache.overlay_cache[i];
+		mc = &dss_cache.manager_cache[oc->channel];
+
+		if (!oc->dirty)
+			continue;
+
+		if (oc->manual_update && !mc->do_manual_update)
+			continue;
+
+		if (mgr_busy[oc->channel]) {
+			busy = true;
+			continue;
+		}
+
+		r = configure_overlay(i);
+		if (r)
+			DSSERR("configure_overlay %d failed\n", i);
+
+		oc->dirty = false;
+		oc->shadow_dirty = true;
+		mgr_go[oc->channel] = true;
+	}
+
+	/* Commit manager settings */
+	for (i = 0; i < num_mgrs; ++i) {
+		mc = &dss_cache.manager_cache[i];
+
+		if (!mc->dirty)
+			continue;
+
+		if (mc->manual_update && !mc->do_manual_update)
+			continue;
+
+		if (mgr_busy[i]) {
+			busy = true;
+			continue;
+		}
+
+		configure_manager(i);
+		mc->dirty = false;
+		mc->shadow_dirty = true;
+		mgr_go[i] = true;
+	}
+
+	/* set GO */
+	for (i = 0; i < num_mgrs; ++i) {
+		mc = &dss_cache.manager_cache[i];
+
+		if (!mgr_go[i])
+			continue;
+
+		/* We don't need GO with manual update display. LCD iface will
+		 * always be turned off after frame, and new settings will be
+		 * taken in to use at next update */
+		if (!mc->manual_upd_display)
+			dispc_go(i);
+	}
+
+	if (busy)
+		r = 1;
+	else
+		r = 0;
+
+	return r;
+}
+
+/* Configure dispc for partial update. Return possibly modified update
+ * area */
+void dss_setup_partial_planes(struct omap_dss_device *dssdev,
+		u16 *xi, u16 *yi, u16 *wi, u16 *hi)
+{
+	struct overlay_cache_data *oc;
+	struct manager_cache_data *mc;
+	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
+	struct omap_overlay_manager *mgr;
+	int i;
+	u16 x, y, w, h;
+	unsigned long flags;
+
+	x = *xi;
+	y = *yi;
+	w = *wi;
+	h = *hi;
+
+	DSSDBG("dispc_setup_partial_planes %d,%d %dx%d\n",
+		*xi, *yi, *wi, *hi);
+
+	mgr = dssdev->manager;
+
+	if (!mgr) {
+		DSSDBG("no manager\n");
+		return;
+	}
+
+	spin_lock_irqsave(&dss_cache.lock, flags);
+
+	/* We need to show the whole overlay if it is scaled. So look for
+	 * those, and make the update area larger if found.
+	 * Also mark the overlay cache dirty */
+	for (i = 0; i < num_ovls; ++i) {
+		unsigned x1, y1, x2, y2;
+		unsigned outw, outh;
+
+		oc = &dss_cache.overlay_cache[i];
+
+		if (oc->channel != mgr->id)
+			continue;
+
+		oc->dirty = true;
+
+		if (!oc->enabled)
+			continue;
+
+		if (!dispc_is_overlay_scaled(oc))
+			continue;
+
+		outw = oc->out_width == 0 ? oc->width : oc->out_width;
+		outh = oc->out_height == 0 ? oc->height : oc->out_height;
+
+		/* is the overlay outside the update region? */
+		if (!rectangle_intersects(x, y, w, h,
+					oc->pos_x, oc->pos_y,
+					outw, outh))
+			continue;
+
+		/* if the overlay totally inside the update region? */
+		if (rectangle_subset(oc->pos_x, oc->pos_y, outw, outh,
+					x, y, w, h))
+			continue;
+
+		if (x > oc->pos_x)
+			x1 = oc->pos_x;
+		else
+			x1 = x;
+
+		if (y > oc->pos_y)
+			y1 = oc->pos_y;
+		else
+			y1 = y;
+
+		if ((x + w) < (oc->pos_x + outw))
+			x2 = oc->pos_x + outw;
+		else
+			x2 = x + w;
+
+		if ((y + h) < (oc->pos_y + outh))
+			y2 = oc->pos_y + outh;
+		else
+			y2 = y + h;
+
+		x = x1;
+		y = y1;
+		w = x2 - x1;
+		h = y2 - y1;
+
+		DSSDBG("changing upd area due to ovl(%d) scaling %d,%d %dx%d\n",
+				i, x, y, w, h);
+	}
+
+	mc = &dss_cache.manager_cache[mgr->id];
+	mc->do_manual_update = true;
+	mc->x = x;
+	mc->y = y;
+	mc->w = w;
+	mc->h = h;
+
+	configure_dispc();
+
+	mc->do_manual_update = false;
+
+	spin_unlock_irqrestore(&dss_cache.lock, flags);
+
+	*xi = x;
+	*yi = y;
+	*wi = w;
+	*hi = h;
+}
+
+void dss_start_update(struct omap_dss_device *dssdev)
+{
+	struct manager_cache_data *mc;
+	struct overlay_cache_data *oc;
+	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
+	const int num_mgrs = ARRAY_SIZE(dss_cache.manager_cache);
+	struct omap_overlay_manager *mgr;
+	int i;
+
+	mgr = dssdev->manager;
+
+	for (i = 0; i < num_ovls; ++i) {
+		oc = &dss_cache.overlay_cache[i];
+		if (oc->channel != mgr->id)
+			continue;
+
+		oc->shadow_dirty = false;
+	}
+
+	for (i = 0; i < num_mgrs; ++i) {
+		mc = &dss_cache.manager_cache[i];
+		if (mgr->id != i)
+			continue;
+
+		mc->shadow_dirty = false;
+	}
+
+	dispc_enable_lcd_out(1);
+}
+
+static void dss_apply_irq_handler(void *data, u32 mask)
+{
+	struct manager_cache_data *mc;
+	struct overlay_cache_data *oc;
+	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
+	const int num_mgrs = ARRAY_SIZE(dss_cache.manager_cache);
+	int i, r;
+	bool mgr_busy[2];
+
+	mgr_busy[0] = dispc_go_busy(0);
+	mgr_busy[1] = dispc_go_busy(1);
+
+	spin_lock(&dss_cache.lock);
+
+	for (i = 0; i < num_ovls; ++i) {
+		oc = &dss_cache.overlay_cache[i];
+		if (!mgr_busy[oc->channel])
+			oc->shadow_dirty = false;
+	}
+
+	for (i = 0; i < num_mgrs; ++i) {
+		mc = &dss_cache.manager_cache[i];
+		if (!mgr_busy[i])
+			mc->shadow_dirty = false;
+	}
+
+	r = configure_dispc();
+	if (r == 1)
+		goto end;
+
+	/* re-read busy flags */
+	mgr_busy[0] = dispc_go_busy(0);
+	mgr_busy[1] = dispc_go_busy(1);
+
+	/* keep running as long as there are busy managers, so that
+	 * we can collect overlay-applied information */
+	for (i = 0; i < num_mgrs; ++i) {
+		if (mgr_busy[i])
+			goto end;
+	}
+
+	omap_dispc_unregister_isr(dss_apply_irq_handler, NULL,
+			DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
+			DISPC_IRQ_EVSYNC_EVEN);
+	dss_cache.irq_enabled = false;
+
+end:
+	spin_unlock(&dss_cache.lock);
+}
+
+static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
+{
+	struct overlay_cache_data *oc;
+	struct manager_cache_data *mc;
+	int i;
+	struct omap_overlay *ovl;
+	int num_planes_enabled = 0;
+	bool use_fifomerge;
+	unsigned long flags;
+	int r;
+
+	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
+
+	spin_lock_irqsave(&dss_cache.lock, flags);
+
+	/* Configure overlays */
+	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+		struct omap_dss_device *dssdev;
+
+		ovl = omap_dss_get_overlay(i);
+
+		if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
+			continue;
+
+		oc = &dss_cache.overlay_cache[ovl->id];
+
+		if (!overlay_enabled(ovl)) {
+			if (oc->enabled) {
+				oc->enabled = false;
+				oc->dirty = true;
+			}
+			continue;
+		}
+
+		if (!ovl->info_dirty) {
+			if (oc->enabled)
+				++num_planes_enabled;
+			continue;
+		}
+
+		dssdev = ovl->manager->device;
+
+		if (dss_check_overlay(ovl, dssdev)) {
+			if (oc->enabled) {
+				oc->enabled = false;
+				oc->dirty = true;
+			}
+			continue;
+		}
+
+		ovl->info_dirty = false;
+		oc->dirty = true;
+
+		oc->paddr = ovl->info.paddr;
+		oc->vaddr = ovl->info.vaddr;
+		oc->screen_width = ovl->info.screen_width;
+		oc->width = ovl->info.width;
+		oc->height = ovl->info.height;
+		oc->color_mode = ovl->info.color_mode;
+		oc->rotation = ovl->info.rotation;
+		oc->rotation_type = ovl->info.rotation_type;
+		oc->mirror = ovl->info.mirror;
+		oc->pos_x = ovl->info.pos_x;
+		oc->pos_y = ovl->info.pos_y;
+		oc->out_width = ovl->info.out_width;
+		oc->out_height = ovl->info.out_height;
+		oc->global_alpha = ovl->info.global_alpha;
+
+		oc->replication =
+			dss_use_replication(dssdev, ovl->info.color_mode);
+
+		oc->ilace = dssdev->type == OMAP_DISPLAY_TYPE_VENC;
+
+		oc->channel = ovl->manager->id;
+
+		oc->enabled = true;
+
+		oc->manual_update =
+			dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE &&
+			dssdev->get_update_mode(dssdev) != OMAP_DSS_UPDATE_AUTO;
+
+		++num_planes_enabled;
+	}
+
+	/* Configure managers */
+	list_for_each_entry(mgr, &manager_list, list) {
+		struct omap_dss_device *dssdev;
+
+		if (!(mgr->caps & OMAP_DSS_OVL_MGR_CAP_DISPC))
+			continue;
+
+		mc = &dss_cache.manager_cache[mgr->id];
+
+		if (mgr->device_changed) {
+			mgr->device_changed = false;
+			mgr->info_dirty  = true;
+		}
+
+		if (!mgr->info_dirty)
+			continue;
+
+		if (!mgr->device)
+			continue;
+
+		dssdev = mgr->device;
+
+		mgr->info_dirty = false;
+		mc->dirty = true;
+
+		mc->default_color = mgr->info.default_color;
+		mc->trans_key_type = mgr->info.trans_key_type;
+		mc->trans_key = mgr->info.trans_key;
+		mc->trans_enabled = mgr->info.trans_enabled;
+		mc->alpha_enabled = mgr->info.alpha_enabled;
+
+		mc->manual_upd_display =
+			dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
+
+		mc->manual_update =
+			dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE &&
+			dssdev->get_update_mode(dssdev) != OMAP_DSS_UPDATE_AUTO;
+	}
+
+	/* XXX TODO: Try to get fifomerge working. The problem is that it
+	 * affects both managers, not individually but at the same time. This
+	 * means the change has to be well synchronized. I guess the proper way
+	 * is to have a two step process for fifo merge:
+	 *        fifomerge enable:
+	 *             1. disable other planes, leaving one plane enabled
+	 *             2. wait until the planes are disabled on HW
+	 *             3. config merged fifo thresholds, enable fifomerge
+	 *        fifomerge disable:
+	 *             1. config unmerged fifo thresholds, disable fifomerge
+	 *             2. wait until fifo changes are in HW
+	 *             3. enable planes
+	 */
+	use_fifomerge = false;
+
+	/* Configure overlay fifos */
+	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+		struct omap_dss_device *dssdev;
+		u32 size;
+
+		ovl = omap_dss_get_overlay(i);
+
+		if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
+			continue;
+
+		oc = &dss_cache.overlay_cache[ovl->id];
+
+		if (!oc->enabled)
+			continue;
+
+		dssdev = ovl->manager->device;
+
+		size = dispc_get_plane_fifo_size(ovl->id);
+		if (use_fifomerge)
+			size *= 3;
+
+		switch (dssdev->type) {
+		case OMAP_DISPLAY_TYPE_DPI:
+		case OMAP_DISPLAY_TYPE_DBI:
+		case OMAP_DISPLAY_TYPE_SDI:
+		case OMAP_DISPLAY_TYPE_VENC:
+			default_get_overlay_fifo_thresholds(ovl->id, size,
+					&oc->burst_size, &oc->fifo_low,
+					&oc->fifo_high);
+			break;
+#ifdef CONFIG_OMAP2_DSS_DSI
+		case OMAP_DISPLAY_TYPE_DSI:
+			dsi_get_overlay_fifo_thresholds(ovl->id, size,
+					&oc->burst_size, &oc->fifo_low,
+					&oc->fifo_high);
+			break;
+#endif
+		default:
+			BUG();
+		}
+	}
+
+	r = 0;
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	if (!dss_cache.irq_enabled) {
+		r = omap_dispc_register_isr(dss_apply_irq_handler, NULL,
+				DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
+				DISPC_IRQ_EVSYNC_EVEN);
+		dss_cache.irq_enabled = true;
+	}
+	configure_dispc();
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+
+	spin_unlock_irqrestore(&dss_cache.lock, flags);
+
+	return r;
+}
+
+static int dss_check_manager(struct omap_overlay_manager *mgr)
+{
+	/* OMAP supports only graphics source transparency color key and alpha
+	 * blending simultaneously. See TRM 15.4.2.4.2.2 Alpha Mode */
+
+	if (mgr->info.alpha_enabled && mgr->info.trans_enabled &&
+			mgr->info.trans_key_type != OMAP_DSS_COLOR_KEY_GFX_DST)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int omap_dss_mgr_set_info(struct omap_overlay_manager *mgr,
+		struct omap_overlay_manager_info *info)
+{
+	int r;
+	struct omap_overlay_manager_info old_info;
+
+	old_info = mgr->info;
+	mgr->info = *info;
+
+	r = dss_check_manager(mgr);
+	if (r) {
+		mgr->info = old_info;
+		return r;
+	}
+
+	mgr->info_dirty = true;
+
+	return 0;
+}
+
+static void omap_dss_mgr_get_info(struct omap_overlay_manager *mgr,
+		struct omap_overlay_manager_info *info)
+{
+	*info = mgr->info;
+}
+
+static void omap_dss_add_overlay_manager(struct omap_overlay_manager *manager)
+{
+	++num_managers;
+	list_add_tail(&manager->list, &manager_list);
+}
+
+int dss_init_overlay_managers(struct platform_device *pdev)
+{
+	int i, r;
+
+	spin_lock_init(&dss_cache.lock);
+
+	INIT_LIST_HEAD(&manager_list);
+
+	num_managers = 0;
+
+	for (i = 0; i < 2; ++i) {
+		struct omap_overlay_manager *mgr;
+		mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+
+		BUG_ON(mgr == NULL);
+
+		switch (i) {
+		case 0:
+			mgr->name = "lcd";
+			mgr->id = OMAP_DSS_CHANNEL_LCD;
+			mgr->supported_displays =
+				OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
+				OMAP_DISPLAY_TYPE_SDI | OMAP_DISPLAY_TYPE_DSI;
+			break;
+		case 1:
+			mgr->name = "tv";
+			mgr->id = OMAP_DSS_CHANNEL_DIGIT;
+			mgr->supported_displays = OMAP_DISPLAY_TYPE_VENC;
+			break;
+		}
+
+		mgr->set_device = &omap_dss_set_device;
+		mgr->unset_device = &omap_dss_unset_device;
+		mgr->apply = &omap_dss_mgr_apply;
+		mgr->set_manager_info = &omap_dss_mgr_set_info;
+		mgr->get_manager_info = &omap_dss_mgr_get_info;
+		mgr->wait_for_go = &dss_mgr_wait_for_go;
+
+		mgr->caps = OMAP_DSS_OVL_MGR_CAP_DISPC;
+
+		dss_overlay_setup_dispc_manager(mgr);
+
+		omap_dss_add_overlay_manager(mgr);
+
+		r = kobject_init_and_add(&mgr->kobj, &manager_ktype,
+				&pdev->dev.kobj, "manager%d", i);
+
+		if (r) {
+			DSSERR("failed to create sysfs file\n");
+			continue;
+		}
+	}
+
+#ifdef L4_EXAMPLE
+	{
+		int omap_dss_mgr_apply_l4(struct omap_overlay_manager *mgr)
+		{
+			DSSDBG("omap_dss_mgr_apply_l4(%s)\n", mgr->name);
+
+			return 0;
+		}
+
+		struct omap_overlay_manager *mgr;
+		mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+
+		BUG_ON(mgr == NULL);
+
+		mgr->name = "l4";
+		mgr->supported_displays =
+			OMAP_DISPLAY_TYPE_DBI | OMAP_DISPLAY_TYPE_DSI;
+
+		mgr->set_device = &omap_dss_set_device;
+		mgr->unset_device = &omap_dss_unset_device;
+		mgr->apply = &omap_dss_mgr_apply_l4;
+		mgr->set_manager_info = &omap_dss_mgr_set_info;
+		mgr->get_manager_info = &omap_dss_mgr_get_info;
+
+		dss_overlay_setup_l4_manager(mgr);
+
+		omap_dss_add_overlay_manager(mgr);
+
+		r = kobject_init_and_add(&mgr->kobj, &manager_ktype,
+				&pdev->dev.kobj, "managerl4");
+
+		if (r)
+			DSSERR("failed to create sysfs file\n");
+	}
+#endif
+
+	return 0;
+}
+
+void dss_uninit_overlay_managers(struct platform_device *pdev)
+{
+	struct omap_overlay_manager *mgr;
+
+	while (!list_empty(&manager_list)) {
+		mgr = list_first_entry(&manager_list,
+				struct omap_overlay_manager, list);
+		list_del(&mgr->list);
+		kobject_del(&mgr->kobj);
+		kobject_put(&mgr->kobj);
+		kfree(mgr);
+	}
+
+	num_managers = 0;
+}
+
+int omap_dss_get_num_overlay_managers(void)
+{
+	return num_managers;
+}
+EXPORT_SYMBOL(omap_dss_get_num_overlay_managers);
+
+struct omap_overlay_manager *omap_dss_get_overlay_manager(int num)
+{
+	int i = 0;
+	struct omap_overlay_manager *mgr;
+
+	list_for_each_entry(mgr, &manager_list, list) {
+		if (i++ == num)
+			return mgr;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(omap_dss_get_overlay_manager);
+
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
new file mode 100644
index 0000000..c7cb81b
--- /dev/null
+++ b/drivers/video/omap2/dss/overlay.c
@@ -0,0 +1,673 @@
+/*
+ * linux/drivers/video/omap2/dss/overlay.c
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * Some code and ideas taken from drivers/video/omap/ driver
+ * by Imre Deak.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define DSS_SUBSYS_NAME "OVERLAY"
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+
+#include <mach/display.h>
+
+#include "dss.h"
+
+static int num_overlays;
+static struct list_head overlay_list;
+
+static ssize_t overlay_name_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", ovl->name);
+}
+
+static ssize_t overlay_manager_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			ovl->manager ? ovl->manager->name : "<none>");
+}
+
+static ssize_t overlay_manager_store(struct omap_overlay *ovl, const char *buf,
+		size_t size)
+{
+	int i, r;
+	struct omap_overlay_manager *mgr = NULL;
+	struct omap_overlay_manager *old_mgr;
+	int len = size;
+
+	if (buf[size-1] == '\n')
+		--len;
+
+	if (len > 0) {
+		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
+			mgr = omap_dss_get_overlay_manager(i);
+
+			if (strncmp(buf, mgr->name, len) == 0)
+				break;
+
+			mgr = NULL;
+		}
+	}
+
+	if (len > 0 && mgr == NULL)
+		return -EINVAL;
+
+	if (mgr)
+		DSSDBG("manager %s found\n", mgr->name);
+
+	if (mgr == ovl->manager)
+		return size;
+
+	old_mgr = ovl->manager;
+
+	/* detach old manager */
+	if (old_mgr) {
+		r = ovl->unset_manager(ovl);
+		if (r) {
+			DSSERR("detach failed\n");
+			return r;
+		}
+
+		r = old_mgr->apply(old_mgr);
+		if (r)
+			return r;
+	}
+
+	if (mgr) {
+		r = ovl->set_manager(ovl, mgr);
+		if (r) {
+			DSSERR("Failed to attach overlay\n");
+			return r;
+		}
+
+		r = mgr->apply(mgr);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+static ssize_t overlay_input_size_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
+			ovl->info.width, ovl->info.height);
+}
+
+static ssize_t overlay_screen_width_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", ovl->info.screen_width);
+}
+
+static ssize_t overlay_position_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
+			ovl->info.pos_x, ovl->info.pos_y);
+}
+
+static ssize_t overlay_position_store(struct omap_overlay *ovl,
+		const char *buf, size_t size)
+{
+	int r;
+	char *last;
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	info.pos_x = simple_strtoul(buf, &last, 10);
+	++last;
+	if (last - buf >= size)
+		return -EINVAL;
+
+	info.pos_y = simple_strtoul(last, &last, 10);
+
+	r = ovl->set_overlay_info(ovl, &info);
+	if (r)
+		return r;
+
+	if (ovl->manager) {
+		r = ovl->manager->apply(ovl->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+static ssize_t overlay_output_size_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
+			ovl->info.out_width, ovl->info.out_height);
+}
+
+static ssize_t overlay_output_size_store(struct omap_overlay *ovl,
+		const char *buf, size_t size)
+{
+	int r;
+	char *last;
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	info.out_width = simple_strtoul(buf, &last, 10);
+	++last;
+	if (last - buf >= size)
+		return -EINVAL;
+
+	info.out_height = simple_strtoul(last, &last, 10);
+
+	r = ovl->set_overlay_info(ovl, &info);
+	if (r)
+		return r;
+
+	if (ovl->manager) {
+		r = ovl->manager->apply(ovl->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+static ssize_t overlay_enabled_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", ovl->info.enabled);
+}
+
+static ssize_t overlay_enabled_store(struct omap_overlay *ovl, const char *buf,
+		size_t size)
+{
+	int r;
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	info.enabled = simple_strtoul(buf, NULL, 10);
+
+	r = ovl->set_overlay_info(ovl, &info);
+	if (r)
+		return r;
+
+	if (ovl->manager) {
+		r = ovl->manager->apply(ovl->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+static ssize_t overlay_global_alpha_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			ovl->info.global_alpha);
+}
+
+static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
+		const char *buf, size_t size)
+{
+	int r;
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	/* Video1 plane does not support global alpha
+	 * to always make it 255 completely opaque
+	 */
+	if (ovl->id == OMAP_DSS_VIDEO1)
+		info.global_alpha = 255;
+	else
+		info.global_alpha = simple_strtoul(buf, NULL, 10);
+
+	r = ovl->set_overlay_info(ovl, &info);
+	if (r)
+		return r;
+
+	if (ovl->manager) {
+		r = ovl->manager->apply(ovl->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+struct overlay_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct omap_overlay *, char *);
+	ssize_t	(*store)(struct omap_overlay *, const char *, size_t);
+};
+
+#define OVERLAY_ATTR(_name, _mode, _show, _store) \
+	struct overlay_attribute overlay_attr_##_name = \
+	__ATTR(_name, _mode, _show, _store)
+
+static OVERLAY_ATTR(name, S_IRUGO, overlay_name_show, NULL);
+static OVERLAY_ATTR(manager, S_IRUGO|S_IWUSR,
+		overlay_manager_show, overlay_manager_store);
+static OVERLAY_ATTR(input_size, S_IRUGO, overlay_input_size_show, NULL);
+static OVERLAY_ATTR(screen_width, S_IRUGO, overlay_screen_width_show, NULL);
+static OVERLAY_ATTR(position, S_IRUGO|S_IWUSR,
+		overlay_position_show, overlay_position_store);
+static OVERLAY_ATTR(output_size, S_IRUGO|S_IWUSR,
+		overlay_output_size_show, overlay_output_size_store);
+static OVERLAY_ATTR(enabled, S_IRUGO|S_IWUSR,
+		overlay_enabled_show, overlay_enabled_store);
+static OVERLAY_ATTR(global_alpha, S_IRUGO|S_IWUSR,
+		overlay_global_alpha_show, overlay_global_alpha_store);
+
+static struct attribute *overlay_sysfs_attrs[] = {
+	&overlay_attr_name.attr,
+	&overlay_attr_manager.attr,
+	&overlay_attr_input_size.attr,
+	&overlay_attr_screen_width.attr,
+	&overlay_attr_position.attr,
+	&overlay_attr_output_size.attr,
+	&overlay_attr_enabled.attr,
+	&overlay_attr_global_alpha.attr,
+	NULL
+};
+
+static ssize_t overlay_attr_show(struct kobject *kobj, struct attribute *attr,
+		char *buf)
+{
+	struct omap_overlay *overlay;
+	struct overlay_attribute *overlay_attr;
+
+	overlay = container_of(kobj, struct omap_overlay, kobj);
+	overlay_attr = container_of(attr, struct overlay_attribute, attr);
+
+	if (!overlay_attr->show)
+		return -ENOENT;
+
+	return overlay_attr->show(overlay, buf);
+}
+
+static ssize_t overlay_attr_store(struct kobject *kobj, struct attribute *attr,
+		const char *buf, size_t size)
+{
+	struct omap_overlay *overlay;
+	struct overlay_attribute *overlay_attr;
+
+	overlay = container_of(kobj, struct omap_overlay, kobj);
+	overlay_attr = container_of(attr, struct overlay_attribute, attr);
+
+	if (!overlay_attr->store)
+		return -ENOENT;
+
+	return overlay_attr->store(overlay, buf, size);
+}
+
+static struct sysfs_ops overlay_sysfs_ops = {
+	.show = overlay_attr_show,
+	.store = overlay_attr_store,
+};
+
+static struct kobj_type overlay_ktype = {
+	.sysfs_ops = &overlay_sysfs_ops,
+	.default_attrs = overlay_sysfs_attrs,
+};
+
+/* Check if overlay parameters are compatible with display */
+int dss_check_overlay(struct omap_overlay *ovl, struct omap_dss_device *dssdev)
+{
+	struct omap_overlay_info *info;
+	u16 outw, outh;
+	u16 dw, dh;
+
+	if (!dssdev)
+		return 0;
+
+	if (!ovl->info.enabled)
+		return 0;
+
+	info = &ovl->info;
+
+	if (info->paddr == 0) {
+		DSSDBG("check_overlay failed: paddr 0\n");
+		return -EINVAL;
+	}
+
+	dssdev->get_resolution(dssdev, &dw, &dh);
+
+	DSSDBG("check_overlay %d: (%d,%d %dx%d -> %dx%d) disp (%dx%d)\n",
+			ovl->id,
+			info->pos_x, info->pos_y,
+			info->width, info->height,
+			info->out_width, info->out_height,
+			dw, dh);
+
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) == 0) {
+		outw = info->width;
+		outh = info->height;
+	} else {
+		if (info->out_width == 0)
+			outw = info->width;
+		else
+			outw = info->out_width;
+
+		if (info->out_height == 0)
+			outh = info->height;
+		else
+			outh = info->out_height;
+	}
+
+	if (dw < info->pos_x + outw) {
+		DSSDBG("check_overlay failed 1: %d < %d + %d\n",
+				dw, info->pos_x, outw);
+		return -EINVAL;
+	}
+
+	if (dh < info->pos_y + outh) {
+		DSSDBG("check_overlay failed 2: %d < %d + %d\n",
+				dh, info->pos_y, outh);
+		return -EINVAL;
+	}
+
+	if ((ovl->supported_modes & info->color_mode) == 0) {
+		DSSERR("overlay doesn't support mode %d\n", info->color_mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dss_ovl_set_overlay_info(struct omap_overlay *ovl,
+		struct omap_overlay_info *info)
+{
+	int r;
+	struct omap_overlay_info old_info;
+
+	old_info = ovl->info;
+	ovl->info = *info;
+
+	if (ovl->manager) {
+		r = dss_check_overlay(ovl, ovl->manager->device);
+		if (r) {
+			ovl->info = old_info;
+			return r;
+		}
+	}
+
+	ovl->info_dirty = true;
+
+	return 0;
+}
+
+static void dss_ovl_get_overlay_info(struct omap_overlay *ovl,
+		struct omap_overlay_info *info)
+{
+	*info = ovl->info;
+}
+
+static int dss_ovl_wait_for_go(struct omap_overlay *ovl)
+{
+	return dss_mgr_wait_for_go_ovl(ovl);
+}
+
+static int omap_dss_set_manager(struct omap_overlay *ovl,
+		struct omap_overlay_manager *mgr)
+{
+	if (!mgr)
+		return -EINVAL;
+
+	if (ovl->manager) {
+		DSSERR("overlay '%s' already has a manager '%s'\n",
+				ovl->name, ovl->manager->name);
+		return -EINVAL;
+	}
+
+	if (ovl->info.enabled) {
+		DSSERR("overlay has to be disabled to change the manager\n");
+		return -EINVAL;
+	}
+
+	ovl->manager = mgr;
+
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	/* XXX: on manual update display, in auto update mode, a bug happens
+	 * here. When an overlay is first enabled on LCD, then it's disabled,
+	 * and the manager is changed to TV, we sometimes get SYNC_LOST_DIGIT
+	 * errors. Waiting before changing the channel_out fixes it. I'm
+	 * guessing that the overlay is still somehow being used for the LCD,
+	 * but I don't understand how or why. */
+	msleep(40);
+	dispc_set_channel_out(ovl->id, mgr->id);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+
+	return 0;
+}
+
+static int omap_dss_unset_manager(struct omap_overlay *ovl)
+{
+	int r;
+
+	if (!ovl->manager) {
+		DSSERR("failed to detach overlay: manager not set\n");
+		return -EINVAL;
+	}
+
+	if (ovl->info.enabled) {
+		DSSERR("overlay has to be disabled to unset the manager\n");
+		return -EINVAL;
+	}
+
+	r = ovl->wait_for_go(ovl);
+	if (r)
+		return r;
+
+	ovl->manager = NULL;
+
+	return 0;
+}
+
+int omap_dss_get_num_overlays(void)
+{
+	return num_overlays;
+}
+EXPORT_SYMBOL(omap_dss_get_num_overlays);
+
+struct omap_overlay *omap_dss_get_overlay(int num)
+{
+	int i = 0;
+	struct omap_overlay *ovl;
+
+	list_for_each_entry(ovl, &overlay_list, list) {
+		if (i++ == num)
+			return ovl;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(omap_dss_get_overlay);
+
+static void omap_dss_add_overlay(struct omap_overlay *overlay)
+{
+	++num_overlays;
+	list_add_tail(&overlay->list, &overlay_list);
+}
+
+static struct omap_overlay *dispc_overlays[3];
+
+void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr)
+{
+	mgr->num_overlays = 3;
+	mgr->overlays = dispc_overlays;
+}
+
+#ifdef L4_EXAMPLE
+static struct omap_overlay *l4_overlays[1];
+void dss_overlay_setup_l4_manager(struct omap_overlay_manager *mgr)
+{
+	mgr->num_overlays = 1;
+	mgr->overlays = l4_overlays;
+}
+#endif
+
+void dss_init_overlays(struct platform_device *pdev)
+{
+	int i, r;
+
+	INIT_LIST_HEAD(&overlay_list);
+
+	num_overlays = 0;
+
+	for (i = 0; i < 3; ++i) {
+		struct omap_overlay *ovl;
+		ovl = kzalloc(sizeof(*ovl), GFP_KERNEL);
+
+		BUG_ON(ovl == NULL);
+
+		switch (i) {
+		case 0:
+			ovl->name = "gfx";
+			ovl->id = OMAP_DSS_GFX;
+			ovl->supported_modes = OMAP_DSS_COLOR_GFX_OMAP3;
+			ovl->caps = OMAP_DSS_OVL_CAP_DISPC;
+			ovl->info.global_alpha = 255;
+			break;
+		case 1:
+			ovl->name = "vid1";
+			ovl->id = OMAP_DSS_VIDEO1;
+			ovl->supported_modes = OMAP_DSS_COLOR_VID_OMAP3;
+			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
+				OMAP_DSS_OVL_CAP_DISPC;
+			ovl->info.global_alpha = 255;
+			break;
+		case 2:
+			ovl->name = "vid2";
+			ovl->id = OMAP_DSS_VIDEO2;
+			ovl->supported_modes = OMAP_DSS_COLOR_VID_OMAP3;
+			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
+				OMAP_DSS_OVL_CAP_DISPC;
+			ovl->info.global_alpha = 255;
+			break;
+		}
+
+		ovl->set_manager = &omap_dss_set_manager;
+		ovl->unset_manager = &omap_dss_unset_manager;
+		ovl->set_overlay_info = &dss_ovl_set_overlay_info;
+		ovl->get_overlay_info = &dss_ovl_get_overlay_info;
+		ovl->wait_for_go = &dss_ovl_wait_for_go;
+
+		omap_dss_add_overlay(ovl);
+
+		r = kobject_init_and_add(&ovl->kobj, &overlay_ktype,
+				&pdev->dev.kobj, "overlay%d", i);
+
+		if (r) {
+			DSSERR("failed to create sysfs file\n");
+			continue;
+		}
+
+		dispc_overlays[i] = ovl;
+	}
+
+#ifdef L4_EXAMPLE
+	{
+		struct omap_overlay *ovl;
+		ovl = kzalloc(sizeof(*ovl), GFP_KERNEL);
+
+		BUG_ON(ovl == NULL);
+
+		ovl->name = "l4";
+		ovl->supported_modes = OMAP_DSS_COLOR_RGB24U;
+
+		ovl->set_manager = &omap_dss_set_manager;
+		ovl->unset_manager = &omap_dss_unset_manager;
+		ovl->set_overlay_info = &dss_ovl_set_overlay_info;
+		ovl->get_overlay_info = &dss_ovl_get_overlay_info;
+
+		omap_dss_add_overlay(ovl);
+
+		r = kobject_init_and_add(&ovl->kobj, &overlay_ktype,
+				&pdev->dev.kobj, "overlayl4");
+
+		if (r)
+			DSSERR("failed to create sysfs file\n");
+
+		l4_overlays[0] = ovl;
+	}
+#endif
+}
+
+/* connect overlays to the new device, if not already connected. if force
+ * selected, connect always. */
+void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
+{
+	int i;
+	struct omap_overlay_manager *lcd_mgr;
+	struct omap_overlay_manager *tv_mgr;
+	struct omap_overlay_manager *mgr = NULL;
+
+	lcd_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_LCD);
+	tv_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_TV);
+
+	if (dssdev->type != OMAP_DISPLAY_TYPE_VENC) {
+		if (!lcd_mgr->device || force) {
+			if (lcd_mgr->device)
+				lcd_mgr->unset_device(lcd_mgr);
+			lcd_mgr->set_device(lcd_mgr, dssdev);
+			mgr = lcd_mgr;
+		}
+	}
+
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
+		if (!tv_mgr->device || force) {
+			if (tv_mgr->device)
+				tv_mgr->unset_device(tv_mgr);
+			tv_mgr->set_device(tv_mgr, dssdev);
+			mgr = tv_mgr;
+		}
+	}
+
+	if (mgr) {
+		for (i = 0; i < 3; i++) {
+			struct omap_overlay *ovl;
+			ovl = omap_dss_get_overlay(i);
+			if (!ovl->manager || force) {
+				if (ovl->manager)
+					omap_dss_unset_manager(ovl);
+				omap_dss_set_manager(ovl, mgr);
+			}
+		}
+	}
+}
+
+void dss_uninit_overlays(struct platform_device *pdev)
+{
+	struct omap_overlay *ovl;
+
+	while (!list_empty(&overlay_list)) {
+		ovl = list_first_entry(&overlay_list,
+				struct omap_overlay, list);
+		list_del(&ovl->list);
+		kobject_del(&ovl->kobj);
+		kobject_put(&ovl->kobj);
+		kfree(ovl);
+	}
+
+	num_overlays = 0;
+}
+
-- 
1.6.4


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
