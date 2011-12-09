From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] ARM: OMAP: hsmmc: Fix mux for non-OMAP pins
Date: Thu, 8 Dec 2011 16:45:07 -0800
Message-ID: <20111209004507.GJ31337@atomide.com>
References: <1321565988-4511-1-git-send-email-weber@corscience.de>
 <1321565988-4511-3-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25782 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753057Ab1LIAqi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 19:46:38 -0500
Content-Disposition: inline
In-Reply-To: <1321565988-4511-3-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: trivial@kernel.org, jkosina@suse.cz, Russell King <linux@arm.linux.org.uk>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, uwe.kleine-koenig@pengutronix.de

* Thomas Weber <weber@corscience.de> [111117 13:05]:
> The Devkit8000 uses a TWL4030 pin for card detection.
> Thats why the error:
> _omap_mux_init_gpio: Could not set gpio192
> occurs.
> 
> This patch checks that the pin is on OMAP before
> calling omap_mux_init_gpio.

Thanks applying into omap driver branch.

Tony
