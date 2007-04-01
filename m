From: Dirk Behme <dirk.behme@googlemail.com>
Subject: MMU FWK changes break OMAP1 compilation
Date: Sun, 01 Apr 2007 11:31:11 +0200
Message-ID: <460F7BDF.4060105@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Linux OMAP ML <linux-omap-open-source@linux.omap.com>, Hiroshi.DOYU@nokia.com
List-Id: linux-omap@vger.kernel.org


Recent MMU FWK changes [1] and [2] break at least OMAP1 
compilation.

Issues:

- omap1_mmu_interrupt() in arch/arm/mach-omap1/mmu.c uses 
various MMU_xxx macros, but in arch/arm/mach-omap1/mmu.h 
they are called OMAP_MMU_xxx.

- omap1_mmu_interrupt() uses MK32 macro, which is defined in 
./plat-omap/dsp/dsp.h, which isn't included.

- omap1_mmu_interrupt() still uses MMUFAULT_MASK, which is 
removed from arch/arm/plat-omap/dsp/mmu.h by [2]. So [1] 
introduces MMUFAULT_MASK to mach-omap1/mmu.c while [2] 
removes it from dsp/mmu.h.

- dsp_mmu_itack() in arch/arm/plat-omap/dsp/mmu.h still uses 
dsp_fault_adr which is removed in same file by [2].

- Some compiler warnings:

arch/arm/plat-omap/dsp/dsp_mem.c: In function 'dsp_mem_ioctl':
arch/arm/plat-omap/dsp/dsp_mem.c:348: warning: unused 
variable 'ret'
arch/arm/plat-omap/dsp/dsp_mem.c:347: warning: unused 
variable 'dspadr'
arch/arm/plat-omap/dsp/mmu.h:88: warning: 'dspadr' is used 
uninitialized in this function

Anybody with a fix for these?

Cheers

Dirk

[1] 
<http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=6b13d95d4979ca9df91420fb5ab18fbfee3f9386>

[2] 
<http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=68a575f924dbe0326ee1e4178f854cfed7933492>
