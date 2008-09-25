From: "Arun KS" <getarunks@gmail.com>
Subject: Re: NULL pointer dereference when using ALSA SOC
Date: Thu, 25 Sep 2008 19:08:13 +0530
Message-ID: <dfeb90390809250638r22474563q1262209d15974cb9@mail.gmail.com>
References: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com>
	 <20080923115053.e404f43e.jarkko.nikula@nokia.com>
	 <20080925140531.64fd14c9.jarkko.nikula@nokia.com>
	 <48DB91A6.5080900@balister.org>
	 <01BA5FDD-AC4E-4450-B576-8A7DA867E314@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:3838 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbYIYNiO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 09:38:14 -0400
Received: by rv-out-0506.google.com with SMTP id k40so453392rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 06:38:13 -0700 (PDT)
In-Reply-To: <01BA5FDD-AC4E-4450-B576-8A7DA867E314@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Steve Sakoman <sakoman@gmail.com>, Koen Kooi <k.kooi@student.utwente.nl>

On Thu, Sep 25, 2008 at 7:02 PM, Koen Kooi <k.kooi@student.utwente.nl> wrote:
>
> Op 25 sep 2008, om 15:27 heeft Philip Balister het volgende geschreven:
>
>> Jarkko Nikula wrote:
>>>
>>> On Tue, 23 Sep 2008 11:50:53 +0300
>>> "ext Jarkko Nikula" <jarkko.nikula@nokia.com> wrote:
>>>>
>>>> On Tue, 23 Sep 2008 11:56:00 +0530
>>>> "ext Arun KS" <getarunks@gmail.com> wrote:
>>>>
>>>>> Hi all,
>>>>>
>>>>> I am writing an ASOC driver for tlvaic23 on osk5912 platform.
>>>>> When do an aplay, I m getting a  NULL pointer dereference. I added
>>>>> some debug prints in the soc/core/pcm_native.c, also in codec and
>>>>> platform drivers. The null pointer is comming in IOCTL
>>>>> SNDRV_PCM_IOCTL_SYNC_PTR. Log is pasted below.
>>>>>
>>>> It's good that you can reproduce this on OSK as well.
>>>>
>>>> I think some configuration difference is revealing this bug out. For
>>>> instance I can trigger this on Beagle with overo_defconfig + manually
>>>> adding support for Beagle (CONFIG_MACH_OMAP3_BEAGLE=y) and ASoC
>>>> Beagle (CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE=y).
>>>>
>>>> But I cannot reproduce this with Beagle defconfig + manually adding
>>>> support for Overo (CONFIG_MACH_OVERO=y) and ASoC Beagle
>>>> (CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE=y).
>>>>
>>> I narrowed this into CONFIG_SLUB. When it's set, I can reproduce the
>>> bug both with N810 and Beagle but not when using CONFIG_SLAB.
>>> Can you try will the problem disappear on your OSK and Overo if you
>>> select slab allocator instead? You find selection under "General
>>> setup" menu.
>>
>> I've also verified this works on a Beagle with Angstrom.
>>
>> Thanks for tracking this down!
>
>
> For people wanting to test it:
>
> http://www.angstrom-distribution.org/demo/beagleboard/uImage
>
> regards,
>
> Koen
>

Jarkko  that was a great. The problem disappeared now on osk also.

Thanks,
Arun
