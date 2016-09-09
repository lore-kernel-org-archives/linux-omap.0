From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Fri, 9 Sep 2016 09:51:41 +0300
Message-ID: <8ec65c33-cc92-7737-ac7a-1338bcab7b90@ti.com>
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
 <20160908144834.i722j3afyztk6vhh@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160908144834.i722j3afyztk6vhh@atomide.com>
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

On 09/08/16 17:48, Tony Lindgren wrote:
>>> My findings so far:
>>> w/o the QoS patch we will hit core OFF even if we are in element mode i=
n McBSP:
>>> # cat /sys/devices/platform/68000000.ocp/49022000.mcbsp/dma_op_mode
>>> [element] threshold
>>>
>>> If I start the playback we will hit core OFF even if the we have DMA re=
quest
>>> coming at every sample (every 0.02ms).
> =

> I think that's because we still have windows without pm qos where dma
> is not active and we hit idle and there's nothing in hardware blocking
> off mode.

Hrm. Should we block idle when the FIFO threshold is 'low'. I don't think it
is a good thing to try to enter to lower C state to immediately jump out of
it. With 0.02ms there is not much time we can spend conserving power and the
enter/leave takes a bit more compared to staying wherever we were.
ON the other hand, if we have big ALSA buffer we can keep the MPU off for a
long time as we only need the DMA and the McBSP to run between user space
filling the ALSA buffer...

Oh, I have looked again to cpuidle34xx.c and we have two tables there:
omap3_idle_driver and omap3430_idle_driver.

The omap3430_idle_driver numbers are based on measurements while the
omap3_idle_driver probably contains safe numbers?

In any way, according to the numbers:
C7 is (7505 + 15274) vs (10000 + 30000)
C6 is (7580 + 4134) vs (3000 + 8500)
C5 is (855 + 1146) vs (2500 + 7500)
C4 is (121 + 3374) vs (1500 + 1800)
C3 is (107 + 410) vs (50 + 50)

with the 30ms QoS we set we will still hit OFF on OMAP3430, it should minim=
um
11.715ms for omap3430, but that will block C6 on omap36xx.

If we could have the data for the struct cpuidle_state coming from DT and n=
ot
wired in the cpuidle34xx/44xx files then the McBSP driver could look up the=
 C7
number and block that...

>>> We hit C6, but when the DMA request comes we have 16 words in the FIFO =
(8
>>> samples, 0.16ms of audio). C6 should take 11.5ms to exit...
> =

> So maybe we have the C6 latency for 36xx wrong, and it's much faster than
> for 34xx? I wonder what happens on the original beagleboard, not the
> xm variant.. I don't have one though.

I have one working omap3 zoom2 board. AFAIK it has OMAP3430. I have
3.9.smthing kernel booting on it, but I'm not sure if mainline would even
work. Zoom3 and Zoom2 are mostly identical, but the SoC is different for su=
re
and probably memories, NAND, something else on the SOM? Can not find
information on this.

>>> Based on my experiments the FIFO threshold does not matter as even if we
>>> should not be able to leave from a C state in time, we do leave from th=
e state :o
> =

> Yes that's a mystery :)
> =

>>> The patch generates the following warning when the playback is stopped:
> ...
>>> [  115.996002] [<c0155b74>] (__cancel_work_timer) from [<c0199ad8>]
>>> (pm_qos_remove_request+0x28/0x1c8)
>>> [  116.005523] [<c0199ad8>] (pm_qos_remove_request) from [<c0684634>]
>>> (omap_mcbsp_dai_trigger+0x70/0x8c)
>>> [  116.015197] [<c0684634>] (omap_mcbsp_dai_trigger) from [<c067baa8>]
>>> (soc_pcm_trigger+0xd0/0x11c)
>>> [  116.024414] [<c067baa8>] (soc_pcm_trigger) from [<c0663be0>]
>>> (snd_pcm_do_stop+0x50/0x54)
>>> [  116.032928] [<c0663be0>] (snd_pcm_do_stop) from [<c06639c4>]
>>> (snd_pcm_action_single+0x38/0x80)
> =

> Hmm OK I wonder why have not seen that one, I've been just hitting ctrl-c
> to stop the playback.

I also stopped the playback with ctrl-c :o

>>> There is one more issue: if we have playback and capture running at the=
 same
>>> time and you stop one of them. It will remove the QoS and the remaining=
 stream
>>> might break.
>>
>> it is better to place the QoS in omap_mcbsp_request() and remove it in
>> omap_mcbsp_free(). This way we retain the QoS for the time the McBSP is =
in
>> active use.
> =

> OK makes sense.
> =

> Regards,
> =

> Tony
> =



-- =

P=E9ter
