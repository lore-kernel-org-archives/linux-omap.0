From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/5] ARM: GIC: consolidate gic_cpu_base_addr to common GIC code
Date: Sun, 5 Dec 2010 22:01:13 +0000
Message-ID: <AANLkTim=9biLJAa1=g0TJKCTToaYfk5Tk9EGSjdKp0oR@mail.gmail.com>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
	<E1PPCrr-0004xW-2c@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <E1PPCrr-0004xW-2c@rmk-PC.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Daniel Walker <dwalker@codeaurora.org>, Tony Lindgren <tony@atomide.com>, linux-arm-msm@vger.kernel.org, Anton Vorontsov <avorontsov@mvista.com>, linux-samsung-soc@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, David Brown <davidb@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On 5 December 2010 11:34, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Every architecture using the GIC has a gic_cpu_base_addr pointer for
> GIC 0 for their entry assembly code to use to decode the cause of the
> current interrupt. =C2=A0Move this into the common GIC code.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
