From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: Re: [PATCHv4 7/7] ASoC: TWL6030: Detect power-up
	sequence completion
Date: Fri, 26 Feb 2010 15:04:22 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65E7E3FF@dlee06.ent.ti.com>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B19@dlee06.ent.ti.com>
	<20100224135909.GR18896@rakim.wolfsonmicro.main>
	<1889FA7136B567478A67D4B0F85B0CCE65DD230C@dlee06.ent.ti.com>
	(sfid-20100225_002415_552142_F4402FD1)
	<6119755B-D3CB-4E4C-ADA2-8AE64EBE4711@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <6119755B-D3CB-4E4C-ADA2-8AE64EBE4711@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Thursday, February 25, 2010 2:42 AM  Mark Brown wrote: 

>>> On Tue, Feb 23, 2010 at 06:10:54PM -0600, Olaya, Margarita wrote:
>>> 
>>>> +    if (naudint) {
>>>> +        /* wait for ready interrupt with 48 ms timeout */
>>>> +        time_left = wait_for_completion_timeout(&priv->ready,
>>>> +                    msecs_to_jiffies(48));

Phoenix manages automatic and manual power on sequences. READYINT
indicates the completion of power up sequence, Phoenix audio drives
the NAUDINT line low when an interrupt is internally detected, when
automatic power on sequence is used, the state of READYINIT is verified
through the interrupt handler using wait_for_completion.

>>>> +    } else {
>>>> +        /* retry 3 times only */
>>>> +        for (time_left = 3; time_left > 0; time_left--) { +    
>>>> mdelay(16); +           
>>>> twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &intid, +           
>>>> TWL6030_REG_INTID); +            if (intid & TWL6030_READYINT)
>>>> +                break;
>>>> +        }

When manual power on sequence is used the driver verifies the status of 
READYINIT by polling.

In both cases if READYINIT is not set before the timeout runs out it means
the codec is not powering on and the driver reports an error.

- Margarita

>>>> +    }
>>> 



>>> It strikes me that you could combine these two cases - the
>>> wait_for_completion_timeout() will function just as well as a
>>> delay. I'd also expect to see an error reported if the device
>>> doesn't report as ready one way or another.
>> 
>> It is split to prevent the case of none valid irq line connected,
>> in such case, wait_for_completion won't work
> 
> It will - you can specify a timeout so if the interrupt doesn't
> happen all that happens is that you delay for the specified timeout.
