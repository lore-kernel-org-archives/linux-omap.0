From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC PATCH] gpio/omap: fix pm_runtime for IRQ functions
Date: Tue, 22 Jan 2013 15:24:19 +0530
Message-ID: <50FE61CB.5010906@ti.com>
References: <1358531362-27933-1-git-send-email-jlu@pengutronix.de> <50FCE27D.7060500@ti.com> <CACRpkdYpCbWtk6PbgLm0HWFBihDqA_G_1btYQ38+WfeXridPJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33588 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764Ab3AVJyg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jan 2013 04:54:36 -0500
In-Reply-To: <CACRpkdYpCbWtk6PbgLm0HWFBihDqA_G_1btYQ38+WfeXridPJA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Jan Luebbe <jlu@pengutronix.de>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, kernel@pengutronix.de

On Tuesday 22 January 2013 01:52 PM, Linus Walleij wrote:
> In the Nomadik I had a similar situation with a GPIO used for the
> ethernet IRQ. I put the GPIO number in a special board-specific
> node and added this to the machine,

Thanks Linus. Are there any bindings already available on how these
special board-specific nodes can be defined in the dts files?
Are there any using some such in the mainline already?

regards,
Rajendra
