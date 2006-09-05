From: tony@atomide.com
Subject: Re: Pending August patches
Date: Tue, 5 Sep 2006 18:41:10 +0300
Message-ID: <20060905154109.GE18073@atomide.com>
References: <44F85C99.7080102@gmail.com>
	<fb249edb0609011004k75484eejae4c583d933bfe01@mail.gmail.com>
	<20060904150433.GC8017@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060904150433.GC8017@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

OK, I've pushed Dirk's list except for the ones commented below.
Please check your patches got merged OK.

Regards,

Tony

1. [PATCH] ARM: OMAP: Remove warnings in DSP code
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007728.html

2. [PATCH] ARM: OMAP: Add GPIO API howto
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007733.html

3. [PATCH] Unmask omap-keypad interrupt on suspend
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007772.html

4. [PATCH] Add LCD backlight driver for OMAP
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007773.html

5. [PATCH] ARM: OMAP: Backlight configuration struct
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007774.html

6. [PATCH] ARM: OMAP: Register LCD backlight on PalmTE
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007775.html

7. [PATCH] ARM: OMAP: Add Amstrad Delta platform bits for framebuffer.
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007776.html

8. [PATCH 1/5] Change all omap15xx devices to use similar DMA handling than h6300 uses.
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007777.html

Already applied.

9. [PATCH 2/5] Removed double spinlocking with omap15xx devices.
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007778.html

Already applied.

10. [PATCH 3/5] Fix init warning in tsc2101 alsa driver.
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007779.html

11. [PATCH 4/5] tsc2101 mixer fixes.
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007780.html

12. [PATCH 5/5] Add gsm phone support for the mixer in tsc2101 alsa driver.
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007781.html

13. H3 alsa support
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007821.html

14. [PATCH] support printk-times by fixing sched_clock to be callable in early boot
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007828.html

Let's do this by implementing printk_clock() instead.

15. Re: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc framework driver
or better: Handle wakeup irqs more correctly and completely
http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007853.html

Already applied.
