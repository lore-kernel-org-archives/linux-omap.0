From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH RFC 0/3] first pass converting omap4 clock data to DT
Date: Tue, 4 Jun 2013 16:28:54 +0300
Message-ID: <1370352534.25965.52.camel@sokoban>
References: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59347 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418Ab3FDN3d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jun 2013 09:29:33 -0400
In-Reply-To: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Rajendra <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>

Hi Mike,

On Mon, 2013-06-03 at 23:39 -0700, Mike Turquette wrote:
> This is a very incomplete conversion of a handful of OMAP4 PRCM clocks
> from the statically defined clock data in
> arch/arm/mach-omap2/cclock44xx_data.c to a new dts file in
> arch/arm/boot/dts/omap4-clocks.dtsi.

I gave a quick try for this set and it seems to be working nicely, so
for at least me this approach is fine. Feel free to add tested-by me if
you like (for the basic clock bindings also.) Can't comment much on the
DT stuff though as my experience is rather limited on it.

> I am not a DT expert so many of the choices here may be quite disgusting
> to look at, or may be on the right path.  In particular I simply include
> the new omap4-clocks.dtsi from omap4.dtsi, which feels a bit kludgey.
> Also this series depends on the basic clock bindings RFC I posted
> earlier today[1].
> 
> I actually have an omap4-clock.dtsi file with many more clocks converted
> to the mux-clock, divider-clock, fixed-clock, fixed-factor and
> (unpublished) gate-clock bindings in my local repo, but it is not
> currently booting.  I wanted to get this early preview out regardless.

Any way I can get access to your local tree? Can you push a branch
somewhere? I could provide you debugging support on this at least, as I
spent quite a bit of time earlier moving the clock data under
drivers/clk... I guess you are probably seeing similar issues I faced.

-Tero

> 
> [1] http://article.gmane.org/gmane.linux.kernel/1501216
> 
> Mike Turquette (3):
>   clk: omap: introduce clock driver
>   ARM: dts: omap4 clock data
>   ARM: omap4: register DT clocks & remove old data
> 
>  arch/arm/boot/dts/omap4-clocks.dtsi   | 128 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi          |   2 +
>  arch/arm/mach-omap2/cclock44xx_data.c |  54 ++------------
>  drivers/clk/Makefile                  |   1 +
>  drivers/clk/omap/Makefile             |   1 +
>  drivers/clk/omap/clk.c                |  55 +++++++++++++++
>  include/linux/clk/omap.h              |  24 +++++++
>  7 files changed, 217 insertions(+), 48 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap4-clocks.dtsi
>  create mode 100644 drivers/clk/omap/Makefile
>  create mode 100644 drivers/clk/omap/clk.c
>  create mode 100644 include/linux/clk/omap.h
> 


