From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/3] Input:TouchScreen: Introduce TSC2004 driver support
Date: Sat, 30 Jan 2010 16:28:54 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A6B8FB7@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1258642000-2271-1-git-send-email-hvaibhav@ti.com>
 <19F8576C6E063C45BE387C64729E7394044A3982AE@dbde02.ent.ti.com>
 <20100112083702.GB3252@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100112083702.GB3252@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Tuesday, January 12, 2010 2:07 PM
> To: Hiremath, Vaibhav
> Cc: linux-input@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/3] Input:TouchScreen: Introduce TSC2004 driver
> support
> 
> On Mon, Jan 11, 2010 at 11:54:05AM +0530, Hiremath, Vaibhav wrote:
> >
> > > -----Original Message-----
> > > From: Hiremath, Vaibhav
> > > Sent: Thursday, November 19, 2009 8:17 PM
> > > To: linux-input@vger.kernel.org
> > > Cc: linux-omap@vger.kernel.org; Hiremath, Vaibhav
> > > Subject: [PATCH 2/3] Input:TouchScreen: Introduce TSC2004 driver
> > > support
> > >
> > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > >
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > ---
> > >  drivers/input/touchscreen/Kconfig   |   11 +
> > >  drivers/input/touchscreen/Makefile  |    1 +
> > >  drivers/input/touchscreen/tsc2004.c |  525
> > > +++++++++++++++++++++++++++++++++++
> > >  include/linux/i2c/tsc2004.h         |   17 ++
> > >  4 files changed, 554 insertions(+), 0 deletions(-)
> > >  create mode 100644 drivers/input/touchscreen/tsc2004.c
> > >  create mode 100644 include/linux/i2c/tsc2004.h
> > >
> > [Hiremath, Vaibhav] Dmitry,
> >
> > Any update on this? This driver support is important for
> AM3517EVM, can we merge this patch?
> >
> 
> Hi Hiremath,
> 
> I looked over the 2 drivers again and I still think that they are
> too
> much alike to warrant splitting them into 2. The only thing that you
> need is provide tsc2004-specific variant of tsc2007_read_values and
> add tsc2007-specific variant of tsc2004_prepare_for_reading.
> 
> Once the drivers start really diverging we may revisit this issue.
[Hiremath, Vaibhav] Hi Dmitry,

Sorry for delayed response, as usual was busy with some other priority issues. Let it be...

As I mentioned before, looking towards the functionality differences I decided to implement/have separate driver for TSC2004. But I think you are right, since as of now software is not leveraging all the features we can use existing TSC2007 driver. Whenever we diverge we can slit them.

Just wanted to share/conform some thoughts on the implementation point of view,

	- Probably change the driver from tsc2007 to tsc200x
	
	- introduce initialization sequence as an array and pass it to the i2c_device_id table.


	- Driver will have to only use this array sequence, that's all.

I will try to change the driver accordingly and submit it again and also update/inform you if I came across any issues (while doing this, which is unlikely).

Thanks,
Vaibhav

> 
> Thanks.
> 
> --
> Dmitry
