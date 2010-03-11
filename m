From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
	file
Date: Thu, 11 Mar 2010 12:48:06 +0000
Message-ID: <20100311124806.GD11135@sirena.org.uk>
References: <hvaibhav@ti.com> <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:50645 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756699Ab0CKMsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 07:48:09 -0500
Content-Disposition: inline
In-Reply-To: <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Tomi.Valkeinen@nokia.com

On Thu, Mar 11, 2010 at 02:25:17PM +0530, hvaibhav@ti.com wrote:

> +static struct regulator_consumer_supply omap3_evm_vpll2_supplies[] = {
> +	{
> +		.supply		= "vdvi",
> +		.dev		= &omap3_evm_lcd_device.dev,
> +	},

Please use dev_name for new code.
