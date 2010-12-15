From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: omap_device: use pdev as parameter to get rt_va
Date: Tue, 14 Dec 2010 17:17:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012141710260.15971@utopia.booyaka.com>
References: <1292024742-27319-1-git-send-email-omar.ramirez@ti.com> <4D05D586.6090408@ti.com> <AANLkTik667cW19eCVNNLf3_dc9efFYms0H2z-fGU24Ob@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52256 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab0LOAR3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 19:17:29 -0500
In-Reply-To: <AANLkTik667cW19eCVNNLf3_dc9efFYms0H2z-fGU24Ob@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Omar

On Mon, 13 Dec 2010, Ramirez Luna, Omar wrote:

> On Mon, Dec 13, 2010 at 2:12 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> > On 12/11/2010 12:45 AM, Ramirez Luna, Omar wrote:
> >>
> >> Make the parameter received by omap_device_get_mpu_rt_va
> >> consistent with the functions meant to be called by drivers.
> >>
> >> Also move its header declaration to appear in the set of
> >> functions to be used by drivers, as per the comment there.
> >
> > Please note that even if Paul submitted this API upon request from Santosh,
> > we do not want driver to us it most of the time.
> 
> Oh, ok. Yes, I was under the impression that this ioremap was internal
> to hwmod, and drivers should do their own one but then I noticed that
> API and since it was under the "public functions through struct
> platform data", I thought it was easier to pass pdev than od.
> 
> > All drivers should us the generic Linux way to get physical mem resource and
> > then ioremap it.
> 
> Then I guess this function belongs to the "public for core code" and
> not for drivers along with the omap_device_get_pwrdm.
> 
> > I assume that if you want to update this API, you are probably already using
> > it.
> > Why cannot you use the generic way?
> 
> I can leave the generic way along with ioremap, the purpose was to use
> omap_device APIs as much as possible.

The above isn't quite it.  What I'd suggest you do in your code is this:

- In your driver-to-core-OMAP integration code in arch/arm/*omap*, call 
omap_hwmod_get_mpu_rt_va(), and pass that to the driver via an entry in 
the struct platform_data.

- In your driver code in drivers/*, test to see if that struct 
platform_data entry is NULL.  If it is, only then should your driver 
ioremap().  Otherwise, it should use the address from the struct 
platform_data.

This is because it's not guaranteed that ioremap() on OMAP will continue 
to reuse the current static mapping in the future.  We've heard from some 
mobile OS vendors that they are under significant address space 
constraints, so on those distributions it might make sense to only map 
devices that are actually in use, and take the additional TLB entry cost.

Does this make sense?


- Paul
