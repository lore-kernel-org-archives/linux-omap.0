From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Wed, 27 Apr 2016 11:15:48 +0100
Message-ID: <57209154.6050508@arm.com>
References: <1461684532-16848-1-git-send-email-grygorii.strashko@ti.com>
 <20160426160245.GI28464@e106497-lin.cambridge.arm.com>
 <571FC2EC.9090605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <571FC2EC.9090605@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: kernel@stlinux.com, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Wei Xu <xuwei5@hisilicon.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, Mike Looijmans <mike.looijmans@topic.nl>, Lars Persson <lars.persson@axis.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Olof Johansson <olof@lixom.n>
List-Id: linux-omap@vger.kernel.org

On 26/04/16 20:35, Grygorii Strashko wrote:
> On 04/26/2016 07:02 PM, Liviu Dudau wrote:
>> On Tue, Apr 26, 2016 at 06:28:52PM +0300, Grygorii Strashko wrote:
>>
>> Hi Grygorii,
>>
>> First time I'm seeing this patch, so I have a few questions, mostly
>> related to the commit message:
>
> Hm. You are in cc for RFC.
> Sry, forgot to add link [1].
>
>>
>>> This patch intended to fix following cases:
>>> - SoC-A has ARM GT, defines DT node for ARM GT and selects
>>> ARM_GLOBAL_TIMER statically in Kconfig file. SoC-B has ARM GT and
>>> defines DT node for ARM GT, but do not selects ARM_GLOBAL_TIMER
>>> statically in Kconfig file. In case of multiplatform build ARM GT w=
ill
>>> be implicitly enabled for SoC-B.
>>
>> Well, SoC-B has the GT *and* the DT node, so what is the problem wit=
h
>> enabling it for SoC-B? If there are reasons not to use the Global Ti=
mer
>> on SoC-B, surely a better option would be to mark it in DT with stat=
us =3D "disabled";
>
> This was rejected [2]. DT describes HW and if it is functional the st=
atus =3D "disabled"
> is not good choice.
> ARM GT can't be used as clocksource/sched_clock/clockevent when CPUFr=
eq or
> CPUIdle are enabled :(, and this is Linux specific functionality and
> not HW description.

It sounds to me like the cleanest option might then be to address it=20
within the Linux-specific driver itself. How feasible would it be for=20
the GT driver to detect at runtime whether CPUfreq/idle will be used an=
d=20
simply refuse to register as a clocksource if so? (I guess there are=20
probably horrible initialisation order issues, at least...)

Robin.

>>
>>>
>>> - There is no way to disable ARM GT without modifying Kconfig file,
>>> once ARM_GLOBAL_TIMER is selected statically in Kconfig file.
>>
>> What about disabling the DT node?
>>
>> Not sure I properly understand the problem you are trying to solve h=
ere.
>
> I'd like to have way to enable/disable ARM GT without modifying Kerne=
l sources
> (Kconfig specifically) which is now impossible.
>
>>
>>>
>>> Hence, fix above case by defining both HAVE_ARM_GLOBAL_TIMER and
>>> ARM_GLOBAL_TIMER as recommended by 'Adding common features and make
>>> the usage configurable' section in kconfig-language.txt. All places=
 in
>>> ARM folder where ARM_GLOBAL_TIMER was used now replaced on
>>> HAVE_ARM_GLOBAL_TIMER.
>>
>> I'm OK with the way you have changed ARM_GLOBAL_TIMER from a sticky =
config
>> option to a selectable one, but I would like more details on the pro=
blem
>> this was causing you.
>>
>
> The same HW (board) could be used with PM features enabled (power sav=
ing)
> and disabled (-RT). Without this change it will require to have
> and maintain two branches, but with it - just separate defconfig.
>
> [1] http://lists.infradead.org/pipermail/linux-rockchip/2016-February=
/007159.html
> [2] http://www.spinics.net/lists/devicetree/msg102918.html
>
>>
>>>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: Wei Xu <xuwei5@hisilicon.com>
>>> Cc: Shawn Guo <shawnguo@kernel.org>
>>> Cc: Sascha Hauer <kernel@pengutronix.de>
>>> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
>>> Cc: Maxime Coquelin <maxime.coquelin@st.com>
>>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Jun Nie <jun.nie@linaro.org>
>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
>>> Cc: Lars Persson <lars.persson@axis.com>
>>> Cc: Mike Looijmans <mike.looijmans@topic.nl>
>>> Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
>>> Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> ---
>>> Changes is v1:
>>> - updated mach-artpec
>>> - rebased on top of tip: timers/core
>>>     commit: 86d3473 time: Introduce do_sys_settimeofday64()
>>>
>>>    arch/arm/mach-artpec/Kconfig   | 2 +-
>>>    arch/arm/mach-bcm/Kconfig      | 4 ++--
>>>    arch/arm/mach-hisi/Kconfig     | 2 +-
>>>    arch/arm/mach-imx/Kconfig      | 2 +-
>>>    arch/arm/mach-rockchip/Kconfig | 2 +-
>>>    arch/arm/mach-sti/Kconfig      | 2 +-
>>>    arch/arm/mach-uniphier/Kconfig | 2 +-
>>>    arch/arm/mach-vexpress/Kconfig | 2 +-
>>>    arch/arm/mach-zx/Kconfig       | 2 +-
>>>    arch/arm/mach-zynq/Kconfig     | 2 +-
>>>    drivers/clocksource/Kconfig    | 7 ++++++-
>>>    11 files changed, 17 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-artpec/Kconfig b/arch/arm/mach-artpec/Kc=
onfig
>>> index 6cbe5a2..6cbca77 100644
>>> --- a/arch/arm/mach-artpec/Kconfig
>>> +++ b/arch/arm/mach-artpec/Kconfig
>>> @@ -9,7 +9,7 @@ config MACH_ARTPEC6
>>>    	depends on ARCH_MULTI_V7
>>>    	select ARM_AMBA
>>>    	select ARM_GIC
>>> -	select ARM_GLOBAL_TIMER
>
> [...]
>
