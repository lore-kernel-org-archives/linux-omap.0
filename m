From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ARM: drop unused Makefile.boot of Multiplatform SoCs
Date: Mon, 8 Feb 2016 13:36:21 -0800
Message-ID: <20160208213621.GD25468@localhost>
References: <1454693808-13081-1-git-send-email-yamada.masahiro@socionext.com>
 <56B4E2B0.8060808@xilinx.com> <20160208200324.GY19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160208200324.GY19432@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-samsung-soc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Viresh Kumar <vireshk@kernel.org>, Michal Simek <michal.simek@xilinx.com>, arm@kernel.org, S??ren Brinkmann <soren.brinkmann@xilinx.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, spear-devel@list.st.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Krzysztof Halasa <khalasa@piap.pl>, Santosh Shilimkar <ssantosh@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Barry Song <baohua@kernel.org>, Eric Miao <eric.y.miao@gmail.com>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 08, 2016 at 12:03:24PM -0800, Tony Lindgren wrote:
> * Michal Simek <michal.simek@xilinx.com> [160205 09:59]:
> > On 5.2.2016 18:36, Masahiro Yamada wrote:
> > > The variable "MACHINE" is empty if CONFIG_ARCH_MULTIPLATFORM=y,
> > > so these Makefile.boot files are never included.
> > > 
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > > 
> > >  arch/arm/mach-cns3xxx/Makefile.boot    | 3 ---
> > >  arch/arm/mach-exynos/Makefile.boot     | 2 --
> > >  arch/arm/mach-integrator/Makefile.boot | 4 ----
> > >  arch/arm/mach-keystone/Makefile.boot   | 1 -
> > >  arch/arm/mach-mmp/Makefile.boot        | 1 -
> > >  arch/arm/mach-mv78xx0/Makefile.boot    | 3 ---
> > >  arch/arm/mach-nspire/Makefile.boot     | 0
> > >  arch/arm/mach-omap2/Makefile.boot      | 3 ---
> > >  arch/arm/mach-orion5x/Makefile.boot    | 3 ---
> > >  arch/arm/mach-prima2/Makefile.boot     | 3 ---
> > >  arch/arm/mach-realview/Makefile.boot   | 9 ---------
> > >  arch/arm/mach-s3c64xx/Makefile.boot    | 2 --
> > >  arch/arm/mach-spear/Makefile.boot      | 3 ---
> > >  arch/arm/mach-u300/Makefile.boot       | 4 ----
> > >  arch/arm/mach-ux500/Makefile.boot      | 3 ---
> > >  arch/arm/mach-zynq/Makefile.boot       | 3 ---
> > 
> > Acked-by: Michal Simek <michal.simek@xilinx.com> (for Zynq)
> 
> I doubt anybody wants to go back to disabling MULTIPLATFORM:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Agreed. I've applied to next/cleanup now.


-Olof
