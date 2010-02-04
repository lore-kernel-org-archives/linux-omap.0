From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: ads7846: add regulator support
Date: Thu, 4 Feb 2010 14:24:40 +0000
Message-ID: <20100204142439.GA1139@sirena.org.uk>
References: <1265290758-2035-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:42675 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab0BDOYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 09:24:41 -0500
Content-Disposition: inline
In-Reply-To: <1265290758-2035-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org

On Thu, Feb 04, 2010 at 03:39:18PM +0200, Grazvydas Ignotas wrote:

> The ADS7846/TSC2046 touchscreen controllers can (and usually are)
> connected to various regulators for power, so add regulator support.
> Make it optional for now to avoid breaking all current users of this
> driver.

This should not be required.  The regulator API stubs itself out when it
is not built so all API calls report as successful.

> +	ts->reg = regulator_get(&spi->dev, "vcc");
> +	if (!IS_ERR(ts->reg)) {
> +		err = regulator_enable(ts->reg);
> +		if (err)
> +			goto err_put_regulator;
> +	}

If the regulator API is not compiled in then the regulator_get() will
return succesfully.  If the regulator API is in use then failure to
acquire the regulator is a serious problem which really should be at a
minimium be being communicated to the user.  For example, the regulator
API may end up powering down regulators which it believes are unused or
the regulator may not be powered by default and needs to be enabled.

The updates to fix up the boards that need this are fairly
straightforward and given that it's fairly easy to identify systems
which are using the driver in mainline so I'd really prefer not to go
down the route of trying to carry on in the face of error, it papers
over stuff now but is not robust in the face of future changes.
