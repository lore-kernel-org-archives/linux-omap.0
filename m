From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 0/1] ARM TCM (Tightly-Coupled Memory) support v1
Date: Fri, 26 Jun 2009 12:43:37 +0200
Message-ID: <1246013017-20275-1-git-send-email-linus.walleij@stericsson.com>
Content-Type: multipart/mixed; boundary="===============1762909644=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linus-embedded@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-omap@vger.kernel.org

--===============1762909644==

ARM TCM (Tightly-Coupled Memory) support v1

For details about TCM and this specific interface for
Linux, see the patch, which includes a document in
Documentation/arm/tcm.txt

I expect a few iterations on this, so it's not like this
is a merge candidate. Wait for v5 or so...

However it works. Result of test run using the example
program in tcm.txt on U335:

CPU: found DTCM 8k @ 00010000, enabled
CPU: moved DTCM 8k to ffff4000, enabled
CPU DTCM: copied data from ffff4000 - ffff4008
CPU: found ITCM 8k @ 00000000, enabled
CPU: moved ITCM 8k to ffff2000, enabled
CPU ITCM: copied code from ffff2000 - ffff201c
Setting up TCM memory pool
CPU DTCM: Added 00001ff8 bytes @ ffff4008 to the TCM memory pool
CPU ITCM: Added 00001fe4 bytes @ ffff201c to the TCM memory pool
Hello TCM executed from ITCM RAM
TCM variable from testrun: 200 @ ffff4000
TCM variable: 0xdeadbeef @ ffff4000
TCM assigned variable: 0x2badbabe @ ffff4004
TCM constant: 0xcafebabe @ ffff2018
TCM Allocated 20 bytes of TCM @ ffff201c
TCM tcmem[0] = deadbeef
TCM tcmem[1] = 2badbabe
TCM tcmem[2] = cafebabe
TCM tcmem[3] = deadbeef
TCM tcmem[4] = 2badbabe


Other implementations:

I've noticed that OMAP1 has TCM, it is however only ever
used from the assembly code found in mach-omap1/sleep.S.
Using this on the OMAP too it's possible to write C and
assembly alike for the TCM. C is nice. I expect it'd be
easy to switch over to using this.


System RAM:

SystemRAM is a generic on-chip memory (also called
retention RAM, backup RAM or just plain on-die/chip RAM)
which is used in som SoC designs for much the same
purposes as TCM memories. TCM is not used much in newer
designs in favor of System RAM.

SystemRAM is different in that it is not Harvard-style
so like in common RAM instructions and data can be mixed.
It is also often below L1 or even L2 caches, so it
behaves just like normal memory. Following the style of
the TCM memory implementation it is easy to add a
similar mechanism för System RAM with some interface
in asm/sysram.h or so, but it is distincly different due
to the Harvard nature of TCM and the fact that TCMs can
be arbitrarily moved about in the physical memory
map.

TI:s DaVinci seems to have something called "sysRAM"
instead in mach-davinci/sram.c perhaps this can be
treated exactly as an ITCM, what do I know, however in
difference from ITCM I believe that is outside the CPU
and thus code running from that RAM can "see" the MMU
remappings. davinci creates a special memory pool for
the sysram on that platform and currently that seems to
be the only way to use it.

I stronly believe that the DaVinci solution should be
made generic and moved out of mach-davinci, and modeled
to be able to compile code into as with TCM, but I have
no suitable machine to test that on so that will be on
my TODO.

Yours,
Linus Walleij


--===============1762909644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--===============1762909644==--
