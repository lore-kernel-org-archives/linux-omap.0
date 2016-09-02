From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Fri, 2 Sep 2016 22:45:11 +0300
Message-ID: <2ff0fe3b-d2a2-6186-1091-6aa802eb3596@ti.com>
References: <20160829182746.53vrgbxadqodzzug@atomide.com>
 <925ded57-1e91-3db6-9e82-3a3ff5775412@ti.com>
 <20160831141340.h24szdqjnicmt2ew@atomide.com>
 <20160831165959.3sldcjxaci3kdx6z@atomide.com>
 <eef88aa4-b829-1889-f083-eb0359c0dac6@ti.com>
 <20160831194107.wijnbmdns2jjvzkv@atomide.com>
 <5af44090-6902-2ade-be78-378843757a0a@ti.com>
 <20160901145006.xr3ux63cg6f5bh7p@atomide.com>
 <b3a254b2-948f-f04d-3289-fb8fb9f9ab23@ti.com> <20160902155437.GA4152@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160902155437.GA4152@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/02/2016 06:54 PM, Pavel Machek wrote:
> Hi!
> =

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
>> I have even put the OMAP3 to OFF during audio playback with the
> =

> I was seeing something like that with 4.x kernel on Nokia N900.

So it must be possible to reproduce it on BeagleBoard-xm... I will try to g=
et
the PM working on it and let's see (hear).


-- =

P=E9ter
