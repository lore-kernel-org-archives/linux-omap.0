From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 08/17] ARM: dts: dra7: Add dt node for the sycon pcie
Date: Wed, 24 Jun 2015 05:49:57 -0700
Message-ID: <20150624124956.GH4156@atomide.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
 <1435060743-5511-9-git-send-email-kishon@ti.com>
 <20150624145017.9b70a1fba477d8b99ce85702@ti.com>
 <20150624145617.e5248d466fe5b2e0eb1ca087@ti.com>
 <20150624120938.GG4156@atomide.com>
 <20150624151931.87252315d0e61ddfd55c4724@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150624151931.87252315d0e61ddfd55c4724-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150624 05:21]:
> On Wed, 24 Jun 2015 05:09:39 -0700
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > 
> > My take is we should only use regmap for the scm_conf area
> > in general.
> 
> +1
> 
> should we get rid of dra7_ctrl_core and dra7_ctrl_general?
> or move them to scm node?

Well at least move them. And if there are clear dedicated
register ranges there claimed only by a single device driver,
then those drivers should be just regular loadable driver
modules doing of_ioremap on the range. And in that case they
can be removed.

We have examples of both in dra7.dtsi, pbias_regulator using
the scm_conf via syscon, and then dra7_pmx_core ioremapping
a dedicated register range. So unless there are other messy
register ranges like the scm_conf area then there should not
be need for other syscon areas.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
