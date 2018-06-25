From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/8] time: Add persistent clock support
Date: Mon, 25 Jun 2018 18:18:47 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1806251815320.1821@nanos.tec.linutronix.de>
References: <cover.1528878545.git.baolin.wang@linaro.org> <d330f02c8ef2a348b179850e1745a52ab9c47e90.1528878545.git.baolin.wang@linaro.org> <alpine.DEB.2.21.1806232224510.8650@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1806232224510.8650@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com, marc.zyngier@arm.com, broonie@kernel.org, paulmck@linux.vnet.ibm.com, mlichvar@redhat.com, rdunlap@infradead.org, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de, linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org, hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com, len.brown@intel.com, rajvi.jingar@intel.com, alexandre.belloni@bootlin.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, 24 Jun 2018, Thomas Gleixner wrote:
> The clocksource core already has all the registration/unregistration
> functionality plus an interface to reconfigure the frequency, so
> clocksources can come and go and be reconfigured and all of this just
> works.

Just for completeness sake.

If this extra suspend clocksource is not needed, i.e. because the system is
not suspended, then it does not need to be enabled. clocksources already
have an enable/disable callback exactly for that purpose. So instead of
having the clocks running during normal system operation the thing can be
OFF and save power and only be switched to ON when it is actually needed,
i.e. when going into suspend.

Thanks,

	tglx
