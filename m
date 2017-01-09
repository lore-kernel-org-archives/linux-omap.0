From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH v5] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Mon, 9 Jan 2017 13:46:01 -0800
Message-ID: <CAJ_EiSRiSSUxDoza0a5gHuP8mvOteZ=9Mi=G91r++QUbgaXpXA@mail.gmail.com>
References: <20170105015918.21621-1-matt@ranostay.consulting>
 <1372efd2-5319-e6c4-629e-6ed5f2e2fe29@ti.com>
 <20170109192123.GN2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170109192123.GN2630@atomide.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Linux OMAP List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 9, 2017 at 11:21 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [170109 05:13]:
>> On 01/05/2017 03:59 AM, Matt Ranostay wrote:
>> > We can get audio errors if hitting deeper idle states on omaps:
>> >
>> > [alsa.c:230] error: Fatal problem with alsa output, error -5.
>> > [audio.c:614] error: Error in writing audio (Input/output error?)!
>> >
>> > This seems to happen with off mode idle enabled as power for the
>> > whole SoC may get cut off between filling the McBSP fifo using DMA.
>> > While active DMA blocks deeper idle states in hardware, McBSP
>> > activity does not seem to do so.
>> >
>> > Basing the QoS latency calculation on the FIFO size, threshold,
>> > sample rate, and channels.
>>
>> Looks good to me, thank you!
>>
>> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>
> Noticed the following about 10 seconds into playing an mp3 file with
> mpg123 though:
>

Didn't notice that happening for me. But haven't rebased for the last
couple days.
Does this happen 100% of the time?

> BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:21
> in_atomic(): 1, irqs_disabled(): 128, pid: 351, name: mpg123
> 2 locks held by mpg123/351:
>  #0:  (snd_pcm_link_rwlock){......}, at: [<bf0667dc>] snd_pcm_stream_lock+0x20/0x50 [snd_pcm]
>  #1:  (&(&substream->self_group.lock)->rlock){......}, at: [<bf06dd70>] snd_pcm_lib_write1+0x1ac/0x30c [snd_pc]
> irq event stamp: 20082
> hardirqs last  enabled at (20081): [<bf0668e8>] snd_pcm_stream_unlock_irq+0x20/0x28 [snd_pcm]
> hardirqs last disabled at (20082): [<bf066834>] snd_pcm_stream_lock_irq+0x28/0x38 [snd_pcm]
> softirqs last  enabled at (17808): [<c013f124>] __do_softirq+0x240/0x564
> softirqs last disabled at (17767): [<c013f7e0>] irq_exit+0xe4/0x160
> CPU: 0 PID: 351 Comm: mpg123 Not tainted 4.10.0-rc2-next-20170109+ #726
> Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [<c0110238>] (unwind_backtrace) from [<c010c2a8>] (show_stack+0x10/0x14)
> [<c010c2a8>] (show_stack) from [<c04be4a0>] (dump_stack+0xac/0xe0)
> [<c04be4a0>] (dump_stack) from [<c0165d60>] (___might_sleep+0x17c/0x2a4)
> [<c0165d60>] (___might_sleep) from [<c0879444>] (down_read+0x20/0x90)
> [<c0879444>] (down_read) from [<c015f62c>] (__blocking_notifier_call_chain+0x2c/0x60)
> [<c015f62c>] (__blocking_notifier_call_chain) from [<c015f678>] (blocking_notifier_call_chain+0x18/0x20)
> [<c015f678>] (blocking_notifier_call_chain) from [<c01a1c98>] (pm_qos_update_target+0x120/0x34c)
> [<c01a1c98>] (pm_qos_update_target) from [<bf247188>] (omap_mcbsp_start+0x2a8/0x334 [snd_soc_omap_mcbsp])
> [<bf247188>] (omap_mcbsp_start [snd_soc_omap_mcbsp]) from [<bf24533c>] (omap_mcbsp_dai_trigger+0x5c/0x90 [snd_)
> [<bf24533c>] (omap_mcbsp_dai_trigger [snd_soc_omap_mcbsp]) from [<bf09bfa0>] (soc_pcm_trigger+0xd0/0x11c [snd_)
> [<bf09bfa0>] (soc_pcm_trigger [snd_soc_core]) from [<bf066368>] (snd_pcm_action_single+0x38/0x78 [snd_pcm])
> [<bf066368>] (snd_pcm_action_single [snd_pcm]) from [<bf06de8c>] (snd_pcm_lib_write1+0x2c8/0x30c [snd_pcm])
> [<bf06de8c>] (snd_pcm_lib_write1 [snd_pcm]) from [<bf06df30>] (snd_pcm_lib_write+0x60/0x74 [snd_pcm])
> [<bf06df30>] (snd_pcm_lib_write [snd_pcm]) from [<bf0692bc>] (snd_pcm_playback_ioctl1+0x38c/0x6f0 [snd_pcm])
> [<bf0692bc>] (snd_pcm_playback_ioctl1 [snd_pcm]) from [<c02cbab8>] (do_vfs_ioctl+0x90/0xa0c)
> [<c02cbab8>] (do_vfs_ioctl) from [<c02cc4a0>] (SyS_ioctl+0x6c/0x7c)
> [<c02cc4a0>] (SyS_ioctl) from [<c01079a8>] (__sys_trace_return+0x0/0x10)
>
> Any ideas?
>
> Tony
