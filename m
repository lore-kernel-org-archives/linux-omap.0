From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 09/21] OMAPDSS: DISPC: Calculate scaling limits in a more
 generic way
Date: Fri, 14 Sep 2012 15:33:40 +0530
Message-ID: <505300FC.3020706@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>   <1347538505-25359-10-git-send-email-archit@ti.com>  <1347612788.2559.57.camel@deskari> <5052F547.9090102@ti.com> <1347616145.2559.70.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56354 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756325Ab2INKDd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 06:03:33 -0400
In-Reply-To: <1347616145.2559.70.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 14 September 2012 03:19 PM, Tomi Valkeinen wrote:
> On Fri, 2012-09-14 at 14:43 +0530, Archit Taneja wrote:
>> On Friday 14 September 2012 02:23 PM, Tomi Valkeinen wrote:
>>> On Thu, 2012-09-13 at 17:44 +0530, Archit Taneja wrote:
>>>> Scaling calculations for an overlay are done by comparing pixel clock of the
>>>> connected overlay manager and the core clock of DISPC. The pixel clock is the
>>>> output rate of the scalar. The scalar block needs to provide pixels at this rate
>>>> since the manager is connected to a panel, which has real time constraints.
>>>>
>>>> In the case of writeback in memory to memory mode, the output of the scalar
>>>> blocks aren't connected to a display, and hence there isn't a pixel clock which
>>>> causes downscaling limitations.
>>>>
>>>> Make the input to scaling calculations a bit more generic by passing the scalar
>>>> output rate rather than passing pixel clock of the overlay manager connected to
>>>> the pipeline, as we now have use cases where the scalar's output may not go to
>>>> a manager connected to a panel.
>>>
>>> Pixel clock is the rate at which pixels are processed. I don't see it
>>> only meaning a clock that's related to actual video signal going out of
>>> OMAP. So if in normal case the scaler outputs pixels at the rate of
>>> pixel clock, we can call it pixel clock with WB's case also, instead of
>>> renaming it to output clock.
>>
>> Pixel clock, in OMAP DSS terms, is the rate at which the video port of
>> an overlay manager provides pixels to an output. It is a fixed rate at
>> which the scaler needs to push out data.
>>
>> If we stick to this terminology of pixel clock, I don't think it applies
>> to writeback. As far as I see it, there is no specific rate at which the
>> scaler outputs data, it adjusts itself based on how much scaling is
>> done, and at the rate we can get/push data to the interconnect. That's
>> why I didn't want to call it pixel clock. Because, that sounds a lot
>> like a fixed rate at which pixels need to be output.
>
> I see your reasoning. I'm a bit reluctant to add a new clock term to
> omapdss. You can't (probably) find it in the TRM. Does the TRM talk
> about clocks with regard to WB?

Yes, you can't find the word pixel clock linked to WB in the TRM.

>
> I do think pixel clock can be used as well here. While normally used for
> output, it's just a clock used for pixels, and at each tick we process
> one pixel, which is exactly what happens with WB also.
>
> Also, if I understood right, this pixel clock is not even used for WB,
> and in a later patch you just use a dummy value of 1 for the clock for
> WB. So even if pixel clock would not be the best name, would it make
> sense to use the name of pixel clock, but return 0 as the pck for WB,
> implying that pck is not valid/does not exist, and the scaling
> restrictions can be skipped for that?

Yes, we could do that. I can check if zero leads to some bad results, or 
we could just bypass the scaler clock stuff if the pixel clock is 0.

Archit

