From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange platform devices
 for ASoC drivers
Date: Thu, 22 Nov 2012 20:03:53 -0600
Message-ID: <50AED989.40408@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com> <1353029819-21809-3-git-send-email-ricardo.neri@ti.com> <50A5F0A5.2010105@ti.com> <50A6805C.3050004@ti.com> <50AA2D01.5020302@ti.com> <20121120011526.GF4483@opensource.wolfsonmicro.com> <50AD6FB0.3050808@ti.com> <20121122010358.GB4371@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55329 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756867Ab2KWCE7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 21:04:59 -0500
In-Reply-To: <20121122010358.GB4371@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, tony@atomide.com, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Hi Mark,

On 11/21/2012 07:03 PM, Mark Brown wrote:
> On Wed, Nov 21, 2012 at 06:20:00PM -0600, Ricardo Neri wrote:
>> On 11/19/2012 07:15 PM, Mark Brown wrote:
>
>>> Yes, this would be more sensible if there's no board specifics involved.
>
>> I think they are truly board-specific. For instance, there could be
>> some board that does not have the OMAP HDMI IP wired to an external
>> connector. We don't want the drivers to be probed in that case. If
>> they are in common code, the devices will be created even if a board
>> does not have HDMI output.
>
> That's just a case of having a flag in the platform data for the device
> saying "don't use this port"
Ok. I guess I can put code so that the devices for ASoC are created only 
if there are HDMI displays in the omapdss_board_info.devices array.

 > as opposed to having the entire ASoC device

> instantiation infrastructure in there which is rather Linux specific.
But the board files are only for Linux, right? The ASoC drivers will 
always be initialized anyways. They will reach probe only if the devices 
are present.

>
>> Something like this:
>
>> 	sound_hdmi {
>> 		compatible = "ti,omap-hdmi-card-audio";
>> 		ti,model = "OMAP4HDMI";
>
>> 		ti,hdmi_audio = <&hdmi>;
>> 		ti,level_shifter = <&tpd12s015>;
>> 	};
>
>> The ASoC machine driver would create the platform device for the
>> HDMI codec if the DT has the required nodes.
>
> Why not just make this a property of the main HDMI controller - the
> compatible property here looks like it's describing the Linux specifics
> not the hardware?

I see. So it seems that there will be nothing to add for DT support for 
HDMI from ASoC. Display code is able to take care of it. BTW, thanks for 
pointing out the issue with the compatible property, I have not noticed it.

BR,

Ricardo
>
