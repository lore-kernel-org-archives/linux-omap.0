From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: omap alsa tsc2101 driver
Date: Wed, 08 Feb 2006 01:16:28 +0200
Message-ID: <43E92A4C.2070004@cc.jyu.fi>
References: <43E66CF6.8040600@cc.jyu.fi>	
	<9268368b0602061113n30e8c49bx756de24a1eaf93c6@mail.gmail.com>	
	<43E7AEC3.3020901@cc.jyu.fi>	
	<9268368b0602061401m4522d31v258f0f67f19509ef@mail.gmail.com>	
	<43E8960E.6090005@cc.jyu.fi>	
	<9268368b0602070634g47a53b15w6492c036166f6cb4@mail.gmail.com>	
	<43E905A8.9090307@cc.jyu.fi>
	<9268368b0602071429k9563756hc94fbc4efd124aa0@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602071429k9563756hc94fbc4efd124aa0@mail.gmail.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Sorry, I send wrong log by myself. Here is the correct one...

<setMixerVolumeAsHeadsetGainControlVolume>: mixer volume = 20
<setMixerVolumeAsHeadsetGainControlVolume>: to registry = 6400
<setMixerVolumeAsHandsetGainControlVolume>: mixer volume = 20
<setMixerVolumeAsHandsetGainControlVolume>: to registry = 6400
<setMixerVolumeAsDacGainControlVolume>: mixer volume left = 93, right = 93
<setMixerVolumeAsDacGainControlVolume>: to registry: left = 6, right =
6, total = 1542
[snd_omap_init_mixer]: end(0)
XXX Alsa debug f:snd_card_omap_alsa_tsc2101_pcm, l:853
XXX Alsa debug f:omap_alsa_tsc2101_audio_init, l:367
XXX Alsa debug f:audio_dma_request, l:393
[omap_request_alsa_sound_dma]: start
[omap_request_alsa_sound_dma]: end(0)
XXX Alsa debug f:audio_dma_request, l:393
[omap_request_alsa_sound_dma]: start
[omap_request_alsa_sound_dma]: end(0)
OMAP_ALSA_TSC2101 audio support initialized
<snd_card_omap_alsa_tsc2101_open>: runtime->hw =
snd_omap_alsa_tsc2101_playback
<snd_omap_alsa_tsc2101_hw_params>: snd_omap_alsa_tsc2101_hw_params(),
size = 131072
XXX Alsa debug f:snd_omap_alsa_tsc2101_prepare, l:694
XXX Alsa debug f:omap_alsa_tsc2101_set_samplerate, l:263
<omap_alsa_tsc2101_set_samplerate>: selected 44.1khz PLL
<snd_omap_alsa_tsc2101_trigger>: cmd = 1
<audio_process_dma>: started,  offset = 0, dma_size = 8192, s->period =
0, s->periods = 0, s->dma_q_head = 0, s->offset = 0, rt->buffer_size =
32768, rt->period_size = 2048, rt->frame_bits = 32, runtime->dma_addr =
0, dma_ptr = -1024065536
[omap_start_alsa_sound_dma]: start
<omap_start_alsa_sound_dma>: stream_id = playback, dma_ptr =
-1024065536, dma_size = 8192
[audio_set_dma_params_play]: start
[audio_set_dma_params_play]: end(0)
[audio_start_dma_chain]: start
XXX Alsa debug f:audio_ifc_stop, l:244
XXX Alsa debug f:audio_ifc_start, l:237
[audio_start_dma_chain]: end(0)
[omap_start_alsa_sound_dma]: end(0)
<audio_process_dma>: done, offset = 0, dma_size = 8192, s->period = 0,
s->periods = 1, s->dma_q_head = 0, s->offset = 0, rt->buffer_size =
32768, rt->period_size = 2048, rt->frame_bits = 32, runtime->dma_addr =
0, dma_ptr = -1024065536
<sound_dma_irq_handler>: started, lch = 0, status = 0x20, dma_status =
32, data = c0b4b80c
<sound_dma_irq_handler>: status = DCSR_END_BLOCK, calling
audio_dma_callback()
<audio_dma_callback>: s->active, calling snd_pcm_period_elapsed
<audio_get_dma_pos>: count = 6150, s->dma_q_head = 0, s->offset = 0,
s->period = 1, s->periods = 1, rt->buffer_size = 32768, rt->period_size
= 2048, rt->frame_bits = 32, runtime->dma_addr = 0, offset = -1537,
dma_ptr = -1024067073
<audio_get_dma_pos>: offsetFrame= 0, countFrame = 1537
<audio_get_dma_pos>: warning, resetted offset to 0, old offset val = 0
<audio_process_dma>: started,  offset = 8192, dma_size = 8192, s->period
= 1, s->periods = 0, s->dma_q_head = 0, s->offset = 0, rt->buffer_size =
32768, rt->period_size = 2048, rt->frame_bits = 32, runtime->dma_addr =
0, dma_ptr = -1024057344
[omap_start_alsa_sound_dma]: start
<omap_start_alsa_sound_dma>: stream_id = playback, dma_ptr =
-1024057344, dma_size = 8192
[audio_set_dma_params_play]: start
[audio_set_dma_params_play]: end(0)
[audio_start_dma_chain]: start
[audio_start_dma_chain]: end(0)
[omap_start_alsa_sound_dma]: end(0)
<audio_process_dma>: done, offset = 8192, dma_size = 8192, s->period =
1, s->periods = 1, s->dma_q_head = 0, s->offset = 8192, rt->buffer_size
= 32768, rt->period_size = 2048, rt->frame_bits = 32, runtime->dma_addr
= 0, dma_ptr = -1024057344
<sound_dma_irq_handler>: done
<audio_get_dma_pos>: count = 6150, s->dma_q_head = 0, s->offset = 8192,
s->period = 2, s->periods = 1, rt->buffer_size = 32768, rt->period_size
= 2048, rt->frame_bits = 32, runtime->dma_addr = 0, offset = 511,
dma_ptr = -1024065025
<audio_get_dma_pos>: offsetFrame= 2048, countFrame = 1537
ALSA
/home/lamikr/own/h6300/eclipsewk/h6300_dev/sound/core/pcm_lib.c:2231:
playback write error (DMA or IRQ trouble?)
<snd_omap_alsa_tsc2101_trigger>: cmd = 0
XXX Alsa debug f:audio_stop_dma, l:496
[omap_alsa_audio_stop_dma]: start
[omap_alsa_audio_stop_dma]: end(0)
[omap_clear_alsa_sound_dma]: start
[omap_clear_alsa_sound_dma]: end(0)
XXX Alsa debug f:snd_card_omap_alsa_tsc2101_close, l:793
