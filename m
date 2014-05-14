From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [alsa-devel] [PATCH 00/19] Rework OMAP4+ HDMI audio support
Date: Wed, 14 May 2014 18:25:47 +0200
Message-ID: <CAGhQ9VzkGDPiQF7TiqiMgZY_oc9dyrW66yGsZR6ei2ejX-EXcw@mail.gmail.com>
References: <cover.1399884780.git.jsarha@ti.com>
	<CAGhQ9VzjndCBp+ZHS3XPPvS4ors6u9BfHf4NY_HNYN5ynyQOYQ@mail.gmail.com>
	<53733F2E.4030803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:38366 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbaENQZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 12:25:48 -0400
In-Reply-To: <53733F2E.4030803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, broonie@kernel.org, peter.ujfalusi@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Benoit Cousson <bcousson@baylibre.com>

On 14 May 2014 12:02, Jyri Sarha <jsarha@ti.com> wrote:
> On 05/13/2014 12:13 AM, Joachim Eastwood wrote:
>>
>> On 12 May 2014 11:12, Jyri Sarha <jsarha@ti.com> wrote:
>
> ...
>
>>
>> hey, this worked straight away :)
>>
>> But there seems to be something wrong with the channel mapping.
>>
>> For stereo (speaker-test -c 2) the mapping is correct.
>>
>> But for -c 4 and -c 8 it gets weird:
>> speaker-test -c 4 -s X # where X is 1-4
>> 1: Front Left is Rear Left
>> 2: Front Right is Rear Right
>> 3: Rear Right is Front Right
>> 4: Rear Left is Front Left
>>
>> speaker-test -c 8 -s X # where X is 1-8
>> 1: Front Left is Rear Left
>> 2: Center is Rear Left
>> 3: Front Right is Rear Right
>> 4: Side Right is Front Right
>> 5: Rear Right is silent
>> 6: Rear Left is Center
>> 7: Side Left is Front Left
>> 8: LFE - Rear Right
>>
>> I think you need to check what channel order ALSA expects. I believe
>> speaker-test does the right thing on my HTPC normally connected to my
>> receiver.
>>
>
> I checked the implementation and there was indeed something weird there, but
> the implementation can not explain the FL and FR channels jumping around. FL
> and FL should always be the first two channels in all configurations and the
> implementation does not touch them.
>
> The implementation uses 8ch HDMI setup for anything above 2ch with "Audio
> InfoFrame Data Byte 4" set to 0x13. According to CEA-861 specs this means
> following channel order: FL, FR, LFE, FC, RL, RR, RLC, RRC
>
> This is a closest match to ALSA 8ch mapping (according to
> sound/core/pcm_lib.c) which is: FL, FR, FC, LFE, RL, RR, SL, SR

hm, okey. I haven't look at the code but it do seem strange. But with
speaker-test -c 4 the front and back are surely swapped here.

I'll do some more testing and also check with my HTPC. btw, I only
have a 5.1 setup over here so I can't test all the discrete channels.

> Current implementation has FLE and FC channels correctly swapped, but it
> shifts them to last two channels and RL, RR, SL, SR are shifted down to fill
> the place. This is all wrong and I'll try to come up with a fix for that.
> Unfortunately I can not test anything beyond 2 ch myself so I would need
> someone to volunteer to test my patch.

I have the dev kit setup up over here so I can test your patches.

regards
Joachim Eastwood
