From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 04/12] OMAPDSS: hdmi_audio: Integrated ASoC DAI component
 driver implementation
Date: Fri, 27 Jun 2014 18:33:13 +0300
Message-ID: <53AD8EB9.1070207@ti.com>
References: <cover.1403807781.git.jsarha@ti.com> <69f5b1481bd8b8a005b5d9142626f3529a0d71c7.1403807781.git.jsarha@ti.com> <53AD5F65.2010107@ti.com> <53AD62FB.10402@ti.com> <53AD6C5E.10805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53938 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187AbaF0Pdh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 11:33:37 -0400
In-Reply-To: <53AD6C5E.10805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi

On 06/27/2014 04:06 PM, Tomi Valkeinen wrote:
> On 27/06/14 15:26, Jyri Sarha wrote:
>> On 06/27/2014 03:11 PM, Tomi Valkeinen wrote:
>>> On 26/06/14 22:20, Jyri Sarha wrote:
>> ...
>>>> +static struct asoc_simple_card_info card_info = {
>>>> +    .name = "HDMI",
>>>> +    .card = "OMAPHDMI",
>>>> +    .codec_dai.name = "hdmi-hifi",
>>>> +};
>>>
>>> The above is not const. That, and the contents of the struct make me
>>> wonder, what happens if we have two HDMI instances?
>>>
>>> I know the core driver doesn't work with multiple instances yet, but as
>>> I mentioned, it has to be done sooner or later. And on the core driver
>>> side it should be quite straightforward.
>>>
>>> I'd rather not introduce new restrictions for that goal.
>>>
>>
>> Ok, I'll alloc that with devm_kzalloc().
>
> Do the strings in the struct need to be unique? If so, you probably need
> to append something to them based on the hdmi device instance.
>

I dont think they need to be unique, but it anyway makes sense to embed 
the HDMI device name into the audio device name, so I'll add it.

BTW, platform_device_register_data() memdups the platform data, so a 
stack variable should be Ok for asoc_simple_card_info.

Cheers,
Jyri
