From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 06/14] mtd: rawnand: ams-delta: Push inversion
 handling to gpiolib
Date: Wed, 12 Feb 2020 10:28:06 -0800
Message-ID: <20200212182806.GL64767@atomide.com>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com>
 <20200212003929.6682-7-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54958 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgBLS2K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 12 Feb 2020 13:28:10 -0500
Content-Disposition: inline
In-Reply-To: <20200212003929.6682-7-jmkrzyszt@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [200212 00:41]:
> Let platforms take care of declaring correct GPIO pin polarity so we
> can just ask a GPIO line to be asserted or deasserted and gpiolib deals
> with the rest depending on how the platform is configured.
> 
> Inspired by similar changes to regulator drivers by Linus Walleij
> <linus.walleij@linaro.org>, thanks!

Acked-by: Tony Lindgren <tony@atomide.com>
