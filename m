From: Jeff DeFouw <jeffd@i2k.com>
Subject: NAND misreads on omap beagle and overo
Date: Fri, 29 Jan 2010 03:10:27 -0500
Message-ID: <20100129081027.GA13915@blorp.plorb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

I'm getting occasional bad reads from NAND on a rev B7 Beagleboard and a 
Gumstix Overo Water.  Both use OMAP3530 with 16-bit 256MB NAND, 
omap-patched kernels from 2.6.31 to 2.6.32.6 (Ubuntu beagleboard kernel 
binaries and my own compiled from source), and software ECC.

Sometimes a read request will read back the last written command byte 
several times before the page data.  The problem occurs with or without 
prefetch mode, and increasing chip_delay to 100 or 200 doesn't fix it.  
The chip is only supposed to need 25us anyway.

If I prepare the flash with a pattern
00 01 02 03 ... fc fd fe ff ff fe fd fc ... 03 02 01 00
and then read every page (full or partial), sometimes I will get
e0 ff e0 ff e0 ff e0 ff ... e0 ff 00 01 02 03 ...
or
30 ff 30 ff 30 ff 30 ff ... 30 ff 00 01 02 03 ...

0x30 and 0xE0 are probably the read and change-column commands echoing 
back for some reason.  This can cause uncorrectable ECC errors, so you 
can do a simple read of the mtd char device (no pattern necessary, 
erased flash will do) and run into the problem on the console if you're 
patient.  (while dd if=/dev/mtd4 of=/dev/null bs=2048; do sleep 1; done)

I can usually get at least one bad read within 4 full 250MB partition 
reads at 512-bytes per read call (more commands that way).  For some 
reason some kernels, like the Ubuntu beagleboard 2.6.31.6-x6.0 binary, 
make this harder to reproduce.  If you flip enough (unrelated) settings 
in the build config, it will happen more often.  For example, removing 
the built-in (=y) RT2800USB wireless driver from that kernel can somehow 
make the difference between seeing an error in a couple minutes and not 
seeing an error for over 10 minutes of continuous reading.

I've tried adding some udelays, and adjusting timings in the OMAP GPMC 
and checking for incorrect config.  A long udelay in the read_buf 
function helped in one test, but also cut the transfer rate in half and 
may not have eliminated the problem.

What event would cause the command byte to echo back anyway?  Is that a 
typical busy NAND response, or something the OMAP memory controller has 
to be doing?

-- 
Jeff DeFouw <jeffd@i2k.com>

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
