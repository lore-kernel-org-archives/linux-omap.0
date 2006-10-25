From: =?gb2312?B?TmluZ3pob25nIE1pYW8gLSDD58T+1tI=?= <Ningzhong.Miao@access-company.com>
Subject: A problem about tsc2101 omap audio alsa driver on H3 board
Date: Wed, 25 Oct 2006 20:49:32 +0800
Message-ID: <A091501C5752EE42A2FD8880B8EF192F3F87C0@njgex02.njg.access-company.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Kernel : 2.6.16

Patch: linux-2.6.16-omap1 from www.muru.com <http://www.muru.com/>=20

Board: omap1710 H3

Rootfs : NFS

=20

I don=A1=AFt know why don=A1=AFt define h3_mcbsp1_device in =
arch/arm/mach-omap1/borad-h3.c, but it is defined in board-h2.c.

So I copy the belowed data from board-h2.c to board-h3.c.=20

=20

static struct omap_mcbsp_reg_cfg mcbsp_regs =3D {

        .spcr2 =3D FREE | FRST | GRST | XRST | XINTM(3),

        .spcr1 =3D RINTM(3) | RRST,

        .rcr2  =3D RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |

                RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(1),

        .rcr1  =3D RFRLEN1(OMAP_MCBSP_WORD_8) | =
RWDLEN1(OMAP_MCBSP_WORD_16),

        .xcr2  =3D XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |

                XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(1) | XFIG,

        .xcr1  =3D XFRLEN1(OMAP_MCBSP_WORD_8) | =
XWDLEN1(OMAP_MCBSP_WORD_16),

        .srgr1 =3D FWID(15),

        .srgr2 =3D GSYNC | CLKSP | FSGM | FPER(31),

=20

        .pcr0  =3D CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,

        //.pcr0 =3D CLKXP | CLKRP,        /* mcbsp: slave */

};

=20

static struct omap_alsa_codec_config alsa_config =3D {

        .name                   =3D "H3 TSC2101",

        .mcbsp_regs_alsa        =3D &mcbsp_regs,

        .codec_configure_dev    =3D NULL, // tsc2101_configure,

        .codec_set_samplerate   =3D NULL, // tsc2101_set_samplerate,

        .codec_clock_setup      =3D NULL, // tsc2101_clock_setup,

        .codec_clock_on         =3D NULL, // tsc2101_clock_on,

        .codec_clock_off        =3D NULL, // tsc2101_clock_off,

        .get_default_samplerate =3D NULL, // =
tsc2101_get_default_samplerate,

};

=20

static struct platform_device h3_mcbsp1_device =3D {

        .name   =3D "omap_alsa_mcbsp",

        .id     =3D 1,

        .dev =3D {

                .platform_data  =3D &alsa_config,

        },

};

static struct platform_device *devices[] __initdata =3D {

        &nor_device,

        &nand_device,

        &smc91x_device,

        &intlat_device,

        &h3_irda_device,

        &h3_kp_device,

        &h3_lcd_device,

        &h3_mcbsp1_device,

};

=20

These codes need to be modified ? mcbsp_regs is same with h2 ??=20

Anyway, I don=A1=AFt modify anything.

I defined DEBUG in include/asm/arch/omap-alsa.h and defined =
CONFIG_MCBSP_DEBUG in arch/arm/plat-omap/mcbsp.c.

=20

Then I run aplay in H3 board.

[root@Linux /root]#alsa-lib/bin/aplay microsoft.wav

XXX Alsa debug f:snd_card_omap_alsa_open, l:315

<tsc2101_clock_on>: clock use count =3D 1

MCLK already in use at 12000000 Hz. We change it to 12000000 Hz

<tsc2101_clock_on>: old clock rate =3D 12000000

omap_alsa_tsc2101_clock_on(), no need to change rate, no need to change =
clock ra

te, rate already 12000000 Hz.

<tsc2101_clock_on>: MCLK =3D 12000000 [12000000], usecount =3D 2, =
clk_enable retval

=3D 0

Playing WAVE 'microsoft.wav' : Unsigned 8 bit, Rate 22050 Hz, Mono

XXX Alsa debug f:snd_omap_alsa_prepare, l:288

XXX Alsa debug f:tsc2101_set_samplerate, l:217

XXX Alsa debug f:snd_omap_alsa_trigger, l:260

XXX Alsa debug f:audio_process_dma, l:197

[omap_start_alsa_sound_dma]: start

[audio_set_dma_params_play]: start

[audio_set_dma_params_play]: end(0)

[audio_start_dma_chain]: start

**** MCBSP1 regs ****

DRR2:  0x0000

DRR1:  0x0000

DXR2:  0x0000

DXR1:  0x0000

SPCR2: 0x02f1

SPCR1: 0x0031

RCR2:  0x8041

RCR1:  0x0040

XCR2:  0x8045

XCR1:  0x0040

SRGR2: 0xd01f

SRGR1: 0x0f00

PCR0:  0x030f

***********************

[audio_start_dma_chain]: end(0)

[omap_start_alsa_sound_dma]: end(0)

XXX Alsa debug f:snd_omap_alsa_pointer, l:303

XXX Alsa debug f:audio_get_dma_pos, l:143

=20

The program died here, and earphone don=A1=AFt have any sound.

I have tried oss audio driver and 2.6.17 kernel. They are same.

=20

Anybody come across this problem ?? help me, thank you !

=20

=20
