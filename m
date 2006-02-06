From: Daniel Petrini <d.pensator@gmail.com>
Subject: Re: omap alsa tsc2101 driver
Date: Mon, 6 Feb 2006 18:01:15 -0400
Message-ID: <9268368b0602061401m4522d31v258f0f67f19509ef@mail.gmail.com>
References: <43E66CF6.8040600@cc.jyu.fi>
	<9268368b0602061113n30e8c49bx756de24a1eaf93c6@mail.gmail.com>
	<43E7AEC3.3020901@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5896_12779150.1139263275047"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <43E7AEC3.3020901@cc.jyu.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: lamikr@cc.jyu.fi
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_5896_12779150.1139263275047
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Mika,

On 2/6/06, lamikr <lamikr@cc.jyu.fi> wrote:
> Hi Petrini
>
> That sounds good for me, I am happy from anything that works and can try
> to continue from that :-)

Great!

> Can you give more info from your driver like is it already using DMA, is
> it using headset or normal speakers for playing, etc?
> In addition do you have sources available somewhere so I could check
> whether your code works also with my device?

Yes, I am sending it right now (I have just updated my tree). Please
note that it is really work in progress code, with remaining debug
printks and so on. I will clean up soon.
Try to make it work w/ your device, you will have to change the board*
file accordingly H2 or osk in this patch.

>
> It should be possible to take the existing mixer part from my code to
> your driver. As I have not yet been able to play songs properly, I have
> sofar only been able to test the volume and mute/unmute settings from
> the Mixers Digital Gain Control (DGC) properly.
> Headset and handset parts seems to act ok, but only time will tell
> whether they really work. But if I can get your driver to play with my
> device, I could continue from that.

Let me know if you can play sounds with this patch so that I will
prepare it to receive your mixer then you can debug it

> I think there will also be a need for a somekind of "temp/work"
> repository for helping to synchronize the our (and possible others)
> work, but I think we can resolve that later.

Yeah, maybe we can try to keep sending pathes privetely in order to
don't mess the list to much, unless we got a server somewhere.

Please let me know if this patch works for you.
The idea was to change omap-alsa-aic23.c to omap-alsa.c and use
separate codec files for board dependent functions and data. Dma and
mcbsp functions should remain untouched.

> Mika
>

Daniel

> Daniel Petrini wrote:
>
> >Hi Mika,
> >
> >I have been working in this ALSA driver as well, and I have a
> >functional patch that plays songs but lacks the mixer support yet.
> >What do you think of join the drivers to make it work faster?
> >I am developing it generically in order to take advantage of existing
> >common code as dma and alsa generic.
> >
> >Daniel
> >
> >On 2/5/06, lamikr <lamikr@cc.jyu.fi> wrote:
> >
> >
> >>Hi
> >>
> >>I have not seen anyone working with the tsc2101 Alsa driver, so attache=
d
> >>are the tsc2101 alsa driver sources I have been working for a while. Th=
e
> >>patch should apply to the omap-driver head. Unfortunately it is still
> >>non-functional at least with my omap 1510 based iPAQ h6340.
> >>
> >>I can hear small start of the song but then nothing happens. I have
> >>tried to debug the code and I can see that the the driver is able to ge=
t
> >>one callback to sound_dma_irq_handler with DSCR_END_BLOCK set, but afte=
r
> >>it does not continue with a next period of code.
> >>
> >>Here is some info from the driver
> >>- all code is located in /sound/arm/omap as I have wanted to mix it to
> >>existing aic23 code until this one works
> >>- based on to aic23 Alsa and tsc2101 OSS drivers. DMA code and driver
> >>base taken from the aic, but hardware initialization taken from the
> >>tsc2101 oss driver. (dma has only small changes like 16 bit mono to
> >>capture params instead of 32 bit ones supported in the aic23)
> >>- mixer code for DGC, headset and handset
> >>- debug is mostly printed by using DPRINTK() function and can be enable=
d
> >>by uncommenting "#define DEBUG 1" from the omap-alsa.h
> >>- This is platform driver, so you need to register it to your board-cod=
e
> >>in arch/arm/mach-omap1/board-* in a following way:
> >>        static struct platform_device h6300_mcbsp1_device =3D {
> >>                    .name        =3D "omap_tsc2101_mcbsp",
> >>                    .id        =3D 1,
> >>            };
> >>
> >>        static struct platform_device *h6300_devices[] __initdata =3D {
> >>                ...
> >>                &h6300_mcbsp1_device,
> >>        };
> >>
> >>I have only tested this with omap1510 based iPAQ h6300, so I would
> >>appreciate if somebody else could test this with other
> >>devices having tsc2101 chipset to find out whether this is just my hw
> >>specific problem. (Fixes would ofcource also be nice :-)
> >>
> >>For testing the driver I have plugged headset and listened the result o=
f
> >>following commands
> >>- aplay song.wav (44100 hz 16 bit little endion format)
> >>- "speaker-test -r 8000", "-r 44100", etc...
> >>
> >>I have also tryed to change the audio_get_dma_pos() method to be like i=
n
> >>the sa11xx-uda1341.c driver. With implementation
> >>based on to that, the speaker-test is able to produce somekind of
> >>periodic "wuff <silence> wuff <silence> wuff..." sound.
> >>(that method version is commented out in the omap-alsa-tsc2101.c)
> >>
> >>In addition to sources, attached is the log from one play attempt.
> >>
> >>Mika
> >>
> >>root@h6300:~# aplay free_breakbeat.wav
> >>Playing WAVE 'free_breakbeat.wav' : Signed 16 bit Little Endian, Rate
> >>44100 Hz, Stereo
> >>aplay: pcm_write:1146: write error: Input/output error
> >>root@h6300:~# dmesg
> >>XXX Alsa debug f:omap_alsa_tsc2101_init, l:1157
> >>XXX Alsa debug f:snd_omap_alsa_tsc2101_probe, l:1077
> >>XXX Alsa debug f:snd_card_omap_alsa_tsc2101_pcm, l:845
> >>XXX Alsa debug f:omap_alsa_tsc2101_audio_init, l:350
> >>XXX Alsa debug f:audio_dma_request, l:385
> >>[omap_request_alsa_sound_dma]: start
> >>[omap_request_alsa_sound_dma]: end(0)
> >>XXX Alsa debug f:audio_dma_request, l:385
> >>[omap_request_alsa_sound_dma]: start
> >>[omap_request_alsa_sound_dma]: end(0)
> >>[snd_omap_init_mixer]: start
> >>[setRecordSource]: start
> >>[setRecordSource]: end(0)
> >>[snd_omap_init_mixer]: end(0)
> >>OMAP_ALSA_TSC2101 audio support initialized
> >><omap_alsa_tsc2101_clock_on>: clock use count =3D 0
> >><omap_alsa_tsc2101_clock_on>: old clock rate =3D 12000000
> >>omap_alsa_tsc2101_clock_on(), no need to change clock rate, rate alread=
y
> >>12000000 Hz.
> >><omap_alsa_tsc2101_clock_on>: MCLK =3D 12000000 [12000000], usecount =
=3D 1,
> >>clk_enable retval =3D 0
> >><snd_card_omap_alsa_tsc2101_open>: runtime->hw =3D
> >>snd_omap_alsa_tsc2101_playback
> >><snd_omap_alsa_tsc2101_hw_params>: snd_omap_alsa_tsc2101_hw_params(),
> >>size =3D 131072
> >>XXX Alsa debug f:snd_omap_alsa_tsc2101_prepare, l:686
> >>XXX Alsa debug f:omap_alsa_tsc2101_set_samplerate, l:248
> >><omap_alsa_tsc2101_set_samplerate>: selected 44.1khz PLL
> >><snd_omap_alsa_tsc2101_trigger>: cmd =3D 1
> >><audio_process_dma>: started,  offset =3D 0, dma_size =3D 8192, s->peri=
od =3D
> >>0, s->periods =3D 0, s->dma_q_head =3D 0, s->offset =3D 0, rt->buffer_s=
ize =3D
> >>32768, rt->period_size =3D 2048, rt->frame_bits =3D 32, runtime->dma_ad=
dr =3D
> >>0, dma_ptr =3D -1042022400
> >>[omap_start_alsa_sound_dma]: start
> >><omap_start_alsa_sound_dma>: stream_id =3D playback, dma_ptr =3D
> >>-1042022400, dma_size =3D 8192
> >>[audio_set_dma_params_play]: start
> >>[audio_set_dma_params_play]: end(0)
> >>[audio_start_dma_chain]: start
> >>XXX Alsa debug f:audio_ifc_stop, l:229
> >>XXX Alsa debug f:audio_ifc_start, l:222
> >>[audio_start_dma_chain]: end(0)
> >>[omap_start_alsa_sound_dma]: end(0)
> >><audio_process_dma>: done, offset =3D 0, dma_size =3D 8192, s->period =
=3D 0,
> >>s->periods =3D 1, s->dma_q_head =3D 0, s->offset =3D 0, rt->buffer_size=
 =3D
> >>32768, rt->period_size =3D 2048, rt->frame_bits =3D 32, runtime->dma_ad=
dr =3D
> >>0, dma_ptr =3D -1042022400
> >><audio_get_dma_pos>: count =3D 6150, s->dma_q_head =3D 0, s->offset =3D=
 0,
> >>s->period =3D 1, s->periods =3D 1, rt->buffer_size =3D 32768, rt->perio=
d_size
> >>=3D 2048, rt->frame_bits =3D 32, runtime->dma_addr =3D 0, offset =3D -1=
537,
> >>dma_ptr =3D -1042023937
> >><audio_get_dma_pos>: offsetFrame=3D 0, countFrame =3D 1537
> >><audio_get_dma_pos>: warning, resetted offset to 0, old offset val =3D =
0
> >><sound_dma_irq_handler>: started, lch =3D 0, status =3D 0x20, dma_statu=
s =3D
> >>32, data =3D c0b0608c
> >><sound_dma_irq_handler>: status =3D DCSR_END_BLOCK, calling
> >>audio_dma_callback()
> >><audio_dma_callback>: s->active, calling snd_pcm_period_elapsed
> >><audio_get_dma_pos>: count =3D 6150, s->dma_q_head =3D 0, s->offset =3D=
 0,
> >>s->period =3D 1, s->periods =3D 1, rt->buffer_size =3D 32768, rt->perio=
d_size
> >>=3D 2048, rt->frame_bits =3D 32, runtime->dma_addr =3D 0, offset =3D -1=
537,
> >>dma_ptr =3D -1042023937
> >><audio_get_dma_pos>: offsetFrame=3D 0, countFrame =3D 1537
> >><audio_get_dma_pos>: warning, resetted offset to 0, old offset val =3D =
0
> >><audio_process_dma>: started,  offset =3D 8192, dma_size =3D 8192, s->p=
eriod
> >>=3D 1, s->periods =3D 0, s->dma_q_head =3D 0, s->offset =3D 0, rt->buff=
er_size =3D
> >>32768, rt->period_size =3D 2048, rt->frame_bits =3D 32, runtime->dma_ad=
dr =3D
> >>0, dma_ptr =3D -1042014208
> >>[omap_start_alsa_sound_dma]: start
> >><omap_start_alsa_sound_dma>: stream_id =3D playback, dma_ptr =3D
> >>-1042014208, dma_size =3D 8192
> >>[audio_set_dma_params_play]: start
> >>[audio_set_dma_params_play]: end(0)
> >>[audio_start_dma_chain]: start
> >>[audio_start_dma_chain]: end(0)
> >>[omap_start_alsa_sound_dma]: end(0)
> >><audio_process_dma>: done, offset =3D 8192, dma_size =3D 8192, s->perio=
d =3D
> >>1, s->periods =3D 1, s->dma_q_head =3D 0, s->offset =3D 8192, rt->buffe=
r_size
> >>=3D 32768, rt->period_size =3D 2048, rt->frame_bits =3D 32, runtime->dm=
a_addr
> >>=3D 0, dma_ptr =3D -1042014208
> >><sound_dma_irq_handler>: done
> >>ALSA
> >>/home/lamikr/own/h6300/git/linux-omap-h6300-2.6/sound/core/pcm_lib.c:22=
31:
> >>playback write error (DMA or IRQ trouble?)
> >><snd_omap_alsa_tsc2101_trigger>: cmd =3D 0
> >>XXX Alsa debug f:audio_stop_dma, l:488
> >>[omap_alsa_audio_stop_dma]: start
> >>[omap_alsa_audio_stop_dma]: end(0)
> >>[omap_clear_alsa_sound_dma]: start
> >>[omap_clear_alsa_sound_dma]: end(0)
> >>XXX Alsa debug f:snd_card_omap_alsa_tsc2101_close, l:785
> >><omap_alsa_tsc2101_clock_off>: clock use count =3D 1
> >><omap_alsa_tsc2101_clock_off>: clock rate =3D 12000000
> >><omap_alsa_tsc2101_clock_off>: clock disabled
> >><omap_alsa_tsc2101_clock_off>: audio codec off
> >>
> >>
> >>
> >>_______________________________________________
> >>Linux-omap-open-source mailing list
> >>Linux-omap-open-source@linux.omap.com
> >>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >>
> >>
> >>
> >>
> >>
> >>
> >
> >
> >--
> >INdT - Manaus - Brazil
> >
> >
> >
>
>


--
INdT - Manaus - Brazil

------=_Part_5896_12779150.1139263275047
Content-Type: text/x-patch; name=alsa_patch-h2-osk20060206.patch;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejdbrbzk
Content-Disposition: attachment; filename="alsa_patch-h2-osk20060206.patch"

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 4cc6a31..ead9ac9 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -41,6 +41,7 @@
 #include <asm/arch/usb.h>
 #include <asm/arch/keypad.h>
 #include <asm/arch/common.h>
+#include <asm/arch/mcbsp.h>
 
 extern int omap_gpio_init(void);
 
@@ -271,12 +272,48 @@ static struct platform_device h2_irda_de
 	.resource	= h2_irda_resources,
 };
 
+static struct omap_mcbsp_config mcbsp1_config = {
+	.mcbsp_regs = { 
+		.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
+		.spcr1 = RINTM(3) | RRST,
+		.rcr2  = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
+			 RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(1),
+		.rcr1  = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
+		.xcr2  = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
+			 XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(1) | XFIG,
+		.xcr1  = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
+		.srgr1 = FWID(15),
+		.srgr2 = GSYNC | CLKSP | FSGM | FPER(31),
+
+		.pcr0  = CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
+		//.pcr0 = CLKXP | CLKRP,	/* mcbsp: slave */
+	},
+	.codec_configure_dev	= tsc2101_configure,
+	.codec_set_samplerate	= tsc2101_set_samplerate,
+	.codec_clock_setup	= tsc2101_clock_setup,
+	.codec_clock_on		= tsc2101_clock_on,
+	.codec_clock_off	= tsc2101_clock_off,
+	.codec_write		= audio_tsc2101_write,
+	.codec_read		= audio_tsc2101_read,
+	.init_audio_controls 	= tsc2101_init_audio_controls,
+
+};
+
+static struct platform_device h2_mcbsp1_device = {
+	.name 		= "omap_mcbsp",
+	.id		= 1,
+	.dev = {
+		.platform_data = &mcbsp1_config,
+	},
+};
+
 static struct platform_device *h2_devices[] __initdata = {
 	&h2_nor_device,
 	&h2_nand_device,
 	&h2_smc91x_device,
 	&h2_irda_device,
 	&h2_kp_device,
+	&h2_mcbsp1_device,
 };
 
 static void __init h2_init_smc91x(void)
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 9d6098b..fb716df 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -148,10 +148,46 @@ static struct platform_device osk5912_cf
 	.num_resources	= ARRAY_SIZE(osk5912_cf_resources),
 	.resource	= osk5912_cf_resources,
 };
+static struct platform_device h2_smc91x_device = {
+	.name		= "smc91x",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(h2_smc91x_resources),
+	.resource	= h2_smc91x_resources,
+};
+
+static struct omap_mcbsp_config mcbsp1_config = {
+	.mcbsp_regs = { 
+		.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
+		.spcr1 = RINTM(3) | RRST,
+		.rcr2  = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
+			 RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(1),
+		.rcr1  = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
+		.xcr2  = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
+			 XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(1) | XFIG,
+		.xcr1  = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
+		.srgr1 = FWID(15),
+		.srgr2 = GSYNC | CLKSP | FSGM | FPER(31),
 
-static struct platform_device osk5912_mcbsp1_device = {
-	.name		= "omap_mcbsp",
+		.pcr0  = CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
+		//.pcr0 = CLKXP | CLKRP,	/* mcbsp: slave */
+	},
+	.codec_configure_dev	= tsc2101_configure,
+	.codec_set_samplerate	= tsc2101_set_samplerate,
+	.codec_clock_setup	= tsc2101_clock_setup,
+	.codec_clock_on		= tsc2101_clock_on,
+	.codec_clock_off	= tsc2101_clock_off,
+	.codec_write		= audio_tsc2101_write,
+	.codec_read		= audio_tsc2101_read,
+	.init_audio_controls 	= tsc2101_init_audio_controls,
+
+};
+
+static struct platform_device h2_mcbsp1_device = {
+	.name 		= "omap_mcbsp",
 	.id		= 1,
+	.dev = {
+		.platform_data = &mcbsp1_config,
+	},
 };
 
 static struct resource osk5912_kp_resources[] = {
diff --git a/include/asm-arm/arch-omap/mcbsp.h b/include/asm-arm/arch-omap/mcbsp.h
index d97e031..1b2c95c 100644
--- a/include/asm-arm/arch-omap/mcbsp.h
+++ b/include/asm-arm/arch-omap/mcbsp.h
@@ -312,4 +312,39 @@ void omap_mcbsp_set_spi_mode(unsigned in
 int omap_mcbsp_pollread(unsigned int id, u16 * buf);
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
 
+/* Codecs -  must leave soon */
+//#include "../../../sound/arm/alsa-omap.h"
+struct codec_controls;
+/* for alsa driver must leave */
+struct omap_mcbsp_config {
+	struct	omap_mcbsp_reg_cfg	 mcbsp_regs;
+	void	(*codec_configure_dev)(void);
+	void	(*codec_set_samplerate)(long, unsigned int *);
+	void	(*codec_clock_setup)(void);
+	int	(*codec_clock_on)(void);
+	int 	(*codec_clock_off)(void);
+	void 	(*codec_write)(u8 address, u16 data);
+	void	(*codec_read) (u8 address);
+	void 	(*init_audio_controls) (struct codec_controls *);
+	
+
+};
+
+
+inline void aic23_configure(void);
+void aic23_set_samplerate(long rate, unsigned int rates[]);
+void aic23_clock_setup(void);
+int aic23_clock_on(void);
+int aic23_clock_off(void);
+void audio_aic23_write(u8, u16);
+void aic23_init_audio_controls(struct codec_controls * controls);
+
+inline void tsc2101_configure(void);
+void tsc2101_set_samplerate(long rate, unsigned int rates[]);
+void tsc2101_clock_setup(void);
+int tsc2101_clock_on(void);
+int tsc2101_clock_off(void);
+void audio_tsc2101_write(u8, u16);
+u16 audio_tsc2101_read(u8);
+void tsc2101_init_audio_controls(struct codec_controls * controls);
 #endif
diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index cf07154..f2e7577 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -7,6 +7,7 @@ config SND_SA11XX_UDA1341
 	tristate "SA11xx UDA1341TS driver (iPaq H3600)"
 	depends on ARCH_SA1100 && SND && L3
 	select SND_PCM
+	select SND_GENERIC_DRIVER
 	help
 	  Say Y here if you have a Compaq iPaq H3x00 handheld computer
 	  and want to use its Philips UDA 1341 audio chip.
@@ -45,4 +46,17 @@ config SND_OMAP_AIC23
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-omap-aic23.
 
+config SND_OMAP_TSC2101
+	tristate "OMAP TSC2101 alsa driver (H2)"
+	depends on ARCH_OMAP && SND
+	select SND_PCM
+        select OMAP_TSC2101
+        select OMAP_UWIRE if ARCH_OMAP
+	help
+	  Say Y here if you have a H2 platform board
+	  and want to use its TSC2101 audio chip.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-omap-alsa-tsc2101.
+
 endmenu
diff --git a/sound/arm/Makefile b/sound/arm/Makefile
index 019a9f0..1215b88 100644
--- a/sound/arm/Makefile
+++ b/sound/arm/Makefile
@@ -14,5 +14,8 @@ snd-pxa2xx-pcm-objs		:= pxa2xx-pcm.o
 obj-$(CONFIG_SND_PXA2XX_AC97)	+= snd-pxa2xx-ac97.o
 snd-pxa2xx-ac97-objs		:= pxa2xx-ac97.o
 
-obj-$(CONFIG_SND_OMAP_AIC23) += snd-omap-aic23.o
-snd-omap-aic23-objs := omap-aic23.o omap-alsa-dma.o omap-alsa-mixer.o
+obj-$(CONFIG_SND_OMAP_AIC23) += snd-omap-alsa-aic23.o
+snd-omap-alsa-aic23-objs := omap-alsa.o omap-alsa-dma.o omap-alsa-mixer.o omap-alsa-aic23.o 
+
+obj-$(CONFIG_SND_OMAP_TSC2101) += snd-omap-alsa-tsc2101.o
+snd-omap-alsa-tsc2101-objs := omap-alsa.o omap-alsa-dma.o omap-alsa-mixer.o omap-alsa-tsc2101.o 
diff --git a/sound/arm/omap-aic23.h b/sound/arm/omap-aic23.h
index c8ab42c..ff7385c 100644
--- a/sound/arm/omap-aic23.h
+++ b/sound/arm/omap-aic23.h
@@ -44,6 +44,7 @@
 #include <asm/arch/dma.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <asm/arch/mcbsp.h>
 
 #define DEFAULT_OUTPUT_VOLUME         0x60
 #define DEFAULT_INPUT_VOLUME          0x00	/* 0 ==> mute line in */
@@ -93,7 +94,7 @@ struct audio_stream {
 /*
  * Alsa card structure for aic23
  */
-struct snd_card_omap_aic23 {
+struct snd_card_omap_codec {
 	snd_card_t *card;
 	snd_pcm_t *pcm;
 	long samplerate;
@@ -103,17 +104,21 @@ struct snd_card_omap_aic23 {
 /*********** Function Prototypes *************************/
 
 void audio_dma_callback(void *);
-int snd_omap_mixer(struct snd_card_omap_aic23 *);
-void snd_omap_init_mixer(void);
+int snd_omap_mixer(struct snd_card_omap_codec *);
+void snd_omap_init_mixer(struct omap_mcbsp_config *);
 /* Clock functions */
 int omap_aic23_clock_on(void);
 int omap_aic23_clock_off(void);
+ /* ADDED functions - H2/LDM port */
+void omap_codec_set_samplerate(struct snd_card_omap_codec * , long rate, unsigned int rates[]);
+inline void codec_configure(void);
 
 #ifdef CONFIG_PM
 void snd_omap_suspend_mixer(void);
 void snd_omap_resume_mixer(void);
 #endif
 
+#if 0
 /* Codec AIC23 */
 #if defined(CONFIG_SENSORS_TLV320AIC23) || defined (CONFIG_SENSORS_TLV320AIC23_MODULE)
 
@@ -126,5 +131,5 @@ static __inline__ void audio_aic23_write
 }
 
 #endif /* CONFIG_SENSORS_TLV320AIC23 */
-
+#endif
 #endif
diff --git a/sound/arm/omap-alsa-aic23.c b/sound/arm/omap-alsa-aic23.c
new file mode 100644
index 0000000..6f7feef
--- /dev/null
+++ b/sound/arm/omap-alsa-aic23.c
@@ -0,0 +1,255 @@
+
+/*
+ * sound/arm/omap-alsa-aic23.c
+ * 
+ * Alsa codec Driver for AIC23 codec on OSK5912 platform board
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * Written by Daniel Petrini (d.pensator@gmail.com)
+ * 
+ * Based in former alsa driver for osk and oss driver
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+//#include <linux/config.h>
+//#include <sound/driver.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+#include <asm/hardware/clock.h>
+#include <asm/arch/aic23.h>
+#include "omap-aic23.h"
+#include "omap-alsa.h"
+
+#include "omap-alsa-mixer.h"
+
+/* Define to set the AIC23 as the master w.r.t McBSP */
+#define AIC23_MASTER
+
+#define NUMBER_SAMPLE_RATES_SUPPORTED 10
+
+static struct clk *aic23_mclk = 0;
+
+struct sample_rate_rate_reg_info {
+	u8 control;		/* SR3, SR2, SR1, SR0 and BOSR */
+	u8 divider;		/* if 0 CLKIN = MCLK, if 1 CLKIN = MCLK/2 */
+};
+
+/* aic23 related */
+static const struct sample_rate_rate_reg_info
+ rate_reg_info[NUMBER_SAMPLE_RATES_SUPPORTED] = {
+	{0x06, 1},		/*  4000 */
+	{0x06, 0},		/*  8000 */
+	{0x0C, 1},		/* 16000 */
+	{0x11, 1},              /* 22050 */
+	{0x00, 1},		/* 24000 */
+	{0x0C, 0},		/* 32000 */
+	{0x11, 0},		/* 44100 */
+	{0x00, 0},		/* 48000 */
+	{0x1F, 0},		/* 88200 */
+	{0x0E, 0},		/* 96000 */
+};
+/*
+ * Codec/mcbsp init and configuration section
+ * codec dependent code.
+ */
+
+extern int tlv320aic23_write_value(u8 reg, u16 value);
+
+/* TLV320AIC23 is a write only device */
+__inline__ void audio_aic23_write(u8 address, u16 data)
+{
+	tlv320aic23_write_value(address, data);
+}
+
+
+/*
+ * Sample rate changing
+ */
+void aic23_set_samplerate(long rate, unsigned int rates[])
+{
+	u8 count = 0;
+	u16 data = 0;
+
+	/* Fix the rate if it has a wrong value */
+	if (rate >= 96000)
+		rate = 96000;
+	else if (rate >= 88200)
+		rate = 88200;
+	else if (rate >= 48000)
+		rate = 48000;
+	else if (rate >= 44100)
+		rate = 44100;
+	else if (rate >= 32000)
+		rate = 32000;
+	else if (rate >= 24000)
+		rate = 24000;
+	else if (rate >= 22050)
+		rate = 22050;
+	else if (rate >= 16000)
+		rate = 16000;
+	else if (rate >= 8000)
+		rate = 8000;
+	else
+		rate = 4000;
+
+	/* Search for the right sample rate */
+	/* Verify what happens if the rate is not supported
+	 * now it goes to 96Khz */
+	while ((rates[count] != rate) &&
+	       (count < (NUMBER_SAMPLE_RATES_SUPPORTED - 1))) {
+		count++;
+	}
+
+	data = (rate_reg_info[count].divider << CLKIN_SHIFT) |
+	    (rate_reg_info[count].control << BOSR_SHIFT) | USB_CLK_ON;
+
+	audio_aic23_write(SAMPLE_RATE_CONTROL_ADDR, data);
+
+}
+
+
+inline void aic23_configure(void)
+{
+	/* Reset codec */
+	audio_aic23_write(RESET_CONTROL_ADDR, 0);
+
+	/* Initialize the AIC23 internal state */
+
+	/* Analog audio path control, DAC selected, delete INSEL_MIC for line in */
+	audio_aic23_write(ANALOG_AUDIO_CONTROL_ADDR, DEFAULT_ANALOG_AUDIO_CONTROL);
+
+	/* Digital audio path control, de-emphasis control 44.1kHz */
+	audio_aic23_write(DIGITAL_AUDIO_CONTROL_ADDR, DEEMP_44K);
+
+	/* Digital audio interface, master/slave mode, I2S, 16 bit */
+//#ifdef AIC23_MASTER
+	audio_aic23_write(DIGITAL_AUDIO_FORMAT_ADDR,
+			  MS_MASTER | IWL_16 | FOR_DSP);
+//#else
+//	audio_aic23_write(DIGITAL_AUDIO_FORMAT_ADDR, IWL_16 | FOR_DSP);
+//#endif
+
+	/* Enable digital interface */
+	audio_aic23_write(DIGITAL_INTERFACE_ACT_ADDR, ACT_ON);
+
+
+	printk(KERN_ERR  "\n\n TESTE 2 \n\n");
+
+}
+
+/*
+ *  Omap MCBSP clock configuration
+ *  
+ *  Here we have some functions that allows clock to be enabled and
+ *   disabled only when needed. Besides doing clock configuration 
+ *   it allows turn on/turn off audio when necessary. 
+ */
+#define CODEC_CLOCK                   12000000
+#define AUDIO_RATE_DEFAULT	      44100
+
+/*
+ * Do clock framework mclk search
+ */
+void aic23_clock_setup(void)
+{
+	aic23_mclk = clk_get(0, "mclk");
+}
+
+/*
+ * Do some sanity check, set clock rate, starts it and
+ *  turn codec audio on 
+ */
+int aic23_clock_on(void)
+{
+	if (clk_get_usecount(aic23_mclk) > 0) {
+		/* MCLK is already in use */
+		printk(KERN_WARNING
+		       "MCLK in use at %d Hz. We change it to %d Hz\n",
+		       (uint) clk_get_rate(aic23_mclk),
+		       CODEC_CLOCK);
+	}
+	
+	if (clk_set_rate(aic23_mclk, CODEC_CLOCK)) {
+		printk(KERN_ERR
+		       "Cannot set MCLK for AIC23 CODEC\n");
+		return -ECANCELED;
+	}
+
+	clk_use(aic23_mclk);
+
+	printk(KERN_DEBUG
+		"MCLK = %d [%d], usecount = %d\n",
+	       (uint) clk_get_rate(aic23_mclk), CODEC_CLOCK,
+	       clk_get_usecount(aic23_mclk));
+
+	/* Now turn the audio on */
+	audio_aic23_write(POWER_DOWN_CONTROL_ADDR, 
+			  ~DEVICE_POWER_OFF & ~OUT_OFF & ~DAC_OFF &
+			  ~ADC_OFF & ~MIC_OFF & ~LINE_OFF);
+	
+	return 0;
+}
+/*
+ * Do some sanity check, turn clock off and then turn
+ *  codec audio off
+ */
+int aic23_clock_off(void)
+{
+	if  (clk_get_usecount(aic23_mclk) > 0) { 
+		if (clk_get_rate(aic23_mclk) != CODEC_CLOCK) {
+			printk(KERN_WARNING
+			       "MCLK for audio should be %d Hz. But is %d Hz\n",
+			       (uint) clk_get_rate(aic23_mclk),
+			       CODEC_CLOCK);
+		}
+
+		clk_unuse(aic23_mclk);
+	}
+	
+	audio_aic23_write(POWER_DOWN_CONTROL_ADDR,
+			  DEVICE_POWER_OFF | OUT_OFF | DAC_OFF |
+			  ADC_OFF | MIC_OFF | LINE_OFF);	
+	return 0;
+}
+
+/*
+ * Mixer part
+ */
+snd_kcontrol_new_t snd_omap_controls[] = {
+	OMAP_DOUBLE("PCM Playback Switch", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
+		     PCM_INDEX, 0x00),
+	OMAP_DOUBLE("PCM Playback Volume", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
+		     PCM_INDEX, OUTPUT_VOLUME_MASK),
+	OMAP_BOOL("Line Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, BYPASS_ON, 0),
+	OMAP_DOUBLE("Line Capture Switch", 0, LEFT_LINE_VOLUME_ADDR, RIGHT_LINE_VOLUME_ADDR,
+		     LINE_INDEX, 0x00),
+	OMAP_DOUBLE("Line Capture Volume", 0, LEFT_LINE_VOLUME_ADDR, RIGHT_LINE_VOLUME_ADDR,
+		     LINE_INDEX, INPUT_VOLUME_MASK),	
+	OMAP_BOOL("Mic Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, STE_ENABLED, 0),	
+	OMAP_SINGLE("Mic Playback Volume", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, 5, SIDETONE_MASK),
+	OMAP_BOOL("Mic Capture Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICM_MUTED, 1),
+	OMAP_BOOL("Mic Booster Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICB_20DB, 0),
+	OMAP_MUX("Capture Source", ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, INSEL_MIC),
+};
+int omap_controls_size = ARRAY_SIZE(snd_omap_controls);
+
+
+void aic23_init_audio_controls(struct codec_controls * mixer_controls)
+{
+	mixer_controls->left_vol_output = DEFAULT_OUTPUT_VOLUME;
+	mixer_controls->right_vol_output = DEFAULT_OUTPUT_VOLUME;
+	mixer_controls->left_line_input = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
+	mixer_controls->right_line_input = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
+	mixer_controls->mic_input = 0;
+	mixer_controls->left_vol_address = LEFT_CHANNEL_VOLUME_ADDR;
+	mixer_controls->right_vol_address = RIGHT_CHANNEL_VOLUME_ADDR;
+	mixer_controls->left_line_address = LEFT_LINE_VOLUME_ADDR;
+	mixer_controls->right_line_address = RIGHT_LINE_VOLUME_ADDR;
+}
diff --git a/sound/arm/omap-alsa-mixer.c b/sound/arm/omap-alsa-mixer.c
index 742e5b6..63cf1fe 100644
--- a/sound/arm/omap-alsa-mixer.c
+++ b/sound/arm/omap-alsa-mixer.c
@@ -39,41 +39,56 @@
 
 #include <linux/config.h>
 #include <sound/driver.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/ioctl.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-
-#include <asm/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/arch/dma.h>
+//#include <linux/module.h>
+//#include <linux/device.h>
+//#include <linux/init.h>
+//#include <linux/errno.h>
+//#include <linux/ioctl.h>
+//#include <linux/delay.h>
+//#include <linux/slab.h>
+
+//#include <asm/hardware.h>
+//#include <asm/mach-types.h>
+//#include <asm/arch/dma.h>
 #include <asm/arch/aic23.h>
 
 #include "omap-aic23.h"
 #include <sound/initval.h>
 #include <sound/control.h>
 
+#include <asm/arch/mcbsp.h>
+#include "omap-alsa.h"
+#include "omap-alsa-mixer.h"
+
 MODULE_AUTHOR("David Cohen, Daniel Petrini - INdT");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("OMAP Alsa mixer driver for ALSA");
 
+struct omap_mcbsp_config * pldata = NULL;
+struct codec_controls mixer_controls;
 /*
  * Codec dependent region
  */
 
 /* Codec AIC23 */
-#if defined(CONFIG_SENSORS_TLV320AIC23) || defined (CONFIG_SENSORS_TLV320AIC23_MODULE)
+//#if defined(CONFIG_SENSORS_TLV320AIC23) || defined (CONFIG_SENSORS_TLV320AIC23_MODULE)
+#if defined(CONFIG_SND_OMAP_AIC23)
 
 extern __inline__ void audio_aic23_write(u8, u16);
 
 #define MIXER_NAME		     "Mixer AIC23"
 #define SND_OMAP_WRITE(reg, val)     audio_aic23_write(reg, val)
 
-#endif
+#else
+
+//extern __inline__ void audio_tsc2101_write(u8 address, u16 data);
 
+#define MIXER_NAME		     "Mixer TSC2101"
+//#define SND_OMAP_WRITE(reg, val)     audio_tsc2101_write(reg, val)
+#define SND_OMAP_WRITE(reg, val)     pldata->codec_write(reg, val)
+
+#endif
+#if 0
 /* Callback Functions */
 #define OMAP_BOOL(xname, xindex, reg, reg_index, mask, invert) \
 { \
@@ -117,14 +132,9 @@ extern __inline__ void audio_aic23_write
 	.put = snd_omap_put_double, \
 	.private_value = left_reg | (right_reg << 8) | (reg_index << 16) | (mask << 18) \
 }
+#endif
 
 /* Local Registers */
-enum snd_device_index {
-	PCM_INDEX = 0,
-	LINE_INDEX,
-	AAC_INDEX, /* Analog Audio Control: reg = l_reg */
-};
-
 struct {
 	u16 l_reg;
 	u16 r_reg;
@@ -150,7 +160,7 @@ u16 snd_sidetone[6] = {
 
 /* Begin Bool Functions */
 
-static int snd_omap_info_bool(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+int snd_omap_info_bool(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;
@@ -160,7 +170,7 @@ static int snd_omap_info_bool(snd_kcontr
 	return 0;
 }
 
-static int snd_omap_get_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+int snd_omap_get_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	int mic_index = (kcontrol->private_value >> 8) & 0x03;
 	u16 mask = (kcontrol->private_value >> 12) & 0xff;
@@ -174,7 +184,7 @@ static int snd_omap_get_bool(snd_kcontro
 	return 0;
 }
 
-static int snd_omap_put_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+int snd_omap_put_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	int mic_index = (kcontrol->private_value >> 8) & 0x03;
 	u16 mask = (kcontrol->private_value >> 12) & 0xff;
@@ -203,7 +213,7 @@ static int snd_omap_put_bool(snd_kcontro
 
 /* Begin Mux Functions */
 
-static int snd_omap_info_mux(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+int snd_omap_info_mux(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	/* Mic = 0
 	 * Line = 1 */
@@ -211,7 +221,7 @@ static int snd_omap_info_mux(snd_kcontro
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
+	uinfo->value.enumerated.items = 1/*2 VOLTE AQUI*/;
 	
 	if (uinfo->value.enumerated.item > 1)
 		uinfo->value.enumerated.item = 1;
@@ -221,7 +231,7 @@ static int snd_omap_info_mux(snd_kcontro
 	return 0;
 }
 
-static int snd_omap_get_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+int snd_omap_get_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	u16 mask = (kcontrol->private_value >> 10) & 0xff;
 	int mux_index = (kcontrol->private_value >> 8) & 0x03;
@@ -231,7 +241,7 @@ static int snd_omap_get_mux(snd_kcontrol
 	return 0;
 }
 
-static int snd_omap_put_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+int snd_omap_put_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	u16 reg = kcontrol->private_value & 0xff;
 	u16 mask = (kcontrol->private_value >> 10) & 0xff;
@@ -253,7 +263,7 @@ static int snd_omap_put_mux(snd_kcontrol
 
 /* Begin Single Functions */
 
-static int snd_omap_info_single(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+int snd_omap_info_single(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	int mask = (kcontrol->private_value >> 18) & 0xff;
 	int reg_val = (kcontrol->private_value >> 8) & 0xff;
@@ -266,7 +276,7 @@ static int snd_omap_info_single(snd_kcon
 	return 0;
 }
 
-static int snd_omap_get_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+int snd_omap_get_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	u16 reg_val = (kcontrol->private_value >> 8) & 0xff;
 
@@ -275,7 +285,7 @@ static int snd_omap_get_single(snd_kcont
 	return 0;
 }
 
-static int snd_omap_put_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+int snd_omap_put_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	u16 reg_index = (kcontrol->private_value >> 16) & 0x03;
 	u16 mask = (kcontrol->private_value >> 18) & 0x1ff;
@@ -305,7 +315,7 @@ static int snd_omap_put_single(snd_kcont
 
 /* Begin Double Functions */
 
-static int snd_omap_info_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+int snd_omap_info_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	/* mask == 0 : Switch
 	 * mask != 0 : Volume */
@@ -319,7 +329,7 @@ static int snd_omap_info_double(snd_kcon
 	return 0;
 }
 
-static int snd_omap_get_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+int snd_omap_get_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	/* mask == 0 : Switch
 	 * mask != 0 : Volume */
@@ -339,7 +349,7 @@ static int snd_omap_get_double(snd_kcont
 	return 0;
 }
 
-static int snd_omap_put_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+int snd_omap_put_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	/* mask == 0 : Switch
 	 * mask != 0 : Volume */
@@ -393,7 +403,7 @@ static int snd_omap_put_double(snd_kcont
 }
 
 /* End Double Functions */
-
+#if 0
 static snd_kcontrol_new_t snd_omap_controls[] = {
 	OMAP_DOUBLE("PCM Playback Switch", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
 		     PCM_INDEX, 0x00),
@@ -410,11 +420,18 @@ static snd_kcontrol_new_t snd_omap_contr
 	OMAP_BOOL("Mic Booster Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICB_20DB, 0),
 	OMAP_MUX("Capture Source", ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, INSEL_MIC),
 };
+#endif
+extern snd_kcontrol_new_t snd_omap_controls[];
+extern int omap_controls_size;
 
-void snd_omap_init_mixer(void)
+void snd_omap_init_mixer(struct omap_mcbsp_config *pdata)
 {
 	u16 vol_reg;
 
+	pldata = pdata;
+
+	pldata->init_audio_controls(&mixer_controls);
+#if 0
 	/* Line's default values */
 	omap_regs[LINE_INDEX].l_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
 	omap_regs[LINE_INDEX].r_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
@@ -434,6 +451,28 @@ void snd_omap_init_mixer(void)
 	omap_regs[PCM_INDEX].sw = 1;
 	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR, vol_reg);
 	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR, vol_reg);
+#endif
+
+	/*Line's default values */
+	omap_regs[LINE_INDEX].l_reg = mixer_controls.left_line_input;
+	omap_regs[LINE_INDEX].r_reg = mixer_controls.right_line_input;
+	omap_regs[LINE_INDEX].sw = 0;
+	SND_OMAP_WRITE(mixer_controls.left_line_address, mixer_controls.left_line_input);
+	SND_OMAP_WRITE(mixer_controls.right_line_address,  mixer_controls.right_line_input);
+
+	/* Analog Audio Control's default values */
+	omap_regs[AAC_INDEX].l_reg = DEFAULT_ANALOG_AUDIO_CONTROL;
+
+	/* Headphone's default values */
+	omap_regs[PCM_INDEX].l_reg = mixer_controls.left_vol_output;
+	omap_regs[PCM_INDEX].r_reg = mixer_controls.right_vol_output;
+	omap_regs[PCM_INDEX].sw = 1;
+//	SND_OMAP_WRITE(mixer_controls.left_vol_address, mixer_controls.left_vol_output);
+//	SND_OMAP_WRITE(mixer_controls.right_vol_address, mixer_controls.right_vol_output);
+	SND_OMAP_WRITE(mixer_controls.right_vol_address, 0x0f0f);
+
+	printk("Volume:::::::::: %d %d %d %d \n", mixer_controls.left_vol_output, mixer_controls.right_vol_output,
+			mixer_controls.left_vol_address, mixer_controls.right_vol_address);
 }
 
 #ifdef CONFIG_PM
@@ -474,7 +513,7 @@ void snd_omap_resume_mixer(void)
 }
 #endif
 
-int snd_omap_mixer(struct snd_card_omap_aic23 *chip)
+int snd_omap_mixer(struct snd_card_omap_codec *chip)
 {
 	snd_card_t *card;
 	unsigned int idx;
@@ -487,7 +526,7 @@ int snd_omap_mixer(struct snd_card_omap_
 	strcpy(card->mixername, MIXER_NAME);
 
 	/* Registering alsa mixer controls */
-	for (idx = 0; idx < ARRAY_SIZE(snd_omap_controls); idx++) 
+	for (idx = 0; idx < omap_controls_size/*ARRAY_SIZE(snd_omap_controls)*/; idx++) 
 		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_omap_controls[idx], chip))) < 0)
 			return err;
 
diff --git a/sound/arm/omap-alsa-mixer.h b/sound/arm/omap-alsa-mixer.h
new file mode 100644
index 0000000..02cf761
--- /dev/null
+++ b/sound/arm/omap-alsa-mixer.h
@@ -0,0 +1,72 @@
+
+#include <sound/initval.h>
+#include <sound/control.h>
+
+enum snd_device_index {
+	PCM_INDEX = 0,
+	LINE_INDEX,
+	AAC_INDEX, /* Analog Audio Control: reg = l_reg */
+};
+
+
+int snd_omap_info_bool(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo);
+int snd_omap_get_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
+int snd_omap_put_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
+int snd_omap_info_mux(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo);
+int snd_omap_get_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
+int snd_omap_put_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
+int snd_omap_info_single(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo);
+int snd_omap_get_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
+int snd_omap_put_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
+int snd_omap_info_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo);
+int snd_omap_get_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
+int snd_omap_put_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
+
+
+
+
+
+/* Callback Functions */
+#define OMAP_BOOL(xname, xindex, reg, reg_index, mask, invert) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_omap_info_bool, \
+	.get = snd_omap_get_bool, \
+	.put = snd_omap_put_bool, \
+	.private_value = reg | (reg_index << 8) | (invert << 10) | (mask << 12) \
+}
+
+#define OMAP_MUX(xname, reg, reg_index, mask) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.info = snd_omap_info_mux, \
+	.get = snd_omap_get_mux, \
+	.put = snd_omap_put_mux, \
+	.private_value = reg | (reg_index << 8) | (mask << 10) \
+}
+
+#define OMAP_SINGLE(xname, xindex, reg, reg_index, reg_val, mask) \
+{\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_omap_info_single, \
+	.get = snd_omap_get_single, \
+	.put = snd_omap_put_single, \
+	.private_value = reg | (reg_val << 8) | (reg_index << 16) | (mask << 18) \
+}
+
+#define OMAP_DOUBLE(xname, xindex, left_reg, right_reg, reg_index, mask) \
+{\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_omap_info_double, \
+	.get = snd_omap_get_double, \
+	.put = snd_omap_put_double, \
+	.private_value = left_reg | (right_reg << 8) | (reg_index << 16) | (mask << 18) \
+}
+
diff --git a/sound/arm/omap-alsa-tsc2101.c b/sound/arm/omap-alsa-tsc2101.c
new file mode 100644
index 0000000..58fc3ac
--- /dev/null
+++ b/sound/arm/omap-alsa-tsc2101.c
@@ -0,0 +1,471 @@
+
+/* routines extracted from file oss/omap-audio-tsc2101.c
+ * or called from drivers/ssi/omap-tsc2101.c */
+
+//#include <linux/module.h>
+//#include <linux/init.h>
+//#include <linux/errno.h>
+//#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/soundcard.h>
+//#include <asm/hardware.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+#include <linux/clk.h>
+#include <asm/io.h>
+#include <asm/arch/mcbsp.h>
+
+#include <asm/hardware/tsc2101.h>
+#include <../drivers/ssi/omap-tsc2101.h>
+
+#include "omap-alsa.h"
+#include "omap-alsa-mixer.h"
+
+/*
+ * AUDIO related MACROS
+ */
+#define DEFAULT_BITPERSAMPLE          16
+#define AUDIO_RATE_DEFAULT	          44100
+#define PAGE2_AUDIO_CODEC_REGISTERS   (2)
+#define LEAVE_CS 			          0x80
+
+/* Tsc Audio Specific */
+#define NUMBER_SAMPLE_RATES_SUPPORTED 16
+#define OUTPUT_VOLUME_MIN 0x7F
+#define OUTPUT_VOLUME_MAX 0x32
+#define OUTPUT_VOLUME_RANGE           (OUTPUT_VOLUME_MIN - OUTPUT_VOLUME_MAX)
+#define OUTPUT_VOLUME_MASK            OUTPUT_VOLUME_MIN
+#define DEFAULT_VOLUME_LEVEL          OUTPUT_VOLUME_MAX
+
+/* use input vol of 75 for 0dB gain */
+#define INPUT_VOLUME_MIN 		      0x0
+#define INPUT_VOLUME_MAX	 0x7D
+#define INPUT_VOLUME_RANGE 		      (INPUT_VOLUME_MAX - INPUT_VOLUME_MIN)
+#define INPUT_VOLUME_MASK 		      INPUT_VOLUME_MAX
+
+#define DEFAULT_VOLUME            20/*93*/
+#define DEFAULT_INPUT_VOLUME	  20	/* An minimal volume */
+typedef struct {
+	u8	volume;
+	u8	line;
+	u8	mic;
+	int	recsrc;
+	int	mod_cnt;
+} tsc2101_local_info;
+
+static tsc2101_local_info tsc2101_local = {
+	volume:		DEFAULT_VOLUME,
+	line:		DEFAULT_INPUT_VOLUME,
+	mic:		DEFAULT_INPUT_VOLUME,
+	recsrc:		SOUND_MASK_LINE,
+	mod_cnt:	0
+};
+
+
+#define AUDIO_MCBSP                   OMAP_MCBSP1
+
+/* Define to set the tsc as the master w.r.t McBSP */
+#define TSC_MASTER
+
+#define SET_VOLUME 			          1
+#define SET_LINE   			          2
+#define SET_MIC	      3
+#define SET_RECSRC	      4
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define ADEBUG() printk("XXX Alsa debug f:%s, l:%d\n", __FUNCTION__, __LINE__)
+#else
+#define ADEBUG()		/* nop */
+#endif
+
+
+//deve sair....
+static int tsc2101_update(int flag, int val);
+
+static struct clk *tsc2101_mclk = 0;
+
+struct sample_rate_reg_info {
+	u16 sample_rate;
+	u8  divisor;
+	u8  fs_44kHz;		/* if 0 48 khz, if 1 44.1 khz fsref */
+};
+
+/* To Store the default sample rate */
+static long audio_samplerate = AUDIO_RATE_DEFAULT;
+
+static const struct sample_rate_reg_info
+ reg_info[NUMBER_SAMPLE_RATES_SUPPORTED] = {
+	/* Div 1 */
+	{48000, 0, 0},
+	{44100, 0, 1},
+	/* Div 1.5 */
+	{32000, 1, 0},
+	{29400, 1, 1},
+	/* Div 2 */
+	{24000, 2, 0},
+	{22050, 2, 1},
+	/* Div 3 */
+	{16000, 3, 0},
+	{14700, 3, 1},
+	/* Div 4 */
+	{12000, 4, 0},
+	{11025, 4, 1},
+	/* Div 5 */
+	{9600, 5, 0},
+	{8820, 5, 1},
+	/* Div 5.5 */
+	{8727, 6, 0},
+	{8018, 6, 1},
+	/* Div 6 */
+	{8000, 7, 0},
+	{7350, 7, 1},
+};
+
+/*
+ * Codec/mcbsp init and configuration section
+ * codec dependent code.
+ */
+
+/*********************************************************************************
+ *
+ * Simplified write for tsc Audio
+ *
+ *********************************************************************************/
+/*inline*/ void audio_tsc2101_write(u8 address, u16 data)
+{
+	printk("WR: ad:0x%x data:0x%x\n", address, data);
+	omap_tsc2101_write(PAGE2_AUDIO_CODEC_REGISTERS, address, data);
+}
+
+/*********************************************************************************
+ *
+ * Simplified read for tsc  Audio
+ *
+ *********************************************************************************/
+__inline__ u16 audio_tsc2101_read(u8 address)
+{
+	return (omap_tsc2101_read(PAGE2_AUDIO_CODEC_REGISTERS, address));
+}
+
+/*
+ * Sample rate changing
+ */
+void tsc2101_set_samplerate(long sample_rate, unsigned int rates[])
+{
+
+	u8 count = 0;
+	u16 data = 0;
+	int clkgdv = 0;
+
+	u16 srgr1, srgr2;
+	/* wait for any frame to complete */
+	udelay(125);
+	ADEBUG();
+
+	/* Search for the right sample rate */
+	while ((reg_info[count].sample_rate != sample_rate) &&
+	       (count < NUMBER_SAMPLE_RATES_SUPPORTED)) {
+		count++;
+	}
+	if (count == NUMBER_SAMPLE_RATES_SUPPORTED) {
+		printk(KERN_ERR "Invalid Sample Rate %d requested\n",
+		       (int)sample_rate);
+		return; // -EPERM;
+	}
+
+	/* Set AC1 */
+	data = audio_tsc2101_read(TSC2101_AUDIO_CTRL_1);
+	/*Clear prev settings */
+	data &= ~(AC1_DACFS(0x07) | AC1_ADCFS(0x07));
+	data |=
+	    AC1_DACFS(reg_info[count].divisor) | AC1_ADCFS(reg_info[count].
+							   divisor);
+	audio_tsc2101_write(TSC2101_AUDIO_CTRL_1, data);
+
+	/* Set the AC3 */
+	data = audio_tsc2101_read(TSC2101_AUDIO_CTRL_3);
+	/*Clear prev settings */
+	data &= ~(AC3_REFFS | AC3_SLVMS);
+	data |= (reg_info[count].fs_44kHz) ? AC3_REFFS : 0;
+#ifdef TSC_MASTER
+	data |= AC3_SLVMS;
+#endif				/* #ifdef TSC_MASTER */
+	audio_tsc2101_write(TSC2101_AUDIO_CTRL_3, data);
+
+	/* program the PLLs */
+	if (reg_info[count].fs_44kHz) {
+		/* 44.1 khz - 12 MHz Mclk */
+		audio_tsc2101_write(TSC2101_PLL_PROG_1, PLL1_PLLSEL | PLL1_PVAL(1) | PLL1_I_VAL(7));	/* PVAL 1; I_VAL 7 */
+		audio_tsc2101_write(TSC2101_PLL_PROG_2, PLL2_D_VAL(0x1490));	/* D_VAL 5264 */
+	} else {
+		/* 48 khz - 12 Mhz Mclk */
+		audio_tsc2101_write(TSC2101_PLL_PROG_1, PLL1_PLLSEL | PLL1_PVAL(1) | PLL1_I_VAL(8));	/* PVAL 1; I_VAL 8 */
+		audio_tsc2101_write(TSC2101_PLL_PROG_2, PLL2_D_VAL(0x780));	/* D_VAL 1920 */
+	}
+
+	audio_samplerate = sample_rate;
+
+	/* Set the sample rate */
+#ifndef TSC_MASTER
+	clkgdv =
+	    DEFAULT_MCBSP_CLOCK / (sample_rate *
+				   (DEFAULT_BITPERSAMPLE * 2 - 1));
+	if (clkgdv)
+		//initial_config.srgr1 =
+		srgr1 = 
+		    (FWID(DEFAULT_BITPERSAMPLE - 1) | CLKGDV(clkgdv));
+	else
+		return (1);
+
+	/* Stereo Mode */
+	//initial_config.srgr2 =
+	srgr2 = 
+	    (CLKSM | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1));
+#else
+	//initial_config.srgr1 =
+	srgr1 = 
+	    (FWID(DEFAULT_BITPERSAMPLE - 1) | CLKGDV(clkgdv));
+	//initial_config.srgr2 =
+	srgr2 = 
+	    ((GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1)));
+
+#endif				/* end of #ifdef TSC_MASTER */
+	//omap_mcbsp_config(AUDIO_MCBSP, &initial_config);
+	
+	OMAP_MCBSP_WRITE(OMAP1610_MCBSP1_BASE, SRGR2, srgr2);
+	OMAP_MCBSP_WRITE(OMAP1610_MCBSP1_BASE, SRGR1, srgr1);
+
+	
+//#define OMAP1610_MCBSP1_BASE	0xe1011800
+
+}
+
+
+inline void tsc2101_configure(void)
+{
+	ADEBUG();
+
+	audio_tsc2101_write(TSC2101_CODEC_POWER_CTRL, 0x0000);
+
+	/*Mute Analog Sidetone */
+	/*Select MIC_INHED input for headset */
+	/*Cell Phone In not connected */
+	audio_tsc2101_write(TSC2101_MIXER_PGA_CTRL,
+			    MPC_ASTMU | MPC_ASTG(0x40) | MPC_MICADC);
+
+	/* Set record source */
+	tsc2101_update(SET_RECSRC, tsc2101_local.recsrc);
+
+	/* ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled */
+	/* 1dB AGC hysteresis */
+	/* MICes bias 2V */
+	audio_tsc2101_write(TSC2101_AUDIO_CTRL_4, AC4_MB_HED(0));
+
+	/* Set codec output volume */
+	audio_tsc2101_write(TSC2101_DAC_GAIN_CTRL, 0x0000);
+
+	/* DAC left and right routed to SPK2 */
+	/* SPK1/2 unmuted */
+	audio_tsc2101_write(TSC2101_AUDIO_CTRL_5,
+			    AC5_DAC2SPK1(3) | AC5_AST2SPK1 | AC5_KCL2SPK1 |
+			    AC5_DAC2SPK2(3) | AC5_AST2SPK2 | AC5_KCL2SPK2 |
+			    AC5_HDSCPTC);
+
+	/* OUT8P/N muted, CPOUT muted */
+
+	audio_tsc2101_write(TSC2101_AUDIO_CTRL_6,
+			    AC6_MUTLSPK | AC6_MUTSPK2 | AC6_LDSCPTC |
+			    AC6_VGNDSCPTC);
+
+	/* Headset/Hook switch detect disabled */
+	audio_tsc2101_write(TSC2101_AUDIO_CTRL_7, 0x0000);
+
+	/* Left line input volume control */
+	tsc2101_update(SET_LINE, tsc2101_local.line);
+
+	/* mic input volume control */
+	tsc2101_update(SET_MIC, tsc2101_local.mic);
+
+	/* Left/Right headphone channel volume control */
+	/* Zero-cross detect on */
+	tsc2101_update(SET_VOLUME, tsc2101_local.volume);
+
+	/* clock configuration */
+	tsc2101_set_samplerate(audio_samplerate, NULL);
+
+//#ifdef TSC_DUMP_REGISTERS
+//	tsc2101_dumpRegisters();
+//#endif
+
+	printk(KERN_ERR  "\n\n TESTE 2 \n\n");
+
+}
+
+/*
+ *  Omap MCBSP clock configuration
+ *  
+ *  Here we have some functions that allows clock to be enabled and
+ *   disabled only when needed. Besides doing clock configuration 
+ *   it allows turn on/turn off audio when necessary. 
+ */
+#define CODEC_CLOCK 12000000
+/*
+ * Do clock framework mclk search
+ */
+void tsc2101_clock_setup(void)
+{
+	tsc2101_mclk = clk_get(0, "mclk");
+	ADEBUG();
+}
+
+/*
+ * Do some sanity check, set clock rate, starts it and
+ *  turn codec audio on 
+ */
+int tsc2101_clock_on(void)
+{
+	omap_tsc2101_enable(); /*  */
+
+	return 0;
+}
+/*
+ * Do some sanity check, turn clock off and then turn
+ *  codec audio off
+ */
+int tsc2101_clock_off(void)
+{
+	omap_tsc2101_disable();
+	
+	return 0;
+}
+
+static int tsc2101_update(int flag, int val)
+{
+	u16 volume;
+	u16 data;
+
+	//FN_IN;
+	ADEBUG();
+	switch (flag) {
+	case SET_VOLUME:
+		if (val < 0 || val > 100) {
+			printk(KERN_ERR "Trying a bad volume value(%d)!\n", val);
+			return -EPERM;
+		}
+		/* Convert 0 -> 100 volume to 0x7F(min) -> y(max) volume range */
+		volume =
+		    ((val * OUTPUT_VOLUME_RANGE) / 100) + OUTPUT_VOLUME_MAX;
+		/* invert the value for getting the proper range 0 min and 100 max */
+		volume = OUTPUT_VOLUME_MIN - volume;
+		data = audio_tsc2101_read(TSC2101_DAC_GAIN_CTRL);
+		data &=
+		    ~(DGC_DALVL(OUTPUT_VOLUME_MIN) |
+		      DGC_DARVL(OUTPUT_VOLUME_MIN));
+		data |= DGC_DALVL(volume) | DGC_DARVL(volume);
+		audio_tsc2101_write(TSC2101_DAC_GAIN_CTRL, data);
+		data = audio_tsc2101_read(TSC2101_DAC_GAIN_CTRL);
+
+		break;
+
+	case SET_LINE:
+		if (val < 0 || val > 100) {
+			printk(KERN_ERR "Trying a bad volume value(%d)!\n", val);
+			return -EPERM;
+		}
+		/* Convert 0 -> 100 volume to 0x0(min) -> 0x7D(max) volume range */
+		/* NOTE: 0 is minimum volume and not mute */
+		volume = ((val * INPUT_VOLUME_RANGE) / 100) + INPUT_VOLUME_MIN;
+		/* Handset Input not muted, AGC for Handset In off */
+		audio_tsc2101_write(TSC2101_HEADSET_GAIN_CTRL,
+	HGC_ADPGA_HED(volume));
+		break;
+
+	case SET_MIC:
+		if (val < 0 || val > 100) {
+			printk(KERN_ERR "Trying a bad volume value(%d)!\n", val);
+			return -EPERM;
+		}
+		/* Convert 0 -> 100 volume to 0x0(min) -> 0x7D(max) volume range */
+		/* NOTE: 0 is minimum volume and not mute */
+		volume = ((val * INPUT_VOLUME_RANGE) / 100) + INPUT_VOLUME_MIN;
+		/* Handset Input not muted, AGC for Handset In off */
+		audio_tsc2101_write(TSC2101_HANDSET_GAIN_CTRL,
+	HNGC_ADPGA_HND(volume));
+		break;
+
+	case SET_RECSRC:
+		/*
+		 * If more than one recording device selected,
+		 * disable the device that is currently in use.
+		 */
+		if (hweight32(val) > 1)
+			val &= ~tsc2101_local.recsrc;
+
+		data = audio_tsc2101_read(TSC2101_MIXER_PGA_CTRL);
+		data &= ~MPC_MICSEL(7); /* clear all MICSEL bits */
+
+		if (val == SOUND_MASK_MIC) {
+			data |=  MPC_MICSEL(1);
+			audio_tsc2101_write(TSC2101_MIXER_PGA_CTRL, data);
+		}
+		else if (val == SOUND_MASK_LINE) {
+			data |=  MPC_MICSEL(0);
+			audio_tsc2101_write(TSC2101_MIXER_PGA_CTRL, data);
+		}
+		else {
+			printk(KERN_WARNING "omap1610-tsc2101: Wrong RECSRC"
+	 " value specified\n");
+			return -EINVAL;
+		}
+		tsc2101_local.recsrc = val;
+		break;
+	default:
+		printk(KERN_WARNING "omap1610-tsc2101: Wrong tsc2101_update "
+	"flag specified\n");
+		break;
+	}
+
+	//FN_OUT(0);
+	return 0;
+}
+
+/*
+ * Mixer part
+ */
+
+/* NOT WORKING *** */
+snd_kcontrol_new_t snd_omap_controls[] = {
+	OMAP_DOUBLE("PCM Playback Switch", 0, TSC2101_DAC_GAIN_CTRL, TSC2101_DAC_GAIN_CTRL,
+		     PCM_INDEX, 0x00),
+	OMAP_DOUBLE("PCM Playback Volume", 0, TSC2101_DAC_GAIN_CTRL, TSC2101_DAC_GAIN_CTRL,
+		     PCM_INDEX, 0x7f/*OUTPUT_VOLUME_MASK*/),
+	//OMAP_BOOL("Line Playback Switch", 0, TSC2101_HEADSET_GAIN_CTRL, AAC_INDEX, 0x02/*mudeme*/, 0),
+	//OMAP_DOUBLE("Line Capture Switch", 0, TSC2101_HEADSET_GAIN_CTRL, TSC2101_HEADSET_GAIN_CTRL,
+	//	     LINE_INDEX, 0x00),
+	//OMAP_DOUBLE("Line Capture Volume", 0, TSC2101_HEADSET_GAIN_CTRL, TSC2101_HEADSET_GAIN_CTRL,
+	//	     LINE_INDEX, 0x7f/*INPUT_VOLUME_MASK*/),	
+	//OMAP_BOOL("Mic Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, STE_ENABLED, 0),	
+	//OMAP_SINGLE("Mic Playback Volume", 0, TSC2101_HANDSET_GAIN_CTRL, AAC_INDEX, 5, SIDETONE_MASK),
+	//OMAP_BOOL("Mic Capture Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICM_MUTED, 1),
+	//OMAP_BOOL("Mic Booster Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICB_20DB, 0),
+	//OMAP_MUX("Capture Source", ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, INSEL_MIC),
+};
+int omap_controls_size = ARRAY_SIZE(snd_omap_controls);
+
+void tsc2101_init_audio_controls(struct codec_controls * mixer_controls)
+{
+	mixer_controls->left_vol_output = 0x30;
+	mixer_controls->right_vol_output = 0x30;
+	mixer_controls->left_line_input = 0;
+	mixer_controls->right_line_input = 0;
+	mixer_controls->mic_input = 0;
+	mixer_controls->left_vol_address = TSC2101_DAC_GAIN_CTRL;
+	mixer_controls->right_vol_address = TSC2101_DAC_GAIN_CTRL;
+	mixer_controls->left_line_address = TSC2101_HEADSET_GAIN_CTRL;
+	mixer_controls->right_line_address = TSC2101_HEADSET_GAIN_CTRL;
+}
diff --git a/sound/arm/omap-alsa.c b/sound/arm/omap-alsa.c
new file mode 100644
index 0000000..ab56ac6
--- /dev/null
+++ b/sound/arm/omap-alsa.c
@@ -0,0 +1,757 @@
+/*
+ * sound/arm/omap-aic23.c
+ * 
+ * Alsa Driver for AIC23 codec on OSK5912 platform board
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * Written by Daniel Petrini, David Cohen, Anderson Briglia
+ *            {daniel.petrini, david.cohen, anderson.briglia}@indt.org.br
+ *
+ * Based on sa11xx-uda1341.c, 
+ * Copyright (C) 2002 Tomas Kasparek <tomas.kasparek@seznam.cz>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * History:
+ *
+ * 2005-07-29   INdT Kernel Team - Alsa driver for omap osk. Creation of new 
+ *                                 file omap-aic23.c
+ * 
+ * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
+ */
+
+#include <linux/config.h>
+#include <sound/driver.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/ioctl.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+#endif
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/arch/dma.h>
+#include <asm/arch/aic23.h>
+//#include <asm/hardware/clock.h>
+#include <asm/arch/mcbsp.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/memalloc.h>
+
+#include "omap-alsa-dma.h"
+#include "omap-aic23.h"
+
+#undef DEBUG
+//#define DEBUG
+
+#ifdef DEBUG
+#define ADEBUG() printk("XXX Alsa debug f:%s, l:%d\n", __FUNCTION__, __LINE__)
+#else
+#define ADEBUG()		/* nop */
+#endif
+
+/*
+ * AUDIO related MACROS
+ */
+#define DEFAULT_BITPERSAMPLE          16
+#define AUDIO_RATE_DEFAULT	      44100
+#define AUDIO_MCBSP                   OMAP_MCBSP1
+#define NUMBER_SAMPLE_RATES_SUPPORTED 10
+
+
+MODULE_AUTHOR("Daniel Petrini, David Cohen, Anderson Briglia - INdT");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("OMAP driver for ALSA");
+MODULE_SUPPORTED_DEVICE("{{AIC23,OMAP AIC23}}");
+MODULE_ALIAS("omap_mcbsp.1");
+
+static char *id = NULL;	
+MODULE_PARM_DESC(id, "OMAP ALSA Driver for AIC23 chip.");
+
+static struct snd_card_omap_codec *omap_alsa = NULL;
+
+struct omap_mcbsp_config * pdata = NULL;
+
+/*
+ * DAC USB-mode sampling rates (MCLK = 12 MHz)
+ * The rates and rate_reg_into MUST be in the same order
+ */
+static unsigned int rates[] = {
+	4000, 8000, 16000, 22050,
+	24000, 32000, 44100,
+	48000, 88200, 96000,
+};
+
+static snd_pcm_hw_constraint_list_t hw_constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list = rates,
+	.mask = 0,
+};
+
+/*
+ * HW interface start and stop helper functions
+ */
+static int audio_ifc_start(void)
+{
+	omap_mcbsp_start(AUDIO_MCBSP);
+	return 0;
+}
+
+static int audio_ifc_stop(void)
+{
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	return 0;
+}
+
+static void omap_alsa_audio_init(struct snd_card_omap_codec *omap_alsa)
+{
+	/* Setup DMA stuff */
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].id = "Alsa AIC23 out";
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].stream_id =
+	    SNDRV_PCM_STREAM_PLAYBACK;
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].dma_dev =
+	    OMAP_DMA_MCBSP1_TX;
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].hw_start =
+	    audio_ifc_start;
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].hw_stop =
+	    audio_ifc_stop;
+
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].id = "Alsa AIC23 in";
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].stream_id =
+	    SNDRV_PCM_STREAM_CAPTURE;
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].dma_dev =
+	    OMAP_DMA_MCBSP1_RX;
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].hw_start =
+	    audio_ifc_start;
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].hw_stop =
+	    audio_ifc_stop;
+}
+
+/* 
+ * DMA functions 
+ * Depends on omap-alsa-dma.c functions and (omap) dma.c
+ * 
+ */
+#define DMA_BUF_SIZE	1024 * 8
+
+static int audio_dma_request(struct audio_stream *s,
+			     void (*callback) (void *))
+{
+	int err;
+	ADEBUG();
+
+	err = omap_request_sound_dma(s->dma_dev, s->id, s, &s->lch);
+	if (err < 0)
+		printk(KERN_ERR "unable to grab audio dma 0x%x\n",
+		       s->dma_dev);
+	return err;
+}
+
+static int audio_dma_free(struct audio_stream *s)
+{
+	int err = 0;
+	ADEBUG();
+
+	err = omap_free_sound_dma(s, &s->lch);
+	if (err < 0)
+		printk(KERN_ERR "Unable to free audio dma channels!\n");
+	return err;
+}
+
+/*
+ *  This function should calculate the current position of the dma in the
+ *  buffer. It will help alsa middle layer to continue update the buffer.
+ *  Its correctness is crucial for good functioning.
+ */
+static u_int audio_get_dma_pos(struct audio_stream *s)
+{
+	snd_pcm_substream_t *substream = s->stream;
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	unsigned int offset;
+	unsigned long flags;
+	dma_addr_t count;
+	ADEBUG();
+
+	/* this must be called w/ interrupts locked as requested in dma.c */
+	spin_lock_irqsave(&s->dma_lock, flags);
+
+	/* For the current period let's see where we are */
+	count = omap_get_dma_src_addr_counter(s->lch[s->dma_q_head]);
+
+	spin_unlock_irqrestore(&s->dma_lock, flags);
+
+	/* Now, the position related to the end of that period */
+	offset = bytes_to_frames(runtime, s->offset) - bytes_to_frames(runtime, count);
+
+	if (offset >= runtime->buffer_size || offset < 0)
+		offset = 0;
+
+	return offset;
+}
+
+/*
+ * this stops the dma and clears the dma ptrs
+ */
+static void audio_stop_dma(struct audio_stream *s)
+{
+	unsigned long flags;
+	ADEBUG();
+
+	spin_lock_irqsave(&s->dma_lock, flags);
+	s->active = 0;
+	s->period = 0;
+	s->periods = 0;
+
+	/* this stops the dma channel and clears the buffer ptrs */
+	omap_audio_stop_dma(s);
+
+	omap_clear_sound_dma(s);
+
+	spin_unlock_irqrestore(&s->dma_lock, flags);
+}
+
+/*
+ *  Main dma routine, requests dma according where you are in main alsa buffer
+ */
+static void audio_process_dma(struct audio_stream *s)
+{
+	snd_pcm_substream_t *substream = s->stream;
+	snd_pcm_runtime_t *runtime;
+	unsigned int dma_size;
+	unsigned int offset;
+	int ret;
+	ADEBUG();
+
+	runtime = substream->runtime;
+	if (s->active) {
+		dma_size = frames_to_bytes(runtime, runtime->period_size);
+		offset = dma_size * s->period;
+		snd_assert(dma_size <= DMA_BUF_SIZE,);
+		ret =
+		    omap_start_sound_dma(s,
+					 (dma_addr_t) runtime->dma_area +
+					 offset, dma_size);
+		if (ret) {
+			printk(KERN_ERR
+			       "audio_process_dma: cannot queue DMA buffer (%i)\n",
+			       ret);
+			return;
+		}
+
+		s->period++;
+		s->period %= runtime->periods;
+		s->periods++;
+		s->offset = offset;
+	}
+}
+
+/* 
+ *  This is called when dma IRQ occurs at the end of each transmited block
+ */
+void audio_dma_callback(void *data)
+{
+	struct audio_stream *s = data;
+	ADEBUG();
+
+	/* 
+	 * If we are getting a callback for an active stream then we inform
+	 * the PCM middle layer we've finished a period
+	 */
+	if (s->active)
+		snd_pcm_period_elapsed(s->stream);
+
+	spin_lock(&s->dma_lock);
+	if (s->periods > 0) {
+		s->periods--;
+	}
+	audio_process_dma(s);
+	spin_unlock(&s->dma_lock);
+}
+
+
+/* 
+ * Alsa section
+ * PCM settings and callbacks
+ */
+
+static int snd_omap_alsa_trigger(snd_pcm_substream_t * substream, int cmd)
+{
+	struct snd_card_omap_codec *chip =
+	    snd_pcm_substream_chip(substream);
+	int stream_id = substream->pstr->stream;
+	struct audio_stream *s = &chip->s[stream_id];
+	int err = 0;
+	ADEBUG();
+
+	/* note local interrupts are already disabled in the midlevel code */
+	spin_lock(&s->dma_lock);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* requested stream startup */
+		s->active = 1;
+		audio_process_dma(s);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		/* requested stream shutdown */
+		audio_stop_dma(s);
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+	spin_unlock(&s->dma_lock);
+	
+	return err;
+}
+
+static int snd_omap_alsa_prepare(snd_pcm_substream_t * substream)
+{
+	struct snd_card_omap_codec *chip =
+	    snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	struct audio_stream *s = &chip->s[substream->pstr->stream];
+	ADEBUG();
+
+	/* set requested samplerate */
+	pdata->codec_set_samplerate(runtime->rate, &rates[0]);
+	chip->samplerate = runtime->rate;
+
+	s->period = 0;
+	s->periods = 0;
+
+	return 0;
+}
+
+static snd_pcm_uframes_t snd_omap_alsa_pointer(snd_pcm_substream_t *
+						substream)
+{
+	ADEBUG();
+	struct snd_card_omap_codec *chip =
+	    snd_pcm_substream_chip(substream);
+	
+	return audio_get_dma_pos(&chip->s[substream->pstr->stream]);
+}
+
+/* Hardware capabilities */
+
+static snd_pcm_hardware_t snd_omap_alsa_capture = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+		  SNDRV_PCM_RATE_KNOT),
+	.rate_min = 8000,
+	.rate_max = 96000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 128 * 1024,
+	.period_bytes_min = 32,
+	.period_bytes_max = 8 * 1024,
+	.periods_min = 16,
+	.periods_max = 255,
+	.fifo_size = 0,
+};
+
+static snd_pcm_hardware_t snd_omap_alsa_playback = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),	
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+		  SNDRV_PCM_RATE_KNOT),
+	.rate_min = 8000,
+	.rate_max = 96000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 128 * 1024,
+	.period_bytes_min = 32,
+	.period_bytes_max = 8 * 1024,
+	.periods_min = 16,
+	.periods_max = 255,
+	.fifo_size = 0,
+};
+
+static int snd_card_omap_alsa_open(snd_pcm_substream_t * substream)
+{
+	struct snd_card_omap_codec *chip =
+	    snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	int stream_id = substream->pstr->stream;
+	int err;
+	ADEBUG();
+
+	chip->s[stream_id].stream = substream;
+	
+	pdata->codec_clock_on();
+	
+	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK)
+		runtime->hw = snd_omap_alsa_playback;
+	else
+		runtime->hw = snd_omap_alsa_capture;
+	if ((err =
+	     snd_pcm_hw_constraint_integer(runtime,
+					   SNDRV_PCM_HW_PARAM_PERIODS)) <
+	    0)
+		return err;
+	if ((err =
+	     snd_pcm_hw_constraint_list(runtime, 0,
+					SNDRV_PCM_HW_PARAM_RATE,
+					&hw_constraints_rates)) < 0)
+		return err;
+
+	return 0;
+}
+
+static int snd_card_omap_alsa_close(snd_pcm_substream_t * substream)
+{
+	struct snd_card_omap_codec *chip =
+	    snd_pcm_substream_chip(substream);
+	ADEBUG();
+	
+	pdata->codec_clock_off();
+	chip->s[substream->pstr->stream].stream = NULL;
+	
+	return 0;
+}
+
+/* HW params & free */
+
+static int snd_omap_alsa_hw_params(snd_pcm_substream_t * substream,
+				    snd_pcm_hw_params_t * hw_params)
+{
+	return snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+}
+
+static int snd_omap_alsa_hw_free(snd_pcm_substream_t * substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+/* pcm operations */
+
+static snd_pcm_ops_t snd_card_omap_alsa_playback_ops = {
+	.open =		snd_card_omap_alsa_open,
+	.close =	snd_card_omap_alsa_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_omap_alsa_hw_params,
+	.hw_free =	snd_omap_alsa_hw_free,
+	.prepare =	snd_omap_alsa_prepare,
+	.trigger =	snd_omap_alsa_trigger,
+	.pointer =	snd_omap_alsa_pointer,
+};
+
+static snd_pcm_ops_t snd_card_omap_alsa_capture_ops = {
+	.open =		snd_card_omap_alsa_open,
+	.close =	snd_card_omap_alsa_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_omap_alsa_hw_params,
+	.hw_free =	snd_omap_alsa_hw_free,
+	.prepare =	snd_omap_alsa_prepare,
+	.trigger =	snd_omap_alsa_trigger,
+	.pointer =	snd_omap_alsa_pointer,
+};
+
+/*
+ *  Alsa init and exit section
+ *  
+ *  Inits pcm alsa structures, allocate the alsa buffer, suspend, resume
+ */
+static int __init snd_card_omap_alsa_pcm(struct snd_card_omap_codec
+					  *omap_alsa, int device)
+{
+	snd_pcm_t *pcm;
+	int err;
+	ADEBUG();
+
+	if ((err =
+	     snd_pcm_new(omap_alsa->card, "AIC23 PCM", device, 1, 1,
+			 &pcm)) < 0)
+		return err;
+
+	/* sets up initial buffer with continuous allocation */
+	snd_pcm_lib_preallocate_pages_for_all(pcm,
+					      SNDRV_DMA_TYPE_CONTINUOUS,
+					      snd_dma_continuous_data
+					      (GFP_KERNEL),
+					      128 * 1024, 128 * 1024);
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_card_omap_alsa_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+			&snd_card_omap_alsa_capture_ops);
+	pcm->private_data = omap_alsa;
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "omap aic23 pcm");
+
+	omap_alsa_audio_init(omap_alsa);
+
+	/* setup DMA controller */
+	audio_dma_request(&omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK],
+			  audio_dma_callback);
+	audio_dma_request(&omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE],
+			  audio_dma_callback);
+
+	omap_alsa->pcm = pcm;
+
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
+
+static int snd_omap_alsa_suspend(snd_card_t * card, pm_message_t state)
+{
+	struct snd_card_omap_codec *chip = card->private_data;
+	ADEBUG();
+
+	if (chip->card->power_state != SNDRV_CTL_POWER_D3hot) {
+		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
+		snd_pcm_suspend_all(chip->pcm);
+		/* Mutes and turn clock off */
+		pdata->codec_clock_off();
+		snd_omap_suspend_mixer();
+	}
+
+	return 0;
+}
+
+/*
+ *  Prepare hardware for resume
+ */
+static int snd_omap_alsa_resume(snd_card_t * card)
+{
+	struct snd_card_omap_codec *chip = card->private_data;
+	ADEBUG();
+	
+	if (chip->card->power_state != SNDRV_CTL_POWER_D0) {
+		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
+		pdata->codec_clock_on();
+		snd_omap_resume_mixer();
+	}
+
+	return 0;
+}
+
+/*
+ * Driver suspend/resume - calls alsa functions. Some hints from aaci.c
+ */
+static int omap_alsa_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	snd_card_t *card = platform_get_drvdata(pdev);
+	
+	if (card->power_state != SNDRV_CTL_POWER_D3hot) {
+		snd_omap_alsa_suspend(card, PMSG_SUSPEND);
+	}
+	return 0;
+}
+
+static int omap_alsa_resume(struct platform_device *pdev)
+{
+	snd_card_t *card = platform_get_drvdata(pdev);
+
+	if (card->power_state != SNDRV_CTL_POWER_D0) {
+		snd_omap_alsa_resume(card);
+	}
+	return 0;
+}
+
+#else
+#define snd_omap_alsa_suspend	NULL
+#define snd_omap_alsa_resume	NULL
+#define omap_alsa_suspend	NULL
+#define omap_alsa_resume	NULL
+
+#endif	/* CONFIG_PM */
+
+/* 
+ */
+void snd_omap_alsa_free(snd_card_t * card)
+{
+	struct snd_card_omap_codec *chip = card->private_data;
+	ADEBUG();
+	
+	/*
+	 * Turn off codec after it is done.
+	 * Can't do it immediately, since it may still have
+	 * buffered data.
+	 */
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(2);
+
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	omap_mcbsp_free(AUDIO_MCBSP);
+
+	//audio_aic23_write(RESET_CONTROL_ADDR, 0);
+	//audio_aic23_write(POWER_DOWN_CONTROL_ADDR, 0xff);
+
+	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_PLAYBACK]);
+	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_CAPTURE]);
+}
+
+/* module init & exit */
+
+/* 
+ *  Inits alsa soudcard structure
+ */
+static int __init snd_omap_alsa_probe(struct platform_device *pdev)
+{
+	int err = 0;
+	snd_card_t *card;
+	ADEBUG();
+
+	pdata = pdev->dev.platform_data;
+
+	if (pdata == NULL) {
+		err = -ENODEV;
+		goto nodev1;
+	}
+	
+	pdata->codec_clock_setup();
+	pdata->codec_clock_on(); 
+
+	omap_mcbsp_request(AUDIO_MCBSP);
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	omap_mcbsp_config(AUDIO_MCBSP, &pdata->mcbsp_regs);
+	omap_mcbsp_start(AUDIO_MCBSP);
+	
+	if (pdata && pdata->codec_configure_dev) {
+		pdata->codec_configure_dev();
+	}
+
+	pdata->codec_clock_off(); 
+
+	/* register the soundcard */
+	card = snd_card_new(-1, id, THIS_MODULE, sizeof(omap_alsa));
+	if (card == NULL)
+		goto nodev2;
+
+	omap_alsa = kcalloc(1, sizeof(*omap_alsa), GFP_KERNEL);
+	if (omap_alsa == NULL)
+		goto nodev3;
+
+	card->private_data = (void *) omap_alsa;
+	card->private_free = snd_omap_alsa_free;
+
+	omap_alsa->card = card;
+	omap_alsa->samplerate = AUDIO_RATE_DEFAULT;
+
+	spin_lock_init(&omap_alsa->s[0].dma_lock);
+	spin_lock_init(&omap_alsa->s[1].dma_lock);
+
+	/* mixer */
+	//if ((err = snd_omap_mixer(omap_alsa)) < 0) 
+	//	goto nodev4;
+
+	/* PCM */
+	if ((err = snd_card_omap_alsa_pcm(omap_alsa, 0)) < 0)
+		goto nodev4;
+
+	//snd_card_set_pm_callback(card, snd_omap_alsa_suspend,
+	//			 snd_omap_alsa_resume, omap_alsa);
+
+	strcpy(card->driver, "AIC23");
+	strcpy(card->shortname, "OSK AIC23");
+	sprintf(card->longname, "OMAP OSK with AIC23");
+
+	//snd_omap_init_mixer(pdata);
+
+	snd_card_set_dev(card, &pdev->dev);
+	
+	if ((err = snd_card_register(card)) == 0) {
+		printk(KERN_INFO "OSK audio support initialized\n");
+		platform_set_drvdata(pdev, card);
+		return 0;
+	}
+	
+	
+nodev4:
+	kfree(omap_alsa);	
+nodev3:	
+	snd_card_free(card);
+nodev2:
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	omap_mcbsp_free(AUDIO_MCBSP);
+nodev1:	
+	return err;
+}
+
+static int snd_omap_alsa_remove(struct platform_device *pdev)
+{
+	snd_card_t *card = platform_get_drvdata(pdev);
+	struct snd_card_omap_codec *chip = card->private_data;
+	
+	snd_card_free(card);
+
+	omap_alsa = NULL;
+	card->private_data = NULL;
+	kfree(chip);
+	
+	platform_set_drvdata(pdev, NULL);
+	
+	return 0;
+	
+}
+
+static struct platform_driver omap_alsa_driver = {
+	.probe =	snd_omap_alsa_probe,
+	.remove =	snd_omap_alsa_remove,
+	.suspend =	omap_alsa_suspend, 
+	.resume =	omap_alsa_resume, 
+	.driver = {
+		.name =	"omap_mcbsp",
+	},
+};
+
+static int __init omap_alsa_init(void)
+{
+	int err;
+	ADEBUG();
+
+	err = platform_driver_register(&omap_alsa_driver);
+
+	return err;
+}
+
+static void __exit omap_alsa_exit(void)
+{
+	ADEBUG();
+	
+	platform_driver_unregister(&omap_alsa_driver);
+}
+
+module_init(omap_alsa_init);
+module_exit(omap_alsa_exit);
+
diff --git a/sound/arm/omap-alsa.h b/sound/arm/omap-alsa.h
new file mode 100644
index 0000000..7867736
--- /dev/null
+++ b/sound/arm/omap-alsa.h
@@ -0,0 +1,16 @@
+
+/*
+ * struct that contais codec audio control values and registers address
+ *  to handle them (used by mixer)
+ */
+struct codec_controls {
+	u16	left_vol_output;
+	u16	right_vol_output;
+	u16	left_line_input;
+	u16	right_line_input;
+	u8	left_vol_address;
+	u8	right_vol_address;
+	u8	left_line_address;
+	u8	right_line_address;
+	u16 	mic_input;
+} ;


------=_Part_5896_12779150.1139263275047
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_5896_12779150.1139263275047--
