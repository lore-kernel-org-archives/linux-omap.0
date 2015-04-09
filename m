From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv7] media: i2c/adp1653: Devicetree support for adp1653
Date: Thu, 9 Apr 2015 13:29:43 +0200
Message-ID: <20150409112943.GA31173@amd>
References: <20150403083353.GA21070@amd>
 <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
 <20150403202624.GA4308@amd>
 <20150403213655.GO20756@valkosipuli.retiisi.org.uk>
 <20150404074337.GA31064@amd>
 <20150404102435.GR20756@valkosipuli.retiisi.org.uk>
 <20150404171116.GA15025@Nokia-N900>
 <20150404200307.GS20756@valkosipuli.retiisi.org.uk>
 <20150409074238.GA22603@amd>
 <20150409091017.GA4526@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150409091017.GA4526@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Sakari Ailus <sakari.ailus@iki.fi>, Andrew Morton <akpm@osdl.org>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, galak@codeaurora.org, bcousson@baylibre.com, m.chehab@samsung.com, devicetree@vger.kernel.org, mchehab@osg.samsung.com, hverkuil@xs4all.nl
List-Id: linux-omap@vger.kernel.org

On Thu 2015-04-09 11:10:17, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Apr 09, 2015 at 09:42:38AM +0200, Pavel Machek wrote:
> > [...]
> > +#include <linux/of_gpio.h>
> > +#include <linux/gpio.h>
> > [...]
> 
> This should probably be
> 
> #include <linux/of.h>
> #include <linux/gpio/consumer.h>

And I thought people would only bikesched paint on the
Documentation. Sakari, feel free to change that, but a) I don't see
why Sebastian's version is better and b) am pretty sure there is about
infinite number of possibilities there.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
