From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH v3 5/5] misc serdev: w2sg0004: add debugging code and
 Kconfig
Date: Wed, 15 Nov 2017 17:42:57 +0100
Message-ID: <20171115164257.2mbbk7yqhq3puc5a@lenoch>
References: <cover.1510759152.git.hns@goldelico.com>
 <9b4969c858d4c3801bb796f92dad5c580799b768.1510759152.git.hns@goldelico.com>
 <28e16c7a-2688-a302-1548-1cdc2552f0ad@suse.de>
 <DC57A290-669C-4B3C-A4EE-2ABEA37F47CE@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <DC57A290-669C-4B3C-A4EE-2ABEA37F47CE-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Andreas =?iso-8859-2?Q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-2?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 15, 2017 at 05:29:25PM +0100, H. Nikolaus Schaller wrote:
> Hi Andreas,
> 
> > Am 15.11.2017 um 16:53 schrieb Andreas Färber <afaerber-l3A5Bk7waGM@public.gmane.org>:
> > 
> > Hi,
> > 
> > Am 15.11.2017 um 16:19 schrieb H. Nikolaus Schaller:
> >> This allows to set CONFIG_W2SG0004_DEBUG which will
> >> make the driver report more activities and it will turn on the
> >> GPS module during boot while the driver assumes that it
> >> is off. This can be used to debug the correct functioning of
> >> the hardware. Therefore we add it as an option to the driver
> >> because we think it is of general use (and a little tricky to
> >> add by system testers).
> >> 
> >> Normally it should be off.
> >> ---
> > 
> > If you want to merge this, it is lacking a Sob.
> 
> Whats is a "Sob" in this context (https://acronyms.thefreedictionary.com/SOB)?

https://acronyms.thefreedictionary.com/Signed-Off-By

Also please read Documentation/process/submitting-patches.rst

	ladis

> BR and thanks,
> Nikolaus Schaller
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
