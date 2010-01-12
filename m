From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input:TouchScreen: Introduce TSC2004 driver support
Date: Tue, 12 Jan 2010 00:37:02 -0800
Message-ID: <20100112083702.GB3252@core.coreip.homeip.net>
References: <hvaibhav@ti.com>
 <1258642000-2271-1-git-send-email-hvaibhav@ti.com>
 <19F8576C6E063C45BE387C64729E7394044A3982AE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A3982AE@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 11, 2010 at 11:54:05AM +0530, Hiremath, Vaibhav wrote:
> 
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Thursday, November 19, 2009 8:17 PM
> > To: linux-input@vger.kernel.org
> > Cc: linux-omap@vger.kernel.org; Hiremath, Vaibhav
> > Subject: [PATCH 2/3] Input:TouchScreen: Introduce TSC2004 driver
> > support
> >
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  drivers/input/touchscreen/Kconfig   |   11 +
> >  drivers/input/touchscreen/Makefile  |    1 +
> >  drivers/input/touchscreen/tsc2004.c |  525
> > +++++++++++++++++++++++++++++++++++
> >  include/linux/i2c/tsc2004.h         |   17 ++
> >  4 files changed, 554 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/input/touchscreen/tsc2004.c
> >  create mode 100644 include/linux/i2c/tsc2004.h
> >
> [Hiremath, Vaibhav] Dmitry,
> 
> Any update on this? This driver support is important for AM3517EVM, can we merge this patch?
> 

Hi Hiremath,

I looked over the 2 drivers again and I still think that they are too
much alike to warrant splitting them into 2. The only thing that you
need is provide tsc2004-specific variant of tsc2007_read_values and
add tsc2007-specific variant of tsc2004_prepare_for_reading.

Once the drivers start really diverging we may revisit this issue.

Thanks.

-- 
Dmitry
