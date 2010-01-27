From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] gic: Add set_type callback
Date: Wed, 27 Jan 2010 23:09:58 +0000
Message-ID: <20100127230958.GE29665@n2100.arm.linux.org.uk>
References: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
	<1264620749-24527-4-git-send-email-adharmap@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1264620749-24527-4-git-send-email-adharmap@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: adharmap@codeaurora.org
Cc: Kalle Valo <kalle.valo@iki.fi>, Linus Walleij <linus.walleij@stericsson.com>, Jean Pihet <jpihet@mvista.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Abhijeet Dharmapurikar <adharmap@quicinc.com>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Andrea Gallo <andrea.gallo@stericsson.com>, Colin Tuckley <colin.tuckley@arm.com>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Philby John <pjohn@in.mvista.com>, linux-arm-kernel@lists.infradead.org, Alessandro Rubini <rubini@unipv.it>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 27, 2010 at 11:32:27AM -0800, adharmap@codeaurora.org wrote:
> +	if (irq > 1020)
> +		return -1;

*unprintable*.  Always use proper error codes.

> +
> +	/*
> +	* Two bits each, calc the register and bit, 16 per 32 bit register
> +	* accessible long word only
> +	* But the field is NxN 1xN and rising/falling
> +	*/
> +	register_index = (irq/16)<<2;
> +	bit_index = (irq & 0xF)<<1;
> +
> +	spin_lock(&irq_controller_lock);
> +	reg_value = readl(gic_dist_base(irq) + GIC_DIST_CONFIG +
> +						register_index);
> +	/*
> +	* keep the nxn and 1xn , mask the edge level
> +	* Edge is 1, level 0
> +	*/
> +	reg_value = (reg_value & ~(2<<bit_index));
> +	if (flow_type & (IRQ_TYPE_EDGE_RISING|IRQ_TYPE_EDGE_FALLING)) {
> +		reg_value |= (2<<bit_index);
> +		writel(reg_value, gic_dist_base(irq) + GIC_DIST_CONFIG
> +							+ register_index);
> +		__set_irq_handler_unlocked(irq, handle_edge_irq);
> +	}
> +
> +	if (flow_type & (IRQ_TYPE_LEVEL_HIGH|IRQ_TYPE_LEVEL_LOW)) {
> +		writel(reg_value, gic_dist_base(irq) + GIC_DIST_CONFIG
> +							+ register_index);
> +		__set_irq_handler_unlocked(irq, handle_level_irq);
> +	}

This needs to exclude the first 32 interrupts, where the interrupt
configuration is either read-only or banked between multiprocessor
CPUs.
