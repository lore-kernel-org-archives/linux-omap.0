From: Fernando Governatore <fergc@uol.com.br>
Subject: Re: McBSP in Multi Channel mode
Date: Wed, 22 Jul 2009 17:50:16 -0300
Message-ID: <29e1ddd50907221350x49bd3c1dh20ea7d07ca71e44b@mail.gmail.com>
References: <29e1ddd50905071118i28bd16b8ub715cd2b5dafaca8@mail.gmail.com>
	<200905081038.01470.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f197.google.com ([209.85.210.197]:63219 "EHLO
	mail-yx0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbZGVUuh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 16:50:37 -0400
Received: by yxe35 with SMTP id 35so772483yxe.33
        for <linux-omap@vger.kernel.org>; Wed, 22 Jul 2009 13:50:37 -0700 (PDT)
In-Reply-To: <200905081038.01470.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

Thanks, it worked perfectly. And sorry for the delay.

--
=46ernando
On Fri, May 8, 2009 at 04:38, Peter Ujfalusi<peter.ujfalusi@nokia.com> =
wrote:
> Hello,
>
>
> On Thursday 07 May 2009 21:18:34 ext Fernando Governatore wrote:
>> Hello,
>>
>> I'm new to kernel development and so I'm a bit confused on how to do
>> things here. I need to use the McBSP with Multi-Channel enabled and
>> using DMA to transfer the data.
>>
>> The data will be PCM sound and I will have 4 cards attached to this
>> McBSP. I'm using OMAP35xx.
>>
>> From what I've seen, I have to change the files:
>> =C2=A0- arch/arm/plat-omap/mcbsp.c
>> =C2=A0- arch/arm/mach-omap2/mcbsp.c
>> to support multi channel. Is that it? or I would need more changes?
>>
>> Is there something that I would need to change in DMA implementation=
?
>> Do you know where I can get an example or documentation?
>
> Take a look at the sound-2.6 tree's topic/asoc branch:
> http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Ds=
hortlog;h=3Dtopic/asoc
>
> The omap3beagle has support for 4 channel audio playback (combination=
 of
> McBSP+TWL4030 codec).
> Files that could be interesting for you:
> sound/soc/omap/omap3beagle.c
> sound/soc/omap/omap-mcbsp.c
> sound/soc/codecs/twl4030.c
>
>>
>> Thanks,
>> Fernando
>
> --
> P=C3=A9ter
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
