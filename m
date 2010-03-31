From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCHv2 2/4] arm: omap: gpio: implement set_debounce
 method
Date: Wed, 31 Mar 2010 17:21:58 +0100
Message-ID: <20100331162158.GB32025@rakim.wolfsonmicro.main>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
 <1270049712-28272-3-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51504 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752342Ab0CaQWA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 12:22:00 -0400
Content-Disposition: inline
In-Reply-To: <1270049712-28272-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Mar 31, 2010 at 06:35:10PM +0300, Felipe Balbi wrote:
> +	if (debounce) {
> +		val |= l;
> +		if (cpu_is_omap34xx() || cpu_is_omap44xx())
> +			clk_enable(bank->dbck);
> +	} else {
> +		val &= ~l;
> +		if (cpu_is_omap34xx() || cpu_is_omap44xx())
> +			clk_disable(bank->dbck);
> +	}

Will these do the right thing with the clocks for noop transitions or
tweaks to the debounce time?  I'm not familiar with the OMAP clock
framework, it could handle this.
