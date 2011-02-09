From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] OMAP4: add clk32kg data to omap4panda and blaze
 board file
Date: Wed, 9 Feb 2011 15:45:09 +0000
Message-ID: <20110209154509.GH24042@opensource.wolfsonmicro.com>
References: <1297265851-21999-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33383 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750997Ab1BIPpK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 10:45:10 -0500
Content-Disposition: inline
In-Reply-To: <1297265851-21999-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, sameo@linux.intel.com

On Wed, Feb 09, 2011 at 09:07:31PM +0530, Balaji T K wrote:

> +	.constraints = {
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,

Does this really support mode setting?
