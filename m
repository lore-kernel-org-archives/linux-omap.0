From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3] iio: light: new driver for the ROHM BH1780
Date: Mon, 4 Apr 2016 15:35:47 -0700
Message-ID: <20160404223546.GC8755@atomide.com>
References: <1459326847-9444-1-git-send-email-linus.walleij@linaro.org>
 <5700E7AF.6040903@kernel.org>
 <CACRpkdYkqzvu_fMcDPy8i0OCpGdGQ39S534HbCQL8T93gadKmQ@mail.gmail.com>
 <20160404074239.GT7800@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160404074239.GT7800-Rysk9IDjsxmJz7etNGeUX8VPkgjIgRvpAL8bYrjMMd8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> [160404 00:43]:
> On Sun, Apr 03, 2016 at 06:30:49PM +0200, Linus Walleij wrote:
> > On Sun, Apr 3, 2016 at 11:51 AM, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > > On 30/03/16 09:34, Linus Walleij wrote:
> > 
> > >> I want to phase out the old misc driver, but don't know how that
> > >> should properly be handled. The driver has an old (totally
> > >> undocumented) sysfs ABI for raw measurements, should I add
> > >> this as backward-compatibility and symlink the device to the old
> > >> location?
> > >
> > > Good question.  I guess we unfortunately do need to jump through the hoops as
> > > who knows what userspace code there is out there using that interface.
> > > At least it is small!
> > 
> > The maintainer Hemanth seems to have disappeared.
> > 
> > Let's ask some of the OMAP and ex-OMAP people, I think they know
> > or know who knows...
> > 
> > Tony, Peter, Paul: drivers/misc/bh1780gli.c has a funky sysfs ABI.
> > It is only used in arch/arm/boot/dts/omap4-sdp.dts as far as I can
> > tell. What device is this, and more importantly, who is running it
> > and with what userspace? I'm happy to go and patch that userspace
> > if I can just get a pointer to whoever is developing it. Sailfish?
> 
> Sailfish has never used OMAP4 afaik. OMAP4 sdp is a TI dev board, so maybe
> someone from TI knows what this is for?

Adding linux-omap to Cc. I suggest do a minimal patch to remove the
sysfs interface, then revert the patch if needed. I don't think
people are using it.

Regards,

Tony
