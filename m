From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] regulator: twl: add clk32kg to twl-regulator
Date: Wed, 9 Feb 2011 15:44:45 +0000
Message-ID: <20110209154444.GG24042@opensource.wolfsonmicro.com>
References: <1297265845-21967-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44402 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750954Ab1BIPor (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 10:44:47 -0500
Content-Disposition: inline
In-Reply-To: <1297265845-21967-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: lrg@slimlogic.co.uk, sameo@linux.intel.com, linux-omap@vger.kernel.org, tony@atomide.com

On Wed, Feb 09, 2011 at 09:07:25PM +0530, Balaji T K wrote:

> -	TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 18, 0, 0x21)
> +	TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 18, 0, 0x21),
> +	TWL6030_FIXED_LDO(CLK32KG, 0x8C, 1000, 48, 0, 0x21),

It'd seem better to implement a version of this that just doesn't have
the voltage readback operation rather than putting in a dummy voltage.
Otherwise this looks good.
