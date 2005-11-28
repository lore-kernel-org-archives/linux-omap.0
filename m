From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: Basic question: how to flash omap system with ccs?
Date: Mon, 28 Nov 2005 07:19:59 -0600
Message-ID: <99E943D7AA8E3A448619E1F809F2A2A201160C67@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Olav Kongas <ok@artecdesign.ee>, Li Weichen <iaadoa@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

CCS 3.1 supports ELF file formats, which is the same format as the
u-boot executable.  You should be able to use a CCS gel file to
configure SDRAM, peripherals, etc. so that CCS can load u-boot into
SDRAM and run it.  Once u-boot is running, you download u-boot.bin and
write it to flash.  If anybody has a gel file for a 5912, he/she could
probably send it to you.  I've don't this with other OMAP platforms.

The SRAM option sounds interesting.  You could probably build u-boot for
SDRAM (the normal build) and save the binary file as something like
u-boot-sdram.bin.  Then build a SRAM version - look at
u-boot/board/omap5912osk/config.mk.  The TEXT_BASE value is where u-boot
will load.  Change this to a SRAM area, rebuild u-boot, and use CCS to
download the ELF format u-boot.  Once that is running in SRAM, download
and flash the SDRAM version .bin file.  I've never tried this, but it
sounds like it might work, assuming the binary image and the executing
image fit into the 250k SRAM.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Olav
Kongas
Sent: Sunday, November 27, 2005 3:55 PM
To: Li Weichen
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: Basic question: how to flash omap system with ccs?



On Sun, 27 Nov 2005, Li Weichen wrote:

> Hi all,
>=20
> I have an TI XDS560 emulator and CCS 3.1 by hand.  Can I load the
> bootloader, kernel and file system with them?  I have never used CCS
before,
> so I eagerly hope someone could show me the steps or where I can find
the
> answer.

I'm right now working on the same problem. I'm using XDS510=20
if that matters. The aim is to transfer u-boot to omap5912's=20
SRAM and then burn it into the virgin onboard flash of our=20
custom board. I plan to transfer kernel and the rest later=20
when already booted up from u-boot.

Initially I started to modify u-boot so that it could run in=20
SRAM, with jtag connected, so that I could use u-boot=20
functionality to burn itself into flash. However, it turned=20
out more and more changes to u-boot were needed so I decided=20
to whip up a little custom flash programmer for that.

The scheme is the following: the u-boot image will be=20
appended to the flash programmer image, the result will be=20
converted to the TI's COFF format and transferred from CCS=20
over jtag to omap's SRAM, where the programmer will be=20
started.

I have CCS and jtag emulator working. I really recommend to=20
carefully read the instructions at Spectrum Digital's=20
webpage on how to set it all correctly up. I have written a=20
little COFF header generator to convert raw images into TI's=20
COFF; that's the format the CCS agrees to load over jtag. If=20
you want the tool just let me know. Currently I am working=20
on the flash programmer.=20

Olav

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
