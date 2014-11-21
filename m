From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: twl4030-power: Fix poweroff with PM configuration
 enabled
Date: Fri, 21 Nov 2014 15:37:10 -0800
Message-ID: <20141121233709.GA7046@atomide.com>
References: <20141102180756.GH31454@atomide.com>
 <5458D29E.50908@compulab.co.il>
 <20141104154231.GP31454@atomide.com>
 <CANOLnOP8JmROaCruC8NEwh+Nzq_-fFit-+5d_W9vU9KtNTphoA@mail.gmail.com>
 <515E660B-B65D-41EF-97F5-74E4DE8FDD13@goldelico.com>
 <20141112212027.GK26481@atomide.com>
 <20141112223154.GP641@saruman>
 <20141119144348.169c4166@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141119144348.169c4166@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <balbi@ti.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

* NeilBrown <neilb@suse.de> [141118 19:45]:
> On Wed, 12 Nov 2014 16:31:54 -0600 Felipe Balbi <balbi@ti.com> wrote:
> > 
> > this is actually what the USB Battery Charging spec requires us to
> > implement. If Linux is doing differently, it's a bug on Linux which
> > should be fixed :-)
> > 
> > No host is allowed to source more then one unit load (100mA in LS/FS/HS,
> > 150mA in SS) until the device is fully enumerated. Host are also
> > required to drop max current budget to 8mA (IIRC) if the device doesn't
> > enumerate for however many minutes (I guess it was a pretty long
> > threshold, something like half an hour or so. My memory fails me right
> > now).
> > 
> 
> I think the twl4030 driver does do the "right" thing unless the "allow_usb"
> module parameter is set, in which case it enables charging at a higher rate
> which is 600mA (default value of BCIIREF1).
> 
> It would be nice if the driver could check if a charger was plugged in and
> act accordingly.
> The charger I have for my openmoko is identified by a 47K resistor between ID
> and ground.  The twl4030 can detect that easily enough, but it isn't very
> standard.

Sounds doable to me, feel free to patch it up since you guys are using
the twl4030 charger :)
 
> The standard is of course to have D+ and D- shorted, but I don't know if the
> twl4030 can detect that?  If it can, then getting some very early code to
> check for the short (or the 47k resistor) and quickly enabling charging might
> be a sufficient solution.

I guess. Note that there's also the USB BC1.2 spec that is more
complicated than having the data lines shorted.

Regards,

Tony
