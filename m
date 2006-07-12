From: Kevin Hilman <khilman@deeprooted.net>
Subject: 2420 boot BUG(): failure to map SRAM
Date: Wed, 12 Jul 2006 17:28:32 -0500
Message-ID: <1152743312.14885.11.camel@vence.internal.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

I just discovered that today's git doesn't boot on 2420 (boot log
below).  I haven't debugged yet, but wanted to post in case anyone as
seen/solved this.

Kevin

Uncompressing
Linux........................................................................................... done, booting the kernel.
<5>Linux version 2.6.17-omap1-default-g64929d88-dirty (khilman@paris)
(gcc version 4.1.1 (MontaVista 4.1.1-2.0.0.0601007 2006-07-10)) #15 Wed
Jul 12 15:33:33 PDT 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: OMAP2420 H4 board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 8192
<7>  DMA zone: 8192 pages, LIFO batch:1
<6>OMAP2420
<4>BUG: map for 0x4020f000 at 0xd0000000 can not be mapped using pages,
ignoring.
<6>SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x100000
