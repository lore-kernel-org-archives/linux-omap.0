From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] arm: sched: stop sched_clock() during suspend
Date: Tue, 23 Oct 2012 00:28:32 +0200
Message-ID: <CACRpkdY6ox+iJAGdSD=e7Yj55TzDWqOmLqu2fSRXvKJxqwfkhQ@mail.gmail.com>
References: <1350906877-19410-1-git-send-email-balbi@ti.com>
	<873916h1yi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <873916h1yi.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Walker <dwalker@fifo99.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kukjin Kim <kgene.kim@samsung.com>, Bryan Huntsman <bryanh@codeaurora.org>, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Ben Dooks <ben-linux@fluff.org>, Alexander Schulz <alex@shark-linux.de>, Andrew Victor <linux@maxim.org.za>, Kyungmin Park <kyungmin.park@samsung.com>, Sascha Hauer <kernel@pengutronix.de>, Olof Johansson <olof@li>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 22, 2012 at 7:05 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:

> However, in light of RT throttling, this a correctness issue for process
> accounting, so I agree that this should be done for all platforms
> instead of providing an optional 'needs suspend' version of the API,
> even though it means printk times no longer reflect time spent
> suspended.

Maybe we should get printk() to use the best clocksource
instead.

The reason AFAICT that printk() is using sched_clock() is that
it's supposed to be fast. But now it seems that it's not going
to return what printk() needs anymore.

(Dragging Stultz & Gleixner into this...)

Yours,
Linus Walleij
