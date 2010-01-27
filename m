From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/5] gic: prevent gic from crossing NR_IRQ
Date: Wed, 27 Jan 2010 22:43:09 +0000
Message-ID: <20100127224309.GD29665@n2100.arm.linux.org.uk>
References: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
	<1264620749-24527-2-git-send-email-adharmap@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1264620749-24527-2-git-send-email-adharmap@codeaurora.org>
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

On Wed, Jan 27, 2010 at 11:32:25AM -0800, adharmap@codeaurora.org wrote:
> From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> 
> The gic code tries to initialize interrupts beyond NR_IRQ. Prevent
> code from doing that.

NAK.  This is completely the wrong approach.

        /*
         * Find out how many interrupts are supported.
         */
        max_irq = readl(base + GIC_DIST_CTR) & 0x1f;
        max_irq = (max_irq + 1) * 32;

        /*
         * The GIC only supports up to 1020 interrupt sources.
         * Limit this to either the architected maximum, or the
         * platform maximum.
         */
        if (max_irq > max(1020, NR_IRQS))
                max_irq = max(1020, NR_IRQS);
...
        for (i = irq_start; i < gic_data[gic_nr].irq_offset + max_irq; i++) {

This function is broken if irq_start != 0, and needs fixing - max_irq
needs to be limited to the _minimum_ of 1020 or NR_IRQS - irq_start.
