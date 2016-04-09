From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 12/15] irqchip/gic: Pass GIC pointer to save/restore
 functions
Date: Sat, 9 Apr 2016 12:52:07 +0100
Message-ID: <20160409125207.4f1d73dd@arm.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
	<1458224359-32665-13-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458224359-32665-13-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 17 Mar 2016 14:19:16 +0000
Jon Hunter <jonathanh@nvidia.com> wrote:

> Instead of passing the GIC index to the save/restore functions pass a
> pointer to the GIC chip data. This will allow these save/restore
> functions to be re-used by a platform driver where the GIC chip data
> structure is allocated dynamically and so there is no applicable index
> for identifying the GIC.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Eventually, I'd like to move to a situation where we don't statically
allocate the chip data anymore, and kill CONFIG_ARM_GIC_MAX_NR
altogether. This is obviously a step in the right direction.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
