From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: Pending patches, was: Git tree updated to 2.6.23-rc2
Date: Mon, 6 Aug 2007 11:42:16 -0400
Message-ID: <31e679430708060842v52bb0ccbra2da74723423c672@mail.gmail.com>
References: <20070806125225.GA2312@atomide.com>
	<46B73C93.5090202@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46B73C93.5090202@googlemail.com>
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
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Dirk,

On 8/6/07, Dirk Behme <dirk.behme@googlemail.com> wrote:
> Tony Lindgren wrote:
> > I've just updated our git tree to 2.6.23-rc2.
>
> :)  Thanks!
>
> > There are quite a few pending patches, I will be looking at them
> > this week.
>
> Ah, I love collecting patches! ;)
>
> I have a loosely, not well maintained and tracked list of pending
> patches since May ;) . Most probably, most of them are outdated, need
> update, are already applied etc. Anyhow, maybe it is somehow useful
> and people can help and comment which are still up to date and should
> be applied. Then we can ignore all others. If anything is missing,
> then please a short note as well. With this, I will reset my pending
> patches list then.
>
> Best regards
>
> Dirk
>
> List of pending OMAP patches:
>
> 1. [PATCH] USB: Disable file_storage USB_CONFIG_ATT_WAKEUP
>
> 2. [PATCH] musb_hdrc: Implement workaround for tusb3.0 wbus bug rev2
>
> 3. [PATCH] musb_hdrc: Add SRP Interface and control it through sysfs
>
> 4. [PATCH] Add Sysfs Interface to Control Vbus states
>
> 5. [PATCH] Add more Test Modes
>
> 6. [PATCH] musb_hdrc: Make HNP work
>
> 7. [PATCH] USB: Fix OTG HNP for hub.c
>
> 8. [PATCH] HSET tool for the MUSB Controler

Patch "8. [PATCH] HSET tool for the MUSB Controler" shouldn't be
applied. This tool should be in userspace. I'm coding this application
but need some help.
Anybody wanna help me with this?? :-p

thanks

>
> 9. [PATCH] Make SRP passes in all Electrical Tests
>
> 10. [PATCH/RFC] Reduce OMAP2420 active current by ~30%
>
> 11. [PATCH 1/1] ARM: OMAP2: TWL4030 RTC driver (v2)
>
> 12. Common code for TSC 2101 and 2102
>
> 13. [PATCH] Fixing SD response type 6 vs. 1
>
> 14. [PATCH 1/12] Add support for the HTC Typhoon, Hurricane and
> Tornado smartphone
>
> 15. [PATCH 2/12] Default config for the HTC Typhoon
>
> 16. [PATCH 3/12] Add an option to disable debug UART.
>
> 17. [PATCH 4/12] Add OMAP730 clocks.
>
> 18. [PATCH 5/12] Add OMAP850 identification.
>
> 19. [PATCH 7/12] USB fixes for OMAP730
>
> 20. [PATCH 8/12] MMC fixes for OMAP730.
>
> 21. [PATCH 9/12] Add support for HTC Typhoon and Hurricane/Tornado LCD
> panels.
>
> 22. [PATCH 10/12] Add support for HTC Typhoon leds.
>
> 23. [PATCH 11/12] Add support for keys setting multiple bits in the scan
>
> 24. [RFC / Patch] Cleanup DM timer list for OMAP2 and OMAP1
>
> 25. [PATCH] Enable Kernel based uncompressing for OMAP3
>
> 26. [PATCH] ARM: OMAP2: Add camera block base address definition.
>
> 27. [PATCH] VIDEO OMAP: camera_core whitespace cleanup
>
> 28. [PATCH] OMAP VIDEO: Convert printk to dev_{dbg,err,info} macros
>
> 29. [PATCH] ARM: OMAP: full-retention fix for 2430
>
> 30. [PATCH] ARM: OMAP: fix suspend for twl4030
>
> 31. [PATCH 1/3] [ARM] OMAP: Adding Support for 2K nand page support
> for     omap2430
>
> 32. [PATCH 2/3] OMAP: Adding Support for 2K nand page support for omap2430
>
> 33. [PATCH 3/3] [ARM] OMAP: Adding Support for 2K nand page support on
> omap2430
>
> 34. [PATCH 1/8] ARM: OMAP: Fix omap mmu framework for omap1
>
> 35. [PATCH 2/8] ARM: OMAP: Fix omap mmu framework for omap1
>
> 36. [PATCH 3/8] DSPGW: Remove CONFIG_OMAP_DSP_TASK_MULTIOPEN
>
> 37. [PATCH 4/8] Add kfifo_get_to_user to copy data to userland directly
>
> 38. [PATCH 5/8] DSPGW: Use kfifo APIs instead of homemade ones
>
> 39. [PATCH 6/8] DSPGW: Use ALIGN macro instead of homemade one
>
> 40. [PATCH 7/8] ARM: OMAP: Fix Unbalanced enable for IRQ in omap mailbox
>
> 41. [PATCH 8/8] ARM: OMAP: Add MMU TWL support for omap1
>
> 42. [PATCH] ARM: OMAP: 2430SDP: turn off secondary LCD backlight on boot
>
> 43. [PATCH] ARM: OMAP: twl4030: make power_companion_init static
>
> 44. - 66. omap2 clock: Bugfixes and cleanups in OMAP2 clock framework
>
> 67. [PATCH] MENELAUS: Remove unnecessary pr_err definition
>
> 68. [PATCH omap-fixes] ARM: OMAP: cleanup: remove OMAP_MCBSP Kconfig
> warnings
>
>
>
>
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
