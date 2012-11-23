From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange platform devices
 for ASoC drivers
Date: Thu, 22 Nov 2012 20:12:01 -0600
Message-ID: <50AEDB71.2040501@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com> <1353029819-21809-3-git-send-email-ricardo.neri@ti.com> <50A5F0A5.2010105@ti.com> <50A6805C.3050004@ti.com> <50AA2D01.5020302@ti.com> <20121120011526.GF4483@opensource.wolfsonmicro.com> <50AD6FB0.3050808@ti.com> <50AE2022.8080607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37771 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382Ab2KWCNF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 21:13:05 -0500
In-Reply-To: <50AE2022.8080607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, tony@atomide.com, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org



On 11/22/2012 06:52 AM, Tomi Valkeinen wrote:
> On 2012-11-22 02:20, Ricardo Neri wrote:
>> Hi Tomi, Mark,
>>
>> On 11/19/2012 07:15 PM, Mark Brown wrote:
>>> On Mon, Nov 19, 2012 at 02:58:41PM +0200, Tomi Valkeinen wrote:
>>>
>>>> I still don't understand why the codec and machine drivers need to be
>>>> created in the board file. That just forces us to replicate the same
>>>> code for all OMAP boards that have OMAP HDMI output. Why not create the
>>>> devices in some common code, for example arch/arm/mach-omap2/display.c?
>>>
>>> Yes, this would be more sensible if there's no board specifics involved.
>>
>> I think they are truly board-specific. For instance, there could be some
>
> I don't =).
>
>> board that does not have the OMAP HDMI IP wired to an external
>> connector. We don't want the drivers to be probed in that case. If they
>> are in common code, the devices will be created even if a board does not
>> have HDMI output.
>
> The HDMI devices are still there in the HW even if we don't have a HDMI
> connector. I don't see any problem with probing the HDMI audio driver
> even in that case.
>
> But of course the user space shouldn't see a usable HDMI display/audio
> if there's no connector. For display side this is managed so that the
> HDMI IP driver is always loaded, but a HDMI panel driver is only there
> if the board file tells that we have a connector.
>
> I guess this could be optimized by having a "disabled" flag for HDMI IP
> driver, so that it wouldn't even need to allocate any private data
> structures of such. But the savings would be quite minimal.

Maybe, just create the devices for ASoC only if it sees a HDMI dss 
device in the omapdss_board_info?
>
>>>> With DT this should be similar: OMAP's hdmi devices should be presented
>>>> in the omap4.dtsi file, not in each individual board dts. Although the
>>>> DT data should represent the hardware, and if the code and machine
>>>> devices are not really there in the HW, then... I don't know =).
>>>
>>> Well, in a case like this where the sound card is essentially autoprobed
>>> based on the detection of the hardware at runtime the sound card
>>> probably shouldn't appear in the device tree at all - you'll probably
>>> want something to say there's a physical HDMI port it's worth looking at
>>> there but everything else should be figured out at runtime.
>>
>> Yes, I was planning to rely on the DSS DT entries in the omap4.dtsi
>> file. However, no HDMI audio support should be probed if the board does
>> not have an HDMI connector. Also, the TPD chip should appear on the
>> Pandaboard/SDP4430 dts files. Only if both conditions are met, probe the
>> HDMI audio drivers, this conditions will be checked at run time by the
>> ASoC HDMI machine driver.
>>
>> Something like this:
>>
>>      sound_hdmi {
>>          compatible = "ti,omap-hdmi-card-audio";
>>          ti,model = "OMAP4HDMI";
>>
>>          ti,hdmi_audio = <&hdmi>;
>>          ti,level_shifter = <&tpd12s015>;
>>      };
>>
>> The ASoC machine driver would create the platform device for the HDMI
>> codec if the DT has the required nodes.
>
> The TPD chip really shouldn't be here in. It's an external component,
> not related to audio in any way. I think the HDMI audio driver should be
> only concerned about the HDMI IP.

OK. So display code will handle all the DT details for the audio drivers 
to use.

> The HDMI IP video driver shouldn't
> care about TPD chip either, but for now we need to manage it somewhere,
> and that's the easiest place for it.
BTW, I have a draft for this, but more urgent things have been consuming 
my bandwidth. :/

BR,

Ricardo
>
> So... I'm not sure how this should be managed, but I am 99% sure that
> there's nothing board specific with HDMI audio, and thus it should be
> managed in common .c files in arch code or dss code, or .dts files. If
> we add the hdmi display in the .dts files, I think the audio should just
> work.
>
> Or is there something in ASoC that forces us to represent it in the
> .dts? I don't think there's really anything related to HW to describe
> there related to HDMI audio. If we have HDMI video output, we also have
> the audio, as simple as that.
>
>   Tomi
>
>
