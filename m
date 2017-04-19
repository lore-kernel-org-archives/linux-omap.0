From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3] PM / OPP: Use - instead of @ for DT entries
Date: Thu, 20 Apr 2017 00:06:03 +0200
Message-ID: <3142028.bncGUUQ4qB@aspire.rjw.lan>
References: <734c5d5a66ef8a5505f368fc68a8ab9c02d710f9.1492492253.git.viresh.kumar@linaro.org> <20170419142215.GA12105@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170419142215.GA12105@localhost>
Sender: linux-pm-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, arm@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Beno??t Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Masahiro
List-Id: linux-omap@vger.kernel.org

On Wednesday, April 19, 2017 07:22:15 AM Olof Johansson wrote:
> Hi Viresh,
> 
> On Tue, Apr 18, 2017 at 10:44:50AM +0530, Viresh Kumar wrote:
> > Compiling the DT file with W=1, DTC warns like follows:
> > 
> > Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> > unit name, but no reg property
> > 
> > Fix this by replacing '@' with '-' as the OPP nodes will never have a
> > "reg" property.
> > 
> > Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com> (sunxi)
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com> (uniphier)
> > Acked-by: Rob Herring <robh@kernel.org>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> We've already turned down other patches that does this in a sweeping manner
> like this, since they tend to be conflict prone with other DT changes.
> 
> Please split per platform and merge with each maintainer.

OK

So I'm assuming that you guys will take care of this going forward.

Thanks,
Rafael
