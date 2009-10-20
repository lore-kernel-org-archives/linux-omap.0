From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: [ANNOUNCE] updated dspbridge on linux-omap
Date: Tue, 20 Oct 2009 17:28:12 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042681C230@dlee03.ent.ti.com>
References: <20091013201408.GC12700@atomide.com>
	<27F9C60D11D683428E133F85D2BB4A53042676A3B5@dlee03.ent.ti.com>
	<20091020010306.GA12576@atomide.com>
 <20091020.083446.39167794.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56944 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbZJTW2N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 18:28:13 -0400
In-Reply-To: <20091020.083446.39167794.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Shah, Bhavin" <bshah@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Pasam, Vijay" <vpasam@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>

Hi All,

I would like to announce that l-o dspbridge branch was mirrored by Tony from DSP Bridge repository at dev.omapzoom.org, this branch was rebased on top of 2.6.32-rc4.

As of now, it is missing some of the latest patches sent to the mailing list but I'm hoping to include them soon. Also, DVFS Bridge feature won't compile if rebasing onto PM branch because it is missing clk notifier functions.

As usual, thanks to all who keep contributing.

omar

---

Ameya Palande (16):
  DSPBRIDGE: Logical code cleanup in bridge_open()
  DSPBRIDGE: Fix module build warnings
  DSPBRIDGE: Removal of unreachable code
  DSPBRIDGE: Use GT_trace for CLk_Disable message
  DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
  DSPBRIDGE: Buffer size warning fixes
  DSPBRIDGE: avoid to dump unnecessary registers without debug
  DSPBRIDGE: Prevent memory access during hibernation
  DSPBRIDGE: fix incorrect mask of DPLL in CHNLSM_InterruptDSP2()
  DSPBRIDGE: Cleanup SleepDSP
  DSPBRIDGE: Set VDD1 OPP1 while MPU initiated OFF mode
  DSPBRIDGE: Pass filp->private to all the ioctl wrappers
  DSPBRIDGE: Define pr_ctxt as a parameter in low level functions
  DSPBRIDGE: Remove old resource cleanup implementation
  DSPBRIDGE: Set VDD1 OPP1 unconditionally while moving to off mode
  DSPBRIDGE: Maintain VDD1 at OPP3 while DSP is active

Armando Uribe de Leon (1):
  BRIDGE: Number of supported OPPs increased to 5

Axel Haslam (1):
  BRIDGE: tiomap unmap fix

Doyu Hiroshi (Nokia-D/Helsinki (1):
  DSPBRIDGE: convert ioctl to unlocked_ioctl

Doyu Hiroshi (Nokia-D/Helsinki) (1):
  DSPBRIDGE: fix macros that break when inside an if/else

Ernesto Ramos Falcon (2):
  DSPBRIDGE: Delete list implementation for resource cleanup
  DSPBRIDGE: Memory leak in Node Register Notify

Felipe Contreras (18):
  tidspbridge: remove revision history
  tidspbridge: trivial cleanup
  tidspbridge: remove unused stuff
  tidspbridge: remove IO_CALLDPC
  tidspbridge: whitespace cleanups
  tidspbridge: trivial cleanups
  tidspbridge: hDevContext == pDevContext
  tidspbridge: remove UTIL_Wait wrapper
  tidspbridge: cleanup and remove HW_MBOX_IsFull
  tidspbridge: remove udelay and use time_after instead
  tidspbridge: Remove IO_InterruptDSP
  tidspbridge: remove IO_InterruptDSP2
  tidspbridge: remove CHNLSM_InterruptDSP
  tidspbridge: remove wIntrVal2Dsp
  tidspbridge: print an error when timing out
  tidspbridge: don't flood the mailbox on MemUnMap
  tidspbridge: cleanup and remove HW_MMU_TLBFlushAll
  tidspbridge: decreate timeout to a saner value

Fernando Guzman Lugo (20):
  BRIDGE: Remove sparse warnings from wcd
  BRIDGE: Module ISR removed
  BRIDGE: PRCS wrappers removal
  BRIDGE: Chnl module cleanup
  BRIDGE: Sparse warnings cleanup
  DSPBRIDGE: Free resources when user fails to do so
  DSPBRIDGE Fix for DCD stack overflow
  DSPBRIDGE: Removed CSL wrapper functions
  DSPBRIDGE: Fixed race condition with DBLL target list
  BRIDGE: Change GFP_ATOMIC to GFP_KERNEL
  DSPBRIDGE: base image reload suppor after DSP error
  DSPBRIDGE: slab corruption in resource cleanup fix
  DSPBRIDGE: Allow separate load/run addresses for Dynamic Loader
  DSPBRIDGE: Reset MMU and DSP on board stop
  DSPBRIDGE: Implemented Trampoline support for dynamic loader
  DSPBRIDGE: Enable/Disable MCBSP_CLOCKS for MCBSP2
  DSPBRIDGE: Remove process context list
  DSPBRIDGE: Fix BUG scheduling while atomic
  DSPBRIDGE: support loading 4 dependent DLL
  DSPBRIDGE: check pointer before calling Proc_Detach

Guzman Lugo Fernando (4):
  DSPBRIDGE: Remove SEEK_* redefinitions
  DSPBRIDGE: Removes wrappers funtions of readl and writel
  DSPBRIDGE: Change address resources to void __iomem *
  DSPBRIDGE: Remove variables not used in cfgdefs.h

Hari Kanigeri (15):
  DSPBRIDGE: Replacing custom mapping implementation
  BRIDGE Add preemption support to unprotected functions
  BRIDGE Resource cleanup node delete fix
  BRIDGE Memory leak fix
  BRIDGE Handle Node messaging when DSP crashed
  DSPBRIDGE: Mapping sidetone registers
  DSPBRIDGE DSP getProcessor fixed
  DSPBRIDGE Memory flush function fix
  DSPBRIDGE: Add DSP_MMU_DEBUG
  DSPBRIDGE: Handle Node operations when DSP is in error state
  DSPBRIDGE: Memory lock for DMM
  DSPBRIDGE: Remove run_IdleBoot support
  DSPBRIDGE: Handle properly user space pointers
  DSPBRIDGE: Keep DMM resources for other nodes on PROC_Detach
  DSPBRIDGE: Increased DMM size to 256MB

Hiroshi DOYU (30):
  BRIDGE: Header files
  BRIDGE: Doff image dynamic loader
  BRIDGE: Generic Utilities
  BRIDGE: Hardware Interfaces
  BRIDGE: Platform Manager
  BRIDGE: Resource Manager
  BRIDGE: Services
  BRIDGE: Mini driver
  BRIDGE: README
  BRIDGE: Fix header path
  BRIDGE: Sync omapzoom bridge patches
  BRIDGE: set 0 for phys_mempool_* as default
  BRIDGE: Rename header file location
  BRIDGE: Fix header path name to
    "arch/arm/plat-omap/include/dspbridge"
  BRIDGE: Add 'dspbridge' dirname in header file inclusion
  BRIDGE: Fix incorrect pathname
  BRIDGE: Remove paths in header comment
  BRIDGE: fix build error
  BRIDGE: use more detail name for interrupt claiming device
  BRIDGE: Fix uninitialized spinlock
  BRIDGE: Fix memory leak in PROC_Init()
  BRIDGE: Remove -Wno-strict-prototypes
  DSPBRIDGE: fix build warning
  DSPBRIDGE: fix build error without CONFIG_PM
  BRIDGE: build fix for clk usecount
  DSPBDRIDGE: use spin_lock_init instead of __SPIN_LOCK_UNLOCKED
  TIDSPBRIDGE: fix some build warnings
  DSPBRIDGE: fix section mismatch warning
  DSPBRIDGE: add checking 128 byte alignment for dsp cache line size
  DSPBRIDGE: move platform_device_register under mach-omap2

Nischal Varide (1):
  DSPBRIDGE Workqueue implementation for DVFS

Omar Ramirez (1):
  DSPBRIDGE: Fix for clock handles

Omar Ramirez Luna (56):
  BRIDGE: Kconfig Entry
  BRIDGE: Ceanup GT sparse warnings
  BRIDGE: Cleanup static declarations warnings
  BRIDGE: Remove unused clk structs
  BRIDGE: Clean up unused variables
  BRIDGE: Cosmetic changes reported from checkpatch
  BRIDGE: Add wcd table end
  BRIDGE: Checkpatch Cleanup
  BRIDGE: OMAP CSL wrappers removed
  BRIDGE: Remove CDECL macro
  BRIDGE: GT mask for DSP traces
  BRIDGE: MMUfault infinite timeout fix
  DSPBRIDGE: LM Timer release for hibernation
  DSPBRIDGE: Handle Hibernation requested from DSP
  DSPBRIDGE: Freeing allocated resources on rmmod
  DSPBRIDGE: Avoid kill task command when dsp crashed
  DSPBRIDGE: Added checks for valid handles in critical places.
  DSPBRIDGE: Unused pointer causing Memory Leaks
  DSPBRIDGE: Fixed Double notification when a sys_error happens
  DSPBRIDGE: Fixed typo in debug traces
  DSPBRIDGE: trivial spacing cleanup for memory module
  DSPBRIDGE: Fixing indentation
  DSPBRIDGE: New PWRERROR event notification
  DSPBRIDGE: Remove all resources on driver exit
  DSPBRIDGE: Stop and reset DSP before removing constraints
  DSPBRIDGE: Revert remmoving all resources on proc detach
  DSPBRIDGE: Removing UTIL module
  DSPBRIDGE: Shared memory size increased to 5MB
  DSPBRIDGE: Compilation fixes 2.6.31
  DSPBRIDGE: switch to pid_task for resource cleanup
  DSPBRIDGE: change ioctl base number
  DSPBRIDGE: Remove IO_ADDRESS, use OMAP2_IO_ADDRESS instead
  [HACK]DSPBRIDGE: Get clock handles using clk_get_sys
  DSPBRIDGE: sysfs entry for global driver state
  DSPBRIDGE: Remove DMM physical addres table
  DSPBRIDGE: create DMM table using vmalloc instead of kmalloc
  DSPBRIDGE: NULL and safety checks
  DSPBRIDGE: less code nesting for MemUnMap
  DSPBRIDGE: enable smart/autoidle for mailbox sysconfig
  DSPBRIDGE: set PWRERROR notifications as an option
  DSPBRIDGE: Enable peripheral clocks on wake up
  DSPBRIDGE: New interface to flush the entire cache
  DSPBRIDGE: Remove long busy-wait loops on PWRST transitions
  DSPBRIDGE: Rename usCount to timeout
  DSPBRIDGE: Trivial cleanup on DBDCD
  DSPBRIDGE: Do not panic on bad page count
  DSPBRIDGE: Reset IVA2 Video sequencer
  DSPBRIDGE: Remove PID usage and replace with TGID
  DSPBRIDGE: Move PROC object abstraction to proc.c
  DSPBRIDGE: Mutex lock for REGistry operations
  DSPBRIDGE: Deprecate Unregister Object API
  DSPBRIDGE: Fix SYNC initialization if enabled debug mode
  DSPBRIDGE: Avoid REGistry if pDevContext is available
  DSPBRIDGE: Bump OPP to minimal needed by DSP before running.
  DSPBRIDGE: Change wrong ifndef condition
  DSPBRIDGE: Fix compile error omap-pm.h not found

Palande Ameya (2):
  dspbridge: use memset instead of memzero
  DSPBRIDGE: CLK_Enable and CLK_Disable Code cleanup

Phil Carmody (3):
  DSPBRIDGE: Heuristic fixes of strlen/malloc out by one
  DSPBRIDGE: PROCWRAP_Load function cleanup in a complete mess
  DSPBRIDGE: Remove unnecessary conditions from some for loops

Ramesh Gupta (6):
  BRIDGE: Power management changes
  BRIDGE: OMAP PM Bug softlockup fix
  BRIDGE Power Management cleanup
  BRIDGE Save mailbox settings for suspend-resume
  DSPBRIDGE Wakeup IVA before accessing IVA MMU Registers
  DSPBRIDGE: fix for auto image load updated

Ramesh Gupta G (1):
  DSPBRIDGE DVFS and offmode support

Rebecca Schultz Zavin (1):
  DSPBRIDGE: Remove preproessor condition that could never work

Roman Tereshonkov (1):
  DSPBRIDGE: Fixes the DSP crash when driver is unloaded

Seth Forshee (1):
  DSPBRIDGE: Fix error handling in NODE_GetUUIDProps

Suman Anna (1):
  BRIDGE: Fix bug in HW Mailbox messaging

Tony Lindgren (1):
  DSPBRIDGE: Flush posted write when acking mailbox irq

ext Gupta, Ramesh (1):
  DSPBRIDGE Fix flush_workque

ext Ramirez Luna, Omar (1):
  BRIDGE: removing unnecesary OMAP3430 checks
