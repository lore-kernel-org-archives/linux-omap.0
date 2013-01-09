From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/10] ARM: OMAP2+: PM/powerdomain: move
	omap_set_pwrdm_state() to powerdomain code
Date: Wed, 9 Jan 2013 17:43:32 +0000
Message-ID: <20130109174332.GC2637@n2100.arm.linux.org.uk>
References: <20121209011755.19716.25244.stgit@dusk.lan> <20121209012339.19716.10548.stgit@dusk.lan> <50C85ABD.8040409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42989 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233Ab3AIRno (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jan 2013 12:43:44 -0500
Content-Disposition: inline
In-Reply-To: <50C85ABD.8040409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, linux-arm-kernel@lists.infradead.org

On Wed, Dec 12, 2012 at 03:51:49PM +0530, Vaibhav Hiremath wrote:
> > -int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
> > -{
> > -	u8 curr_pwrst, next_pwrst;
> > -	int sleep_switch = -1, ret = 0, hwsup = 0;
> > -
> > -	if (!pwrdm || IS_ERR(pwrdm))
> 
> You can use IS_ERR_OR_NULL here.

As this is removing code...

However, if you pay attention to linux-kernel or linux-arm-kernel, you will
notice that I've sent a patch deprecating IS_ERR_OR_NULL() and I'm starting
to remove its use.  IS_ERR_OR_NULL() creates more problems than it solves
because people don't think about what the hell they're doing with it, or
even whether it's appropriate to use it.
