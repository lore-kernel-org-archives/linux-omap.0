From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv4 7/7] ASoC: TWL6030: Detect power-up sequence completion
Date: Thu, 25 Feb 2010 08:42:21 +0000
Message-ID: <6119755B-D3CB-4E4C-ADA2-8AE64EBE4711@opensource.wolfsonmicro.com>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B19@dlee06.ent.ti.com> <20100224135909.GR18896@rakim.wolfsonmicro.main> <1889FA7136B567478A67D4B0F85B0CCE65DD230C@dlee06.ent.ti.com> (sfid-20100225_002415_552142_F4402FD1)
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38986 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752107Ab0BYIls (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Feb 2010 03:41:48 -0500
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE65DD230C@dlee06.ent.ti.com> (sfid-20100225_002415_552142_F4402FD1)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

On 25 Feb 2010, at 00:24, "Olaya, Margarita" <magi.olaya@ti.com> wrote:

>
>
>> -----Original Message-----
>> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>> Sent: Wednesday, February 24, 2010 7:59 AM
>> To: Olaya, Margarita
>> Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org; lrg@slimlogic.co.uk
>> Subject: Re: [PATCHv4 7/7] ASoC: TWL6030: Detect power-up sequence  
>> completion
>>
>> On Tue, Feb 23, 2010 at 06:10:54PM -0600, Olaya, Margarita wrote:
>>
>>> +    if (naudint) {
>>> +        /* wait for ready interrupt with 48 ms timeout */
>>> +        time_left = wait_for_completion_timeout(&priv->ready,
>>> +                    msecs_to_jiffies(48));
>>> +    } else {
>>> +        /* retry 3 times only */
>>> +        for (time_left = 3; time_left > 0; time_left--) {
>>> +            mdelay(16);
>>> +            twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &intid,
>>> +                    TWL6030_REG_INTID);
>>> +            if (intid & TWL6030_READYINT)
>>> +                break;
>>> +        }
>>> +    }
>>
>> It strikes me that you could combine these two cases - the
>> wait_for_completion_timeout() will function just as well as a delay.
>> I'd also expect to see an error reported if the device doesn't  
>> report as
>> ready one way or another.
>
> It is split to prevent the case of none valid irq line connected, in  
> such case, wait_for_completion won't work

It will - you can specify a timeout so if the interrupt doesn't happen  
all that happens is that you delay for the specified timeout.

>
