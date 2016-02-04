From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Thu, 4 Feb 2016 14:41:29 -0800
Message-ID: <20160204224128.GG4215@xsjsorenbubuntu>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, tony@atomide.com, nsekhar@ti.com, linux-omap@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, kernel@stlinux.com, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Wei Xu <xuwei5@hisilicon.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Jun Nie <jun.nie@linaro.org>, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 2016-02-04 at 20:20:17 +0200, Grygorii Strashko wrote:
> This patch intended to fix following cases:=20
> - SoC-A has ARM GT, defines DT node for ARM GT and selects ARM_GLOBAL=
_TIMER
> statically in Kconfig file. SoC-B has ARM GT and defines DT node for =
ARM GT,
> but do not selects ARM_GLOBAL_TIMER statically in Kconfig file. In ca=
se of
> multiplatform build ARM GT will be implicitly enabled for SoC-B.
>=20
> - There is no way to disable ARM GT without modifying Kconfig file,
> once ARM_GLOBAL_TIMER is selected statically in Kconfig file.
>=20
> Hence, fix above case by defining both HAVE_ARM_GLOBAL_TIMER and
> ARM_GLOBAL_TIMER as recommended by 'Adding common features and make
> the usage configurable' section in kconfig-language.txt. All places i=
n
> ARM folder where ARM_GLOBAL_TIMER was used now replaced on
> HAVE_ARM_GLOBAL_TIMER.
>=20
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S=C3=B6ren Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
[...]
> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
> index fd0aeeb..3165720 100644
> --- a/arch/arm/mach-zynq/Kconfig
> +++ b/arch/arm/mach-zynq/Kconfig
> @@ -5,7 +5,7 @@ config ARCH_ZYNQ
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select ARM_AMBA
>  	select ARM_GIC
> -	select ARM_GLOBAL_TIMER if !CPU_FREQ
> +	select HAVE_ARM_GLOBAL_TIMER if !CPU_FREQ

We actually have this issue, as we don't want to use GT when CPU_FREQ i=
s
enabled. But with this change the 'if !CPU_FREQ' becomes obsolete.

Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>

	S=C3=B6ren
