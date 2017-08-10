From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: dts: omap: workarounds for Ethernet PHY
 strap on DRA71 and DRA72 EVMs
Date: Thu, 10 Aug 2017 10:37:19 -0700
Message-ID: <20170810173718.GP8569@atomide.com>
References: <cover.1502284400.git.nsekhar@ti.com>
 <ca0d0615-d813-d00b-e853-25df9a5c49b6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ca0d0615-d813-d00b-e853-25df9a5c49b6-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [170809 15:27]:
> On 08/09/2017 09:02 AM, Sekhar Nori wrote:
> > Here are some patches to overcome incorrect Ethernet PHY strap settings
> > on DRA72x EVM Rev C and DRA71 EVM. Both of these boards use TI's DP83867
> > PHY.
> > 
> > The incorrect PHY strap settings cause a voilation of PHY specification
> > and need to be worked around in software as documented in the commit
> > messages. But there is no known issue that these patches fix.
...

> Reviewed-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

Applying dts changes into omap-for-v4.14/fixes-not-urgent
and defconfig into omap-for-v4.14/defconfig.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
