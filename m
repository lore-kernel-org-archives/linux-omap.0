From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Fri, 2 Nov 2012 16:14:11 +0530
Message-ID: <5093A3FB.1060806@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com> <5090D28E.6050703@ti.com> <50939B84.6090602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41478 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756141Ab2KBKo3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 06:44:29 -0400
In-Reply-To: <50939B84.6090602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

On Friday 02 November 2012 03:38 PM, Tomi Valkeinen wrote:
> On 2012-10-31 09:26, Archit Taneja wrote:
>> On Tuesday 30 October 2012 09:40 PM, Tomi Valkeinen wrote:
>
>>> -    if (dpi_use_dsi_pll(dssdev)) {
>>> -        enum omap_dss_clk_source dispc_fclk_src =
>>> -            dssdev->clocks.dispc.dispc_fclk_src;
>>> -        dpi.dsidev = dpi_get_dsidev(dispc_fclk_src);
>>> +    /*
>>> +     * XXX We shouldn't need dssdev->channel for this. The dsi pll clock
>>> +     * source for DPI is SoC integration detail, not something that
>>> should
>>> +     * be configured in the dssdev
>>> +     */
>>
>> It is SoC integration detail, but it's flexible, it depends on which
>> manager is connected to DPI output. If it's connected to LCD1, the
>
> Hmm, yes, the comment is a bit misleading. The DSI PLL is not used for
> DPI, but for DISPC's LCD output. And DPI uses one of those LCD outputs.
>
>> source can be DSI1 PLL, if it's LCD2, it's source can be DSI2 PLL, if
>> it's connected to TV manager, it's source "has to be" HDMI PLL. And
>> these connections vary based on which OMAP revision we are on. We can
>> only be certain on OMAP3 that the source for DPI pixel clock can be
>> either PRCM or DSI PLL.
>
> On OMAP2 we can be certain the clock is PRCM =).
>
>> At the point of probe, we really don't know which manager is the DPI
>> output connected to. Hence, we sort of use dssdev->channel to make a
>> guess what manager we connect to in the future.
>
> Yep. My point was mainly that dssdev needs to go away, and we should
> somehow decide the used channel internally.
>
>> The right approach would be to figure this out at the time of enable,
>> where we know which manager the DPI output is connected to. We could
>> probably move the verification there too.
>
> Who chooses which manager to use for DPI?

If you are asking in terms of HW. The value in the DSS_CTRL bitfield 
decides which manager to use.

If you meant who/how should we choose this in software, then I don't 
know either.

>
> I'm not sure... I would really like to manage the basic setup, acquiring
> the resources, etc. at probe time, and enable would only enable the display.

One thing we could do is to grab all the possible resources that DPI can 
use for its pixel clock, and when it's enable time, see what all options 
it has. So, for example, for DPI on omap4, we could try to grab and 
verify all DSI PLL, HDMI PLL and PRCM. And then later choose the most 
appropriate one while enabling.

>
> That means that we should somehow get a manager for DPI at probe time,
> which may be a bit difficult, as we don't know what other displays there
> will be. So if, say, DPI can use LCD1 or LCD2, but DSI can only use
> LCD2, and at DPI's probe (presuming it's before DSI) we pick LCD2, DSI
> won't work.

Yes, it's not easy to know this at probe time. We could try to allocate 
resources at the time mgr->set_output() is called. We could have an 
output specific op. dss_mgr_set_output() could look like:

dss_mgr_set_output(mgr, output)
{
	/* Do the older stuff */
	...
	...

	output->get_and_config_resources(output);
}

In dpi.c:

dss_dpi_get_and_config_resources(output)
{
	switch (output->manager->id) {
	case LCD:
		Get DSI 1 PLL;
	case LCD2:
		Get DSI2 PLL;
	case TV:
		Get HDMI PLL;
	}

	/*
	 * Also set the DSS_CTRL bits here to tell which manager
	 * we need to connect to
	 */

	dss_select_dpi_manager(output->manager->id);
}

omapdss_output_ops dpi_ops = {
	.get_and_config_resources = dss_dpi_get_and_config_resources,
	...
};

However, even though this approach might be correct in the sense that we 
confiugre dpi when we know what manager we are connected to, I have to 
say that its not nice at all. Especially because setting manager output 
links is very omapdss-apply-ish. But I feel we would need to do 
something similar in omapdrm too.

>
> Anyway, while I'm not sure how to solve the above problem, I think we
> should improve our init a bit. For DPI there are the following steps
> done, in order:
>
> - DPI device added
> - DPI driver probe
> - DPI panel device added
> - DPI panel driver probe
>
> We currently add the panel device in DPI driver's probe, and figure out
> the DSI PLL at the same time. I think that should happen only when the
> panel driver probe happens. The panel driver should call something like
> dpi_get_output() or whatever, which acquires the DPI bus for the panel
> driver, and this would probably also choose the manager.

Hmm, that makes sense. Anyway, I don't think it's really bad if we refer 
to dssdev->channel for now.

I think we could have a clearer picture of this when we understand how 
omapdrm sets the links between its entities and how CPF would link the 
output-panel side of things.

Archit

