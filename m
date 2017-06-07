From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] iio: adc: cpcap: Fix default register values and
 battery temperature
Date: Tue, 6 Jun 2017 23:22:00 -0700
Message-ID: <20170607062200.GD3730@atomide.com>
References: <20170523005146.726-1-tony@atomide.com>
 <20170523005146.726-2-tony@atomide.com>
 <20170524201831.3504c42d@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170524201831.3504c42d-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170524 12:22]:
> On Mon, 22 May 2017 17:51:44 -0700
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> 
> > Looking at the register dumps from Android kernel on droid 4, I noticed
> > the values with the mainline kernel don't match. Let's fix this by
> > initializing the ADC registers to what Android does.
> > 
> > For getting correct values from the battery thermistor, we need to
> > toggle the CPCAP_BIT_THERMBIAS_EN when measuring battery temperature
> > to get correct battery temperatures. And looks like we also need to
> > wait a little bit before reading the battery temperature as otherwise
> > the results are inaccurate.
> > 
> > Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> > Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Applied to the togreg branch of iio.git and will be shortly pushed
> out as testing for the autobuilders to play with it.

Not seeing these in your togreg brach or in next? The
branch I just checked is the one below, maybe I'm looking
at a wrong branch or something.

Regards,

Tony

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=togreg
