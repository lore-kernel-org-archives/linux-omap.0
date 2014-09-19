From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 1/5] clk: ti: add "ti,gpio-gate-clock" controlled clock
Date: Fri, 19 Sep 2014 08:12:40 -0500
Message-ID: <541C2BC8.3020207@ti.com>
References: <cover.1410898073.git.jsarha@ti.com> <71e8bdf16f8a3bff5db6ba80dcab9d21de05e939.1410898073.git.jsarha@ti.com> <541C2A77.9070406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47599 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756614AbaISNMw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2014 09:12:52 -0400
In-Reply-To: <541C2A77.9070406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org, Mike Turquette <mturquette@linaro.org>
Cc: tony@atomide.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, t-kristo@ti.com

On 09/19/2014 08:07 AM, Tomi Valkeinen wrote:
> On 16/09/14 23:40, Jyri Sarha wrote:
>> The added ti,gpio-gate-clock is a basic clock that can be enabled and
>> disabled trough a gpio output. The DT binding document for the clock
>> is also added. For EPROBE_DEFER handling the registering of the clock
>> has to be delayed until of_clk_get() call time.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>  .../bindings/clock/ti/gpio-gate-clock.txt          |   21 ++
>>  drivers/clk/ti/Makefile                            |    2 +-
>>  drivers/clk/ti/gpio.c                              |  202 ++++++++++++++++++++
>>  3 files changed, 224 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/clock/ti/gpio-gate-clock.txt
>>  create mode 100644 drivers/clk/ti/gpio.c
> 
> Why is this a TI clock? Sounds like a generic one to me.

Like thread: https://lkml.org/lkml/2014/9/5/284 ?
> 
> In any case, this should go through Mike.
> 
yep - should have been posted independent of this series :).



-- 
Regards,
Nishanth Menon
