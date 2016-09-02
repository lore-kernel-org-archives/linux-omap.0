From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Fri, 2 Sep 2016 22:38:44 +0300
Message-ID: <c8f293f6-db2e-e518-7566-2cd92eb06ec0@ti.com>
References: <20160829182746.53vrgbxadqodzzug@atomide.com>
 <925ded57-1e91-3db6-9e82-3a3ff5775412@ti.com>
 <20160831141340.h24szdqjnicmt2ew@atomide.com>
 <20160831165959.3sldcjxaci3kdx6z@atomide.com>
 <eef88aa4-b829-1889-f083-eb0359c0dac6@ti.com>
 <20160831194107.wijnbmdns2jjvzkv@atomide.com>
 <5af44090-6902-2ade-be78-378843757a0a@ti.com>
 <20160901145006.xr3ux63cg6f5bh7p@atomide.com>
 <b3a254b2-948f-f04d-3289-fb8fb9f9ab23@ti.com>
 <20160902145604.nlixopwza76kfgbz@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160902145604.nlixopwza76kfgbz@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Machel <pavel@ucw.cz>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/02/2016 05:56 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160902 00:30]:
>> On 09/01/16 17:50, Tony Lindgren wrote:
>>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160831 23:58]:
>>>> What is the audio format you are using? sampling rate and how many cha=
nnels?
>>>> cat /proc/asound/card0/pcm0p/sub0/hw_params
>>>
>>> Just 44.1 stereo mp3 or wav files.
>>>
>>>> What happens if you set the FIFO to 256? Do you still need the 30ms or=
 it can
>>>> be higher, like 60ms?
>>>
>>> No this is not related to the FIFO size. We just need to block off idle=
 mode
>>> for cpuidle as the McBSP hardware is not blocking it.
>>
>> So this happens with any threshold value? Even in element mode, where we=
 have
>> the threshold set to 2?
> =

> Probably. How can I test the above?

set 'element' mode to the used McBSP's dma_op_mode file in sysfs.
When in 'threshold' mode, you can change the FIFO threshold.

>>>> When the FIFO is set to 128, it means that after the initial FIFO fill=
 we will
>>>> have DMA request coming from McBSP to sDMA with a rate of:
>>>>
>>>> (1000/sampling_rate) * (FIFO-threshold / channels) =3D DMA_req_distanc=
e_in_ms
>>>>
>>>> So in case of 44.1KHz, stereo with 128 FIFO threshold DMA request will=
 come at
>>>> every 1.45ms. If I'm not mistaken. The whole FIFO (1280) holds 14.51ms=
 of
>>>> audio in this case.
>>>>
>>>> I don't see this correlate with the 30ms at all.
>>>
>>> It seems we easily have a situation where DMA is done buffering to McBS=
P,
>>> and PMIC is playing audio, and we hit idle. At that point there are no =
immediate
>>> timers pending and cpuidle determines we can try to hit a deeper idle m=
ode. As
>>> there are no hardware blockers with DMA off and McBSP not blocking, the=
 hardware
>>> hits off mode. This cuts power to McBSP.
>>>
>>> Ideally we'd configure McBSP activity to block deeper idle states in the
>>> hardware but I don't think we have such a configuration available.
>>
>> I wonder why we have not seen this before? I can not recall anything lik=
e this
>> with n900 (Jarkko might know that better) neither with n9/n950. On the n=
9/n950
>> I have even put the OMAP3 to OFF during audio playback with the DAC33 and
>> still it worked just fine. On the twl4030 audio side we used 1024 or som=
ething
>> as threshold during audio playback and we do not had QoS placed at all.
>> The C state numbers must be different what we had and what we have in ma=
inline
>> now days, but still this is something I don't expect to happen.
>>
>> Why McBSP is not working correctly in smart-idle mode in upstream, when =
it
>> appeared to be working fine on n900/n9/n950?
> =

> I think the difference is that the audio chip on n900/n9/n950 is a buffer=
ing
> one while the pmic is not.

n900 uses aic3x for audio with McBSP2. On n9/n950 we have dac33 with McBSP2
and twl5030 on McBSP3. The DAC33 can be set in bypass mode when it is not
buffering.

> Plus I think we're also missing McBSP state save
> and restore in the mainline kernel for off mode.

In Nokia kernel we did not had suspend/resume either in mcbsp driver.

> And we're missing the piece
> of code that in the Nokia kernel blocked off idle when McBSP was active.
> And we're missing some kind of wakeirq that tells to wake up McBSP, resto=
re
> it's state and refill the fifo.

Hrm, it is possible that the C state numbers in Nokia kernel were adjusted,
but I don't see anything in the McBSP or audio codes to do this.

> The wakeirq could be anything like audio codec GPIO in bank one or PMIC
> GPIO. Or it could be just a Linux timer that wakes up the system to refill
> the fifo.

Yeah, for the DAC3 mode7lp mode we had the gpio irq to wake the system up a=
nd
there I have set the QoS to be able to wake up in time.

>>> So we just want to tell pm_qos that McBSP can't take any idle states sh=
orter
>>> than 30 ms to prevent cutting off power fro the whole SoC.
>>
>> based on the numbers in the arch/arm/mach-omap2/cpuidle34xx.c we are try=
ing to
>> block C7 since the exit_latency for it is (10000 + 30000)us, right? Or i=
s it
>> the traget_residency we need to look at when we set PM_QOS_CPU_DMA_LATEN=
CY?
> =

> Yeah anything blocking C7 is enough because McBSP can't survive off mode.
> =

>> Still in case of 44.1KHz/Stereo, FIFO threshold at 128 we will have DMA
>> requests coming at 1.45ms with the whole FIFO holding 14.51ms of data. In
>> order to avoid draining the FIFO, the latency for omap3.mcbsp2 when the =
audio
>> is 44.1KHz, stereo must be set to 14.51ms maximum, but I would set it to:
>> (1000/sampling_rate) * ((FIFOsize - threshold) / channels) in ms.
> =

> Yes if it was fifo related I'd agree :) But it's not, see below.
> =

> I think the reason why we don't need to set any pm_qos latency limit with
> retention idle is that the McBSP hardware will automatigally wake up the
> system to a fifo threshold interrupt or a timer which will trigger another
> dma transaction. As long as the wakeup latency from retention idle is less
> than the time needed to refill the fifo, everything works automagically in
> the hardware. So the calculation above is not needed at all and unnecessa=
rily
> blocks core retention during idle.
> =

>> Certainly not 30ms. What happens if someone changes the C7 state number =
and it
>> is going to be less than 30ms? We will hit C7 and have the same issue? I
>> suppose yes.
> =

> That value is a hardware limitation of the SoC for the only known working
> case of off idle in the mainline kernel. But yes it would have to be SoC
> specific if we ever get let's say omap4 off idle working in the mainline
> kernel. In that case I'd make SoC specific using someting like
> compatible =3D "ti,omap4-mcbsp".
> =

>> This is my main problem with the 30ms. It is just an arbitrary number wh=
ich
>> matches some number in cpuidle34xx.c, but it has nothing to do with the =
real
>> requirement of McBSP, which is that we should not hit a state where the =
wakeup
>> is going to take more time than what we can compensate from the McBSP FI=
FO.
> =

> Yeah I agree this number is somewhat artificial as it is a value that's a
> limitation of the SoC and not the McBSP. I don't know a better way to
> block C7 in a Linux generic way though when McBSP is active.
> =

>> Furthermore: in case of other McBSPs where they have 128 word FIFO, which
>> holds in your use case 1.45ms of audio, how it will survive the C6 wakeup
>> latency of (3000 + 8500)us? It can tolerate C3 at maximum, C4 takes (150=
0 +
>> 1800)us.
> =

> That's because the hardware or a timer triggers the next dma automagically
> so we don't need to do anything.

McBSP is triggering thee DMA request. In case of non OMAP3.McBSP2 the time
between them is shorter than 1.45ms. as the maximum FIFO size is 128. But in
your case you also have threshold of 128, which means that we have DMA
requests coming in every 1.45ms.
In theory no audio should be working on OMAP3 if we can hit C7 runtime.

>> Sure, we will not going to be able to hit C6 with this based on the numb=
ers we
>> have in cpuidle34xx.c, but I have no view on how those numbers were calc=
ulated...
> =

> Right, but we don't need to block C6 because of the hardware and/or Linux
> timers doing things for us :)

But the correct QoS latency for McBSP is the one which would ensure that the
FIFO will be not drained. This is the whole point of PM_QOS. And that is:
(1000/sampling_rate) * ((FIFOsize - threshold) / channels)
In case of playback

On OMAP3.McBSP2 for example (44.1KHz, stereo):
FIFO threshold 128
 - DMA request will be triggered when 128 slots are free in the FIFO
 - at that point we have still 1152 words in the FIFO.
 - if the C wakeup latency is longer then what it takes to play out the
samples from the FIFO (13.06ms), we will drain the FIFO and got underflow.
 - in this case the QOS should be set as 13.06ms

FIFO threshold 1024
 - DMA request will be triggered when 1024 slots are free in the FIFO
 - at that point we have still 256 words in the FIFO.
 - if the C wakeup latency is longer then what it takes to play out the
samples from the FIFO (2.9ms), we will drain the FIFO and got underflow.
 - in this case the QOS should be 2.9ms

On other McBSPs with 128 word FIFO the required latency is shorter to ensure
we don't drain the FIFO.

IMHO if the driver sets the PM_QOS, it should set it in a way it is needing=
 it
and not to work around system issues.

I don't know the PM code that well, but is there a way to set attribute to a
device to tell how deep C state it can tolerate on the given board or SoC?

-- =

P=E9ter
