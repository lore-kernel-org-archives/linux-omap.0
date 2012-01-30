From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: hwmod: add omap_hwmod_get_mpu_irq()
 and omap_hwmod_get_mpu_rt_pa()
Date: Mon, 30 Jan 2012 09:13:28 -0800
Message-ID: <20120130171327.GD9339@atomide.com>
References: <20120130101251.10450.58423.stgit@dusk>
 <20120130101816.10450.2624.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61924 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab2A3RNa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 12:13:30 -0500
Content-Disposition: inline
In-Reply-To: <20120130101816.10450.2624.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Hi,

* Paul Walmsley <paul@pwsan.com> [120130 01:47]:
> The timer integration code pokes around in hwmod data structures.
> Those data structures are about to change.  Define some functions for
> the timer integration code to use instead.

Maybe these should use struct resource instead to make these more
generic? Something like this maybe:

int omap_hwmod_get_resource(struct omap_hwmod *oh, unsigned int type,
				unsigned int num, struct resource *r);

Then the calling code would do:

	...
	struct resource r;
	int res;

	res = omap_hwmod_get_resource(oh, IORESOURCE_IRQ, 0, &r);
	...

Regards,

Tony
