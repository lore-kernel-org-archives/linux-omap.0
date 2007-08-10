From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pending patches, was: Git tree updated to 2.6.23-rc2
Date: Fri, 10 Aug 2007 03:58:08 -0700
Message-ID: <20070810105808.GY8658@atomide.com>
References: <20070806125225.GA2312@atomide.com>
	<46B73C93.5090202@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46B73C93.5090202@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Dirk Behme <dirk.behme@googlemail.com> [070807 06:44]:
> Tony Lindgren wrote:
>> I've just updated our git tree to 2.6.23-rc2. 
>
> :)  Thanks!
>
>> There are quite a few pending patches, I will be looking at them
>> this week.
>
> Ah, I love collecting patches! ;)
>
> I have a loosely, not well maintained and tracked list of pending patches 
> since May ;) . Most probably, most of them are outdated, need update, are 
> already applied etc. Anyhow, maybe it is somehow useful and people can help 
> and comment which are still up to date and should be applied. Then we can 
> ignore all others. If anything is missing, then please a short note as 
> well. With this, I will reset my pending patches list then.

Here are my edits to your list. I've removed the numbering as I was
moving them around grouping them. I've also added some more patches
I had in my inbox. I guess we're pretty close up to date now with
pending patches :)

Please everybody check the list below and refresh and comment as needed.

Regards,

Tony

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pending-2007-08-10.txt"

List of pending OMAP patches:

1. PATCHES APPLIED 2007-08-10

Common code for TSC 2101 and 2102
[PATCH] ARM: OMAP: fix suspend for twl4030
[PATCH] ARM: OMAP: 2430SDP: turn off secondary LCD backlight on boot
[PATCH] ARM: OMAP: twl4030: make power_companion_init static
[PATCH] To Cleanup TWL-Core driver
[PATCH] ARM: OMAP: Put LCD drivers back to Makefile.
[PATCH] ARM: OMAP: Remove unnecessary N800 PM board specific file
[PATCH omap-fixes] ARM: OMAP: cleanup: remove OMAP_MCBSP Kconfig warnings
[PATCH] ARM: OMAP: full-retention fix for 2430
[PATCH] VIDEO OMAP: camera_core whitespace cleanup
[PATCH] OMAP VIDEO: Convert printk to dev_{dbg,err,info} macro
[PATCH] ARM: OMAP2: Add camera block base address definition.
[PATCH 1/3] [ARM] OMAP: Adding Support for 2K nand page support for omap2430
All patches above applied.

[PATCH 1/8] ARM: OMAP: Fix omap mmu framework for omap1
[PATCH 2/8] ARM: OMAP: Fix omap mmu framework for omap1
[PATCH 3/8] DSPGW: Remove CONFIG_OMAP_DSP_TASK_MULTIOPEN
[PATCH 4/8] Add kfifo_get_to_user to copy data to userland directly
[PATCH 5/8] DSPGW: Use kfifo APIs instead of homemade ones
[PATCH 6/8] DSPGW: Use ALIGN macro instead of homemade one
[PATCH 7/8] ARM: OMAP: Fix Unbalanced enable for IRQ in omap mailbox
[PATCH 8/8] ARM: OMAP: Add MMU TWL support for omap1
Above series applied. Kfifo patches should be discus
sed on LKML for
integration.

[PATCH 00/22] omap2 clock: Bugfixes and cleanups in OMAP2 clock framework
[PATCH 01/22] omap2 clock: drop meaningless RATE_CKCTLs
[PATCH 02/22] omap2 clock: fix incorrect rate calculation for osc_ck, sys_ck
[PATCH 03/22] omap2 clock: fix clksel divisor bug
[PATCH 04/22] omap2 clock: vlynq_fck recalc should be clksel, not followparent
[PATCH 05/22] omap2 clock: fix CodingStyle issues
[PATCH 06/22] omap2 clock: drop unnecessary variable in omap2_clk_round_rate()
[PATCH 07/22] omap2 clock: get rid of sleep_ck
[PATCH 08/22] omap2 clock: clean up dss2_fck clock flags
[PATCH 09/22] omap2 clock: move SDRC-related code from clock.c to memory.c
[PATCH 10/22] omap2 clock: use symbolic constants in clock.h rate_offset/src_offset fields
[PATCH 11/22] omap2 clock: fix some clocks incorrectly marked as present on OMAP2430
[PATCH 12/22] omap2 clock: vlynq_fck is missing clksel divider code
[PATCH 13/22] omap2 clock: convert PARENT_CONTROLS_CLOCK into a clock flag
[PATCH 14/22] omap2 clock: omap2 clock.c: Consolidate wait-for-lock code
[PATCH 15/22] omap2 clock: return -EINVAL if no clock enable code; fix dpll_ck enable
[PATCH 16/22] omap2 clock: From: Paul Walmsley <paul@pwsan.com> Subject:
[PATCH 17/22] omap2 clock: Cleanup in clksel-related code; add sys_clkout2 divisor handling
[PATCH 18/22] omap2 clock: Use symbolic constants in clock.c
[PATCH 19/22] omap2 clock: use dedicated omap2_dpll_recalc() for DPLL recalc func
[PATCH 20/22] omap2 clock: add fixed divisor clock code
[PATCH 21/22] omap2 clock: remove fixed rate from mdm_osc_ck
[PATCH 22/22] omap2 clock: get rid of omap2_followparent_recalc()
Above series applied.


2. PATCHES ALREADY APPLIED EARLIER OR OBSOLETE

[PATCH] USB: Disable file_storage USB_CONFIG_ATT_WAKEUP
This has already been committed via linux-usb-devel list.

[PATCH] musb_hdrc: Implement workaround for tusb3.0 wbus bug rev2
[PATCH] musb_hdrc: Add SRP Interface and control it through sysfs
[PATCH] Add Sysfs Interface to Control Vbus states
[PATCH] Add more Test Modes
[PATCH] musb_hdrc: Make HNP work
[PATCH] USB: Fix OTG HNP for hub.c
Patches above have already been committed or are obsolete.

[PATCH] HSET tool for the MUSB Controler
Will be in userspace, Felipe is working on it.

[PATCH] Make SRP passes in all Electrical Tests
Already committed.

[PATCH] Fixing SD response type 6 vs. 1
Already applied via LKML.

[PATCH] Enable Kernel based uncompressing for OMAP3
Not needed 

[PATCH] ARM: OMAP: silence Kconfig warnings for non-ARM build
Replaced by another patch

[RFC / Patch] Cleanup DM timer list for OMAP2 and OMAP1
Already applied in updated form

[PATCH 1/1] ARM: OMAP2: TWL4030 RTC driver (v2)
Already applied, please verify.


3. PATCHES NEEDING UPDATING

[PATCH/RFC] Reduce OMAP2420 active current by ~30%
Needs to be updated to use new PRCM framework.

[PATCH] MENELAUS: Remove unnecessary pr_err definition
Needs to be refreshed.

[PATCH 1/12] Add support for the HTC Typhoon, Hurricane and Tornado smartphone
[PATCH 2/12] Default config for the HTC Typhoon
[PATCH 3/12] Add an option to disable debug UART.
[PATCH 4/12] Add OMAP730 clocks.
[PATCH 5/12] Add OMAP850 identification.
[PATCH 7/12] USB fixes for OMAP730
[PATCH 8/12] MMC fixes for OMAP730.
[PATCH 9/12] Add support for HTC Typhoon and Hurricane/Tornado LCD panels.
[PATCH 10/12] Add support for HTC Typhoon leds.
[PATCH 11/12] Add support for keys setting multiple bits in the scan
I believe we are still waiting an update on this series?

[PATCH] ARM: OMAP: Fix building with CONFIG_OMAP_GPIO_SWITCH off.
This needs to have extern prototypes moved to *.h files

[PATCH 2/3] OMAP: Adding Support for 2K nand page support for omap2430
[PATCH 3/3] [ARM] OMAP: Adding Support for 2K nand page support on omap2430
Maybe should be merged with omap-nand-flash.c?

4. PATCHES PENDING

At least MMC multislot support patches are still pending.

Anybody have more pending patches in mind?

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--dDRMvlgZJXvWKvBx--
