From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [RFC v2] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Fri, 27 Sep 2013 23:36:15 +0300
Message-ID: <20130927203615.GA4572@blackmetal.musicnaut.iki.fi>
References: <1380009480-4975-1-git-send-email-javier.martinez@collabora.co.uk>
 <5244C0C4.2030004@wwwdotorg.org>
 <52453545.3090504@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52453545.3090504@collabora.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lars Poeschel <larsi@wh2.tu-dresden.de>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Balaji T K <balajitk@ti.com>, Tony Lindgren <tony@atomide.com>, Jon Hunter <jgchunter@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, r.sricharan@ti.com, holler@ahsoftware.de, Paul Walmsley <paul@pwsan.com>, joelf@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 27, 2013 at 09:35:33AM +0200, Javier Martinez Canillas wrote:
> I cc'ed Aaro Koskinen and Paul Walmsley now which seems to have OMAP1
> platforms to test. Could you please test [1] and [2] on a OMAP1 board?

[...]

> [1]: https://patchwork.kernel.org/patch/2937351/
> [2]: https://patchwork.kernel.org/patch/2937371/

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

I applied these patches on top of 3.12-rc2 and tested them on Nokia
770 (OMAP1, Touchscreen & Retu powerbutton GPIO IRQs) and N800 (OMAP2,
Retu powerbutton). Seems to work fine on both boards.

A.
