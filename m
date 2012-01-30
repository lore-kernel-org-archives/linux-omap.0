From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: hwmod: add omap_hwmod_get_mpu_irq()
 and omap_hwmod_get_mpu_rt_pa()
Date: Mon, 30 Jan 2012 14:36:03 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201301435430.17726@utopia.booyaka.com>
References: <20120130101251.10450.58423.stgit@dusk> <20120130101816.10450.2624.stgit@dusk> <20120130171327.GD9339@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47214 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab2A3VgE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 16:36:04 -0500
In-Reply-To: <20120130171327.GD9339@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

Hi

On Mon, 30 Jan 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [120130 01:47]:
> > The timer integration code pokes around in hwmod data structures.
> > Those data structures are about to change.  Define some functions for
> > the timer integration code to use instead.
> 
> Maybe these should use struct resource instead to make these more
> generic? Something like this maybe:
> 
> int omap_hwmod_get_resource(struct omap_hwmod *oh, unsigned int type,
> 				unsigned int num, struct resource *r);
> 
> Then the calling code would do:
> 
> 	...
> 	struct resource r;
> 	int res;
> 
> 	res = omap_hwmod_get_resource(oh, IORESOURCE_IRQ, 0, &r);
> 	...

That's a good idea and will definitely look into that.

- Paul
