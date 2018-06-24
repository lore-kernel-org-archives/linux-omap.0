From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/8] arm: time: Remove the persistent clock support for
 ARM architecture
Date: Sun, 24 Jun 2018 02:21:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1806240215310.8650@nanos.tec.linutronix.de>
References: <cover.1528878545.git.baolin.wang@linaro.org>
 <ec57a4f5d7ba300540b99236e6eef1b551b152dc.1528878545.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ec57a4f5d7ba300540b99236e6eef1b551b152dc.1528878545.git.baolin.wang@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: mark.rutland@arm.com, kstewart@linuxfoundation.org, alexandre.belloni@bootlin.com, x86@kernel.org, heiko@sntech.de, tony@atomide.com, viresh.kumar@linaro.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, hpa@zytor.com, mingo@kernel.org, aaro.koskinen@iki.fi, daniel.lezcano@linaro.org, linux@armlinux.org.uk, jonathanh@nvidia.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, len.brown@intel.com, arnd@arndb.de, marc.zyngier@arm.com, mlichvar@redhat.com, broonie@kernel.org, john.stultz@linaro.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, douly.fnst@cn.fujitsu.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, rajvi.jingar@intel.com, pombredanne@nexb.com
List-Id: linux-omap@vger.kernel.org

On Wed, 13 Jun 2018, Baolin Wang wrote:

> We have introduced the persistent clock framework to support the OS time
> compensating from persistent clock, and we will convert all drivers to
> use common persistent clock framework instead of the persistent clock
> support used only for the ARM architecture. So we can remove these code
> with converting the Omap 32k counter and tegra20 timer.

Why did I look at that in the first place? But as I did, I just have to
say, it's just consistent trainwreck engineering. Remove working code first
and then add new one.

Hell NO! This is not how it works. We add new infrastructure - if required
with some extra temporary helpers - while keeping the existing
functionality intact. Then we convert the users of the old infrastructure
over and when the last user is gone, we remove that including all temporary
helpers.

That's not something fundamentally new. It's documented all over the place.

Thanks,

	tglx
