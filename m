From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2 13/14] dt-bindings: arm-gic: Add documentation for
 Tegra210 AGIC
Date: Wed, 11 May 2016 18:28:23 +0100
Message-ID: <20160511172823.GC18829@leverpostej>
References: <20160427173810.GC7359@leverpostej>
 <5721C597.1010105@nvidia.com>
 <20160428095525.GB21145@leverpostej>
 <572C56A6.7020408@nvidia.com>
 <CAMuHMdX+egbNPP4QQ2R28GbyVkg9qBrwYfUy8EE0PdB6od+LBg@mail.gmail.com>
 <CAL_Jsq+HSH7e1T9y47nHV_x5NvZ-52cfDEKKFkr16ax671FxSw@mail.gmail.com>
 <573358F9.6000108@nvidia.com>
 <57335AD3.7070109@nvidia.com>
 <CAL_Jsq+ZhwUOSfQG-8V9xgxiXBj2j3Q6k48d=BWtWK9pEHH_MQ@mail.gmail.com>
 <57336397.4000401@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57336397.4000401-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 11, 2016 at 05:53:43PM +0100, Jon Hunter wrote:
> Hi Rob, Mark,
> 
> On 11/05/16 17:30, Rob Herring wrote:
> > A platform driver for just gic-400 is wrong IMO until we have platform
> > drivers for all interrupt controllers.
> 
> Yes, that is fine with me, but can we decide on whether the platform
> driver should match "tegra210-agic" or the early driver should bail-out
> if clocks/power-domains are present?
> 
> I am fine with either, but I think that Rob prefers the tegra210-agic
> compat string and Mark prefers to bail-out of the early driver if
> clocks/power-domains are present.

If anything, I wasn't too keen on bailing out becuase of those
properties, as I mentioned for the case of a root interrupt controller.

I am happy to match the "tegra210-agic" string specifically.

Thanks,
Mark.
