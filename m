From: Pavel Machek <pavel@ucw.cz>
Subject: Re: camera application for testing (was Re: v4l subdevs without big
 device)
Date: Wed, 22 Jun 2016 13:52:18 +0200
Message-ID: <20160622115218.GA27606@amd>
References: <20160428084546.GA9957@amd> <20160429221359.GA29297@amd>
 <20160501140831.GH26360@valkosipuli.retiisi.org.uk>
 <1500395.gQ70N9eqVS@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1500395.gQ70N9eqVS@avalon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: ivo.g.dimitrov.75@gmail.com, linux-media@vger.kernel.org, khilman@kernel.org, tony@atomide.com, mchehab@osg.samsung.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@iki.fi>, pali.rohar@gmail.com, tuukkat76@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > I think libv4l itself has algorithms to control at least some of these. It
> > relies on the image data so the CPU time consumption will be high.
> > 
> > AFAIR Laurent has also worked on implementing some algorithms that use the
> > histogram and some of the statistics. Add him to cc list.
> 
> http://git.ideasonboard.org/omap3-isp-live.git
> 
> That's outdated and might not run or compile anymore. The code is
> more of a

Lets see, it compiles with this hack:

index 6f3ffbe..935f41d 100644
--- a/isp/v4l2.c
+++ b/isp/v4l2.c
@@ -292,7 +292,7 @@ struct v4l2_device *v4l2_open(const char *devname)
         * driver (>= v3.19) will set both CAPTURE and OUTPUT in the
         * capabilities field.
         */
-       capabilities = cap.device_caps ? : cap.capabilities;
+       capabilities = /* cap.device_caps ? : */ cap.capabilities;
 
        if (capabilities & V4L2_CAP_VIDEO_CAPTURE)
                dev->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;


I can try to run it, but I guess I'll need kernel with camera support.

pavel@n900:/my/omap3-isp-live$ LD_LIBRARY_PATH=isp ./snapshot
media_open: Can't open media device /dev/media0
error: unable to open media device /dev/media0
Segmentation fault (core dumped)

I tried again on kernel with camera:

pavel@n900:/my/omap3-isp-live$ LD_LIBRARY_PATH=isp ./snapshot
error: unable to locate sensor.
Segmentation fault (core dumped)
pavel@n900:/my/omap3-isp-live$

Here's the fix for coredump:

diff --git a/isp/subdev.c b/isp/subdev.c
index 9b36234..c74514e 100644
--- a/isp/subdev.c
+++ b/isp/subdev.c
@@ -75,6 +75,8 @@ int v4l2_subdev_open(struct media_entity *entity)
 
 void v4l2_subdev_close(struct media_entity *entity)
 {
+  if (!entity)
+    return;
        if (entity->fd == -1)
                return;

Let me investigate some more.

> proof of concept implementation, but it could be used as a starting point. 
> With an infinite amount of free time I'd love to work on an open-source 
> project for computational cameras, integrating it with libv4l.

For the record, I pushed my code to

https://gitlab.com/pavelm/fcam-dev

Best regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
