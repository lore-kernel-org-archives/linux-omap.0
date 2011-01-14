From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] TWD: enable one-shot mode
Date: Fri, 14 Jan 2011 10:45:08 -0800
Message-ID: <4D3099B4.40900@codeaurora.org>
References: <20101224191855.GJ20587@n2100.arm.linux.org.uk> <4D2BE6C4.4040806@codeaurora.org> <20110111115209.GA12781@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110111115209.GA12781@n2100.arm.linux.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Bryan Huntsman <bryanh@codeaurora.org>, Colin Cross <ccross@android.com>, Daniel Walker <dwalker@codeaurora.org>, David Brown <davidb@codeaurora.org>, Erik Gilling <konkers@android.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@stericsson.com>, Olof Johansson <olof@lixom.net>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/11/2011 03:52 AM, Russell King - ARM Linux wrote:
> On Mon, Jan 10, 2011 at 09:12:36PM -0800, Stephen Boyd wrote:
>>
>> I see this patch was already tested and merged but can you elaborate on
>> why this was done? From what I understand, NOHZ selects one-shot (like
>> is done in this patch), so why don't the machines with a TWD choose NOHZ
>> or high res timers?
>
> You're right - so it's not actually required.  It should probably be
> reverted, though it does no damage...

Now I'm wondering why there are other 'select TICK_ONESHOT' lines in
arch/arm/Kconfig. Can we just remove them all? Otherwise it feels like
we're making it confusing for others later on.

----->8---[cut here]----8<-----
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e2f8011..7750a78 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -532,7 +532,6 @@ config ARCH_MMP
        select CLKDEV_LOOKUP
        select GENERIC_CLOCKEVENTS
        select HAVE_SCHED_CLOCK
-       select TICK_ONESHOT
        select PLAT_PXA
        select SPARSE_IRQ
        help
@@ -613,7 +612,6 @@ config ARCH_PXA
        select ARCH_REQUIRE_GPIOLIB
        select GENERIC_CLOCKEVENTS
        select HAVE_SCHED_CLOCK
-       select TICK_ONESHOT
        select PLAT_PXA
        select SPARSE_IRQ
        help
@@ -668,7 +666,6 @@ config ARCH_SA1100
        select GENERIC_CLOCKEVENTS
        select HAVE_CLK
        select HAVE_SCHED_CLOCK
-       select TICK_ONESHOT
        select ARCH_REQUIRE_GPIOLIB
        help
          Support for StrongARM 11x0 based boards.
@@ -1300,7 +1297,6 @@ config HAVE_ARM_SCU
 config HAVE_ARM_TWD
        bool
        depends on SMP
-       select TICK_ONESHOT
        help
          This options enables support for the ARM timer and watchdog unit

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

