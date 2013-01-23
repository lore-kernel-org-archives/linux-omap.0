From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c: omap: fix draining irq handling
Date: Wed, 23 Jan 2013 10:57:23 +0100
Message-ID: <20130123095723.GF3767@nekote.pengutronix.de>
References: <1358707022-26477-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40660 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773Ab3AWJ5b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 04:57:31 -0500
Content-Disposition: inline
In-Reply-To: <1358707022-26477-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: ben-linux@fluff.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, balbi@ti.com

On Sun, Jan 20, 2013 at 08:37:02PM +0200, Aaro Koskinen wrote:
> Commit 0bdfe0cb803dce699ff337c35d8e97ac355fa417 (i2c: omap: sanitize
> exit path) changed the interrupt handler to exit early and complete
> the transfer after the draining IRQ is handled. As a result, the ARDY
> may not be cleared properly, and it may cause all future I2C transfers
> to timeout with "timeout waiting for bus ready". This is reproducible
> at least with N900 when twl4030_gpio makes a long write (> FIFO size)
> during the probe (http://marc.info/?l=linux-omap&m=135818882610432&w=2).
> 
> The fix is to continue until we get ARDY interrupt that completes the
> transfer. Tested with 3.8-rc4 + N900: 20 boots in a row without errors;
> without the patch the problem triggers after few reboots.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to current and interpreted Felipe's comments as ack. Thanks!

