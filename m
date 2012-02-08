From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/16] ARM: omap: fix uninformative vc/i2c
 configuration error message
Date: Wed, 8 Feb 2012 10:46:08 -0800
Message-ID: <20120208184608.GF29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAWj-0006HB-7D@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59309 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757106Ab2BHSqO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:46:14 -0500
Content-Disposition: inline
In-Reply-To: <E1RvAWj-0006HB-7D@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:06]:
> On my OMAP4 platform, I'm getting this error message repeated several
> times at boot:
> 
> omap_vc_i2c_init: I2C config for all channels must match.
> omap_vc_i2c_init: I2C config for all channels must match.
> 
> This doesn't help identify what the problem is.  Fix this message to
> be more informative:
> 
> omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
> omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).
> 
> This allows us to identify which voltage domains have a problem, and
> what the I2C configuration state (a boolean, i2c_high_speed) setting
> being used actually is.
> 
> omap4_iva_pmic and omap4_mpu_pmic both have it set true.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
