From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: HDMI: Create platform device to support
 audio
Date: Thu, 25 Oct 2012 19:46:58 -0500
Message-ID: <5089DD82.3050906@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-7-git-send-email-ricardo.neri@ti.com> <5084F85C.9050508@ti.com> <5085E957.6060003@ti.com> <50866569.8010409@ti.com> <5086BB01.1080802@ti.com> <5086C333.9000801@ti.com> <5086D200.7000008@ti.com> <50876E9F.5010305@ti.com> <50894D3F.6000701@ti.com> <508952A7.3040800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46605 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab2JZAtN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 20:49:13 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9Q0nDAW013409
	for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 19:49:13 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9Q0nDFM006431
	for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 19:49:13 -0500
In-Reply-To: <508952A7.3040800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org



On 10/25/2012 09:54 AM, Tomi Valkeinen wrote:
> On 2012-10-25 17:31, Ricardo Neri wrote:
>>
>>
>> On 10/23/2012 11:29 PM, Tomi Valkeinen wrote:
>>> On 2012-10-23 20:21, Ricardo Neri wrote:
>>>
>>>>> If so, you could pass only that one address, instead of the whole HDMI
>>>>> register space?
>>>> Yes, that could work. I thought about that but the common HDMI driver
>>>> would have to know the the IP-specific register, which it should not.
>>>
>>> Argh, of course...
>>>
>>>> Perhaps the IP-specific register address can be passed by a IP-specific
>>>> function such as hdmi_get_audio_dma_port for the common HDMI driver to
>>>> populate the resource.
>>>>
>>>> Btw, could this be another reason to convert the IP-specific libraries
>>>> to drivers?
>>>
>>> Yes, I think it makes more and more sense to do that.
>>>
>>>> Even though this would allow our HDMI drivers to be more inline with
>>>> what other HDMI drivers do, things like power management and interrupts
>>>> are still handled by DSS, unlike x86, for instance [1][2]. So the audio
>>>> drivers will still depend on DSS. Also, the register layout is different
>>>> for OMAP5 and audio registers are even more scattered. Furthermore, the
>>>> common HDMI driver would have to know the IP-specific layout to know
>>>> what register spaces expose to the audio driver (another reason to have
>>>> IP-specific drivers?). So I would vote for continuing using the omapdss
>>>> audio interface.
>>>
>>> Okay.
>>>
>>> I think your approach is ok for the time being. I don't like passing the
>>> whole register space to the audio driver, but that's the best we can do
>>> with the current driver.
>>
>> What about for now having a function in the IP library to be called from
>> the common driver to determine the address of the port? Something like[1]:
>>
>>      res = platform_get_resource_byname(hdmi.pdev,
>>                         IORESOURCE_MEM, "hdmi_wp");
>>
>>      aud_offset = hdmi.ip_data.ops->audio_get_dma_port_off();
>>      aud_res[0].start = res->start + aud_offset;
>>      aud_res[0].end = res->start + aud_offset + 3;
>
> Yep, I think that looks quite clean. I wonder if there's a macro or func
> to calculate the end position... It'd be more readable to set start and
> size, instead if start and end.
I'll check.

>
>>> Have you looked at converting to IP specific drivers? Any idea of the
>>> effort? I'd like it to be done with the omap4 hdmi driver first, before
>>> merging omap5 hdmi into the mainline, if at all possible.
>>>
>> As a first step, I have started implementing a separate driver for the
>> TPD12S015 as you suggested in the past. For converting the IP libraries
>
> I'm not sure you can to the TPD as a separate driver currently. Or, at
> least in the way I've imagined it to be. My thinking is that it should
> be a "video entity" between OMAP's HDMI output and the HDMI monitor, but
> we don't currently support these kind of chains. That's why I suggested
> to just cleanly separate the TPD code in separate areas, and prefix the
> funcs with tpd, etc.
>
> What have you planned for it?

I was thinking that this driver would handle the LS_OE and the CT_CP_HDP 
GPIOs and the HDP interrupt. Thus, the HDMI driver would call 
tpd_ls_oe(1) instead of gpio_set_value. For the HPD interrupt, it would 
call the HDMI driver to put the PHY in LDOON state. Of course, the 
driver (or library or separate functions?) would get its info from the 
DT or board data.

The interrupt would have to be handled with care to ensure that PHY is 
never in TX when there is no cable attached.

For the DDC signals, only take care of the pull-up resistor settings.

Thus, my view of connecting the OMAP HDMI IP to the HDMI monitor is just 
enabling the shifter or getting the HPD events.
>
>> into drivers, I still don't see how to keep them independent of omapdss
>> to be reusable by DaVinci platforms (but afaik they are not using our
>> libraries anyways). Maybe, a thin compatibility layer for omapdss (the
>> hdmi_panel)? I still don't  have a clear idea. :/
>
> Yeah, I think we need quite a bit of restructuring to convert the IP
> libs to drivers. Or more precisely, redirections.
>
> What I imagine we'd have is some kind of hdmi_ops struct, containing
> function pointers for the operations. These calls would go to IP driver.
> The IP driver would create this struct at probe time, and register
> itself somewhere.

Could we have a sort of HDMI core driver? This is to serve as a hub of 
the IP operations and a layer between the panel and the IP driver. The 
IP driver would register with this driver. Also this core would handle 
HDMI stuff that is specific to the protocol (e.g., N/CTS calculation, 
Pclk vs TMDS clock for deep color, video timings, etc).
>
> Then hdmi panel driver would get this hdmi_ops pointer from the place
> where it was registered to, and use it to call the functions.

This would contain the omapdss specific stuff so that DaVinci can use 
the HDMI core and IP drivers.

BR,

Ricardo
>
>   Tomi
>
>
