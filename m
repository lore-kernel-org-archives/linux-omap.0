From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v3 1/5] clk: ti: add "ti,gpio-gate-clock" controlled clock
Date: Fri, 26 Sep 2014 16:56:12 -0700
Message-ID: <20140926235612.19023.35601@quantum>
References: <cover.1410898073.git.jsarha@ti.com>
 <71e8bdf16f8a3bff5db6ba80dcab9d21de05e939.1410898073.git.jsarha@ti.com>
 <541C2A77.9070406@ti.com> <541C2BC8.3020207@ti.com> <541C2EDC.2050707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:50043 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847AbaIZX4f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2014 19:56:35 -0400
Received: by mail-pd0-f169.google.com with SMTP id p10so1869135pdj.28
        for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2014 16:56:34 -0700 (PDT)
In-Reply-To: <541C2EDC.2050707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Nishanth Menon <nm@ti.com>Tomi Valkeinen <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org
Cc: tony@atomide.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, t-kristo@ti.com

Quoting Tomi Valkeinen (2014-09-19 06:25:48)
> On 19/09/14 16:12, Nishanth Menon wrote:
> > On 09/19/2014 08:07 AM, Tomi Valkeinen wrote:
> >> On 16/09/14 23:40, Jyri Sarha wrote:
> >>> The added ti,gpio-gate-clock is a basic clock that can be enabled and
> >>> disabled trough a gpio output. The DT binding document for the clock
> >>> is also added. For EPROBE_DEFER handling the registering of the clock
> >>> has to be delayed until of_clk_get() call time.
> >>>
> >>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> >>> ---
> >>>  .../bindings/clock/ti/gpio-gate-clock.txt          |   21 ++
> >>>  drivers/clk/ti/Makefile                            |    2 +-
> >>>  drivers/clk/ti/gpio.c                              |  202 ++++++++++++++++++++
> >>>  3 files changed, 224 insertions(+), 1 deletion(-)
> >>>  create mode 100644 Documentation/devicetree/bindings/clock/ti/gpio-gate-clock.txt
> >>>  create mode 100644 drivers/clk/ti/gpio.c
> >>
> >> Why is this a TI clock? Sounds like a generic one to me.
> > 
> > Like thread: https://lkml.org/lkml/2014/9/5/284 ?
> 
> Right, I should've read the earlier versions before making any smart
> comments =).

No supporters cropped up for the generic gpio clock, but the design is
common enough to merit a common clock type. And all of that stuff I said
about the machine-specific ops isn't that relevant since it is hidden
behing the gpio api.

Regards,
Mike

> 
>  Tomi
> 
> 
