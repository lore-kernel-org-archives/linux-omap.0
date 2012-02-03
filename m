From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] pinctrl: Add simple pinmux driver using device tree data
Date: Fri, 3 Feb 2012 23:49:21 +0100
Message-ID: <CACRpkdaDOZ3X0AkWH4B4ZGCXHPxh0CkSg3xi=jHC5L+kJr1d=w@mail.gmail.com>
References: <20120203205049.4089.74610.stgit@kaulin.local>
	<20120203205508.4089.35304.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63280 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab2BCWtW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Feb 2012 17:49:22 -0500
In-Reply-To: <20120203205508.4089.35304.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Linus Walleij <linus.walleij@stericsson.com>, Barry Song <21cnbao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Grant Likely <grant.likely@secretlab.ca>, Thomas Abraham <thomas.abraham@linaro.org>, Rajendra Nayak <rajendra.nayak@linaro.org>, Dong Aisheng <dong.aisheng@linaro.org>, Shawn Guo <shawn.guo@freescale.com>, Dong Aisheng <dongas86@gmail.com>

On Fri, Feb 3, 2012 at 9:55 PM, Tony Lindgren <tony@atomide.com> wrote:

> Add simple pinmux driver using device tree data.
>
> Currently this driver only works on omap2+ series of
> processors, where there is either an 8 or 16-bit mux
> register for each pin. Support for other similar pinmux
> controllers could be added.

So since it's not named pinctrl-omap I guess you intend it
to be fully generic for simple muxes, which is nice!
If people start ACK:ing this I will be happy with it too,
because it's very easy to understand.

> Note that this patch does not yet support pinconf_ops
> or GPIO. Further, alternative mux modes are not yet
> handled.

Do you want to evolve the patch for these features
or do you want to refactor it in later?

Yours,
Linus Walleij
