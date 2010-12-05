From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 2/5] ARM: GIC: Remove MMIO address from gic_cpu_init,
 rename to gic_secondary_init
Date: Sun, 5 Dec 2010 21:47:25 +0000
Message-ID: <AANLkTi=exHys8FBAvLmk0HHQu8w+a3=WzGYVaRtkWcq_@mail.gmail.com>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
	<E1PPCrW-0004xS-L5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <E1PPCrW-0004xS-L5@rmk-PC.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Erik Gilling <konkers@android.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-omap@vger.kernel.org

On 5 December 2010 11:34, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> We don't need to re-pass the base address for the CPU interfaces to the
> GIC for secondary CPUs, as it will never be different from the boot CPU
> - and even if it was, we'd overwrite the boot CPU's base address.
>
> Get rid of this argument, and rename to gic_secondary_init().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

(minor issue, maybe a comment for gic_secondary_init just in case
anyone things about primary and secondary GICs).
