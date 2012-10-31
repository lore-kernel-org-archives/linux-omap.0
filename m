From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 05/12] OMAPDSS: DSI: skip odd dividers when pck >= 100MHz
Date: Wed, 31 Oct 2012 13:02:32 +0530
Message-ID: <5090D410.5040101@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-6-git-send-email-tomi.valkeinen@ti.com> <5090C8F9.4060103@ti.com> <5090D29A.3050605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46124 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638Ab2JaHcs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 03:32:48 -0400
In-Reply-To: <5090D29A.3050605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

On Wednesday 31 October 2012 12:56 PM, Tomi Valkeinen wrote:
> On 2012-10-31 08:45, Archit Taneja wrote:
>> On Tuesday 30 October 2012 09:40 PM, Tomi Valkeinen wrote:
>>> The DSI PLL and HSDivider can be used to generate the pixel clock for
>>> LCD overlay manager, which then goes to DPI output. On the DPI output
>>> pin the voltage of the signal is shifted from the OMAP's internal
>>> minimal voltage to 1.8V range. The shifting is not instant, and the
>>> higher the clock frequency, the less time there is to shift the signal
>>> to nominal voltage.
>>>
>>> If the HSDivider's divider is greater than one and odd, the resulting
>>> pixel clock does not have 50% duty cycle. For example, with a divider of
>>> 3, the duty cycle is 33%.
>>>
>>> When combining high frequency (in the area of 140MHz+) and non-50% duty
>>> cycle, it has been observed the the shifter does not have enough time to
>>> shift the voltage enough, and this leads to bad signal which is rejected
>>> by monitors.
>>
>> Is this something seen on OMAP3 also? I guess it must be since it's the
>> same DSI IP.
>
> I have not seen this on OMAP3, but I'm 99% sure the same problem happens
> there. But I guess there are many small things affecting the signal
> quality, it could be that on omap3 beagleboard the resulting signal
> voltage is still inside the standard range, even if odd dividers weaken it.
>
> And I also think that we have the same problem with logic and pixel
> clock dividers. My understanding is that all these simple dividers (i.e.
> not a PLL or such) are made the same way, and, for example, divider of 3
> is produced by keeping the output clock low for 2 cycles of the original
> clock, and high for 1 cycle. Which leads to 33% duty cycle.
>
> However, as the actual problem only materializes with high frequencies,
> in practice we don't have a problem with pck or lck dividers. The reason
> is that if we used pcd or lcd of 3, and the resulting pixel clock would
> be > 100, the incoming DSS func clock would be around 300. Which is much
> over the limit, and thus this scenario doesn't happen.
>
>>> As a workaround this patch makes the divider calculation skip all odd
>>> dividers when the required pixel clock is over 100MHz.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>>>    drivers/video/omap2/dss/dsi.c |    5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/video/omap2/dss/dsi.c
>>> b/drivers/video/omap2/dss/dsi.c
>>> index 7d0db2b..d0e35da 100644
>>> --- a/drivers/video/omap2/dss/dsi.c
>>> +++ b/drivers/video/omap2/dss/dsi.c
>>> @@ -1386,6 +1386,11 @@ retry:
>>>                    cur.dsi_pll_hsdiv_dispc_clk =
>>>                        cur.clkin4ddr / cur.regm_dispc;
>>>
>>> +                if (cur.regm_dispc > 1 &&
>>> +                        cur.regm_dispc % 2 != 0 &&
>>> +                        req_pck >= 1000000)
>>> +                    continue;
>>> +
>>
>> Why do we do the req_pck check here? Can't we do it much earlier? We
>> could bail out right in the beginning of dsi_pll_calc_clock_div_pck() if
>> we see that req_pck is greater than 100 Mhz.
>
> I think you misunderstood the patch. We don't skip or fail calculations
> for pck > 100. What we do is we skip odd dividers if pck > 100.

Ah okay. I missed that point.

Archit
