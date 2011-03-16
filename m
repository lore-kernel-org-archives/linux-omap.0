From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [HELP] Audio on BeagleBoard xM can't work
Date: Wed, 16 Mar 2011 11:39:00 +0800
Message-ID: <AANLkTi=rZhmku6j2Cq9E3B8jQbT6R9NHishibLK5atNB@mail.gmail.com>
References: <AANLkTikMCttrVTS==b2j9VyvSSz+WzoBg8dZ-nb4QUaN@mail.gmail.com>
	<20110315115315.bcd2451b.jhnikula@gmail.com>
	<AANLkTimSHRUJthtZ5co7oTjMZ3pBjGLoT40-HpsZUvUK@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C3075F8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52588 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab1CPDjB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 23:39:01 -0400
Received: by qyk7 with SMTP id 7so3065104qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 20:39:00 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C3075F8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "lars@metafoo.de" <lars@metafoo.de>, "paul@pwsan.com" <paul@pwsan.com>, "peter.ujfalusi@nokia.com" <peter.ujfalusi@nokia.com>, "Koyamangalath, Abhilash" <abhilash.kv@ti.com>

On Wed, Mar 16, 2011 at 12:21 AM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Bob Liu
>> Sent: Tuesday, March 15, 2011 3:27 PM
>> To: Jarkko Nikula
>> Cc: linux-omap@vger.kernel.org;
>> broonie@opensource.wolfsonmicro.com; lrg@slimlogic.co.uk;
>> lars@metafoo.de; paul@pwsan.com; peter.ujfalusi@nokia.com
>> Subject: Re: [HELP] Audio on BeagleBoard xM can't work
>>
>> On Tue, Mar 15, 2011 at 5:53 PM, Jarkko Nikula
>> <jhnikula@gmail.com> wrote:
>> > On Tue, 15 Mar 2011 11:12:17 +0800
>> > Bob Liu <lliubbo@gmail.com> wrote:
>> >
>> >> It seems that the code in sound/soc/omap/omap-mcbsp.c uses
>> the function
>> >> "cpu-is-omap343x()" which fails and returns ENODEV.
>> >>
>> >> But I have enabled "OMAP3430 support" in "System Type" /
>> "TI OMAP2/3/4
>> >> Specific Features",
>> >> why it still return ENODEV? (Attached my kernel config).
>> >>
>> >> And after I changed that check to "cpu-is-omap34xx()", there was no
>> >> error message but neither any audio output,
>> >> I can't hear any sound.
>> >> ----------------------------
>> >
>> > Is the DMA running after you change the cpu_is_omap34xx and
>> try to play
>> > e.g. "aplay /dev/urandom"? If audio is running you should see DMA
>> > interrupt count increasing with "grep DMA /proc/interrupts".
>> >
>>
>> Yes, DMA interrupt count increased after aplay /dev/urandom or some
>> other audio file.
>> Thanks
>>
>> > If that is working then issue could be in codec side. I don't have a
>> > beagle at the moment to verify but IRCC something like ~10
>> TWL4030 ALSA
>> > controls must be adjusted in order to route audio from DAC
>> to outputs
>> > at proper volume.
>
> I don't have HW with me right now, can you try the following?
> (Got the steps over phone from Abhilash)
>
> 1) run command "alsamixer"
> 2) Un-mute by pressing the key "m"
> 3) Play the audio using aplay
>
> If it doesn't work, you may want to check the options used by
> alsamixer. I will be able to try it myself tomorrow morning.
>

Thanks for your reply.
It seems pressing the key "m" has no effect during alsamixer and there
are so many options I don't know how to adjust it.

-- 
Regards,
--Bob
