From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange platform devices
 for ASoC drivers
Date: Fri, 16 Nov 2012 12:05:16 -0600
Message-ID: <50A6805C.3050004@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com> <1353029819-21809-3-git-send-email-ricardo.neri@ti.com> <50A5F0A5.2010105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38404 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407Ab2KPSGS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 13:06:18 -0500
In-Reply-To: <50A5F0A5.2010105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: tony@atomide.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org



On 11/16/2012 01:52 AM, Tomi Valkeinen wrote:
> On 2012-11-16 03:36, Ricardo Neri wrote:
>> This relocates and renames the platform devices for ASoC HDMI drivers
>> to give them a more logical structure.
>>
>> The previous omap-hdmi-audio device is renamed as omap-hdmi-audio-card
>> and is relocated to the SDP4430 and Pandaboard board files. This is to
>> better illustrate the fact that it describes the whole HDMI audio
>> functionality on such boards, including the companion chip.
>>
>> The previous omap-hdmi-audio-dai is renamed as omap-hdmi-audio. The -dai
>> part is removed to not have references to ASoC concepts in the OMAPDSS
>> HDMI driver. Also, as it will be used by the ASoC HDMI CPU DAI driver,
>> the name refers only to OMAP HDMI audio functionality, irrespective of the
>> board.
>>
>> The names of the ASoC drivers are also updated accordingly.
>
> And same thing here as with the previous patch. Do the move and rename
> in separate patches for clarity.

OK. I'll do.
>
>> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
>> ---
>>   arch/arm/mach-omap2/board-4430sdp.c    |    6 ++++++
>>   arch/arm/mach-omap2/board-omap4panda.c |    6 ++++++
>>   arch/arm/mach-omap2/devices.c          |   17 -----------------
>>   drivers/video/omap2/dss/hdmi.c         |    2 +-
>>   sound/soc/omap/omap-hdmi-card.c        |    4 ++--
>>   sound/soc/omap/omap-hdmi.c             |    2 +-
>>   6 files changed, 16 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
>> index 3669c12..97bdff3 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -388,6 +388,11 @@ static struct platform_device sdp4430_hdmi_audio_codec = {
>>   	.id	= -1,
>>   };
>>
>> +static struct platform_device sdp4430_hdmi_audio_card = {
>> +	.name	= "omap-hdmi-audio-card",
>> +	.id	= -1,
>> +};
>> +
>>   static struct omap_abe_twl6040_data sdp4430_abe_audio_data = {
>>   	.card_name = "SDP4430",
>>   	.has_hs		= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
>> @@ -423,6 +428,7 @@ static struct platform_device *sdp4430_devices[] __initdata = {
>>   	&sdp4430_dmic_codec,
>>   	&sdp4430_abe_audio,
>>   	&sdp4430_hdmi_audio_codec,
>> +	&sdp4430_hdmi_audio_card,
>>   };
>
> I don't know anything at all about the audio drivers, but this doesn't
> feel good to me. The HDMI audio is tied to the HDMI video, both of which
> are parts of OMAP SoC. So if you have two boards with HDMI video (and
> thus audio), the device data related to HDMI video and audio are
> identical except for a few HW details like the GPIOs for the TPD chip.
>
> So is there any reason to add hdmi audio devices in each board file? It
> sounds to me that a common place to add the device for all boards would
> make more sense. This could, perhaps, be arch/arm/mach-omap2/display.c
> which handles adding the HDMI device, or some other similar file
> (although you just removed it from such a file, the devices.c...).

In ASoC, we have three drivers for ASoC HDMI audio. The CPU-DAI driver 
deals with the CPU audio interface. So, I regard the OMAP HDMI IP as the 
CPU DAI. A device is needed to probe the driver, but as HDMI audio and 
video are the same physical component, it made sense to have the HDMI 
video driver to create it. Furthermore, except for the TPD handling the 
HDMI driver deals only with OMAP stuff. Also, we will have a single node 
for HDMI when DT comes. Thus, the device for the ASoC CPU DAI has to be 
created somewhere.

We also have codec. ASoC codecs are chips like TWL6040 that 
render/capture audio. For ASoC HDMI, a TV or a home theater unit could 
be regarded as the codec. Strictly speaking, it is not a device mounted 
on the board such as TWL6040 but does the same work and we have to 
represent it for ASoC to use.

Finally we have the ASoC machine (or board) driver, that glues together 
the DAI and codec.
>
> And actually, why isn't the card driver added in the hdmi video driver,
> like the omap-hdmi-audio-dai?

The card driver represents a board. It made sense to me to relocate it 
into the board files. Furthermore, when HDMI DT is supported in the 
feature, the node for this machine driver will be in the DT; so, we will 
not needed and we would end up relocating it anyways.
>
> You say the omap-hdmi-audio-card covers also the TPD chip, but why does
> HDMI audio even need to cover that chip? It has no relevance to the
> audio side, as long as the video driver enables it properly, right?

Yes, audio does not have anything to do with the TPD chip, but we do 
need an ASoC machine driver. Thus, the only components that are there to 
describe an ASoC machine driver are the OMAP, TPD and the HDMI 
connector. Indeed, to not tie the ASoC machine driver to a specific 
companion chip (as commented by Liam), I just used the -card suffix.
>
> Perhaps I'm missing something here, as I don't have any knowledge of the
> audio side, though. What do the different audio devices represent?

I hope the explanation above provides more clarity to you. I think HDMI 
does not fit seamlessly into the ASoC driver model, as we don't have a 
real codec and no machine driver seems to be needed. This is the best I 
could get. :/ :)


>
> So I'm not saying your approach is wrong, I just don't understand it =).

:)

BR,

Ricardo
>
>   Tomi
>
>
