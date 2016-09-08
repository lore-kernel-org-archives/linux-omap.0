From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Thu, 8 Sep 2016 13:49:08 +0300
Message-ID: <9452a3c6-9bf9-818f-6e8d-455193839e94@ti.com>
References: <20160831194107.wijnbmdns2jjvzkv@atomide.com>
 <5af44090-6902-2ade-be78-378843757a0a@ti.com>
 <20160901145006.xr3ux63cg6f5bh7p@atomide.com>
 <b3a254b2-948f-f04d-3289-fb8fb9f9ab23@ti.com>
 <20160902145604.nlixopwza76kfgbz@atomide.com>
 <c8f293f6-db2e-e518-7566-2cd92eb06ec0@ti.com>
 <20160902204049.uhp4oosu3oc4k5v6@atomide.com>
 <7d1c9a2f-60ae-2d83-f7dc-55fe476dbccb@ti.com>
 <20160906201649.fx4vhuqmnziwshoe@atomide.com>
 <1b82e33a-7db5-81ed-de4f-75847f840088@ti.com>
 <20160908035356.mkk35s5gpcemifcg@atomide.com>
 <ceb7854b-6cd4-fe3d-ede7-016c64f88dc0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <ceb7854b-6cd4-fe3d-ede7-016c64f88dc0@ti.com>
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

On 09/08/16 13:41, Peter Ujfalusi wrote:
> On 09/08/16 06:53, Tony Lindgren wrote:
>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160907 07:32]:
>>> On 09/06/2016 11:16 PM, Tony Lindgren wrote:
>>>> Makes sense. Do you have a formula or updated patch I can test here?
>>>> Then we can add comments about the possible unaccounted latencies that
>>>> can be worked out as needed.
>>>
>>> Not yet, but I'll try to come up with something in the coming days.
>>
>> OK
> =

> I managed to get time for this and it looks like that we only need to blo=
ck
> core OFF for audio. I don't know why C6 ("MPU OFF + CORE RET") with it's =
3000
> + 8500 exit latency not causing issues when we have less time from the DMA
> request to empty FIFO...
> =

> My findings so far:
> w/o the QoS patch we will hit core OFF even if we are in element mode in =
McBSP:
> # cat /sys/devices/platform/68000000.ocp/49022000.mcbsp/dma_op_mode
> [element] threshold
> =

> If I start the playback we will hit core OFF even if the we have DMA requ=
est
> coming at every sample (every 0.02ms).
> =

> With the QoS set to 30ms and:
> # cat /sys/devices/platform/68000000.ocp/49022000.mcbsp/dma_op_mode
> element [threshold]
> # cat /sys/devices/platform/68000000.ocp/49022000.mcbsp/max_tx_thres
> 1264
> =

> # cat /sys/kernel/debug/pm_debug/count; aplay -Dplughw:0,0
> media/music/nin-echoplex.wav; cat /sys/kernel/debug/pm_debug/count
> =

> core_pwrdm
> (ON),OFF:1885,RET:6777,INA:86320,ON:94983,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
F:0,RET-MEMBANK2-OFF:0
> per_pwrdm (ON),OFF:2507,RET:1518,INA:0,ON:4026,RET-LOGIC-OFF:0,RET-MEMBAN=
K1-OFF:0
> mpu_pwrdm
> (ON),OFF:80588,RET:7876,INA:97390,ON:185855,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
> =

> Playing WAVE 'media/music/nin-echoplex.wav' : Signed 16 bit Little Endian,
> Rate 48000 Hz, Stereo
> =

> core_pwrdm
> (ON),OFF:1885,RET:7860,INA:107434,ON:117180,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0,RET-MEMBANK2-OFF:0
> per_pwrdm (ON),OFF:2507,RET:1518,INA:0,ON:4026,RET-LOGIC-OFF:0,RET-MEMBAN=
K1-OFF:0
> mpu_pwrdm
> (ON),OFF:103223,RET:8185,INA:97461,ON:208870,RET-LOGIC-OFF:0,RET-MEMBANK1=
-OFF:0
> =

> We hit C6, but when the DMA request comes we have 16 words in the FIFO (8
> samples, 0.16ms of audio). C6 should take 11.5ms to exit...
> =

>>> btw: I have tried the idle off on beagbeboard-xm with audio, but even w=
/o the
>>> qos it is not triggering. w/o audio I hit off but if audio is running, =
not.
>>
>> OK yeah figured it out you need to comment out the watch -n5 command
>> as that keeps the serial console busy :) I was doing it over ssh earlier
>> on the torpedo board.
>>
>>> btw2: if you set the qos to 30ms and set the mcbsp2 threshold to 1024 (=
or
>>> leave it as default) do you have audio glitches? I think if we hit C6 we
>>> should not be able to wake up in time...
>>
>> Not that I've noticed at least with the default fifo size. How can
>> I force the threshold to 1024? I tried changing pkt_size for
>> omap_mcbsp_set_threshold but not getting any audio.
> =

> Based on my experiments the FIFO threshold does not matter as even if we
> should not be able to leave from a C state in time, we do leave from the =
state :o
> =

> The patch generates the following warning when the playback is stopped:
> [  115.726531]
> [  115.728149] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  115.732727] [ INFO: inconsistent lock state ]
> [  115.737304] 4.8.0-rc3-next-20160825-00064-g957cf3635c39-dirty #1450 No=
t tainted
> [  115.744964] ---------------------------------
> [  115.749542] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> [  115.755859] swapper/0/0 [HC0[0]:SC1[1]:HE0:SE0] takes:
> [  115.761230]  ((&(&req->work)->work)){+.?...}, at: [<c0152fe0>]
> flush_work+0x0/0x260
> [  115.769348] {SOFTIRQ-ON-W} state was registered at:
> [  115.774475]   [<c015301c>] flush_work+0x3c/0x260
> [  115.779357]   [<c0155b74>] __cancel_work_timer+0x90/0x1c0
> [  115.785034]   [<c01999c8>] pm_qos_update_request+0x28/0x54
> [  115.790802]   [<c01549ec>] process_one_work+0x1fc/0x770
> [  115.796295]   [<c0154f98>] worker_thread+0x38/0x550
> [  115.801452]   [<c015b0b8>] kthread+0xd4/0xf0
> [  115.805969]   [<c0107910>] ret_from_fork+0x14/0x24
> [  115.811004] irq event stamp: 191097
> [  115.814666] hardirqs last  enabled at (191096): [<c07f8fb8>]
> _raw_spin_unlock_irq+0x24/0x2c
> [  115.823455] hardirqs last disabled at (191097): [<c0663f30>]
> _snd_pcm_stream_lock_irqsave+0x2c/0x40
> [  115.832977] softirqs last  enabled at (191090): [<c013e5dc>]
> irq_enter+0x68/0x84
> [  115.840759] softirqs last disabled at (191091): [<c013e6b8>]
> irq_exit+0xc0/0x134
> [  115.848541]
> [  115.848541] other info that might help us debug this:
> [  115.855407]  Possible unsafe locking scenario:
> [  115.855407]
> [  115.861602]        CPU0
> [  115.864166]        ----
> [  115.866760]   lock((&(&req->work)->work));
> [  115.871063]   <Interrupt>
> [  115.873809]     lock((&(&req->work)->work));
> [  115.878326]
> [  115.878326]  *** DEADLOCK ***
> [  115.878326]
> [  115.884552] 2 locks held by swapper/0/0:
> [  115.888671]  #0:  (snd_pcm_link_rwlock){...-..}, at: [<c0663e9c>]
> snd_pcm_stream_lock+0x20/0x50
> [  115.897857]  #1:  (&(&substream->self_group.lock)->rlock){..-...}, at:
> [<c0663f38>] _snd_pcm_stream_lock_irqsave+0x34/0x40
> [  115.909515]
> [  115.909515] stack backtrace:
> [  115.914123] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 4.8.0-rc3-next-20160825-00064-g957cf3635c39-dirty #1450
> [  115.924530] Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [  115.931121] [<c0110128>] (unwind_backtrace) from [<c010c2c0>]
> (show_stack+0x10/0x14)
> [  115.939270] [<c010c2c0>] (show_stack) from [<c048c120>] (dump_stack+0x=
b0/0xe4)
> [  115.946868] [<c048c120>] (dump_stack) from [<c0192708>]
> (print_usage_bug+0x1e0/0x2d4)
> [  115.955108] [<c0192708>] (print_usage_bug) from [<c0192d7c>]
> (mark_lock+0x580/0x6c4)
> [  115.963256] [<c0192d7c>] (mark_lock) from [<c0193a38>]
> (__lock_acquire+0x5a8/0x187c)
> [  115.971374] [<c0193a38>] (__lock_acquire) from [<c0195128>]
> (lock_acquire+0xd0/0x238)
> [  115.979614] [<c0195128>] (lock_acquire) from [<c015301c>]
> (flush_work+0x3c/0x260)
> [  115.987487] [<c015301c>] (flush_work) from [<c0155b74>]
> (__cancel_work_timer+0x90/0x1c0)
> [  115.996002] [<c0155b74>] (__cancel_work_timer) from [<c0199ad8>]
> (pm_qos_remove_request+0x28/0x1c8)
> [  116.005523] [<c0199ad8>] (pm_qos_remove_request) from [<c0684634>]
> (omap_mcbsp_dai_trigger+0x70/0x8c)
> [  116.015197] [<c0684634>] (omap_mcbsp_dai_trigger) from [<c067baa8>]
> (soc_pcm_trigger+0xd0/0x11c)
> [  116.024414] [<c067baa8>] (soc_pcm_trigger) from [<c0663be0>]
> (snd_pcm_do_stop+0x50/0x54)
> [  116.032928] [<c0663be0>] (snd_pcm_do_stop) from [<c06639c4>]
> (snd_pcm_action_single+0x38/0x80)
> [  116.041961] [<c06639c4>] (snd_pcm_action_single) from [<c066aa4c>]
> (snd_pcm_update_state+0xd0/0x100)
> [  116.051574] [<c066aa4c>] (snd_pcm_update_state) from [<c066ac20>]
> (snd_pcm_update_hw_ptr0+0x1a4/0x3ac)
> [  116.061340] [<c066ac20>] (snd_pcm_update_hw_ptr0) from [<c066ae9c>]
> (snd_pcm_period_elapsed+0x74/0xb4)
> [  116.071136] [<c066ae9c>] (snd_pcm_period_elapsed) from [<c04e63f8>]
> (vchan_complete+0x190/0x1a4)
> [  116.080352] [<c04e63f8>] (vchan_complete) from [<c013ee68>]
> (tasklet_action+0x88/0x128)
> [  116.088775] [<c013ee68>] (tasklet_action) from [<c013dee0>]
> (__do_softirq+0xc4/0x55c)
> [  116.096984] [<c013dee0>] (__do_softirq) from [<c013e6b8>] (irq_exit+0x=
c0/0x134)
> [  116.104675] [<c013e6b8>] (irq_exit) from [<c01a17a8>]
> (__handle_domain_irq+0x6c/0xe0)
> [  116.112884] [<c01a17a8>] (__handle_domain_irq) from [<c07f96b0>]
> (__irq_svc+0x70/0x98)
> [  116.121215] [<c07f96b0>] (__irq_svc) from [<c0613808>]
> (cpuidle_enter_state+0x15c/0x464)
> [  116.129699] [<c0613808>] (cpuidle_enter_state) from [<c0187788>]
> (cpu_startup_entry+0x2b8/0x3e0)
> [  116.138946] [<c0187788>] (cpu_startup_entry) from [<c0b00c1c>]
> (start_kernel+0x340/0x3b4)
> =

> There is one more issue: if we have playback and capture running at the s=
ame
> time and you stop one of them. It will remove the QoS and the remaining s=
tream
> might break.

it is better to place the QoS in omap_mcbsp_request() and remove it in
omap_mcbsp_free(). This way we retain the QoS for the time the McBSP is in
active use.

> =



-- =

P=E9ter
