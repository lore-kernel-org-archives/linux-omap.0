From: Archit Taneja <a0393947@ti.com>
Subject: Re: [RFC 00/17] OMAPDSS: Change way of passing timings from panel
 driver to interface
Date: Wed, 8 Aug 2012 14:54:53 +0530
Message-ID: <50223065.8070302@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>     <1344349948.7216.82.camel@lappyti> <502201B7.9030205@ti.com>    <1344407158.17575.21.camel@lappyti> <50220B94.5040303@ti.com>   <1344410835.17575.54.camel@lappyti> <50221C4D.8000503@ti.com>  <1344413580.4932.5.camel@deskari> <50222575.6050807@ti.com> <1344415685.4932.14.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33083 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757927Ab2HHJ0T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Aug 2012 05:26:19 -0400
In-Reply-To: <1344415685.4932.14.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com

On Wednesday 08 August 2012 02:18 PM, Tomi Valkeinen wrote:
> On Wed, 2012-08-08 at 14:08 +0530, Archit Taneja wrote:
>> On Wednesday 08 August 2012 01:43 PM, Tomi Valkeinen wrote:
>>> On Wed, 2012-08-08 at 13:29 +0530, Archit Taneja wrote:
>>>
>>>> Okay, one thing which I want to align on is that most of these functions
>>>> don't really do the actual configurations. That is, they'll just update
>>>> the private data, and the actual configuration will only happen on enable.
>>>>
>>>> We would want set_timings() op to have a direct impact. But we wouldn't
>>>> want the same for setting the data lines, that could be clubbed with
>>>> other configurations at enable. That's okay, right?
>>>
>>> I'm not sure we want/need set_timings to have direct impact. Changing
>>> the timings on the fly has some problems, like the output size changing
>>> to smaller than the overlays, and we perhaps may need to adjust the
>>> clock dividers (dispc's, DSI PLL's or PRCM's).
>>>
>>> It feels just much easier and safer to require that the mgr is disabled
>>> when these changes are made. And as far as I can see, there shouldn't be
>>> any need to change the timings via the shadow registers, as quickly as
>>> possible and during vblank...
>>
>> That makes sense. But currently set_timings for DPI has a direct impact.
>> HDMI/VENC/SDI take the easier route of disabling and enabling the interface.
>>
>> I agree it's safer and easier to make sure things are disabled first,
>> but maybe it's good to have the capability set hdmi timings on the fly
>> in the future, it would make the switch faster, same goes for reading edid.
>
> When do we need to switch mode quickly? Reading edid should not require
> disabling the output for sure.

I think I'm just finding excuses to find a use for my work done in 
APPLYing manager related registers.

You are right about edid. Changing HDMI timings take a couple of seconds 
now, I was wondering how much that has to do with us completely 
disabling/enabling hdmi. it may be just the slowness of the monitors 
which causes this.

>
> HDMI is a bit broken currently, though. I think we first enable the
> whole stuff, including video output using VGA, then we read EDID, then
> we change the mode.
>
> We should just enable enough of HDMI to be able to read EDID, and start
> the video output with the correct mode. This needs some restructuring of
> the driver, though. I tried it once quickly, but it turned out not to be
> trivial.

Right. Most likely this restructuring would allow us to modify only the 
hdmi timings part when setting a new timing. We could check how much 
time we save then :)

>
>> What I meant to ask was whether we should do the same for something like
>> dpi_set_data_lines(), that is, disable dpi, update the data_lines
>> private data with a new value, and enable dpi again.
>
> Hmm, I think it's better to leave disabling and enabling the output to
> the panel driver. So when the panel driver wants to use
> dpi_set_data_lines(), it needs to first disable the DPI output. If it
> doesn't, dpi_set_data_lines() returns -EBUSY.
>
> Otherwise if the panel driver does something like:
>
> dpi_set_foo()
> dpi_set_bar()
>
> Both of those could first disable output, change setting, enable output.
> Instead the panel should first disable, then call those, and then
> enable.

Right, that makes sense.

Archit

