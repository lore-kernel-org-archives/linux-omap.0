From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: Provide dummy supply support
Date: Sat, 29 Oct 2011 18:42:02 +0100
Message-ID: <20111029174202.GA9646@opensource.wolfsonmicro.com>
References: <1319833618-25190-1-git-send-email-s.hauer@pengutronix.de> <1319833618-25190-2-git-send-email-s.hauer@pengutronix.de> <20111028215931.GA30366@opensource.wolfsonmicro.com> <20111028224757.GG23421@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111028224757.GG23421@pengutronix.de>
Sender: linux-sh-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Mundt <lethal@linux-sh.org>, Tony Lindgren <tony@atomide.com>, Mike Frysinger <vapier@gentoo.org>, linux-sh@vger.kernel.org, linux-omap@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-omap@vger.kernel.org

On Sat, Oct 29, 2011 at 12:47:57AM +0200, Sascha Hauer wrote:

> My main concern with the fixed regulator is that it needs quite much
> boilerplate code just to say that we have no regulator at all for a
> given device. That could also be handled with a helper function which
> registers a fixed regulator and only takes the regulator_consumer_supply
> as an argument. Would that be ok for you?

All you're actually doing in this code is adding a function to register
a new type of regulator which is exactly equivalent to what the existing
regulators provide - there's nothing particularly wrong with the helper
function but defining an entirely new regulator type for it doesn't seem
useful.
