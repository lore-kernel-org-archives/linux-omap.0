From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC PATCH v2 3/5] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
Date: Tue, 11 Dec 2012 15:27:39 -0800
Message-ID: <50C7C16B.7050106@codeaurora.org>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com> <1347986135-17979-4-git-send-email-lorenzo.pieralisi@arm.com> <20120919134658.GA2111@linaro.org> <20120920102514.GD4588@e102568-lin.cambridge.arm.com> <20120920110439.GB2117@linaro.org> <Pine.LNX.4.64.1212111655050.29758@axis700.grange> <20121211163313.GG16759@mudshark.cambridge.arm.com> <20121211163843.GH16759@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20121211163843.GH16759@mudshark.cambridge.arm.com>
Sender: linux-sh-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Nicolas Pitre <nicolas.pitre@linaro.org>, Dave Martin <dave.martin@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Simon Horman <horms@verge.net.au>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Colin Cross <ccross@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Wenzeng Chen <wzch@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 12/11/12 08:38, Will Deacon wrote:
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index cd95664..f58248f 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -44,7 +44,8 @@ ENDPROC(v7_flush_icache_all)
>  ENTRY(v7_flush_dcache_louis)
>         dmb                                     @ ensure ordering with previous memory accesses
>         mrc     p15, 1, r0, c0, c0, 1           @ read clidr, r0 = clidr
> -       ands    r3, r0, #0xe00000               @ extract LoUIS from clidr
> +       ALT_SMP(ands    r3, r0, #(7 << 21))     @ extract LoUIS from clidr
> +       ALT_UP(ands     r3, r0, #(7 << 27))     @ extract LoUU from clidr
>         mov     r3, r3, lsr #20                 @ r3 = LoUIS * 2

You need to fix this mov as well, right?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

