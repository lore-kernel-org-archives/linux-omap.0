From: Olav Kongas <ok@artecdesign.ee>
Subject: RE: Basic question: how to flash omap system with ccs?
Date: Mon, 28 Nov 2005 17:18:48 +0200 (EET)
Message-ID: <Pine.LNX.4.63.0511281604550.22060@pcy.artec.ee>
References: <99E943D7AA8E3A448619E1F809F2A2A201160C67@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <99E943D7AA8E3A448619E1F809F2A2A201160C67@dlee04.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Kipisz, Steven" <s-kipisz2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi Steven,

On Mon, 28 Nov 2005, Kipisz, Steven wrote:

> CCS 3.1 supports ELF file formats, which is the same format as the
> u-boot executable.  You should be able to use a CCS gel file to
> configure SDRAM, peripherals, etc. so that CCS can load u-boot into
> SDRAM and run it.  Once u-boot is running, you download u-boot.bin and
> write it to flash.  If anybody has a gel file for a 5912, he/she could
> probably send it to you.  I've don't this with other OMAP platforms.

I did not know about ELF format support. Thanks.  Knowing 
that would have saved me a half day.

I'll look into the gel files to see, whether setting up the 
EMIFS for my flash (if I need to do this at all) is easier 
in gel files than in my flash programmer. Though, I really 
prefer the situation, where just calling 'make' would build 
me an image (COFF or ELF) that can be directly loaded also 
by future versions of CCS without the need to hack gel 
files.

> The SRAM option sounds interesting.  You could probably build u-boot for
> SDRAM (the normal build) and save the binary file as something like
> u-boot-sdram.bin.  Then build a SRAM version - look at
> u-boot/board/omap5912osk/config.mk.  The TEXT_BASE value is where u-boot
> will load.  Change this to a SRAM area, rebuild u-boot, and use CCS to
> download the ELF format u-boot.  Once that is running in SRAM, download
> and flash the SDRAM version .bin file.  I've never tried this, but it
> sounds like it might work, assuming the binary image and the executing
> image fit into the 250k SRAM.

I tried converting u-boot to run from SRAM. I managed to 
change the relevant bits like TEXT_BASE, stack location, 
heap size, etc. But when u-boot, already running in SRAM, 
changed SoC's clocks then my jtag started to report "cannot 
halt processor" or the like. Is my jtag connection fragile 
or what, but I decided to minimize the dependence on it and 
go with a dedicated, tiny, non-time-critical flash 
programmer.

For omap5912, I don't see a reason of initializing sdram in 
the flash burning phase at all. Even if one would burn with 
an sram-specific u-boot (instead of a dedicated flash 
programmer), both sram-specific and sdram-specific u-boot 
images should fit simultaneously into the 250k of sram. For 
SoC's with smaller srams it may be necessary, however.

Thanks a lot for the info,
Olav
