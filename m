From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] OMAP3: rx-51: Add full regulator definitions
Date: Sat, 30 Apr 2011 20:23:47 +0100
Message-ID: <20110430192347.GB16378@opensource.wolfsonmicro.com>
References: <1304081264-4915-1-git-send-email-kalle.jokiniemi@nokia.com> <1304081264-4915-2-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41575 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752440Ab1D3TXt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Apr 2011 15:23:49 -0400
Content-Disposition: inline
In-Reply-To: <1304081264-4915-2-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: tony@atomide.com, sakari.ailus@nokia.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

On Fri, Apr 29, 2011 at 03:47:44PM +0300, Kalle Jokiniemi wrote:

> +		.always_on		= true,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,

_CHANGE_STATUS doesn't make much sense in conjunction with always_on.
Otherwise this looks OK to me.
