From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] ARM: dts: OMAP2+: create a DT header for GPIO
Date: Wed, 22 May 2013 08:34:52 -0700
Message-ID: <20130522153452.GZ10378@atomide.com>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
 <1369232864-14460-3-git-send-email-florian.vaussard@epfl.ch>
 <519CE3BB.3040704@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25021 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755409Ab3EVPe6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 May 2013 11:34:58 -0400
Content-Disposition: inline
In-Reply-To: <519CE3BB.3040704@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [130522 08:32]:
> On 05/22/2013 08:27 AM, Florian Vaussard wrote:
> > Define the OMAP_GPIO macro to conveniently use GPIO inside OMAP DT.
> > For example:
> > 
> > 	gpios = <&gpio6 3 0>;  /* GPIO 163 */
> > 
> > can be replaced by
> > 
> > 	gpios = OMAP_GPIO(163, 0);
> 
> > diff --git a/include/dt-bindings/gpio/omap-gpio.h b/include/dt-bindings/gpio/omap-gpio.h
> 
> > +#define OMAP_GPIO_0_BANK        gpio1
> > +#define OMAP_GPIO_1_BANK        gpio1
> > +#define OMAP_GPIO_2_BANK        gpio1
> > +#define OMAP_GPIO_3_BANK        gpio1
> 
> There are a /lot/ of those. Is this really worth it?
> 
> If the OMAP GPIO HW is already represented as a bunch of separate DT
> nodes which represent separate GPIO blocks, then I would have thought
> the syntax <&gpioN M 0> more directly represents what would be found in
> the HW manual? If not, surely the DT should have a single node to
> represent a single GPIO controller, which just happens to internally
> support a bunch of register arrays.

Yes I agree, let's not go back to numbering anything except within the
a single instance. If anything, we can put the gpio number into comments.

Regards,

Tony
