From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V2] misc : ROHM BH1780GLI Ambient light sensor Driver
Date: Tue, 1 Jun 2010 13:38:51 -0700
Message-ID: <20100601133851.76adbe17.akpm@linux-foundation.org>
References: <39216.10.24.255.17.1274699065.squirrel@dbdmail.itg.ti.com>
	<20100601131244.7164b43c.akpm@linux-foundation.org>
	<20100601202715.GV2695@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100601202715.GV2695@buzzloop.caiaq.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Hemanth V <hemanthv@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

On Tue, 1 Jun 2010 22:27:15 +0200
Daniel Mack <daniel@caiaq.de> wrote:

> On Tue, Jun 01, 2010 at 01:12:44PM -0700, Andrew Morton wrote:
> > On Mon, 24 May 2010 16:34:25 +0530 (IST)
> > "Hemanth V" <hemanthv@ti.com> wrote:
> > 
> > > This patch adds support for ROHM BH1780GLI Ambient light sensor.
> > > 
> > > BH1780 supports I2C interface. Driver supports read/update of power state and
> > > read of lux value (through SYSFS). Writing value 3 to power_state enables the
> > > sensor and current lux value could be read.
> > 
> > There are at least two other ambient light sensor drivers:
> > drivers/misc/isl29003.c and drivers/misc/tsl2550.c.
> > 
> > Is there any standardisation of the ABIs whcih these drivers offer?  If
> > so, does this new driver comply with that?
> 
> Jonathan proposed the ALS framework for these type of devices, but it
> was rejected (don't know about the reasons, I didn't follow the
> discussions). The new idea is to put such drivers in the industrial IO
> subsystem, but I don't know how mature that approach is currently.
> 
> For the time being, these drivers cook up whatever sysfs interface they
> like, and their userspace ABIs are not standardized, unfortunately.

Well can we fix that?  Look at the existing drivers, pick one and make
this new driver provide the same interface?

It's not a grand plan - more of an incremental baby step, but it's
better than this random proliferation.
