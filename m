From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/40] Complete set of clocksource/sched_clock patches
Date: Tue, 21 Dec 2010 11:24:30 -0800
Message-ID: <87pqsvx72p.fsf@deeprootsystems.com>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20101217113223.GC9937@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri, 17 Dec 2010 11:32:23 +0000")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alessandro Rubini <rubini@unipv.it>, Bryan Huntsman <bryanh@codeaurora.org>, Colin Cross <ccross@android.com>, Daniel Walker <dwalker@codeaurora.org>, David Brown <davidb@codeaurora.org>, Eric Miao <eric.y.miao@gmail.com>, Erik Gilling <konkers@android.com>, "Hans J. Koch" <hjk@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khc@pm.waw.pl>, Kukjin Kim <kgene.kim@samsung.com>, Lennert Buytenhek <kernel@wantstofly.org>, Jiandong Zheng <jdzheng@broadcom.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Olof Johansson <olof@lixom.net>, Sascha Hauer <kernel@pengutronix.de>, Scott Branden <sbranden@broadcom.com>, STEricsson <STEricsson_nomadik_linux@list.st.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Here is the entire set of clocksource and sched_clock patches which
> have been previously posted.  There's a couple of small tweaks in a
> few of the patches (such as adding notrace to OMAP clocksource read
> functions), and this also shows the proper ordering of these patches.
>
> Still looking for acks or tested-by's for these patches.

Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

on a few davinci platforms.

Kevin
