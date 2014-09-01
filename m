From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 01/26] genirq: add irq_domain-aware core IRQ handler
Date: Mon, 1 Sep 2014 16:22:48 +0100
Message-ID: <20140901152248.GA30405@n2100.arm.linux.org.uk>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com> <1409047421-27649-2-git-send-email-marc.zyngier@arm.com> <53FCC714.3090206@codeaurora.org> <53FCCCC7.9070801@arm.com> <53FCD60E.1030009@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53FCD60E.1030009@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux@openrisc.net" <linux@openrisc.net>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "tony@atomide.com" <tony@atomide.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "jonas@southpole.se" <jonas@southpole.se>, "tglx@linutronix.de" <tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "shc_work@mail.ru" <shc_work@mail.ru>, "baohua@kernel.org" <baohua@kernel.org>, "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>, "khilman@linaro.org" <khilman@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>l
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 26, 2014 at 11:46:38AM -0700, Stephen Boyd wrote:
> Ah ok. This is the multi-irq handler case? Has this been broken since
> v3.2 at least for the gic users? Now that we call irq_enter()/irq_exit()
> a lot more code runs, including things like updating jiffies when
> interrupts arrive and invoking softirq? Do we only call irq_exit() on
> the IPI path otherwise?
> 
> Are there any plans to send this back to stable trees? Not calling
> irq_enter()/irq_exit() when we get an interrupt seems like a big problem.

gic_handle_irq() calls handle_IRQ() which has the irq_enter()..irq_exit()
wrappers.

If we didn't have irq_exit(), then softirq's would be totally broken on
all gic-based platforms.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
