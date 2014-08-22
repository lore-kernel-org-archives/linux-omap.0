From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: DRA7: fix interrupt-cells for GPIO
Date: Fri, 22 Aug 2014 16:02:54 -0700
Message-ID: <20140822230253.GJ10066@atomide.com>
References: <1406748032-19417-1-git-send-email-nm@ti.com>
 <53F249F3.9070402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53F249F3.9070402-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, inux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [140818 11:49]:
> On 07/30/2014 02:20 PM, Nishanth Menon wrote:
> > GPIO modules are also interrupt sources. However, they require both the
> > GPIO number and IRQ type to function properly.
> > 
> > By declaring that GPIO uses interrupt-cells=<1>, we essentially do not
> > allow users of the nodes to use the interrupt property appropritely.
> > 
> > With this change, the following now works:
> > 
> > interrupt-parent = <&gpio6>;
> > interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> > 
> > Fixes: 6e58b8f1daaf ('ARM: dts: DRA7: Add the dts files for dra7 SoC and dra7-evm board')
> > Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> > ---
> > Based on v3.16-rc7
> > 
> >  arch/arm/boot/dts/dra7.dtsi |   16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> Tony,
> Gentle ping. we still have this issue on 3.17-rc1. any suggestions on
> if we can pick this up during RC?

Yes thanks applying into omap-for-v3.17/fixes.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
