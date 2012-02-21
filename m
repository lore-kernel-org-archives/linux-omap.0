From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 EVM: remove out-of-bounds array access of
 gpio_leds.
Date: Tue, 21 Feb 2012 14:48:24 -0800
Message-ID: <20120221224824.GT18185@atomide.com>
References: <1329122122-5804-1-git-send-email-arnout@mind.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:37104 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219Ab2BUWs2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 17:48:28 -0500
Content-Disposition: inline
In-Reply-To: <1329122122-5804-1-git-send-email-arnout@mind.be>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Cc: linux-omap@vger.kernel.org, Syed Mohammed Khasim <khasim@ti.com>, Russell King <linux@arm.linux.org.uk>, Philip Oberstaller <philip.oberstaller@septentrio.com>

* Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be> [120213 00:04]:
> From: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
> 
> The omap3evm BSP enables a GPIO LED on the twl4030 chip.  However,
> the static gpio_leds array doesn't have an entry for it.  This is
> most likely a copy-and-paste error, because it has been in there
> since the first commit of the omap3evm BSP (53c5ec31).
> 
> Signed-off-by: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
> ---
> Please CC me, I'm not on the list.
> 
> Since I don't have access to an OMAP3EVM board or schematics, I
> couldn't actually test if my fix is correct.  I discovered the error
> because I'm using this BSP for an AM37xEVM board - which has the
> LED connected to a different GPIO.  It works on the AM37xEVM board
> if I replace the assignment with the correct GPIO number (8).

Thanks, applying it into fixes.

Regards,

Tony
