From: RobertChou <rbtchc@gmail.com>
Subject: Help for omap2430sdp ALSA driver
Date: Thu, 18 Jan 2007 15:46:00 +0800
Message-ID: <dbf1574b0701172346n3a514c46hf4b94d0fef5722dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hi:

   I'm recently working on some audio applications on linux-2.6.14-omap2430sdp
downloaded from TI's webiste. And when I'm trying to config kernel with

 <*> Advanced Linux Sound Architecture
     ALSA ARM devices  --->
         <*> SOUND OMAP24XX_tsc2101 driver (24XX)

 the kernel compile will failed due to lack of "arm/arch/eac.h" header file.
Does anybody ever successfully build kernel w/ this driver?

Also, I'm wondering that according to the spec., OMAP2430-SDP uses
TWL4030 chip as audio device. Is it possible to run SOUND
OMAP24XX_tsc2101 driver to
drive TWL4030?? (the comment in the $SRC_DIR/sound/arm/Makefile says
it is the OMAP 2430SDP sound...)

If not... is there any available TWL4030 ALSA driver for us to download?

Thx a lot...

Robert 2007.1.18


Following is my kernel compile log...
--------------------------------------------------------------------------------------------
  CC      sound/sound_core.o
  CC      sound/sound_firmware.o
  LD      sound/soundcore.o
  CC      sound/arm/omap-tsc2101.o
sound/arm/omap-tsc2101.c:28:26: asm/arch/eac.h: No such file or directory
sound/arm/omap-tsc2101.c: In function `eac_init':
sound/arm/omap-tsc2101.c:132: error: `OMAP24XX_EAC_SYSCONFIG'
undeclared (first use in this function)
sound/arm/omap-tsc2101.c:132: error: (Each undeclared identifier is
reported only once
sound/arm/omap-tsc2101.c:132: error: for each function it appears in.)
sound/arm/omap-tsc2101.c:137: error: `OMAP24XX_EAC_AGCTR' undeclared
(first use in this function)
sound/arm/omap-tsc2101.c:138: warning: implicit declaration of
function `eac_configure'
sound/arm/omap-tsc2101.c: In function `eac_shutdown':
sound/arm/omap-tsc2101.c:155: error: `OMAP24XX_EAC_AGCTR' undeclared
(first use in this function)
sound/arm/omap-tsc2101.c: At top level:
sound/arm/omap-tsc2101.c:403: warning: static declaration of
'eac_configure' follows non-static declaration
sound/arm/omap-tsc2101.c:138: warning: previous implicit declaration
of 'eac_configure' was here
sound/arm/omap-tsc2101.c: In function `eac_configure':
sound/arm/omap-tsc2101.c:439: error: `OMAP24XX_EAC_CPTCTL' undeclared
(first use in this function)
sound/arm/omap-tsc2101.c:442: error: `OMAP24XX_EAC_AMSCFR' undeclared
(first use in this function)
sound/arm/omap-tsc2101.c: In function `eac_samplerate':
sound/arm/omap-tsc2101.c:541: error: `OMAP24XX_EAC_AGCFR' undeclared
(first use in this function)
sound/arm/omap-tsc2101.c:560: error: `OMAP24XX_EAC_AGCFR3' undeclared
(first use in this function)
sound/arm/omap-tsc2101.c: At top level:
sound/arm/omap-tsc2101.c:577: warning: initialization from
incompatible pointer type
sound/arm/omap-tsc2101.c:830: warning: initialization from
incompatible pointer type
sound/arm/omap-tsc2101.c:831: warning: initialization from
incompatible pointer type
sound/arm/omap-tsc2101.c: In function `eac_init':
sound/arm/omap-tsc2101.c:132: warning: statement with no effect
sound/arm/omap-tsc2101.c:137: warning: statement with no effect
sound/arm/omap-tsc2101.c: In function `eac_shutdown':
sound/arm/omap-tsc2101.c:155: warning: statement with no effect
sound/arm/omap-tsc2101.c: In function `eac_samplerate':
sound/arm/omap-tsc2101.c:541: warning: statement with no effect
sound/arm/omap-tsc2101.c:560: warning: statement with no effect
sound/arm/omap-tsc2101.c: At top level:
sound/arm/omap-tsc2101.c:57: warning: 'ret' defined but not used
sound/arm/omap-tsc2101.c:115: warning: 'McBSP_ops' defined but not used
sound/arm/omap-tsc2101.c:161: warning: 'audio_dma_callback' defined but not used
sound/arm/omap-tsc2101.c:817: warning: 'omap_sound_device' defined but not used
make[2]: *** [sound/arm/omap-tsc2101.o] Error 1
make[1]: *** [sound/arm] Error 2
make: *** [sound] Error 2
