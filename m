From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Subject: Re: [PATCH] ARM: drop unused Makefile.boot of Multiplatform SoCs
Date: Mon, 15 Feb 2016 08:02:20 +0100
Message-ID: <m3r3gebgn7.fsf@t19.piap.pl>
References: <1454693808-13081-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454693808-13081-1-git-send-email-yamada.masahiro@socionext.com>
	(Masahiro Yamada's message of "Sat, 6 Feb 2016 02:36:48 +0900")
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: arm@kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Barry Song <baohua@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Viresh Kumar <vireshk@kernel.org>, =?utf-8?Q?S=C3=B6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, spear-devel@list.st.com, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> The variable "MACHINE" is empty if CONFIG_ARCH_MULTIPLATFORM=3Dy,
> so these Makefile.boot files are never included.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/mach-cns3xxx/Makefile.boot    | 3 ---

Acked-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
--=20
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
