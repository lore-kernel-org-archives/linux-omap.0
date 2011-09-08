From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
	gic_arch_extn
Date: Thu, 08 Sep 2011 11:27:25 -0700
Message-ID: <878vpyhotu.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sun, 4 Sep 2011 19:24:14 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> OMAP WakeupGen is the interrupt controller extension used along
> with ARM GIC to wake the CPU out from low power states on
> external interrupts.
>
> The WakeupGen unit is responsible for generating wakeup event
> from the incoming interrupts and enable bits. It is implemented
> in MPU always ON power domain. During normal operation,
> WakeupGen delivers external interrupts directly to the GIC.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

[...]

> +#ifdef CONFIG_PM
> +/*
> + * Masking wakeup irqs is handled by the IRQCHIP_MASK_ON_SUSPEND flag,
> + * so no action is necessary in set_wake, but implement an empty handler
> + * here to prevent enable_irq_wake() returning an error.
> + * FIXME: Remove the dummy handler once gen irq code fix above.
> + */

Just curious... is there a fix for this pending for v3.2?

Kevin
