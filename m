From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v2 1/8] clk: ti: add gpio controlled clock
Date: Tue, 19 Aug 2014 15:23:12 +0300
Message-ID: <53F341B0.3090904@ti.com>
References: <cover.1408397864.git.jsarha@ti.com> <f080a02691e0f1b45607d7a1afe89698b7f911da.1408397864.git.jsarha@ti.com> <20140819113200.GJ3302@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40584 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbaHSMXd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Aug 2014 08:23:33 -0400
In-Reply-To: <20140819113200.GJ3302@leverpostej>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "airlied@linux.ie" <airlied@linux.ie>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "detheridge@ti.com" <detheridge@ti.com>, "ezequiel.garcia@free-electrons.com" <ezequiel.garcia@free-electrons.com>, "t-kristo@ti.com" <t-kristo@ti.com>

On 08/19/2014 02:32 PM, Mark Rutland wrote:
> On Mon, Aug 18, 2014 at 10:46:39PM +0100, Jyri Sarha wrote:
>> The added ti,gpio-clock is a basic clock that can be enabled and
>> disabled trough a gpio output. The DT binding document for the clock
>> is also added. For EPROBE_DEFER handling the registering of the clock
>> has to be delayed until of_clk_get() call time.
>
> I guess this is basically an AND gate with the GPIO and parent clock as
> inputs? Or is this something more complex that we might want to do more
> things with later?
>
> If it's the former it sounds like this could be a completely generic
> "gpio-gate-clock".
>

Yes, its completely generic. However, since there has been no response 
to my several earlier attempts to get this patch in I finally gave up 
and moved it under clk/ti.

"gpio-gate-clock" sound like more accurate name for ti. I'll change that.

Do you think I should give this one more try to get it in as generic 
basic clock?

Cheers,
Jyri

