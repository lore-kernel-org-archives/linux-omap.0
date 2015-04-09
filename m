From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: [PATCHv7] media: i2c/adp1653: fix includes
Date: Thu, 9 Apr 2015 14:31:55 +0200
Message-ID: <20150409123155.GB9563@amd>
References: <20150403202624.GA4308@amd>
 <20150403213655.GO20756@valkosipuli.retiisi.org.uk>
 <20150404074337.GA31064@amd>
 <20150404102435.GR20756@valkosipuli.retiisi.org.uk>
 <20150404171116.GA15025@Nokia-N900>
 <20150404200307.GS20756@valkosipuli.retiisi.org.uk>
 <20150409074238.GA22603@amd>
 <20150409091017.GA4526@earth>
 <20150409112943.GA31173@amd>
 <20150409121913.GB18713@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150409121913.GB18713@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Fix includes according to Sebastian.

Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

---

On Thu 2015-04-09 14:19:14, Sebastian Reichel wrote:
> On Thu, Apr 09, 2015 at 01:29:43PM +0200, Pavel Machek wrote:
> > On Thu 2015-04-09 11:10:17, Sebastian Reichel wrote:
> > > On Thu, Apr 09, 2015 at 09:42:38AM +0200, Pavel Machek wrote:
> > > > [...]
> > > > +#include <linux/of_gpio.h>
> > > > +#include <linux/gpio.h>
> > > > [...]
> > > 
> > > This should probably be
> > > 
> > > #include <linux/of.h>
> > > #include <linux/gpio/consumer.h>
> > 
> > And I thought people would only bikesched paint on the
> > Documentation. Sakari, feel free to change that, but
> 
> > a) I don't see why Sebastian's version is better
> 
> You neither use <linux/of_gpio.h> nor <linux/gpio.h>.
> 
> Well "include/linux/gpio.h" describes the old gpio API. The new
> gpiod gpiod API is described in "include/linux/gpio/consumer.h" and
> you use it, so the include should be included ;)
> 
> You don't use anything from "include/linux/of_gpio.h", but it
> includes "include/linux/of.h", which you are using. So you should
> include <linux/of.h> instead ;)

diff --git a/drivers/media/i2c/adp1653.c b/drivers/media/i2c/adp1653.c
index d703636..7107ac2 100644
--- a/drivers/media/i2c/adp1653.c
+++ b/drivers/media/i2c/adp1653.c
@@ -35,8 +35,8 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
-#include <linux/of_gpio.h>
-#include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/gpio/consumer.h>
 #include <media/adp1653.h>
 #include <media/v4l2-device.h>
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
