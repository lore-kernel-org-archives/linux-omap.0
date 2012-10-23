From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] arm: sched: stop sched_clock() during suspend
Date: Tue, 23 Oct 2012 07:17:33 -0700
Message-ID: <87a9vdclxe.fsf@deeprootsystems.com>
References: <1350906877-19410-1-git-send-email-balbi@ti.com>
 <873916h1yi.fsf@deeprootsystems.com>
 <CACRpkdY6ox+iJAGdSD=e7Yj55TzDWqOmLqu2fSRXvKJxqwfkhQ@mail.gmail.com>
 <20121023092231.GE28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121023092231.GE28061@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 23 Oct 2012 10:22:31 +0100")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Walker <dwalker@fifo99.com>, Thomas Gleixner <tglx@linutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Barry Song <21cnbao@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lennert Buytenhek <kernel@wantstofly.org>, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, John Stultz <john.stultz@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Alexander Schulz <alex@shark-linux.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Bryan Huntsman <bryanh@codeaurora.org>, Santosh
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Tue, Oct 23, 2012 at 12:28:32AM +0200, Linus Walleij wrote:
>> On Mon, Oct 22, 2012 at 7:05 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>> 
>> > However, in light of RT throttling, this a correctness issue for process
>> > accounting, so I agree that this should be done for all platforms
>> > instead of providing an optional 'needs suspend' version of the API,
>> > even though it means printk times no longer reflect time spent
>> > suspended.
>> 
>> Maybe we should get printk() to use the best clocksource
>> instead.
>> 
>> The reason AFAICT that printk() is using sched_clock() is that
>> it's supposed to be fast. But now it seems that it's not going
>> to return what printk() needs anymore.
>
> No, printk() does not need this.  You think it does, but it doesn't.  What
> we have is a difference between ARM and x86, and this difference is breaking
> the scheduler.
>
> The fact that the printk timestamp increments while suspended is a bug.  It
> doesn't on x86.

Russell, I agree that it's a bug, but does it qualify as a something
you're willing to take for v3.7-rc?

For OMAP, we need to know if this will go for v3.7 or not because
there's a regression in the OMAP I2C driver, and if this doesn't go in,
we'll need to revert something in the I2C driver until it does.

Thanks,

Kevin
