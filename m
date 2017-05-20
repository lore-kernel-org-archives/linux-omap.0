From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] iio: adc: cpcap: Fix default register values and
 battery temperature
Date: Sat, 20 May 2017 09:02:40 -0700
Message-ID: <20170520160240.GL10472@atomide.com>
References: <20170519034035.16795-1-tony@atomide.com>
 <20170519034035.16795-2-tony@atomide.com>
 <CAJCx=gm7t=2nuHiLCXUohLXR62gZ-ux62tWyEQXyNXMrhTutKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJCx=gm7t=2nuHiLCXUohLXR62gZ-ux62tWyEQXyNXMrhTutKg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <matt.ranostay-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "open list:IIO SUBSYSTEM AND..." <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Matt Ranostay <matt.ranostay-OWPKS81ov/FWk0Htik3J/w@public.gmane.org> [170519 22:55]:
> On Thu, May 18, 2017 at 8:40 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >  enum cpcap_adc_channel {
> >         /* Bank0 channels */
> > -       CPCAP_ADC_AD0_BATTDETB, /* Battery detection */
> > +       CPCAP_ADC_AD0_BATTDETB, /* Battery temperature */
> 
> Since this doesn't mean battery detection anymore I'd recommend
> renaming to CPCAP_ADC_AD0_BATTEMP or similar.

OK I'll change it to just CPCAP_ADC_AD0 as it seems it's use has
changed across revisions or products.

Regards,

Tony
