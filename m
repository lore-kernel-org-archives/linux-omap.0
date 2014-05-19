From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [alsa-devel] [PATCH 00/19] Rework OMAP4+ HDMI audio support
Date: Mon, 19 May 2014 17:44:09 +0300
Message-ID: <537A18B9.3040504@ti.com>
References: <cover.1399884780.git.jsarha@ti.com>	<CAGhQ9VzjndCBp+ZHS3XPPvS4ors6u9BfHf4NY_HNYN5ynyQOYQ@mail.gmail.com>	<53733F2E.4030803@ti.com>	<CAGhQ9VzkGDPiQF7TiqiMgZY_oc9dyrW66yGsZR6ei2ejX-EXcw@mail.gmail.com>	<CAGhQ9VwY_qeOLsa_oAUuL3XT2tmn-mLg0WBtOdL8JL6u+0PQcw@mail.gmail.com> <CAGhQ9VyxKWZ9KSWoYkhf8KeUJnMKJO=b0kG=upC7uojNLHVObw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42473 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932236AbaESOoY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 May 2014 10:44:24 -0400
In-Reply-To: <CAGhQ9VyxKWZ9KSWoYkhf8KeUJnMKJO=b0kG=upC7uojNLHVObw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, broonie@kernel.org, peter.ujfalusi@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Benoit Cousson <bcousson@baylibre.com>

On 05/17/2014 12:16 PM, Joachim Eastwood wrote:
> On 17 May 2014 10:51, Joachim  Eastwood <manabian@gmail.com> wrote:
>> On 14 May 2014 18:25, Joachim  Eastwood <manabian@gmail.com> wrote:
...
>>
>> I did some more testing over here.
>>
>> My HTPC (nVidia ION2 based) works good with speaker-test and all
>> channels are where they are suppose to be.
>>
>> On the OMAP4 board I tried doing: "while true; do speaker-test -c 4 -s
>> 1; done" and this had an interesting effect.
>> Most of the time FL (Front Left) is swapped with BL (Back Left) but
>> about every 10th time the sound comes out in the FL speaker... So
>> there something weird going on here. Same story for the right channel.
>>
>> I also noticed that HDMI doesn't always work on boot up, it sometimes fail with:
>> [ 193.985565] omapdss_hdmi 58006000.encoder: audio not supported
>> [ 193.985565] omapdss_hdmi 58006000.encoder: ASoC: can't open
>> interface 58006000.encoder: -19
>>
>> But after replugging the HDMI connector a couple of times it starts to work.
>>

That is weird I can not reproduce this problem. I rebooted my panda 
several times and the audio device was always there. Could it be that 
the connector is in DVI mode or something?

>> I'll see if I can try with an old TI OMAP4 kernel (3.4) and see how that works.
>
> On the 3.4 Variscite kernel:
> Linux version 3.4.0-1489-omap4 (uri@pluto) (gcc version 4.6.3
> (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #27 SMP PREEMPT Sun Apr 7 13:27:10
> IDT 2013
> git://dev.omapzoom.org/pub/scm/integration/kernel-ubuntu.git +
> Variscite vendor patches
>
> Both speaker-test -c 4 and -c 8 works. All channels are where they are
> suppose to be.
>
> Hot plugging is broken, though. So the HDMI must be connected on boot,
> but that might be the Variscite board setup.
>

I checked the ubuntu branch implementation and found that it is quite 
different in many places, but the one place that affects the i2s channel 
mapping to HDMI looks exactly the same. So there must be a bug some 
where else and there is no point trying to fix it by changing the 
mapping (it would be impossible anyway). I'll compare the 
implementations further when I have time.

Thanks for your testing. Now I at least now where the bug is not.

Best regards,
Jyri
