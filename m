From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [HELP] Audio on BeagleBoard xM can't work
Date: Wed, 16 Mar 2011 11:01:43 +0530
Message-ID: <AANLkTimNGaNME3QGnwZ1fGSQFktPjm2xVLhrnExRSPuP@mail.gmail.com>
References: <AANLkTikMCttrVTS==b2j9VyvSSz+WzoBg8dZ-nb4QUaN@mail.gmail.com>
	<20110315115315.bcd2451b.jhnikula@gmail.com>
	<AANLkTimSHRUJthtZ5co7oTjMZ3pBjGLoT40-HpsZUvUK@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C3075F8@dbde02.ent.ti.com>
	<AANLkTi=rZhmku6j2Cq9E3B8jQbT6R9NHishibLK5atNB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:33014 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751165Ab1CPFbo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 01:31:44 -0400
Received: by mail-yx0-f173.google.com with SMTP id 8so634753yxk.4
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 22:31:43 -0700 (PDT)
In-Reply-To: <AANLkTi=rZhmku6j2Cq9E3B8jQbT6R9NHishibLK5atNB@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "lars@metafoo.de" <lars@metafoo.de>, "paul@pwsan.com" <paul@pwsan.com>, "peter.ujfalusi@nokia.com" <peter.ujfalusi@nokia.com>, "Koyamangalath, Abhilash" <abhilash.kv@ti.com>

On Wed, Mar 16, 2011 at 9:09 AM, Bob Liu <lliubbo@gmail.com> wrote:
> On Wed, Mar 16, 2011 at 12:21 AM, Premi, Sanjeev <premi@ti.com> wrote=
:
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org
>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Bob Liu
>>> Sent: Tuesday, March 15, 2011 3:27 PM
>>> To: Jarkko Nikula
>>> Cc: linux-omap@vger.kernel.org;
>>> broonie@opensource.wolfsonmicro.com; lrg@slimlogic.co.uk;
>>> lars@metafoo.de; paul@pwsan.com; peter.ujfalusi@nokia.com
>>> Subject: Re: [HELP] Audio on BeagleBoard xM can't work
>>>
>>> On Tue, Mar 15, 2011 at 5:53 PM, Jarkko Nikula
>>> <jhnikula@gmail.com> wrote:
>>> > On Tue, 15 Mar 2011 11:12:17 +0800
>>> > Bob Liu <lliubbo@gmail.com> wrote:
>>> >
>>> >> It seems that the code in sound/soc/omap/omap-mcbsp.c uses
>>> the function
>>> >> "cpu-is-omap343x()" which fails and returns ENODEV.
>>> >>
>>> >> But I have enabled "OMAP3430 support" in "System Type" /
>>> "TI OMAP2/3/4
>>> >> Specific Features",
>>> >> why it still return ENODEV? (Attached my kernel config).
>>> >>
>>> >> And after I changed that check to "cpu-is-omap34xx()", there was=
 no
>>> >> error message but neither any audio output,
>>> >> I can't hear any sound.
>>> >> ----------------------------
>>> >
>>> > Is the DMA running after you change the cpu_is_omap34xx and
>>> try to play
>>> > e.g. "aplay /dev/urandom"? If audio is running you should see DMA
>>> > interrupt count increasing with "grep DMA /proc/interrupts".
>>> >
>>>
>>> Yes, DMA interrupt count increased after aplay /dev/urandom or some
>>> other audio file.
>>> Thanks
>>>
>>> > If that is working then issue could be in codec side. I don't hav=
e a
>>> > beagle at the moment to verify but IRCC something like ~10
>>> TWL4030 ALSA
>>> > controls must be adjusted in order to route audio from DAC
>>> to outputs
>>> > at proper volume.
>>
>> I don't have HW with me right now, can you try the following?
>> (Got the steps over phone from Abhilash)
>>
>> 1) run command "alsamixer"
>> 2) Un-mute by pressing the key "m"
>> 3) Play the audio using aplay
>>
>> If it doesn't work, you may want to check the options used by
>> alsamixer. I will be able to try it myself tomorrow morning.
>>
>
> Thanks for your reply.
> It seems pressing the key "m" has no effect during alsamixer and ther=
e
> are so many options I don't know how to adjust it.

   I've never tried playing audio in beagleboardxm but I've tried
using 3430 SDP.
   You can try with the following settings.

amixer cset name=3D"HandsfreeR Switch" 1
amixer cset name=3D"HandsfreeR Mux" 2
amixer cset name=3D"HandsfreeL Switch" 1
amixer cset name=3D"HandsfreeL Mux" 2
amixer cset name=3D"DAC1 Analog Playback Switch" 1
amixer cset name=3D"DAC1 Analog Playback Volume" 12
amixer cset name=3D"DAC1 Digital Coarse Playback Volume" 2
amixer cset name=3D"DAC1 Digital Fine Playback Volume" 50
amixer cset name=3D"DAC2 Analog Playback Switch" 1
amixer cset name=3D"DAC2 Analog Playback Volume" 12
amixer cset name=3D"DAC2 Digital Coarse Playback Volume" 2
amixer cset name=3D"DAC2 Digital Fine Playback Volume" 50

aplay -D plughw:0,0 -d 5 /mnt/mmc/beethoven.wav

-Kishon

>
> --
> Regards,
> --Bob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
