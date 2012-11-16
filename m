From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP2+: HDMI: Relocate audio platform device
 creation
Date: Fri, 16 Nov 2012 11:14:56 -0600
Message-ID: <50A67490.4080002@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com> <1353029819-21809-2-git-send-email-ricardo.neri@ti.com> <50A5ED76.4040308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33888 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140Ab2KPRP6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 12:15:58 -0500
In-Reply-To: <50A5ED76.4040308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: tony@atomide.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Hi Tomi,

On 11/16/2012 01:38 AM, Tomi Valkeinen wrote:
> Hi,
>
> On 2012-11-16 03:36, Ricardo Neri wrote:
>> Creating the accessory devices (such as audio) from the HDMI driver,
>> allows to regard HDMI as a single entity with audio an display
>> functionality. This intends to follow the design of drivers such
>> as MFD-type, in which a single entity handles the creation of the accessory
>> devices. Such devices are then used by domain-specific drivers (audio in
>> this case). This is in line with the DT implementation of HDMI, in which
>> we will have a single node to describe this feature of the OMAP SoC. Otherwise,
>> we would need to have separate nodes for audio and video functionality.
>>
>> Previously, the platform device for the audio driver was created in
>> arch/arm/mach-omap2/devices.c. Thus, this is removed.
>>
>> Also, as the platform device for audio created by the OMAPDSS HDMI now provides
>> a resource for the DMA port for audio samples, we do not need to specify
>> any offset in the ASoC HDMI CPU DAI driver.
>
> If you notice yourself writing "also, the patch does this" in the patch
> description, it's usually a sign that the patch needs to be split =).
:)

>
> That's perhaps not so important when a patch only deals with one
> subsystem or one file, but when the patch changes arch, video and audio
> drivers at the same time I would like to have the patches as simple as
> possible.
>
> Here I suggest you handle the DMA port change in a separate patch.

I went ahead and submitted this part in the same patch to make sure that 
HDMI audio works in every patch.

What I can do is that a first patch creates the platform device for HDMI 
and just passes the whole register space to the audio platform device to 
not break ASoC HDMI. Then, a second patch will refine the pdev audio 
resources and remove the offset from the ASoC HDMI driver. Does that 
make sense to you?

BR,

Ricardo
>
>   Tomi
>
>
