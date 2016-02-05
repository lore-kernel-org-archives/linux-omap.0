From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] ARM: drop unused Makefile.boot of Multiplatform SoCs
Date: Fri, 5 Feb 2016 18:58:08 +0100
Message-ID: <56B4E2B0.8060808@xilinx.com>
References: <1454693808-13081-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454693808-13081-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, arm@kernel.org
Cc: Gregory Clement <gregory.clement@free-electrons.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Barry Song <baohua@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Krzysztof Halasa <khalasa@piap.pl>, Viresh Kumar <vireshk@kernel.org>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, spear-devel@list.st.com, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 5.2.2016 18:36, Masahiro Yamada wrote:
> The variable "MACHINE" is empty if CONFIG_ARCH_MULTIPLATFORM=y,
> so these Makefile.boot files are never included.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/mach-cns3xxx/Makefile.boot    | 3 ---
>  arch/arm/mach-exynos/Makefile.boot     | 2 --
>  arch/arm/mach-integrator/Makefile.boot | 4 ----
>  arch/arm/mach-keystone/Makefile.boot   | 1 -
>  arch/arm/mach-mmp/Makefile.boot        | 1 -
>  arch/arm/mach-mv78xx0/Makefile.boot    | 3 ---
>  arch/arm/mach-nspire/Makefile.boot     | 0
>  arch/arm/mach-omap2/Makefile.boot      | 3 ---
>  arch/arm/mach-orion5x/Makefile.boot    | 3 ---
>  arch/arm/mach-prima2/Makefile.boot     | 3 ---
>  arch/arm/mach-realview/Makefile.boot   | 9 ---------
>  arch/arm/mach-s3c64xx/Makefile.boot    | 2 --
>  arch/arm/mach-spear/Makefile.boot      | 3 ---
>  arch/arm/mach-u300/Makefile.boot       | 4 ----
>  arch/arm/mach-ux500/Makefile.boot      | 3 ---
>  arch/arm/mach-zynq/Makefile.boot       | 3 ---

Acked-by: Michal Simek <michal.simek@xilinx.com> (for Zynq)

Thanks,
Michal
