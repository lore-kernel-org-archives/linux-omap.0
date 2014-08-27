From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: Re: [PATCH v2 21/26] irqchip: or1k-pic: convert to
	handle_domain_irq
Date: Wed, 27 Aug 2014 20:09:06 +0300
Message-ID: <20140827170905.GA5838@chokladfabriken.org>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
	<1409047421-27649-22-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
Content-Disposition: inline
In-Reply-To: <1409047421-27649-22-git-send-email-marc.zyngier@arm.com>
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
Cc: mark.rutland@arm.com, tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com, linux@lists.openrisc.net, tglx@linutronix.de, lorenzo.pieralisi@arm.com, linux@arm.linux.org.uk, shc_work@mail.ru, shawn.guo@freescale.com, khilman@linaro.org, jason@lakedaemon.net, larry.bassel@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, baohua@kernel.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, sudeep.holla@arm.com, schwidefsky@de.ibm.com, maxime.ripard@free-electrons.com, vkale@apm.com
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 26, 2014 at 11:03:36AM +0100, Marc Zyngier wrote:
> Use the new handle_domain_irq method to handle interrupts.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

This (and the other two openrisc related patches in this series) works fine
in my setup at least.

Acked-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
