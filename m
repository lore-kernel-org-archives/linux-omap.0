From: tony@atomide.com
Subject: Re: Pending October patches
Date: Wed, 1 Nov 2006 23:28:52 +0200
Message-ID: <20061101212850.GD6833@atomide.com>
References: <4548C32E.8010800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4548C32E.8010800@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Thanks again for the list. I've pushed most of them, some patches
need minor fixes, see below. Again, please verify your patches got
applied OK.

I've also updated to -rc4. BTW, I probably won't have email access 
until Tuesday.

* Dirk Behme <dirk.behme@googlemail.com> [061101 18:34]:
> Hi,
> 
> my list of pending OMAP patches for October 2006:
> 
> 1. [PATCH] ARM: OMAP: Fix warning no IRQF_TRIGGER set_type 
> function for IRQ 353
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008119.html

Pushed.
 
> 2. ARM: OMAP2: fix apollon gpmc initialization
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008132.html

Pushed.
 
> 3. Git tree updated to 2.6.19-rc2
> (Fix BUG in omap1_mbox_enable_irq)
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008148.html

Pushed.
 
> 4. [PATCH] ARM: OMAP: Register tsc2102 on Palm Tungsten E
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008155.html

Pushed.
 
> 5. [patch 2.6.19-rc3-omap] gpio init section cleanups
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008175.html

Pushed.
 
> 6. [patch 2.6.19-rc3-omap] gpio object shrinkage, cleanup
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008176.html

Pushed. We should split this to omap1- and omap2-specific gpio.c that
uses common gpio.c to get rid of the ifdefs.
 
> 7. [PATCH]: Fixing blksz_bits calling inside 
> drivers/mmc/mmc.c and drivers/mmc/omap.c
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008183.html

Pushed Dirk's version that also fixes the warning.
 
> 8. [PATCH] ARM: OMAP: Fix warnings in plat-omap
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008184.html

Pushed.
 
> 9. [PATCH] ARM: OMAP: Fix warnings in plat-omap/dsp
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008185.html

I think the unlikely() is unlikely necessary for init and sysfs?
 
> 10. [PATCH] ARM: OMAP: Fix warning in mach-omap1
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008187.html

Same here, also missing space after if.
 
> 11. [PATCH] ARM: OMAP: Fix warning in mach-omap2
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008188.html

Pushed.
 
> 12. [PATCH] ARM: OMAP: Fix warning in omap-keypad
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008190.html

Pushed.
 
> 13. [PATCH] ARM: OMAP: Fix warnings in ads7846
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008191.html

Is the unlikely() needed here?
 
> 14. [PATCH] ARM: OMAP: Fix Amstrad Delta omap-keypad usage.
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008194.html

Pushed.
 
> 15. [PATCH] ARM: OMAP: Remove struct pt_regs from 
> omap_irda_irq()
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008195.html

Pushed.
 
> 16. [PATCH] ARM: OMAP: Remove struct pt_regs from 
> lcdc_irq_handler()
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008196.html

Pushed.
 
> 17. [PATCH] ARM: OMAP: Remove struct pt_regs from menelaus_irq()
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008197.html

Pushed.
 
> 18. [PATCH] ARM: OMAP1: Fix CONFIG_DEBUG_LL
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008201.html

Pushed.
 
> 19. [PATCH] PalmZ71 extra brace fix
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008204.html

Pushed.
 
> 20. [PATCH 1/3] Palm Tungsten|T support
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008206.html

Please replace spaces with tabs according to Documentation/CodingStyle.
 
> 21. [PATCH 2/3] Palm Tungsten|T LCD
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008207.html

Please replace spaces with tabs according to Documentation/CodingStyle.
 
> 22. [PATCH 3/3] Palm Tungsten|T defconfig
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008208.html

Depends on previous patches.
 
> 23. [PATCH] Palm Tungsten|T LEDs
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008219.html

This too.
 
> 24. [PATCH] ARM: OMAP: fix apollon USB device support
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008220.html

Pushed.
 
> 25. [PATCH] omap-hw: Fix build breakage
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008229.html

Pushed.
 
> 26. [PATCH] ARM: OMAP: Make AIC23 sound work again
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008232.html

Hmmm, I think there were some comments on this hack on LKML when we
merged the driver?
 
> 27. [PATCH] [USB/CORE/USB.C] Fixes autosuspend and auto_pm 
> fields missing
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008234.html

Sounds like this is getting fixed in the mainline tree.
 
> A lot of stuff this month, was somewhat tricky to track. So 
> as usual, please correct if anything missing, if anything is 
> wrong, outdated or already applied. Are there any older 
> patches pending?

Yes it's been a busy patch month :) I cannot think of any patches we've
missed.

Regards,

Tony
