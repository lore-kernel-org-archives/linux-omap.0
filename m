From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: TSC2101 kernel compilation error: Touch & Audio IOCTLs questions
Date: Sat, 27 Oct 2007 07:42:16 +0200
Message-ID: <4722CFB8.8000803@googlemail.com>
References: <7f3c88400710261245o2cc4b77bq8739fbdb29ceadc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7f3c88400710261245o2cc4b77bq8739fbdb29ceadc6@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eduardo Giacoman <giacoman@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Eduardo Giacoman wrote:
> I'm having some troubles compiling the kernel with the audio and touchscreen
> enabled. I am working with an OMAP1610 H2 board and it has a TSC2101 chip.
> I am using kernel 2.6.23.1 with muru patch and I also tried with the latest
> git tree. I am getting the following error while compiling:
> 
> CC      sound/arm/omap/omap-alsa-tsc2101.o
> sound/arm/omap/omap-alsa-tsc2101.c: In function `tsc2101_audio_write':
> sound/arm/omap/omap-alsa-tsc2101.c:146: error: implicit declaration of
> function `omap_tsc2101_write'
> sound/arm/omap/omap-alsa-tsc2101.c: In function `tsc2101_audio_read':
> sound/arm/omap/omap-alsa-tsc2101.c:154: error: implicit declaration of
> function `omap_tsc2101_read'
> make[3]: *** [sound/arm/omap/omap-alsa-tsc2101.o] Error 1
> make[2]: *** [sound/arm/omap] Error 2
> make[1]: *** [sound/arm] Error 2
> make: *** [sound] Error 2
> 
> I see that those functions are undeclared, but I've been looking for and I
> only found them on an older kernel under drivers/ssi/ folder which is
> missing (deprecated?) in the recent versions: omap-tsc2101.h, omap-tsc2101.c,
> omap-uwire.c, omap-uwire.h.

Yes, drivers/ssi/ was removed. drivers/spi/tsc2101.c should be used 
instead of above functions.

Seems that

drivers/input/touchscreen/omap/ts_hx.c
sound/arm/omap/omap-alsa-tsc2101.c
sound/arm/omap/omap-alsa-tsc2101-mixer.c

still need to be converted to the reworked interface.

Dirk
