From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 29/35] arm: omap: intc: switch over to linear irq domain
Date: Tue, 29 Jul 2014 05:14:25 -0700
Message-ID: <20140729121425.GR29045@atomide.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-30-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406582183-696-30-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, bcousson@baylibre.com, linux@arm.linux.org.uk, khilman@deeprootsystems.com, tglx@linutronix.de, jason@lakedaemon.net, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [140728 14:19]:
> now that we don't need to support legacy board-files,
> we can completely switch over to a linear irq domain
> and make use of irq_alloc_domain_generic_chips() to
> allocate all generic irq chips for us.

This patch seems to somehow break off-idle for omap3 
where it no longer wakes up.

Other than that, this whole series boots fine for me.

Regards,

Tony
