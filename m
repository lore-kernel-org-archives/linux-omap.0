From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Wed, 19 Dec 2012 12:27:48 +0100
Message-ID: <CAAwP0s30Ap9deL506Fk6tBD=JqLT8wFP0CZw8n71hx_YJvNBfw@mail.gmail.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
 <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
 <50ADE6A5.3030001@ti.com> <CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com>
 <50AF37EA.3080400@ti.com> <CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com>
 <50B4A4D7.2070203@ti.com> <CAGDS+nmaGK1igkYnz0EQEycUU=LsD5yz9wxmipSnWohKvAPTXA@mail.gmail.com>
 <50B74592.3020308@ti.com> <CAGDS+n=oQYr+24mX6bdgtW=fzvfvfX5rAvNXXpxM4YKPxHDodQ@mail.gmail.com>
 <50B771D3.8050907@ti.com> <CAGDS+n=dbuEQgdw9nJ_mYQpuJr5huSgX6e3sBDcvy0+C6T5hFQ@mail.gmail.com>
 <50B777A3.1080803@ti.com> <CAAwP0s3hYiovSqRfBFDGVQCDVUqYKZrY9QXp+G-R707szdmVqA@mail.gmail.com>
 <CAAwP0s1JgN4tZjQ74-tmcGyJy9NFf=gPipP3VmqOCKJ6HdmrWg@mail.gmail.com>
 <CAAwP0s2ksE1wbb4Y3k3+_XeR5DLTgOsOAo63arh4f9F942nGdQ@mail.gmail.com> <50D17BCF.1080108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:45888 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab2LSL2K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 06:28:10 -0500
Received: by mail-oa0-f54.google.com with SMTP id n9so1884289oag.13
        for <linux-omap@vger.kernel.org>; Wed, 19 Dec 2012 03:28:10 -0800 (PST)
In-Reply-To: <50D17BCF.1080108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

On Wed, Dec 19, 2012 at 9:33 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2012-12-18 15:45, Javier Martinez Canillas wrote:
>> Hi,
>>
>> I've tested with the latest stable kernel (Linux 3.7.1) and the video
>> output is working correctly with the same user-space components.
>> The complete dmesg is here: http://fpaste.org/1Kv4/
>>
>> Looking at the logs for both kernels I realized that there are two
>> differences main between the working (3.7.1) and non-working
>> (mainline) kernel (besides the versions of course):
>>
>> a) The number of framebuffers created (working 1, non working 3)
>> b) The omapfb now uses dma_alloc_attrs to allocate memory instead of
>> the now removed OMAP-specific omap_vram_alloc
>>
>> For a) I built mainline with CONFIG_FB_OMAP2_NUM_FBS=1 and that made
>> the error about the overlay paddr being zero disappear (OVERLAY error:
>> check_overlay: paddr cannot be 0) but still no video on the screen.
>
> Ok. I think the reason for that is that the paddr errors come from X
> trying to setup the video overlays with paddr 0. The video overlays are
> by default on fb1 and fb2, so they are not present if you set the
> NUM_FBS to 1.
>

Yes, that's what I thought, I'll just use CONFIG_FB_OMAP2_NUM_FBS=1
then on my defconfig.

>> Conversely I build 3.7.1 with CONFIG_FB_OMAP2_NUM_FBS=3 and even
>> though I had the paddr can't be zero error, video is working
>> correctly. So it seems that error shouldn't affect the video display.
>
> Hmm, so do you get any display with 3.8, before X is started, using
> plain fb? For example, break the boot before X is started, and do
>
> cat /dev/urandom > /dev/fb0
>
> Do you have an userspace image I could download to reproduce this?
>
>> For b) I tried to built mainline with CONFIG_CMA=y but it didn't work either.
>
> I don't think the vram change affects this, except if you see errors
> about mem alloc. But yes, I think you should enable CMA with 3.8,
> although allocation may work fine for smaller displays even without CMA.
>
>  Tomi
>
>

Hi Tomi,

At the end it was a red herring.

The problem was not in the kernel but in U-Boot that now only sets the
OMAP mux pins of the peripherals that uses. So the DSS OMAP mux pins
and the OMAP GPIO line that is used to power up the TFP410 chip has to
now be set in the kernel.

We will send a patch for the igep0020 board file to fix the issue.

Thanks a lot for your help and sorry for the noise!

Best regards,
Javier
