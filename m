From: comunerito <cdavila@att.net>
Subject: ALSA support for H2 board
Date: Thu, 29 Nov 2007 09:05:25 -0800 (PST)
Message-ID: <405835.87027.qm@web34313.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hello,

I tried adding ALSA support for the H2 board using a
recent kernel (2.6.24.3, from the montavista git tree)
and got the following errors:

$ make omap_h2_1610_defconfig (ran ok)
$ make menuconfig (ran ok)
$ make modules
 ...
  CC [M]  sound/sound_core.o
  LD [M]  sound/soundcore.o
  CC [M]  sound/arm/omap/omap-alsa.o
  CC [M]  sound/arm/omap/omap-alsa-dma.o
  CC [M]  sound/arm/omap/omap-alsa-tsc2101.o
sound/arm/omap/omap-alsa-tsc2101.c: In function
`tsc2101_audio_write':
sound/arm/omap/omap-alsa-tsc2101.c:146: error:
implicit declaration of function `omap_tsc2101_write'
sound/arm/omap/omap-alsa-tsc2101.c: In function
tsc2101_audio_read':
sound/arm/omap/omap-alsa-tsc2101.c:154: error:
implicit declaration of function `omap_tsc2101_read'
make[3]: *** [sound/arm/omap/omap-alsa-tsc2101.o]
Error 1
make[2]: *** [sound/arm/omap] Error 2
make[1]: *** [sound/arm] Error 2
make: *** [sound] Error 2

I found an earlier post describing a similar error
here:
http://linux.omap.com/pipermail/linux-omap-open-source/2007-October/011765.html
and was wondering if anyone has any suggestions on how
to get this to work or if I should go back to an
earlier version of the kernel that does work.

Thanks and regards,
Carlos
