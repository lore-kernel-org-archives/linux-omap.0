From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] mfd: twl4030-power: Fix PM idle pin configuration to not
 conflict with regulators
Date: Wed, 20 Aug 2014 00:33:51 +0300
Message-ID: <20140819213351.GF4885@drone.musicnaut.iki.fi>
References: <20140819152405.GA12002@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:38058 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbaHSVeA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2014 17:34:00 -0400
Content-Disposition: inline
In-Reply-To: <20140819152405.GA12002@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Tue, Aug 19, 2014 at 08:24:05AM -0700, Tony Lindgren wrote:
> Commit 43fef47f94a1 (mfd: twl4030-power: Add a configuration to turn
> off oscillator during off-idle) added support for configuring the PMIC
> to cut off resources during deeper idle states to save power.

[...]

> Fixes: 43fef47f94a1 (mfd: twl4030-power: Add a configuration to turn off oscillator during off-idle)
> Cc: stable@vger.kernel.org # v3.16
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
