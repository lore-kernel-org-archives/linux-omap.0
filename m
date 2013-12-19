From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: tps65910 backup battery regulator
Date: Thu, 19 Dec 2013 09:25:25 +0100
Message-ID: <20131219082525.GE23493@pengutronix.de>
References: <1387378208-26841-1-git-send-email-mpa@pengutronix.de>
 <1387378208-26841-2-git-send-email-mpa@pengutronix.de>
 <20131218162546.GY28455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50266 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab3LSIZ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 03:25:29 -0500
Content-Disposition: inline
In-Reply-To: <20131218162546.GY28455@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On Wed, Dec 18, 2013 at 04:25:46PM +0000, Mark Brown wrote:
> On Wed, Dec 18, 2013 at 03:50:08PM +0100, Markus Pargmann wrote:
> > This patch adds a devicetree node for the backup battery regulator.
> 
> Your previous patch missed an update to the binding documentation for
> the regulator driver.

Right, thank you, I added vbb to the tps65910 mfd binding documentation.

Regards,

Markus



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
