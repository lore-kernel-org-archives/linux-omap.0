From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 06/13] clocksource: add common mmio clocksource
Date: Tue, 10 May 2011 10:59:20 +0100
Message-ID: <20110510095920.GB29977@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Alessandro Rubini <rubini@unipv.it>, Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Imre Kaloz <kaloz@openwrt.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <kernel@pengutronix.de>, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>, Lennert Buytenhek <kernel@wantstofly.org>, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: linux-omap@vger.kernel.org

On Tue, May 10, 2011 at 08:29:18AM +0100, Russell King - ARM Linux wrote:
> +cycle_t clocksource_mmio_readl_up(struct clocksource *c)
> +{
> +	return readl_relaxed(to_mmio_clksrc(c)->reg);
> +}
> +
> +cycle_t clocksource_mmio_readl_down(struct clocksource *c)
> +{
> +	return ~readl_relaxed(to_mmio_clksrc(c)->reg);
> +}
> +
> +cycle_t clocksource_mmio_readw_up(struct clocksource *c)
> +{
> +	return readw_relaxed(to_mmio_clksrc(c)->reg);
> +}
> +
> +cycle_t clocksource_mmio_readw_down(struct clocksource *c)
> +{
> +	return ~(unsigned)readw_relaxed(to_mmio_clksrc(c)->reg);
> +}

I probably ought to point out why that cast is there: readw* returns an
u16.

u16 will be promoted to 'int' by the compiler, then not'd, and then
extended to cycle_t (64-bit).  This extension is a signed extension
which not only results in more code than required, but also results in
a delay slot not being filled.

It's the u16 -> signed int -> cycle_t which causes the signed extension.

u16 -> cycle_t doesn't involve changing the signed-ness of the type, so
doesn't suffer.

Neither does readl as it returns a u32 which doesn't need any promotion
to an int type.

So, rather than allow the compiler to do automatic promotion to a signed
int, the cast is there to ensure that it becomes an unsigned int instead.
