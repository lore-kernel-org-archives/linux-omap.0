From: Trilok Soni <trilok_soni@yahoo.co.in>
Subject: Re: [PATCH 1/2] ov9640: Add OmniVision ov9640 driver - new interface
Date: Thu, 23 Aug 2007 05:29:01 -0700 (PDT)
Message-ID: <262354.79141.qm@web8503.mail.in.yahoo.com>
References: <5d5443650708200321h6fa11423j24f48a565dacbbdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1558548496-1187872141=:79141"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650708200321h6fa11423j24f48a565dacbbdb@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--0-1558548496-1187872141=:79141
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

--- Trilok Soni <soni.trilok@gmail.com> wrote:

> Hi Sakari,
> 
> On 8/20/07, Sakari Ailus <sakari.ailus@nokia.com>
> wrote:
> > ext Trilok Soni wrote:
> > > Hi All,
> >
> > Hi, Trilok!
> >
> > > I have attached two patches which converts the
> ov9640 driver to use
> > > the new v4l2 sensor interface. Sensor detection
> is working with H4 but
> > > the output is not anywhere near to correct, so
> someone with H4 please
> > > check and give inputs.
> > >
> > > Patches are implemented and tested against
> mainline kernel and OMAP2
> > > camera driver posted by Sakari to v4l mailing
> list [1].
> >
> >  > +#define NUM_IOCTLS 16
> > ...
> >  > +     /* Just an experiment --- don't use *_cb
> functions yet. */
> >  > +     ov9640_ioctl_desc[i++] =
> vidioc_int_dev_init_cb(&ioctl_dev_init);
> >  > +     BUG_ON(i >= NUM_IOCTLS);
> >
> > These are leftovers from the
> check-slave-interface-types experiment
> > which probably should be removed. This applies to
> TCM825x as well.
> >
> 
> I will remove that and update the patch once camera
> output is correct.
> 

I have attached the updated ov9640 patch with
v4l2_ifparm addition and some cosmetic changes, sensor
still not working except detection.

---Trilok Soni


       
____________________________________________________________________________________
Take the Internet to Go: Yahoo!Go puts the Internet in your pocket: mail, news, photos & more. 
http://mobile.yahoo.com/go?refer=1GNXIC
--0-1558548496-1187872141=:79141
Content-Type: text/x-patch;
	name="0001-ov9640-Update-sensor-driver-with-v4l2_ifparm.patch"
Content-Description: 3395908420-0001-ov9640-Update-sensor-driver-with-v4l2_ifparm.patch
Content-Disposition: inline;
	filename="0001-ov9640-Update-sensor-driver-with-v4l2_ifparm.patch"

>From 9cceb274ab423ce74db6c8c97062dc31d56cfefb Mon Sep 17 00:00:00 2001
From: Trilok Soni <soni.trilok@gmail.com>
Date: Wed, 22 Aug 2007 17:04:40 +0530
Subject: [PATCH] ov9640: Update sensor driver with v4l2_ifparm.

- Update driver with new v4l2_ifparm structure.
- Remove un-necessary '&' and some test code.

Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
---
 drivers/media/video/ov9640.c |   56 ++++++++++++++++++------------------------
 drivers/media/video/ov9640.h |    1 +
 2 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/media/video/ov9640.c b/drivers/media/video/ov9640.c
index 9a7b039..8caa240 100644
--- a/drivers/media/video/ov9640.c
+++ b/drivers/media/video/ov9640.c
@@ -1128,19 +1128,18 @@ static int ioctl_s_parm(struct v4l2_int_device *s,
 	return rval;
 }
 
-static int ioctl_s_power(struct v4l2_int_device *s, int on)
+static int ioctl_g_ifparm(struct v4l2_int_device *s, struct v4l2_ifparm *p)
 {
 	struct ov9640_sensor *sensor = s->priv;
 
-	return sensor->pdata->power_set(on);
+	return sensor->pdata->ifparm(p);
 }
 
-/* FIXME - g_needs_reset will be removed once camera driver
- * implments fix for it e.g -ENOIOCTLCMD.
- */
-static int ioctl_g_needs_reset(struct v4l2_int_device *s, void *buf)
+static int ioctl_s_power(struct v4l2_int_device *s, int on)
 {
-	return 0;
+	struct ov9640_sensor *sensor = s->priv;
+
+	return sensor->pdata->power_set(on);
 }
 
 static int ioctl_init(struct v4l2_int_device *s)
@@ -1171,41 +1170,39 @@ static int ioctl_dev_init(struct v4l2_int_device *s)
 	return 0;
 }
 
-#define NUM_IOCTLS 16
-
-static struct v4l2_int_ioctl_desc ov9640_ioctl_desc[NUM_IOCTLS] = {
+static struct v4l2_int_ioctl_desc ov9640_ioctl_desc[] = {
 	{ vidioc_int_dev_init_num,
-	  (v4l2_int_ioctl_func *)&ioctl_dev_init },
+	  (v4l2_int_ioctl_func *)ioctl_dev_init },
 	{ vidioc_int_dev_exit_num,
-	  (v4l2_int_ioctl_func *)&ioctl_dev_exit },
+	  (v4l2_int_ioctl_func *)ioctl_dev_exit },
 	{ vidioc_int_s_power_num,
-	  (v4l2_int_ioctl_func *)&ioctl_s_power },
+	  (v4l2_int_ioctl_func *)ioctl_s_power },
 	{ vidioc_int_g_ext_clk_num,
-	  (v4l2_int_ioctl_func *)&ioctl_g_ext_clk },
-	{ vidioc_int_g_needs_reset_num,
-	  (v4l2_int_ioctl_func *)&ioctl_g_needs_reset },
+	  (v4l2_int_ioctl_func *)ioctl_g_ext_clk },
+	{ vidioc_int_g_ifparm_num,
+	  (v4l2_int_ioctl_func *)ioctl_g_ifparm },
 	{ vidioc_int_s_ext_clk_num,
-	  (v4l2_int_ioctl_func *)&ioctl_s_ext_clk },
+	  (v4l2_int_ioctl_func *)ioctl_s_ext_clk },
 	{ vidioc_int_init_num,
-	  (v4l2_int_ioctl_func *)&ioctl_init },
+	  (v4l2_int_ioctl_func *)ioctl_init },
 	{ vidioc_int_enum_fmt_cap_num,
-	  (v4l2_int_ioctl_func *)&ioctl_enum_fmt_cap },
+	  (v4l2_int_ioctl_func *)ioctl_enum_fmt_cap },
 	{ vidioc_int_try_fmt_cap_num,
-	  (v4l2_int_ioctl_func *)&ioctl_try_fmt_cap },
+	  (v4l2_int_ioctl_func *)ioctl_try_fmt_cap },
 	{ vidioc_int_g_fmt_cap_num,
-	  (v4l2_int_ioctl_func *)&ioctl_g_fmt_cap },
+	  (v4l2_int_ioctl_func *)ioctl_g_fmt_cap },
 	{ vidioc_int_s_fmt_cap_num,
-	  (v4l2_int_ioctl_func *)&ioctl_s_fmt_cap },
+	  (v4l2_int_ioctl_func *)ioctl_s_fmt_cap },
 	{ vidioc_int_g_parm_num,
-	  (v4l2_int_ioctl_func *)&ioctl_g_parm },
+	  (v4l2_int_ioctl_func *)ioctl_g_parm },
 	{ vidioc_int_s_parm_num,
-	  (v4l2_int_ioctl_func *)&ioctl_s_parm },
+	  (v4l2_int_ioctl_func *)ioctl_s_parm },
 	{ vidioc_int_queryctrl_num,
-	  (v4l2_int_ioctl_func *)&ioctl_queryctrl },
+	  (v4l2_int_ioctl_func *)ioctl_queryctrl },
 	{ vidioc_int_g_ctrl_num,
-	  (v4l2_int_ioctl_func *)&ioctl_g_ctrl },
+	  (v4l2_int_ioctl_func *)ioctl_g_ctrl },
 	{ vidioc_int_s_ctrl_num,
-	  (v4l2_int_ioctl_func *)&ioctl_s_ctrl },
+	  (v4l2_int_ioctl_func *)ioctl_s_ctrl },
 };
 
 static struct v4l2_int_slave ov9640_slave = {
@@ -1288,11 +1285,6 @@ static struct ov9640_sensor ov9640 = {
 static int ov9640sensor_init(void)
 {
 	int err;
-	int i = 0;
-
-	/* Just an experiment --- don't use *_cb functions yet. */
-	ov9640_ioctl_desc[i++] = vidioc_int_dev_init_cb(&ioctl_dev_init);
-	BUG_ON(i >= NUM_IOCTLS);
 
 	err = i2c_add_driver(&ov9640sensor_i2c_driver);
 	if (err) {
diff --git a/drivers/media/video/ov9640.h b/drivers/media/video/ov9640.h
index b6858b4..6de3fef 100644
--- a/drivers/media/video/ov9640.h
+++ b/drivers/media/video/ov9640.h
@@ -166,6 +166,7 @@ struct ov9640_platform_data {
 	int (*power_set)(int power);
 	/* Default registers written after power-on or reset. */
 	const struct ov9640_reg *default_regs;
+	int (*ifparm)(struct v4l2_ifparm *p);
 };
 
 /*
-- 
1.5.0


--0-1558548496-1187872141=:79141
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1558548496-1187872141=:79141--
