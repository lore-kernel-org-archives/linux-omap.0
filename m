From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH v7] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Fri, 13 Jan 2017 21:15:23 -0800
Message-ID: <CAJ_EiSR-R=5qUKOfHWTTrjj+ZD6Q6BBf1yPj3atf84Q6K03NZg@mail.gmail.com>
References: <20170113035432.6723-1-matt@ranostay.consulting>
 <20170113152049.GD5696@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170113152049.GD5696@atomide.com>
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

On Fri, Jan 13, 2017 at 7:20 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Matt Ranostay <matt@ranostay.consulting> [170112 19:55]:
>> We can get audio errors if hitting deeper idle states on omaps:
>>
>> [alsa.c:230] error: Fatal problem with alsa output, error -5.
>> [audio.c:614] error: Error in writing audio (Input/output error?)!
>>
>> This seems to happen with off mode idle enabled as power for the
>> whole SoC may get cut off between filling the McBSP fifo using DMA.
>> While active DMA blocks deeper idle states in hardware, McBSP
>> activity does not seem to do so.
>>
>> Basing the QoS latency calculation on the FIFO size, threshold,
>> sample rate, and channels.
>>
>> Based on the original patch by Tony Lindgren
>> Link: https://patchwork.kernel.org/patch/9305867/
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> ---
>> Changes from v1:
>> * add calculations for latency per number of FIFO locations
>>
>> Changes from v2:
>> * add missing mcbsp.h header change
>>
>> Changes from v3:
>> * base the latency calculations on threshold, buffer size, sample
>>   rate, and channels
>>
>> Changes from v4:
>> * using Peter Ujfalusi's suggestions for restoring a higher latency on
>>   audio stream completion, or if not applicable remove the QoS request
>>
>> Changes from v5:
>> * clean up latency checking logic
>> * move logic to .prepare and .shutdown to avoid functions that can sleep
>>
>> Changes from v6:
>> * move QoS removal to asoc_mcbsp_remove from omap_mcbsp_cleanup
>> * also remove header include that is unneeded
>
> Hmm now I'm seeing these when starting or stopping playback:

Ok I can't reproduce but I have an idea why it is happening. There is
likely a race condition between pm_qos_remove_request() and
omap_mcbsp_dai_shutdown()... Should we do a pm_qos_request_active
check in omap_mcbsp_dai_shutdown? That seems to be hacking around the
issue.

Thanks,

Matt


>
> WARNING: CPU: 0 PID: 373 at kernel/power/qos.c:534 omap_mcbsp_dai_shutdown+0x6c/0x70 [snd_soc_omap_mcbsp]
> pm_qos_remove_request() called for unknown object
> Modules linked in: snd_soc_omap_twl4030 snd_soc_twl4030 snd_soc_omap_mcbsp evdev mwifiex_sdio mwifiex leds_gpio
>  snd_soc_omap cfg80211 bq27xxx_battery_i2c leds_pca963x bq27xxx_battery led_class bq24190_charger phy_twl4030_usb omap2430 mus
>  b_hdrc usbcore snd_soc_core twl4030_wdt snd_pcm_dmaengine rtc_twl snd_pcm snd_timer snd soundcore twl4030_pwrbutton pwm_twl_le
>  d twl4030_keypad pwm_twl matrix_keymap omap_ssi hsi ledtrig_timer usb_f_serial usb_f_rndis usb_f_mass_storage usb_f_ecm u_ethe
>  r usb_f_acm libcomposite u_serial udc_core usb_common autofs4 [last unloaded: snd_soc_omap_mcbsp]
>  [   51.542541] CPU: 0 PID: 373 Comm: mpg123 Not tainted 4.10.0-rc2-next-20170109+ #751
>  [   51.550231] Hardware name: Generic OMAP36xx (Flattened Device Tree)
>  [   51.556579] [<c0110198>] (unwind_backtrace) from [<c010c208>] (show_stack+0x10/0x14)
>  [   51.564361] [<c010c208>] (show_stack) from [<c04be0a0>] (dump_stack+0xac/0xe0)
>  [   51.571655] [<c04be0a0>] (dump_stack) from [<c0137428>] (__warn+0xd8/0x104)
>  [   51.578643] [<c0137428>] (__warn) from [<c0137488>] (warn_slowpath_fmt+0x34/0x44)
>  [   51.586212] [<c0137488>] (warn_slowpath_fmt) from [<bf3538f4>] (omap_mcbsp_dai_shutdown+0x6c/0x70 [snd_soc_omap_mcbsp])
>  [   51.597351] [<bf3538f4>] (omap_mcbsp_dai_shutdown [snd_soc_omap_mcbsp]) from [<bf11037c>] (soc_pcm_close+0xa0/0x2b8 [snd_so
>  c_core])
>  [   51.609497] [<bf11037c>] (soc_pcm_close [snd_soc_core]) from [<bf0d0654>] (snd_pcm_release_substream.part.13+0x48/0xac [snd
>  _pcm])
>  [   51.621337] [<bf0d0654>] (snd_pcm_release_substream.part.13 [snd_pcm]) from [<bf0d0764>] (snd_pcm_release+0x94/0xb4 [snd_pc
>  m])
>  [   51.632843] [<bf0d0764>] (snd_pcm_release [snd_pcm]) from [<c02b91d8>] (__fput+0x94/0x1e4)
>  [   51.641174] [<c02b91d8>] (__fput) from [<c015b768>] (task_work_run+0xcc/0x104)
>  [   51.648437] [<c015b768>] (task_work_run) from [<c010bb38>] (do_work_pending+0xbc/0xc0)
>  [   51.656402] [<c010bb38>] (do_work_pending) from [<c01077c8>] (slow_work_pending+0xc/0x20)
>
>
> Regards,
>
> Tony
