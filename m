From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] omap3: Add cpuidle parameters table for omap3430
Date: Tue, 16 Feb 2016 11:01:43 +0100
Message-ID: <56C2F387.3040803@linaro.org>
References: <20160215152542.GS19432@atomide.com>
 <1455559328-19783-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455559328-19783-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 02/15/2016 07:02 PM, Pali Roh=C3=A1r wrote:
> Based on CPU type choose generic omap3 or omap3430 specific cpuidle
> parameters. Parameters for omap3430 were measured on Nokia N900 devic=
e and
> added by commit 5a1b1d3a9efa ("OMAP3: RX-51: Pass cpu idle parameters=
")
> which were later removed by commit 231900afba52 ("ARM: OMAP3: cpuidle=
 -
> remove rx51 cpuidle parameters table") due to huge code complexity.
>
> This patch brings cpuidle parameters for omap3430 devices again, but =
uses
> simple condition based on CPU type.
>
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Fixes: 231900afba52d6faddfb480cde4132d4edc089bc
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
