From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] 3430 clock: REVISED: Add SmartReflex, emulation,
	trace clocks
Date: Mon, 12 Nov 2007 03:57:26 -0700
Message-ID: <20071112105726.514186925@pwsan.com>
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

This short series of two patches adds some remaining OMAP3430 clocks:
the SmartReflex voltage regulator clocks, and the ARM Cortex-A8
trace/emulation clocks.  Now with more pointers to further documentation
on the emulation clocks from Richard Woodruff <r-woodruff2@ti.com>.

Boot-tested on 3430SDP ES1.

---

diffstat: 

 arch/arm/mach-omap2/clock34xx.h |  196 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 183 insertions(+), 13 deletions(-)

size:

   text    data     bss     dec     hex filename
2847056  140800   95304 3083160  2f0b98 vmlinux.orig
2847720  141472   95304 3084496  2f10d0 vmlinux
