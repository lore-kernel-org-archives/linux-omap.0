From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH RFC v3 0/8] Beaglebone-Black HDMI audio
Date: Mon, 27 Jan 2014 20:47:23 +0100
Message-ID: <52E6B7CB.7010107@metafoo.de>
References: <y> <cover.1390836773.git.jsarha@ti.com> <52E6806A.2090109@metafoo.de> <52E686B2.9060806@ti.com> <52E68A00.5030207@metafoo.de> <52E6B613.9050400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:61575 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753841AbaA0To6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jan 2014 14:44:58 -0500
In-Reply-To: <52E6B613.9050400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: detheridge@ti.com, alsa-devel@alsa-project.org, Jean-Francois Moine <moinejf@free.fr>, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/27/2014 08:40 PM, Jyri Sarha wrote:
> On 01/27/2014 06:32 PM, Lars-Peter Clausen wrote:
>> On 01/27/2014 05:17 PM, Jyri Sarha wrote:
>>> On 01/27/2014 05:51 PM, Lars-Peter Clausen wrote:
>>>> Hi,
>>>>
>>>> I think you should try to get this in sync with the work Jean-Francois is
>>>> currently doing[1]. Having the HDMI transmitter register a CODEC device is
>>>> definitely the right approach, compared to the rather 'interesting'
>>>> constraints stuff you do in patch 4.
>>>>
>>>
>>> Oh, Jean-Francois's patches are now out. I'll take those into use, but I am
>>> afraid it still does not save me from the constraint stuff.
>>>
>>> The most complex piece of code comes from limited sample-rate availability,
>>> which is coming Beaglebone-Black desing (available i2s master clock), not
>>> from the HDMI encoder itself. It does not help with the stereo only
>>> limitation either, because it comes from the one wire only audio data
>>> connection on BBB.
>>>
>>> Support for S16_LE could maybe be added if the tda998x specific codec would
>>> fiddle with CTS_N predivider-setting (K select) according to the used sample
>>> width. But it appears Cobox plays all the sample formats fine without this
>>> change, so the question is if playing around with CTS_N predivider would
>>> break already working support there (something to be tested).
>>
>> The ASoC core will set the constraints for the audio format/rate to the
>> intersection of what is supported by the CODEC and the CPU DAI. So if the
>> limitation comes from the CPU DAI the constraints should be applied there
>> and not in the machine driver. Similar if the tda998x only supports 32 bit
>> samples it should advertise this and the compound card will only support 32
>> bit samples.
>>
>
> Yes. I know. But these limitations come from the run time setup of the audio
> serial bus and those details are not available to the cpu dai at the register
> time.
>
> If more of the McASP configuration data would be moved to DT, instead of giving
> it in set_sysclk, set_fmt, etc. calls it would be possible for the driver code
> produce more accurate constraints at register time. However that would change
> McASP driver a lot and would possibly break some of the legacy support.

There is nothing wrong with setting the constraints based on the parameters 
passed to set_sysclk or set_fmt, etc. In fact this is something that is often 
done by drivers.

- Lars

