From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH 05/10] ARM: OMAP2+: Disable GPIO softreset for dm81xx
Date: Wed, 2 Dec 2015 01:10:10 +0100
Message-ID: <CAALWOA-Cy7MUUE-6i7sovSQLj8g86E1gZu06+45oB20QGGQweA@mail.gmail.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com> <1449013103-23238-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449013103-23238-6-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On 2 December 2015 at 00:38, Tony Lindgren <tony@atomide.com> wrote:
> Looks like GPIO softreset status bit on both dm8168 and dm8148
> is broken and only goes high initially. After writing to sysc
> softreset bit, the resetdone bit never goes high again.

The resetdone bit works fine, but it needs all clocks active to come
up. You're neglecting to enable the debounce clock to the GPIO module:

> # mw.l 0x4818155c 0x2

That should write 0x102 instead.

You can disable the debounce clock after resetting the module if you
don't need it, though I doubt there's any significant power savings
there. (More likely it exists as a separate bit to allow it to stay
enabled even if the module isn't, for wakeup on debounced inputs.)

Matthijs
