From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Mon, 5 Sep 2016 10:53:28 +0300
Message-ID: <7d1c9a2f-60ae-2d83-f7dc-55fe476dbccb@ti.com>
References: <925ded57-1e91-3db6-9e82-3a3ff5775412@ti.com>
 <20160831141340.h24szdqjnicmt2ew@atomide.com>
 <20160831165959.3sldcjxaci3kdx6z@atomide.com>
 <eef88aa4-b829-1889-f083-eb0359c0dac6@ti.com>
 <20160831194107.wijnbmdns2jjvzkv@atomide.com>
 <5af44090-6902-2ade-be78-378843757a0a@ti.com>
 <20160901145006.xr3ux63cg6f5bh7p@atomide.com>
 <b3a254b2-948f-f04d-3289-fb8fb9f9ab23@ti.com>
 <20160902145604.nlixopwza76kfgbz@atomide.com>
 <c8f293f6-db2e-e518-7566-2cd92eb06ec0@ti.com>
 <20160902204049.uhp4oosu3oc4k5v6@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160902204049.uhp4oosu3oc4k5v6@atomide.com>
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

On 09/02/16 23:40, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160902 12:39]:
>> On 09/02/2016 05:56 PM, Tony Lindgren wrote:
>>> That's because the hardware or a timer triggers the next dma automagica=
lly
>>> so we don't need to do anything.
>>
>> McBSP is triggering thee DMA request. In case of non OMAP3.McBSP2 the ti=
me
>> between them is shorter than 1.45ms. as the maximum FIFO size is 128. Bu=
t in
>> your case you also have threshold of 128, which means that we have DMA
>> requests coming in every 1.45ms.
>> In theory no audio should be working on OMAP3 if we can hit C7 runtime.
> =

> I agree C7 audio playback should only work if the external audio chip
> is buffering. And there needs to be a wakeup event from the external
> audio chip based on the external audio fifo threshold to wake up the
> SoC and queue up more data. Or a hrtimer in the external audio chip
> that wakes up the SoC and McBSP.

The only C state we can not take is where the McBSP would need context
save/restore... In that case the McBSP FIFO will be lost and there is no way
to recover that. If the external chip has FIFO we could try to somehow make
sure that at the end of a codec FIFO fill the McBSP FIFO is empty. I don't
think it is possible at all.
Another way is to check the amount of data in the FIFO before off and with =
CPU
try to write back the data from the ALSA buffer - from DMA point we step ba=
ck
and read the data... But if it is in period boundary, the previous period
might be already updated -> corrupted audio. The sDMA also have internal FI=
FO
which holds unknown amount of data -> audio corruption, etc.

If the codec does not have FIFO, we can not hit a C state where McBSP would=
 be
off at all.

>>>> Sure, we will not going to be able to hit C6 with this based on the nu=
mbers we
>>>> have in cpuidle34xx.c, but I have no view on how those numbers were ca=
lculated...
>>>
>>> Right, but we don't need to block C6 because of the hardware and/or Lin=
ux
>>> timers doing things for us :)
>>
>> But the correct QoS latency for McBSP is the one which would ensure that=
 the
>> FIFO will be not drained. This is the whole point of PM_QOS. And that is:
>> (1000/sampling_rate) * ((FIFOsize - threshold) / channels)
>> In case of playback
>>
>> On OMAP3.McBSP2 for example (44.1KHz, stereo):
>> FIFO threshold 128
>>  - DMA request will be triggered when 128 slots are free in the FIFO
>>  - at that point we have still 1152 words in the FIFO.
>>  - if the C wakeup latency is longer then what it takes to play out the
>> samples from the FIFO (13.06ms), we will drain the FIFO and got underflo=
w.
>>  - in this case the QOS should be set as 13.06ms
>>
>> FIFO threshold 1024
>>  - DMA request will be triggered when 1024 slots are free in the FIFO
>>  - at that point we have still 256 words in the FIFO.
>>  - if the C wakeup latency is longer then what it takes to play out the
>> samples from the FIFO (2.9ms), we will drain the FIFO and got underflow.
>>  - in this case the QOS should be 2.9ms
>>
>> On other McBSPs with 128 word FIFO the required latency is shorter to en=
sure
>> we don't drain the FIFO.
>>
>> IMHO if the driver sets the PM_QOS, it should set it in a way it is need=
ing it
>> and not to work around system issues.
> =

> Hmm well actually with the fifo threshold your calculations above
> start making some sense. The missing piece is that we will never hit
> off mode until DMA is done. So the true worst case would be:
> =

> - 2.9 - 13.06 ms for the fifo threshold minus dma setup time
> - plus the time it takes to complete the fifo fill with dma
>   as dma will keep the SoC active
> - plus the time it takes to idle the dma after the last fifo fill
>   as the dma will keep SoC active

Yeah, I have done this calculations for the DADC33 mode7LP mode :D

While the calculation is correct for the wake latency requirements, there i=
s a
flip side:
FIFO threshold 128:
- wake threshold is ~13.06ms to ensure that we don't drain the FIFO
- DMA requests are coming at 1.45ms rate.

While we could take a C state which would take ~13.06ms to leave, in reality
the system will be busy to respond to the DMA request coming in every 1.45m=
s.

FIFO threshold is 1024:
- wake threshold is ~2.9ms to ensure that we don't drain the FIFO
- DMA requests are coming at 11.6ms rate.

In this case we only going to allow C state from which we can leave under
2.9ms, but between DMA burst we have 11.6ms. We could be in deeper state, b=
ut
we are going to be woken up by the DMA request and after the DMA request we
have ~2.9ms before the FIFO is empty...

So either we allow deeper C state (threshold 128) which we might not able to
take to the 'fast' DMA requests, or we only allow shallow C state (threshold
1024), and have more time between the DMA requests.

Is this makes sense?

> The dma setup, complete, and idle latencies here can be probably
> be measured with hrtimer :) That still does not explain we don't
> miss anything in retention idle currently.
> =

>> I don't know the PM code that well, but is there a way to set attribute =
to a
>> device to tell how deep C state it can tolerate on the given board or So=
C?
> =

> I believe we can only set the pm_qos latency requirements and there
> is no direct limiting of C states. Then I think the idea of
> dev_pm_qos and set_latency_tolerance callback is that it allows the
> SoC specific code to select the allowed C states. So if we
> implemented set_latency_tolerance in the cpuidle driver, we could
> tinker directly with the C states for latencies.

What we can agree on is that OFF need to be blocked when audio is in use. B=
ut
I'm not sure what is the correct way.

-- =

P=E9ter
