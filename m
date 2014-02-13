From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: dtsi: am335x-bone-common, usb0 is peripheral only
Date: Thu, 13 Feb 2014 14:54:38 -0800
Message-ID: <20140213225438.GF28216@atomide.com>
References: <1389448851-20010-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43505 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751813AbaBMWyv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 17:54:51 -0500
Content-Disposition: inline
In-Reply-To: <1389448851-20010-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

* Markus Pargmann <mpa@pengutronix.de> [140111 06:03]:
> The PMIC is using usb0 vbus line as power source. It is also connected
> to the am335x processor as vbus sense. But there is no possibility to
> pullup usb0 vbus to operate as host. This patch fixes the dr_mode of usb0.

That's the MUSB? AFAIK it's not possible to operate MUSB in peripheral
only mode because the hardware does what it wants based on the ID
pin state.

Regards,

Tony
