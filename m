From: "arun c" <arun.edarath@gmail.com>
Subject: U-boot gives undefined instruction
Date: Thu, 5 Jul 2007 11:27:46 +0530
Message-ID: <c656a4d20707042257t38f071r9185585126d89ee@mail.gmail.com>
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

Hi all,

I am working with omap2430sdp uboot.
i am running this uboot from RAM(by copying the uboot.elf file to RAM
using CCS).
But it always prints the messages shown below and hangs. I am unable
to give any
commands.

Can anybody diagnose the problem please.

#################################################################
U-Boot 1.1.4 (Jul  2 2007 - 17:26:21)

U-Boot code: 80E80000 -> 80EA6040  BSS: -> 80EAC860
OMAP2430C-GP revision 3, PRCM #5A
TI 2430OSK 1.1 Version + mDDR (Boot NAND)
RAM Configuration:
Bank #0: 80000000 undefined instruction
undefined instruction
undefined instruction
undefined instruction
pc : [<80080004>]    lr : [<80e3f2e4>]
sp : 80e3f2dc  ip : 80e9eefc  fp : 00000000
undefined instruction
pc : [<80080004>]    lr : [<80e3efa4>]
sp : 80e3ef9c  ip : 80e9ef48  fp : 00000000
r10: 00000001  r9 : 80e3efc4  r8 : 80e3ffdc
r7 : 80e3efe7  r6 : 80e3f1f4  r5 : ffffffff  r4 : 80e3f294
r3 : 0000003c  r2 : 00000000  r1 : 00000038  r0 : 00000008
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32
Resetting CPU ...



U-Boot 1.1.4 (Jul  2 2007 - 17:26:21)

undefined instruction
undefined instruction
pc : [<80080004>]    lr : [<80e3f984>]
sp : 80e3f97c  ip : 80e9eefc  fp : 00000000
undefined instruction
undefined instruction
pc : [<80080004>]    lr : [<80e3f2dc>]
sp : 80e3f2fc  ip : ffffffff  fp : 00000000
r10: 00000001  r9 : 80e3f324  r8 : 8000ffdc
undefined instruction
pc : [<80080004>]    lr : [<80e3efc4>]
sp : 80e3efbc  ip : 80e9ef78  fp : 00000000
undefined instruction
pc : [<80080004>]    lr : [<80e3ec5c>]
sp : 80e3ec7c  ip : ffffffff  fp : 00000000
undefined instruction
undefined instruction
undefined instruction
pc : [<80080004>]    lr : [<80e3e29c>]
sp : 80e3e2bc  ip : ffffffff  fp : 00000000
r10: 00000001  r9 : 80e3e2e4  r8 : 80e3ffdc
r7 : 80e3e2eb  r6 : 80e3e510  r5 : 00000008  r4 : 80e3e5b4
r3 : 80e3e2a3  r2 : 00000034  r1 : 80e3e257  r0 : 80e3e2f3
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32
Resetting CPU ...

#############################################################

Best regards
Arun
