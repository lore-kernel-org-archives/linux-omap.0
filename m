From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [HELP] Audio on BeagleBoard xM can't work
Date: Tue, 15 Mar 2011 17:57:27 +0800
Message-ID: <AANLkTimSHRUJthtZ5co7oTjMZ3pBjGLoT40-HpsZUvUK@mail.gmail.com>
References: <AANLkTikMCttrVTS==b2j9VyvSSz+WzoBg8dZ-nb4QUaN@mail.gmail.com>
	<20110315115315.bcd2451b.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34608 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1COJ52 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 05:57:28 -0400
Received: by qyk7 with SMTP id 7so2223711qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 02:57:27 -0700 (PDT)
In-Reply-To: <20110315115315.bcd2451b.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, lars@metafoo.de, paul@pwsan.com, peter.ujfalusi@nokia.com

On Tue, Mar 15, 2011 at 5:53 PM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> On Tue, 15 Mar 2011 11:12:17 +0800
> Bob Liu <lliubbo@gmail.com> wrote:
>
>> It seems that the code in sound/soc/omap/omap-mcbsp.c uses the function
>> "cpu-is-omap343x()" which fails and returns ENODEV.
>>
>> But I have enabled "OMAP3430 support" in "System Type" / "TI OMAP2/3/4
>> Specific Features",
>> why it still return ENODEV? (Attached my kernel config).
>>
>> And after I changed that check to "cpu-is-omap34xx()", there was no
>> error message but neither any audio output,
>> I can't hear any sound.
>> ----------------------------
>
> Is the DMA running after you change the cpu_is_omap34xx and try to play
> e.g. "aplay /dev/urandom"? If audio is running you should see DMA
> interrupt count increasing with "grep DMA /proc/interrupts".
>

Yes, DMA interrupt count increased after aplay /dev/urandom or some
other audio file.
Thanks

> If that is working then issue could be in codec side. I don't have a
> beagle at the moment to verify but IRCC something like ~10 TWL4030 ALSA
> controls must be adjusted in order to route audio from DAC to outputs
> at proper volume.
>

-- 
Regards,
--Bob
