From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch 2.6.29-rc3-git 1/2] regulator: twl4030 regulators
Date: Thu, 26 Feb 2009 22:15:26 +0000
Message-ID: <1235686526.31223.105.camel@vega.slimlogic.co.uk>
References: <200902081037.06645.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slimlogic.co.uk ([89.16.172.20]:48557 "EHLO slimlogic.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbZBZWPa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 17:15:30 -0500
In-Reply-To: <200902081037.06645.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Sun, 2009-02-08 at 10:37 -0800, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Support most of the LDO regulators in the twl4030 family chips.
> In the case of LDOs supporting MMC/SD, the voltage controls are
> used; but in most other cases, the regulator framework is only
> used to enable/disable a supplies, conserving power when a given
> voltage rail is not needed.
> 
> The drivers/mfd/twl4030-core.c code already sets up the various
> regulators according to board-specific configuration, and knows
> that some chips don't provide the full set of voltage rails.
> 
> The omitted regulators are intended to be under hardware control,
> such as during the hardware-mediated system powerup, powerdown,
> and suspend states.  Unless/until software hooks are known to
> be safe, they won't be exported here.
> 
> These regulators implement the new get_status() operation, but
> can't realistically implement get_mode(); the status output is
> effectively the result of a vote, with the relevant hardware
> inputs not exposed.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Applied.

Thanks

Liam

