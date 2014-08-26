From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 02/26] arm64: convert handle_IRQ to use
 __handle_domain_irq
Date: Tue, 26 Aug 2014 17:51:38 +0100
Message-ID: <20140826165138.GM16482@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
	<1409047421-27649-3-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
Content-Disposition: inline
In-Reply-To: <1409047421-27649-3-git-send-email-marc.zyngier@arm.com>
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

On Tue, Aug 26, 2014 at 11:03:17AM +0100, Marc Zyngier wrote:
> In order to limit code duplication, convert the architecture specific
> handle_IRQ to use the generic __handle_domain_irq function.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/Kconfig      |  1 +
>  arch/arm64/kernel/irq.c | 18 +-----------------
>  2 files changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fd4e81a..1f16ed9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -30,6 +30,7 @@ config ARM64
>  	select GENERIC_STRNCPY_FROM_USER
>  	select GENERIC_STRNLEN_USER
>  	select GENERIC_TIME_VSYSCALL
> +	select HANDLE_DOMAIN_IRQ
>  	select HARDIRQS_SW_RESEND
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_JUMP_LABEL
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index 0f08dfd..2c0e2a7 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -48,23 +48,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>   */
>  void handle_IRQ(unsigned int irq, struct pt_regs *regs)
>  {
> -	struct pt_regs *old_regs = set_irq_regs(regs);
> -
> -	irq_enter();
> -
> -	/*
> -	 * Some hardware gives randomly wrong interrupts.  Rather
> -	 * than crashing, do something sensible.
> -	 */
> -	if (unlikely(irq >= nr_irqs)) {
> -		pr_warn_ratelimited("Bad IRQ%u\n", irq);
> -		ack_bad_irq(irq);
> -	} else {
> -		generic_handle_irq(irq);
> -	}
> -
> -	irq_exit();
> -	set_irq_regs(old_regs);
> +	__handle_domain_irq(NULL, irq, false, regs);
>  }

The only thing that's missing is a pr_warn_ratelimited(). Do we still
need it? We could add it to ack_bad_irq() though.

Either way:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
