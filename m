From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] arm: sched: stop sched_clock() during suspend
Date: Tue, 23 Oct 2012 07:14:48 -0700
Message-ID: <87mwzdcm1z.fsf@deeprootsystems.com>
References: <873916h1yi.fsf@deeprootsystems.com>
 <1350971854-9161-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1350971854-9161-1-git-send-email-balbi@ti.com> (Felipe Balbi's
 message of "Tue, 23 Oct 2012 08:57:34 +0300")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>, linus.walleij@linaro.org, Daniel Walker <dwalker@fifo99.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kukjin Kim <kgene.kim@samsung.com>, Barry Song <21cnbao@gmail.com>, Bryan Huntsman <bryanh@codeaurora.org>, Russell King <rmk+kernel@arm.linux.org.uk>, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, John Stultz <john.stultz@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Alexander Schulz <alex@shark-linux.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Santosh
List-Id: linux-omap@vger.kernel.org

Felipe Balbi <balbi@ti.com> writes:

> The scheduler imposes a requirement to sched_clock()
> which is to stop the clock during suspend, if we don't
> do that any RT thread will be rescheduled in the future
> which might cause any sort of problems.
>
> This became an issue on OMAP when we converted omap-i2c.c
> to use threaded IRQs, it turned out that depending on how
> much time we spent on suspend, the I2C IRQ thread would
> end up being rescheduled so far in the future that I2C
> transfers would timeout and, because omap_hsmmc depends
> on an I2C-connected device to detect if an MMC card is
> inserted in the slot, our rootfs would just vanish.
>
> arch/arm/kernel/sched_clock.c already had an optional
> implementation (sched_clock_needs_suspend()) which would
> handle scheduler's requirement properly, what this patch
> does is simply to make that implementation non-optional.
>
> Note that this has the side-effect that printk timings
> won't reflect the actual time spent on suspend so other
> methods to measure that will have to be used.
>
> This has been tested with beagleboard XM (OMAP3630) and
> pandaboard rev A3 (OMAP4430). Suspend to RAM is now working
> after this patch.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>
