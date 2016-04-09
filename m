From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 10/15] irqchip/gic: Remove static irq_chip definition
 for eoimode1
Date: Sat, 9 Apr 2016 12:38:25 +0100
Message-ID: <20160409123825.3550eb16@arm.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
	<1458224359-32665-11-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458224359-32665-11-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 17 Mar 2016 14:19:14 +0000
Jon Hunter <jonathanh@nvidia.com> wrote:

> There are only 3 differences (not including the name) in the definitions
> of the gic_chip and gic_eoimode1_chip structures. Instead of statically
> defining the gic_eoimode1_chip structure, remove it and populate the
> eoimode1 functions dynamically for the appropriate GIC irqchips.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Linus' remark notwithstanding,

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
