From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 06/13] clocksource: add common mmio clocksource
Date: Tue, 10 May 2011 09:46:48 +0100
Message-ID: <20110510084648.GA31122@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
	<20110510083841.GF30963@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110510083841.GF30963@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, John Stultz <johnstul@us.ibm.com>, Krzysztof Halasa <khc@pm.waw.pl>, linux-omap@vger.kernel.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <kernel@pengutronix.de>, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Wan ZongShun <mcuos.com@gmail.com>, Lennert Buytenhek <kernel@wantstofly.org>, linux-arm-kernel@lists.infradead.org, Alessandro Rubini <rubini@unipv.it>
List-Id: linux-omap@vger.kernel.org

On Tue, May 10, 2011 at 10:38:41AM +0200, Sascha Hauer wrote:
> You forgot to initialize cs->reg. With this:

Damnit.  Fixed.

> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks.
