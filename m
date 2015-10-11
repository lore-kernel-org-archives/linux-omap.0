From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched_clock: add data pointer argument to read
 callback
Date: Sun, 11 Oct 2015 22:40:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1510112238380.6097@nanos>
References: <1444427858-576-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1444427858-576-1-git-send-email-mans@mansr.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Mans Rullgard <mans@mansr.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Tony Lindgren <tony@atomide.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>C
List-Id: linux-omap@vger.kernel.org

Mans,

On Fri, 9 Oct 2015, Mans Rullgard wrote:

> This passes a data pointer specified in the sched_clock_register()
> call to the read callback allowing simpler implementations thereof.
>
> In this patch, existing uses of this interface are simply updated
> with a null pointer.

I can't see any simplifaction of any driver. This is called in hot
pathes and that extra unused argument just adds register pressure for
no value.

What are you actually trying to solve?

Thanks,

	tglx
