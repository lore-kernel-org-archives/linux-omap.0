From: Olav Kongas <ok@artecdesign.ee>
Subject: RE: Basic question: how to flash omap system with ccs?
Date: Thu, 1 Dec 2005 12:55:43 +0200 (EET)
Message-ID: <Pine.LNX.4.63.0512011117310.24954@pcy.artec.ee>
References: <438dd76f.621835a8.5534.1d69@mx.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <438dd76f.621835a8.5534.1d69@mx.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Li Weichen <iaadoa@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



On Thu, 1 Dec 2005, Li Weichen wrote:
> I have tried your generator, but It seems that I cannot get the right '.out'
> file.  I compiled it with gcc3.3 and followed the instructions in the file,
> then I got the u-boot.out.  I load the u-boot.out in CCS, but when I pressed
> the run button it had no messages at all and certainly the flashing is
> unsuccessful.  

This is an expected result. The layout of the resulting .out 
image must be as follows:

- COFF header (built with coff_hdr for len(flash-programmer)+len(u-boot))
- flash-programmer
- u-boot (not run, just to be programmed into flash)

You are currently missing the flash programmer. Therefore, 
after loading and running your resulting .out file, the CCS 
will strip COFF header and start u-boot, while you want it 
would start flash programmer instead.

If you want the flash programmer then I can put it up on the 
web. Let me know. I'd have to clean it up before, though.

> But I can load the factory u-boot image in OSK cdrom with CCS
> and flashing it rightly.  Is there something wrong with my u-boot or other
> thing?

On OSK CD, there are 2 u-boot images - the raw binary one 
and the .out. The .out one seems to contain a special flash 
programmer to be run right after jtag-ing. If you open the 
.out image then quite at the beginning you see strings 
reporting about flash writing. These strings are missing in 
the raw binary u-boot image on the CD.

> Oh, I nearly forgot.  I compile the coff_hdr.c simply with this command,
> $gcc coff_hdr.c -o coff_hdr

This compiling command is OK. If you're still in doubt then 
you could run for example the following command

	./coff_hdr 111111 | od -w4 -t x4

and compare your result with mine

ok@pcy coff> ./coff_hdr 111111 | od -w4 -t x4
0000000 000100c2
0000004 438ecdb5  <-- Creation date, your one will be different
0000010 00000000
*
0000020 1103001c
0000024 01080097
0000030 b2070fa1
0000034 00000001
0000040 00000000
*
0000050 00002000
*
0000060 742e2000
0000064 00747865
0000070 00000000
0000074 00002000
0000100 b2072000
0000104 00620001
0000110 00000000
*
0000130 00200000
0000134 00000000
*
0000142


Olav
