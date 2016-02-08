From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: drop unused Makefile.boot of Multiplatform SoCs
Date: Mon, 8 Feb 2016 12:03:24 -0800
Message-ID: <20160208200324.GY19432@atomide.com>
References: <1454693808-13081-1-git-send-email-yamada.masahiro@socionext.com>
 <56B4E2B0.8060808@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56B4E2B0.8060808@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, arm@kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Barry Song <baohua@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Krzysztof Halasa <khalasa@piap.pl>, Viresh Kumar <vireshk@kernel.org>, =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, spear-devel@list.st.com, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@ker>
List-Id: linux-omap@vger.kernel.org

* Michal Simek <michal.simek@xilinx.com> [160205 09:59]:
> On 5.2.2016 18:36, Masahiro Yamada wrote:
> > The variable "MACHINE" is empty if CONFIG_ARCH_MULTIPLATFORM=y,
> > so these Makefile.boot files are never included.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> > 
> >  arch/arm/mach-cns3xxx/Makefile.boot    | 3 ---
> >  arch/arm/mach-exynos/Makefile.boot     | 2 --
> >  arch/arm/mach-integrator/Makefile.boot | 4 ----
> >  arch/arm/mach-keystone/Makefile.boot   | 1 -
> >  arch/arm/mach-mmp/Makefile.boot        | 1 -
> >  arch/arm/mach-mv78xx0/Makefile.boot    | 3 ---
> >  arch/arm/mach-nspire/Makefile.boot     | 0
> >  arch/arm/mach-omap2/Makefile.boot      | 3 ---
> >  arch/arm/mach-orion5x/Makefile.boot    | 3 ---
> >  arch/arm/mach-prima2/Makefile.boot     | 3 ---
> >  arch/arm/mach-realview/Makefile.boot   | 9 ---------
> >  arch/arm/mach-s3c64xx/Makefile.boot    | 2 --
> >  arch/arm/mach-spear/Makefile.boot      | 3 ---
> >  arch/arm/mach-u300/Makefile.boot       | 4 ----
> >  arch/arm/mach-ux500/Makefile.boot      | 3 ---
> >  arch/arm/mach-zynq/Makefile.boot       | 3 ---
> 
> Acked-by: Michal Simek <michal.simek@xilinx.com> (for Zynq)

I doubt anybody wants to go back to disabling MULTIPLATFORM:

Acked-by: Tony Lindgren <tony@atomide.com>
