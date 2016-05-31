From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv5] support for AD5820 camera auto-focus coil
Date: Tue, 31 May 2016 23:34:37 +0200
Message-ID: <20160531213437.GA28397@amd>
References: <20160517181927.GA28741@amd>
 <20160521054336.GA27123@amd>
 <573FFF51.1000004@gmail.com>
 <20160521105607.GA20071@amd>
 <574049EF.2090208@gmail.com>
 <20160524090433.GA1277@amd>
 <20160524091746.GA14536@amd>
 <20160525212659.GK26360@valkosipuli.retiisi.org.uk>
 <20160527205140.GA26767@amd>
 <20160531212222.GP26360@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160531212222.GP26360@valkosipuli.retiisi.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, patrikbachan@gmail.com, serge@hallyn.com, linux-media@vger.kernel.org, mchehab@osg.samsung.com
List-Id: linux-omap@vger.kernel.org

On Wed 2016-06-01 00:22:22, Sakari Ailus wrote:
> Hi Pavel,
> 
> On Fri, May 27, 2016 at 10:51:40PM +0200, Pavel Machek wrote:
> > 
> > This adds support for AD5820 autofocus coil, found for example in
> > Nokia N900 smartphone.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> The patch looks good to me but then I came to think of a question I've
> missed so far: is there DT documentation somewhere for the properties used
> by the driver? I might put that to a separate patch, and cc the relevant
> list.

Well, it does not use any dt properties. So there's not really much to
discuss with dt people...

Maybe "ad5820" needs to go to list of simple i2c drivers somewhere,
but...

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
