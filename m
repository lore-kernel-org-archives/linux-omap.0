From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: Pending August patches
Date: Fri, 1 Sep 2006 19:04:14 +0200
Message-ID: <fb249edb0609011004k75484eejae4c583d933bfe01@mail.gmail.com>
References: <44F85C99.7080102@gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <44F85C99.7080102@gmail.com>
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

On 01/09/06, Dirk Behme <dirk.behme@googlemail.com> wrote:
> Hi,
>
> my list of pending OMAP patches for August 2006:
>
> 1. [PATCH] OMAP1510 serial fix for 115200 baud.
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007677.html
>
> 2. [PATCH] Unmask omap-keypad interrupt on suspend
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007720.html

This patch contained a locking error.

>
> 3. [PATCH] ARM: OMAP: Remove warnings in DSP code
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007728.html
>
> 4. [PATCH] ARM: OMAP: Add GPIO API howto
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007733.html
>
> 5. [PATCH] Unmask omap-keypad interrupt on suspend
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007772.html

This is the correct change. (obsoletes 2. [PATCH] Unmask omap-keypad
interrupt on suspend)

>
> 6. [PATCH] Add LCD backlight driver for OMAP
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007773.html
>
> 7. [PATCH] ARM: OMAP: Backlight configuration struct
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007774.html
>
> 8. [PATCH] ARM: OMAP: Register LCD backlight on PalmTE
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007775.html
>
> 9. [PATCH] ARM: OMAP: Add Amstrad Delta platform bits for
> framebuffer.
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007776.html
>
> 10. [PATCH 1/5] Change all omap15xx devices to use similar
> DMA handling than h6300 uses.
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007777.html
>
> 11. [PATCH 2/5] Removed double spinlocking with omap15xx
> devices.
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007778.html
>
> 12. [PATCH 3/5] Fix init warning in tsc2101 alsa driver.
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007779.html
>
> 13. [PATCH 4/5] tsc2101 mixer fixes.
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007780.html
>
> 14. [PATCH 5/5] Add gsm phone support for the mixer in
> tsc2101 alsa driver.
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007781.html
>
> 15. [PATCH] support printk-times by fixing sched_clock to be
> callable in early boot
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007828.html
>
> 16. Re: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc framework
> driver
> or better: Handle wakeup irqs more correctly and completely
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007853.html
>
> Please correct if I missed anything, if any of above patches
> are already applied or if any has comments I overlooked and
> needs resend. Are there any older patches pending?
>
> Cheers
>
> Dirk
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
balrog 2oo6
