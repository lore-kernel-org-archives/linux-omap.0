From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
Date: Wed, 13 Apr 2016 17:40:50 -0700
Message-ID: <20160414004050.GJ14441@codeaurora.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
 <20160408003328.GA14441@codeaurora.org>
 <20160408100600.GI1668@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160408100600.GI1668@linux-mips.org>
Sender: linux-clk-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Greg Ungerer <gerg@uclinux.org>, Ryan Mallon <rmallon@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Simon Horman <horms@verge.net.au>, Wan ZongShun <mcuos.com@gmail.com>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, adi-buildroot-devel@lists.sourceforge.net, Russell King <linux@arm.linux.org.uk>, linux-m68k@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, John Crispin <blogic@openwrt.org>H
List-Id: linux-omap@vger.kernel.org

On 04/08, Ralf Baechle wrote:
> 
> While your argument makes perfect sense, Many clk_disable implementations
> are already doing similar checks, for example:
> 
> arch/arm/mach-davinci/clock.c:
> 
[...]
> 
> So should we go and weed out these checks?

Yes, it would be nice to at least make the differing
implementations of the clk API consistent. Of course, we should
really put our efforts towards getting rid of the non-CCF
implementations instead so that there's less confusion overall.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
