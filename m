From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch 2.6.29-rc6 1/2] regulator: enumerate voltages (v2)
Date: Thu, 26 Feb 2009 20:53:58 +0000
Message-ID: <1235681638.31223.57.camel@vega.slimlogic.co.uk>
References: <200902081037.06645.david-b@pacbell.net>
	 <200902231245.44360.david-b@pacbell.net>
	 <200902231252.01980.david-b@pacbell.net>
	 <200902261148.36892.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slimlogic.co.uk ([89.16.172.20]:58799 "EHLO slimlogic.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754523AbZBZUyE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 15:54:04 -0500
In-Reply-To: <200902261148.36892.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thu, 2009-02-26 at 11:48 -0800, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Add a basic mechanism for regulators to report the discrete
> voltages they support:  list_voltage() enumerates them using
> selectors numbered from 0 to an upper bound.
> 
> Use those methods to force machine-level constraints into bounds.
> (Example:  regulator supports 1.8V, 2.4V, 2.6V, 3.3V, and board
> constraints for that rail are 2.0V to 3.6V ... so the range of
> voltages is then 2.4V to 3.3V on this board.)
> 
> Export those voltages to the regulator consumer interface, so for
> example regulator hooked up to an MMC/SD/SDIO slot can report the
> actual voltage options available to cards connected there.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---

Applied with git-am merge conflicts. It builds ok, can you check against
your tree.

Thanks

Liam

