From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: Provide dummy supply support
Date: Fri, 28 Oct 2011 23:59:31 +0200
Message-ID: <20111028215931.GA30366@opensource.wolfsonmicro.com>
References: <1319833618-25190-1-git-send-email-s.hauer@pengutronix.de>
 <1319833618-25190-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1319833618-25190-2-git-send-email-s.hauer@pengutronix.de>
Sender: linux-sh-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Mundt <lethal@linux-sh.org>, Tony Lindgren <tony@atomide.com>, Mike Frysinger <vapier@gentoo.org>, linux-sh@vger.kernel.org, linux-omap@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 28, 2011 at 10:26:58PM +0200, Sascha Hauer wrote:

>  drivers/regulator/Makefile        |    2 +-
>  drivers/regulator/dummy-supply.c  |   88 +++++++++++++++++++++++++++++++++++++

We already have a dummy regulator driver and a fixed voltage regulator
driver, we shouldn't be adding a third implementation of the same thing.
Just use the fixed voltage regulator for this.
