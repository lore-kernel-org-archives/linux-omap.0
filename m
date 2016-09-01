From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Thu, 1 Sep 2016 07:50:07 -0700
Message-ID: <20160901145006.xr3ux63cg6f5bh7p@atomide.com>
References: <20160829182746.53vrgbxadqodzzug@atomide.com>
 <925ded57-1e91-3db6-9e82-3a3ff5775412@ti.com>
 <20160831141340.h24szdqjnicmt2ew@atomide.com>
 <20160831165959.3sldcjxaci3kdx6z@atomide.com>
 <eef88aa4-b829-1889-f083-eb0359c0dac6@ti.com>
 <20160831194107.wijnbmdns2jjvzkv@atomide.com>
 <5af44090-6902-2ade-be78-378843757a0a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <5af44090-6902-2ade-be78-378843757a0a@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Machel <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160831 23:58]:
> What is the audio format you are using? sampling rate and how many channels?
> cat /proc/asound/card0/pcm0p/sub0/hw_params

Just 44.1 stereo mp3 or wav files.

> What happens if you set the FIFO to 256? Do you still need the 30ms or it can
> be higher, like 60ms?

No this is not related to the FIFO size. We just need to block off idle mode
for cpuidle as the McBSP hardware is not blocking it.

> When the FIFO is set to 128, it means that after the initial FIFO fill we will
> have DMA request coming from McBSP to sDMA with a rate of:
> 
> (1000/sampling_rate) * (FIFO-threshold / channels) = DMA_req_distance_in_ms
> 
> So in case of 44.1KHz, stereo with 128 FIFO threshold DMA request will come at
> every 1.45ms. If I'm not mistaken. The whole FIFO (1280) holds 14.51ms of
> audio in this case.
> 
> I don't see this correlate with the 30ms at all.

It seems we easily have a situation where DMA is done buffering to McBSP,
and PMIC is playing audio, and we hit idle. At that point there are no immediate
timers pending and cpuidle determines we can try to hit a deeper idle mode. As
there are no hardware blockers with DMA off and McBSP not blocking, the hardware
hits off mode. This cuts power to McBSP.

Ideally we'd configure McBSP activity to block deeper idle states in the
hardware but I don't think we have such a configuration available.

So we just want to tell pm_qos that McBSP can't take any idle states shorter
than 30 ms to prevent cutting off power fro the whole SoC.

> Do you see anything in the kernel log? If McBSP is not powered and DMA tries
> to write data we should see l3 error at least. If the reason is that the
> system is not able to wake up fast enough to react to the DMA request from
> McBSP, then we should see FIFO underrun from McBSP (this patch will show them:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111671.html)

No, nothing as both McBSP and DMA are powered off :) Coming back from
idle, from McBSP and DMA point of view things appear as if nothing happened.
I think we're still missing the save and restore of the McBSP state, but
that's a different story and does not help with the fact that we allow
cutting off the power to McBSP during playback.

With Linux next with the patch above, I do see occasional interrupts
for "omap-mcbsp 49022000.mcbsp: TX Buffer Overflow!" but those seem
to also happen if I keep the system busy and I don't hear any dropped
samples.

> Have you tried with different sampling rates? That would have similar effect
> as changing the FIFO threshold for the DMA request periods.

Not very much, but this seems more like a SoC specific issue.

Regards,

Tony
