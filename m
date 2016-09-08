From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Thu, 8 Sep 2016 07:48:34 -0700
Message-ID: <20160908144834.i722j3afyztk6vhh@atomide.com>
References: <b3a254b2-948f-f04d-3289-fb8fb9f9ab23@ti.com>
 <20160902145604.nlixopwza76kfgbz@atomide.com>
 <c8f293f6-db2e-e518-7566-2cd92eb06ec0@ti.com>
 <20160902204049.uhp4oosu3oc4k5v6@atomide.com>
 <7d1c9a2f-60ae-2d83-f7dc-55fe476dbccb@ti.com>
 <20160906201649.fx4vhuqmnziwshoe@atomide.com>
 <1b82e33a-7db5-81ed-de4f-75847f840088@ti.com>
 <20160908035356.mkk35s5gpcemifcg@atomide.com>
 <ceb7854b-6cd4-fe3d-ede7-016c64f88dc0@ti.com>
 <9452a3c6-9bf9-818f-6e8d-455193839e94@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <9452a3c6-9bf9-818f-6e8d-455193839e94@ti.com>
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
Cc: alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Machel <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160908 03:49]:
> > 
> > I managed to get time for this and it looks like that we only need to block
> > core OFF for audio. I don't know why C6 ("MPU OFF + CORE RET") with it's 3000
> > + 8500 exit latency not causing issues when we have less time from the DMA
> > request to empty FIFO...

Right, the wakeup event should be the fifo threshold and the dma trigger
line.. But there must some other thing we're not accounting for.

> > My findings so far:
> > w/o the QoS patch we will hit core OFF even if we are in element mode in McBSP:
> > # cat /sys/devices/platform/68000000.ocp/49022000.mcbsp/dma_op_mode
> > [element] threshold
> > 
> > If I start the playback we will hit core OFF even if the we have DMA request
> > coming at every sample (every 0.02ms).

I think that's because we still have windows without pm qos where dma
is not active and we hit idle and there's nothing in hardware blocking
off mode.

> > We hit C6, but when the DMA request comes we have 16 words in the FIFO (8
> > samples, 0.16ms of audio). C6 should take 11.5ms to exit...

So maybe we have the C6 latency for 36xx wrong, and it's much faster than
for 34xx? I wonder what happens on the original beagleboard, not the
xm variant.. I don't have one though.

> > Based on my experiments the FIFO threshold does not matter as even if we
> > should not be able to leave from a C state in time, we do leave from the state :o

Yes that's a mystery :)

> > The patch generates the following warning when the playback is stopped:
...
> > [  115.996002] [<c0155b74>] (__cancel_work_timer) from [<c0199ad8>]
> > (pm_qos_remove_request+0x28/0x1c8)
> > [  116.005523] [<c0199ad8>] (pm_qos_remove_request) from [<c0684634>]
> > (omap_mcbsp_dai_trigger+0x70/0x8c)
> > [  116.015197] [<c0684634>] (omap_mcbsp_dai_trigger) from [<c067baa8>]
> > (soc_pcm_trigger+0xd0/0x11c)
> > [  116.024414] [<c067baa8>] (soc_pcm_trigger) from [<c0663be0>]
> > (snd_pcm_do_stop+0x50/0x54)
> > [  116.032928] [<c0663be0>] (snd_pcm_do_stop) from [<c06639c4>]
> > (snd_pcm_action_single+0x38/0x80)

Hmm OK I wonder why have not seen that one, I've been just hitting ctrl-c
to stop the playback.

> > There is one more issue: if we have playback and capture running at the same
> > time and you stop one of them. It will remove the QoS and the remaining stream
> > might break.
> 
> it is better to place the QoS in omap_mcbsp_request() and remove it in
> omap_mcbsp_free(). This way we retain the QoS for the time the McBSP is in
> active use.

OK makes sense.

Regards,

Tony
