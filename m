From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC v2] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Mon, 30 Sep 2013 01:23:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1309300122450.17980@utopia.booyaka.com>
References: <1380009480-4975-1-git-send-email-javier.martinez@collabora.co.uk> <5244C0C4.2030004@wwwdotorg.org> <52453545.3090504@collabora.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <52453545.3090504@collabora.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lars Poeschel <larsi@wh2.tu-dresden.de>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Balaji T K <balajitk@ti.com>, Tony Lindgren <tony@atomide.com>, Jon Hunter <jgchunter@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, r.sricharan@ti.com, holler@ahsoftware.de, aaro.koskinen@iki.fi, joelf@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, 27 Sep 2013, Javier Martinez Canillas wrote:

> I cc'ed Aaro Koskinen and Paul Walmsley now which seems to have OMAP1 platforms
> to test. Could you please test [1] and [2] on a OMAP1 board? These patches
> solves a long standing issue we have on OMAP2+ when booting with DT and it would
> be great if you can check that it does not cause regressions on OMAP1 based boards.

Unfortunately my OMAP1 test platform is down at the moment, so am not able 
to test.  But saw that it passed Aaro's tests, so I'd say that's a pretty 
good endorsement.


- Paul
