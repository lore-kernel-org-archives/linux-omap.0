From: Ilkka Koskinen <ikoskine@nokia.com>
Subject: Re: [PATCHv4 0/2] McBSP: OMAP3: Add sidetone feature
Date: Fri, 19 Feb 2010 12:05:40 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1002191026060.2509@tumpelo.nmp.nokia.com>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com> <20100218222229.0f0eb3a9.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39283 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab0BSKEZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 05:04:25 -0500
In-Reply-To: <20100218222229.0f0eb3a9.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "tony@atomide.com" <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>



On Thu, 18 Feb 2010, ext Jarkko Nikula wrote:
> On Thu, 18 Feb 2010 20:42:27 +0200
> Ilkka Koskinen <ilkka.koskinen@nokia.com> wrote:
>
>> The first patch implements McBSP sidetone feature on OMAP3 while the second
>> one provides ALSA interface for using it.
>>
>> The patch set is based on the patch Eduardo Valentin sent to alsa-devel
>> mailing list in October 2009. Channel gain control and enabling the sidetone
>> have been moved to ALSA interface as suggested in comments.
>>
>> These patches apply on top of Janusz Krzysztofik's McBSP register cache
>> patches in linux-omap-2.6.git
>>
>> Since the version 3, the buggy channel gain control has been fixed. ASoC part
>> have been simplified resulting in removing a couple unnecessary functions.
>> Added a comment to ASoC part explaining McBSP port number vs. index values
>> used in OMAP McBSP implementation.
>>
> I still have two concern:
>
> 1. port number vs. index difference inside driver code is not enough
>
> It's just confusing if a machine driver and internal API (mcbsp.c) has
> to use different indexing. See:
>
> omap_mcbsp_st_add_controls(codec, 2);
> ...
> *(unsigned int *)omap3beagle_dai.cpu_dai->private_data = 1; /* McBSP2 */
>
> and mcbsp->id use in mcbsp.c.

Ah, that's what you meant by it. Sure, I'll change it.

> 2. I cannot change the sidetone level with alsamixer
>
I think with the previous patch set, it was impossible to set the other 
channel's gain as Peter pointed out. But at least now that I try, i can 
change it with alsamixer.

> Is this bug with the alsamixer? With amixer I'm able to set positive
> values but not negative
>
> amixer set -D hw:0 'McBSP2 Sidetone Channel 0' 32767

If you try to give negative values, you need to put '--' before the value.

Such as:

# amixer -Dhw:0 -- sset 'McBSP3 Sidetone Channel 0' -10000
Simple mixer control 'McBSP3 Sidetone Channel 0',0
   Capabilities: volume volume-joined
   Playback channels: Mono
   Capture channels: Mono
   Limits: -32768 - 32767
   Mono: -10000 [35%]


> What I'm looking here, is that I can execute a test below with unit
> impulse response tap filter, hear the sound and note that the volume is
> changing as I'm changing the sidetone volume :-)
>
> arecord -f dat >/dev/null |aplay -f dat /dev/zero

As Peter said in the other mail, you need to have the taps also.

Cheers, Ilkka
