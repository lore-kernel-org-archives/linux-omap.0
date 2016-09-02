From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Fri, 2 Sep 2016 10:30:36 +0300
Message-ID: <b3a254b2-948f-f04d-3289-fb8fb9f9ab23@ti.com>
References: <20160829182746.53vrgbxadqodzzug@atomide.com>
 <925ded57-1e91-3db6-9e82-3a3ff5775412@ti.com>
 <20160831141340.h24szdqjnicmt2ew@atomide.com>
 <20160831165959.3sldcjxaci3kdx6z@atomide.com>
 <eef88aa4-b829-1889-f083-eb0359c0dac6@ti.com>
 <20160831194107.wijnbmdns2jjvzkv@atomide.com>
 <5af44090-6902-2ade-be78-378843757a0a@ti.com>
 <20160901145006.xr3ux63cg6f5bh7p@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160901145006.xr3ux63cg6f5bh7p@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>, "Kristo, Tero" <t-kristo@ti.com>
Cc: alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Machel <pavel@ucw.cz>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/01/16 17:50, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160831 23:58]:
>> What is the audio format you are using? sampling rate and how many chann=
els?
>> cat /proc/asound/card0/pcm0p/sub0/hw_params
> =

> Just 44.1 stereo mp3 or wav files.
> =

>> What happens if you set the FIFO to 256? Do you still need the 30ms or i=
t can
>> be higher, like 60ms?
> =

> No this is not related to the FIFO size. We just need to block off idle m=
ode
> for cpuidle as the McBSP hardware is not blocking it.

So this happens with any threshold value? Even in element mode, where we ha=
ve
the threshold set to 2?

>> When the FIFO is set to 128, it means that after the initial FIFO fill w=
e will
>> have DMA request coming from McBSP to sDMA with a rate of:
>>
>> (1000/sampling_rate) * (FIFO-threshold / channels) =3D DMA_req_distance_=
in_ms
>>
>> So in case of 44.1KHz, stereo with 128 FIFO threshold DMA request will c=
ome at
>> every 1.45ms. If I'm not mistaken. The whole FIFO (1280) holds 14.51ms of
>> audio in this case.
>>
>> I don't see this correlate with the 30ms at all.
> =

> It seems we easily have a situation where DMA is done buffering to McBSP,
> and PMIC is playing audio, and we hit idle. At that point there are no im=
mediate
> timers pending and cpuidle determines we can try to hit a deeper idle mod=
e. As
> there are no hardware blockers with DMA off and McBSP not blocking, the h=
ardware
> hits off mode. This cuts power to McBSP.
> =

> Ideally we'd configure McBSP activity to block deeper idle states in the
> hardware but I don't think we have such a configuration available.

I wonder why we have not seen this before? I can not recall anything like t=
his
with n900 (Jarkko might know that better) neither with n9/n950. On the n9/n=
950
I have even put the OMAP3 to OFF during audio playback with the DAC33 and
still it worked just fine. On the twl4030 audio side we used 1024 or someth=
ing
as threshold during audio playback and we do not had QoS placed at all.
The C state numbers must be different what we had and what we have in mainl=
ine
now days, but still this is something I don't expect to happen.

Why McBSP is not working correctly in smart-idle mode in upstream, when it
appeared to be working fine on n900/n9/n950?

> So we just want to tell pm_qos that McBSP can't take any idle states shor=
ter
> than 30 ms to prevent cutting off power fro the whole SoC.

based on the numbers in the arch/arm/mach-omap2/cpuidle34xx.c we are trying=
 to
block C7 since the exit_latency for it is (10000 + 30000)us, right? Or is it
the traget_residency we need to look at when we set PM_QOS_CPU_DMA_LATENCY?

Still in case of 44.1KHz/Stereo, FIFO threshold at 128 we will have DMA
requests coming at 1.45ms with the whole FIFO holding 14.51ms of data. In
order to avoid draining the FIFO, the latency for omap3.mcbsp2 when the aud=
io
is 44.1KHz, stereo must be set to 14.51ms maximum, but I would set it to:
(1000/sampling_rate) * ((FIFOsize - threshold) / channels) in ms.

Certainly not 30ms. What happens if someone changes the C7 state number and=
 it
is going to be less than 30ms? We will hit C7 and have the same issue? I
suppose yes.
This is my main problem with the 30ms. It is just an arbitrary number which
matches some number in cpuidle34xx.c, but it has nothing to do with the real
requirement of McBSP, which is that we should not hit a state where the wak=
eup
is going to take more time than what we can compensate from the McBSP FIFO.

Furthermore: in case of other McBSPs where they have 128 word FIFO, which
holds in your use case 1.45ms of audio, how it will survive the C6 wakeup
latency of (3000 + 8500)us? It can tolerate C3 at maximum, C4 takes (1500 +
1800)us.

Sure, we will not going to be able to hit C6 with this based on the numbers=
 we
have in cpuidle34xx.c, but I have no view on how those numbers were calcula=
ted...

>> Do you see anything in the kernel log? If McBSP is not powered and DMA t=
ries
>> to write data we should see l3 error at least. If the reason is that the
>> system is not able to wake up fast enough to react to the DMA request fr=
om
>> McBSP, then we should see FIFO underrun from McBSP (this patch will show=
 them:
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111671.=
html)
> =

> No, nothing as both McBSP and DMA are powered off :) Coming back from
> idle, from McBSP and DMA point of view things appear as if nothing happen=
ed.
> I think we're still missing the save and restore of the McBSP state, but
> that's a different story and does not help with the fact that we allow
> cutting off the power to McBSP during playback.
> =

> With Linux next with the patch above, I do see occasional interrupts
> for "omap-mcbsp 49022000.mcbsp: TX Buffer Overflow!" but those seem
> to also happen if I keep the system busy and I don't hear any dropped
> samples.
> =

>> Have you tried with different sampling rates? That would have similar ef=
fect
>> as changing the FIFO threshold for the DMA request periods.
> =

> Not very much, but this seems more like a SoC specific issue.

-- =

P=E9ter
