From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 25/26] arm64: get rid of handle_IRQ
Date: Tue, 26 Aug 2014 17:53:06 +0100
Message-ID: <20140826165304.GN16482@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
	<1409047421-27649-26-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
Content-Disposition: inline
In-Reply-To: <1409047421-27649-26-git-send-email-marc.zyngier@arm.com>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "tony@atomide.com" <tony@atomide.com>, "linux@openrisc.net" <linux@openrisc.net>, Will Deacon <Will.Deacon@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "shc_work@mail.ru" <shc_work@mail.ru>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>, "khilman@linaro.org" <khilman@linaro.org>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "larry.bassel@linaro.org" <larry.bassel@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "baohua@kernel.org" <baohua@kernel.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Sudeep
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 26, 2014 at 11:03:40AM +0100, Marc Zyngier wrote:
> All the arm64 irqchip drivers have been converted to handle_domain_irq,
> making it possible to remove the handle_IRQ stub entierely.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
