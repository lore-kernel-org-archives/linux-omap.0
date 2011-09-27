From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/9] regulator: twl: Remove hardcoded board constraints
 from driver
Date: Tue, 27 Sep 2011 12:37:19 +0100
Message-ID: <20110927113719.GH2910@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
 <1317118372-17052-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35649 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752733Ab1I0LhV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 07:37:21 -0400
Content-Disposition: inline
In-Reply-To: <1317118372-17052-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tue, Sep 27, 2011 at 03:42:44PM +0530, Rajendra Nayak wrote:
> Remove the hardcoded .valid_modes_mask and .valid_ops_mask for
> each regulator from the twl driver and let the boards pass it.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>


> -	/* Constrain board-specific capabilities according to what
> -	 * this driver and the chip itself can actually do.
> -	 */
> -	c = &initdata->constraints;
> -	c->valid_modes_mask &= REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY;
> -	c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE
> -				| REGULATOR_CHANGE_MODE
> -				| REGULATOR_CHANGE_STATUS;

This isn't actually hard coding constraints, this is restricting the
constraints passed in further rather than adding new ones.

However should be fine:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
