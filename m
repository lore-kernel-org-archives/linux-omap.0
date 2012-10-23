From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: sched: stop sched_clock() during suspend
Date: Tue, 23 Oct 2012 10:22:31 +0100
Message-ID: <20121023092231.GE28061@n2100.arm.linux.org.uk>
References: <1350906877-19410-1-git-send-email-balbi@ti.com>
 <873916h1yi.fsf@deeprootsystems.com>
 <CACRpkdY6ox+iJAGdSD=e7Yj55TzDWqOmLqu2fSRXvKJxqwfkhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdY6ox+iJAGdSD=e7Yj55TzDWqOmLqu2fSRXvKJxqwfkhQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Kevin Hilman <khilman@deeprootsystems.com>, Daniel Walker <dwalker@fifo99.com>, Thomas Gleixner <tglx@linutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Barry Song <21cnbao@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lennert Buytenhek <kernel@wantstofly.org>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, John Stultz <john.stultz@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Alexander Schulz <alex@shark-linux.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Bryan Huntsman <bryanh@codeaurora.org>, Santosh
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 23, 2012 at 12:28:32AM +0200, Linus Walleij wrote:
> On Mon, Oct 22, 2012 at 7:05 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
> 
> > However, in light of RT throttling, this a correctness issue for process
> > accounting, so I agree that this should be done for all platforms
> > instead of providing an optional 'needs suspend' version of the API,
> > even though it means printk times no longer reflect time spent
> > suspended.
> 
> Maybe we should get printk() to use the best clocksource
> instead.
> 
> The reason AFAICT that printk() is using sched_clock() is that
> it's supposed to be fast. But now it seems that it's not going
> to return what printk() needs anymore.

No, printk() does not need this.  You think it does, but it doesn't.  What
we have is a difference between ARM and x86, and this difference is breaking
the scheduler.

The fact that the printk timestamp increments while suspended is a bug.  It
doesn't on x86.

There's three other functions in the kernel which do return updated time.
I'm sure one of those can be used to printk() the time passed in suspend
at resume time, which would give the information required.
