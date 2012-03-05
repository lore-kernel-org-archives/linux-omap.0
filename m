From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] RM: OMAP4: board-4430sdp: don't initialize value that
 is never used
Date: Mon, 5 Mar 2012 10:23:11 -0800
Message-ID: <20120305182311.GD12083@atomide.com>
References: <1328823034-9668-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:22917 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756766Ab2CESXO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 13:23:14 -0500
Content-Disposition: inline
In-Reply-To: <1328823034-9668-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [120209 13:00]=
:
> sdp4430_spi_board_info.irq was initialized to ETH_KS8851_IRQ and in
> omap_4430sdp_init() overwritten with gpio_to_irq(ETH_KS8851_IRQ) befo=
re
> sdp4430_spi_board_info was registered. This is a bit confusing, so
> better don't initialize .irq and document that it is set later.

Thanks applying into board branch.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
