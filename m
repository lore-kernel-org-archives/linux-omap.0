From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] regulator: provide dummy supply support
Date: Sat, 29 Oct 2011 01:22:01 +0200
Message-ID: <CAJaTeTpgjDoB1xj-faekgXRWH-gwBp9OOdrGLKDAcXj0CZF=VA@mail.gmail.com>
References: <1319833618-25190-1-git-send-email-s.hauer@pengutronix.de> <20111028215703.GB30339@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111028215703.GB30339@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Mundt <lethal@linux-sh.org>, Tony Lindgren <tony@atomide.com>, linux-sh@vger.kernel.org, linux-omap@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 28, 2011 at 23:57, Mark Brown wrote:
> On Fri, Oct 28, 2011 at 10:26:57PM +0200, Sascha Hauer wrote:
>> The following patch allows it for boards to register a dummy supply for
>> devices for which no software controllable regulator is available. The
>> current CONFIG_REGULATOR_DUMMY and (unused) regulator_use_dummy_regulator()
>
> Please don't send cover letters for single patch serieses, if there's
> content it should probably be in the changelog...

sorry for the additional noise, but +1
-mike
