From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/8] Regulator: Adding TPS65023 and TPS6507x in Kconfig
	and Makefile
Date: Fri, 7 Aug 2009 17:07:29 +0100
Message-ID: <20090807160728.GL639@sirena.org.uk>
References: <1249658960-11021-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:45161 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbZHGQH2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 12:07:28 -0400
Content-Disposition: inline
In-Reply-To: <1249658960-11021-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 07, 2009 at 08:59:20PM +0530, Anuj Aggarwal wrote:

> +config REGULATOR_TPS65023
> +	tristate "TI TPS65023 Power regulators"
> +	depends on OMAP3EVM_TPS65023
> +	help

...

> +config REGULATOR_TPS65073
> +	tristate "TI TPS65073 Power regulators"
> +	depends on OMAP3EVM_TPS65073

These dependencies on the OMAP3EVM seem very wrong - the only dependency
I'd expect would be on I2C (or a MFD core for the .

Also, the Kconfig stuff says TPS65073 but the driver said it supported
the entire TPS6507x line.  I'd expect these to be consistent with each
other.
