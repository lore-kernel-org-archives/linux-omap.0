From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: omap alsa tsc2101 driver
Date: Mon, 06 Feb 2006 22:17:07 +0200
Message-ID: <43E7AEC3.3020901@cc.jyu.fi>
References: <43E66CF6.8040600@cc.jyu.fi>
	<9268368b0602061113n30e8c49bx756de24a1eaf93c6@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602061113n30e8c49bx756de24a1eaf93c6@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Petrini

That sounds good for me, I am happy from anything that works and can try
to continue from that :-)
Can you give more info from your driver like is it already using DMA, is
it using headset or normal speakers for playing, etc?
In addition do you have sources available somewhere so I could check
whether your code works also with my device?

It should be possible to take the existing mixer part from my code to
your driver. As I have not yet been able to play songs properly, I have
sofar only been able to test the volume and mute/unmute settings from
the Mixers Digital Gain Control (DGC) properly.
Headset and handset parts seems to act ok, but only time will tell
whether they really work. But if I can get your driver to play with my
device, I could continue from that.

I think there will also be a need for a somekind of "temp/work"
repository for helping to synchronize the our (and possible others)
work, but I think we can resolve that later.

Mika

Daniel Petrini wrote:

>Hi Mika,
>
>I have been working in this ALSA driver as well, and I have a
>functional patch that plays songs but lacks the mixer support yet.
>What do you think of join the drivers to make it work faster?
>I am developing it generically in order to take advantage of existing
>common code as dma and alsa generic.
>
>Daniel
>
>On 2/5/06, lamikr <lamikr@cc.jyu.fi> wrote:
>  
>
>>Hi
>>
>>I have not seen anyone working with the tsc2101 Alsa driver, so attached
>>are the tsc2101 alsa driver sources I have been working for a while. The
>>patch should apply to the omap-driver head. Unfortunately it is still
>>non-functional at least with my omap 1510 based iPAQ h6340.
>>
>>I can hear small start of the song but then nothing happens. I have
>>tried to debug the code and I can see that the the driver is able to get
>>one callback to sound_dma_irq_handler with DSCR_END_BLOCK set, but after
>>it does not continue with a next period of code.
>>
>>Here is some info from the driver
>>- all code is located in /sound/arm/omap as I have wanted to mix it to
>>existing aic23 code until this one works
>>- based on to aic23 Alsa and tsc2101 OSS drivers. DMA code and driver
>>base taken from the aic, but hardware initialization taken from the
>>tsc2101 oss driver. (dma has only small changes like 16 bit mono to
>>capture params instead of 32 bit ones supported in the aic23)
>>- mixer code for DGC, headset and handset
>>- debug is mostly printed by using DPRINTK() function and can be enabled
>>by uncommenting "#define DEBUG 1" from the omap-alsa.h
>>- This is platform driver, so you need to register it to your board-code
>>in arch/arm/mach-omap1/board-* in a following way:
>>        static struct platform_device h6300_mcbsp1_device = {
>>                    .name        = "omap_tsc2101_mcbsp",
>>                    .id        = 1,
>>            };
>>
>>        static struct platform_device *h6300_devices[] __initdata = {
>>                ...
>>                &h6300_mcbsp1_device,
>>        };
>>
>>I have only tested this with omap1510 based iPAQ h6300, so I would
>>appreciate if somebody else could test this with other
>>devices having tsc2101 chipset to find out whether this is just my hw
>>specific problem. (Fixes would ofcource also be nice :-)
>>
>>For testing the driver I have plugged headset and listened the result of
>>following commands
>>- aplay song.wav (44100 hz 16 bit little endion format)
>>- "speaker-test -r 8000", "-r 44100", etc...
>>
>>I have also tryed to change the audio_get_dma_pos() method to be like in
>>the sa11xx-uda1341.c driver. With implementation
>>based on to that, the speaker-test is able to produce somekind of
>>periodic "wuff <silence> wuff <silence> wuff..." sound.
>>(that method version is commented out in the omap-alsa-tsc2101.c)
>>
>>In addition to sources, attached is the log from one play attempt.
>>
>>Mika
>>
>>root@h6300:~# aplay free_breakbeat.wav
>>Playing WAVE 'free_breakbeat.wav' : Signed 16 bit Little Endian, Rate
>>44100 Hz, Stereo
>>aplay: pcm_write:1146: write error: Input/output error
>>root@h6300:~# dmesg
>>XXX Alsa debug f:omap_alsa_tsc2101_init, l:1157
>>XXX Alsa debug f:snd_omap_alsa_tsc2101_probe, l:1077
>>XXX Alsa debug f:snd_card_omap_alsa_tsc2101_pcm, l:845
>>XXX Alsa debug f:omap_alsa_tsc2101_audio_init, l:350
>>XXX Alsa debug f:audio_dma_request, l:385
>>[omap_request_alsa_sound_dma]: start
>>[omap_request_alsa_sound_dma]: end(0)
>>XXX Alsa debug f:audio_dma_request, l:385
>>[omap_request_alsa_sound_dma]: start
>>[omap_request_alsa_sound_dma]: end(0)
>>[snd_omap_init_mixer]: start
>>[setRecordSource]: start
>>[setRecordSource]: end(0)
>>[snd_omap_init_mixer]: end(0)
>>OMAP_ALSA_TSC2101 audio support initialized
>><omap_alsa_tsc2101_clock_on>: clock use count = 0
>><omap_alsa_tsc2101_clock_on>: old clock rate = 12000000
>>omap_alsa_tsc2101_clock_on(), no need to change clock rate, rate already
>>12000000 Hz.
>><omap_alsa_tsc2101_clock_on>: MCLK = 12000000 [12000000], usecount = 1,
>>clk_enable retval = 0
>><snd_card_omap_alsa_tsc2101_open>: runtime->hw =
>>snd_omap_alsa_tsc2101_playback
>><snd_omap_alsa_tsc2101_hw_params>: snd_omap_alsa_tsc2101_hw_params(),
>>size = 131072
>>XXX Alsa debug f:snd_omap_alsa_tsc2101_prepare, l:686
>>XXX Alsa debug f:omap_alsa_tsc2101_set_samplerate, l:248
>><omap_alsa_tsc2101_set_samplerate>: selected 44.1khz PLL
>><snd_omap_alsa_tsc2101_trigger>: cmd = 1
>><audio_process_dma>: started,  offset = 0, dma_size = 8192, s->period =
>>0, s->periods = 0, s->dma_q_head = 0, s->offset = 0, rt->buffer_size =
>>32768, rt->period_size = 2048, rt->frame_bits = 32, runtime->dma_addr =
>>0, dma_ptr = -1042022400
>>[omap_start_alsa_sound_dma]: start
>><omap_start_alsa_sound_dma>: stream_id = playback, dma_ptr =
>>-1042022400, dma_size = 8192
>>[audio_set_dma_params_play]: start
>>[audio_set_dma_params_play]: end(0)
>>[audio_start_dma_chain]: start
>>XXX Alsa debug f:audio_ifc_stop, l:229
>>XXX Alsa debug f:audio_ifc_start, l:222
>>[audio_start_dma_chain]: end(0)
>>[omap_start_alsa_sound_dma]: end(0)
>><audio_process_dma>: done, offset = 0, dma_size = 8192, s->period = 0,
>>s->periods = 1, s->dma_q_head = 0, s->offset = 0, rt->buffer_size =
>>32768, rt->period_size = 2048, rt->frame_bits = 32, runtime->dma_addr =
>>0, dma_ptr = -1042022400
>><audio_get_dma_pos>: count = 6150, s->dma_q_head = 0, s->offset = 0,
>>s->period = 1, s->periods = 1, rt->buffer_size = 32768, rt->period_size
>>= 2048, rt->frame_bits = 32, runtime->dma_addr = 0, offset = -1537,
>>dma_ptr = -1042023937
>><audio_get_dma_pos>: offsetFrame= 0, countFrame = 1537
>><audio_get_dma_pos>: warning, resetted offset to 0, old offset val = 0
>><sound_dma_irq_handler>: started, lch = 0, status = 0x20, dma_status =
>>32, data = c0b0608c
>><sound_dma_irq_handler>: status = DCSR_END_BLOCK, calling
>>audio_dma_callback()
>><audio_dma_callback>: s->active, calling snd_pcm_period_elapsed
>><audio_get_dma_pos>: count = 6150, s->dma_q_head = 0, s->offset = 0,
>>s->period = 1, s->periods = 1, rt->buffer_size = 32768, rt->period_size
>>= 2048, rt->frame_bits = 32, runtime->dma_addr = 0, offset = -1537,
>>dma_ptr = -1042023937
>><audio_get_dma_pos>: offsetFrame= 0, countFrame = 1537
>><audio_get_dma_pos>: warning, resetted offset to 0, old offset val = 0
>><audio_process_dma>: started,  offset = 8192, dma_size = 8192, s->period
>>= 1, s->periods = 0, s->dma_q_head = 0, s->offset = 0, rt->buffer_size =
>>32768, rt->period_size = 2048, rt->frame_bits = 32, runtime->dma_addr =
>>0, dma_ptr = -1042014208
>>[omap_start_alsa_sound_dma]: start
>><omap_start_alsa_sound_dma>: stream_id = playback, dma_ptr =
>>-1042014208, dma_size = 8192
>>[audio_set_dma_params_play]: start
>>[audio_set_dma_params_play]: end(0)
>>[audio_start_dma_chain]: start
>>[audio_start_dma_chain]: end(0)
>>[omap_start_alsa_sound_dma]: end(0)
>><audio_process_dma>: done, offset = 8192, dma_size = 8192, s->period =
>>1, s->periods = 1, s->dma_q_head = 0, s->offset = 8192, rt->buffer_size
>>= 32768, rt->period_size = 2048, rt->frame_bits = 32, runtime->dma_addr
>>= 0, dma_ptr = -1042014208
>><sound_dma_irq_handler>: done
>>ALSA
>>/home/lamikr/own/h6300/git/linux-omap-h6300-2.6/sound/core/pcm_lib.c:2231:
>>playback write error (DMA or IRQ trouble?)
>><snd_omap_alsa_tsc2101_trigger>: cmd = 0
>>XXX Alsa debug f:audio_stop_dma, l:488
>>[omap_alsa_audio_stop_dma]: start
>>[omap_alsa_audio_stop_dma]: end(0)
>>[omap_clear_alsa_sound_dma]: start
>>[omap_clear_alsa_sound_dma]: end(0)
>>XXX Alsa debug f:snd_card_omap_alsa_tsc2101_close, l:785
>><omap_alsa_tsc2101_clock_off>: clock use count = 1
>><omap_alsa_tsc2101_clock_off>: clock rate = 12000000
>><omap_alsa_tsc2101_clock_off>: clock disabled
>><omap_alsa_tsc2101_clock_off>: audio codec off
>>
>>
>>
>>_______________________________________________
>>Linux-omap-open-source mailing list
>>Linux-omap-open-source@linux.omap.com
>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
>>
>>
>>
>>    
>>
>
>
>--
>INdT - Manaus - Brazil
>
>  
>
