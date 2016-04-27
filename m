From: Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH v1] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Wed, 27 Apr 2016 11:12:14 +0100
Message-ID: <20160427101214.GK28464@e106497-lin.cambridge.arm.com>
References: <1461684532-16848-1-git-send-email-grygorii.strashko@ti.com>
 <20160426160245.GI28464@e106497-lin.cambridge.arm.com>
 <571FC2EC.9090605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <571FC2EC.9090605@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: kernel@stlinux.com, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Wei Xu <xuwei5@hisilicon.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, Mike Looijmans <mike.looijmans@topic.nl>, Lars Persson <lars.persson@axis.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Olof Johansson <olof@lixom.n>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 26, 2016 at 10:35:08PM +0300, Grygorii Strashko wrote:
> On 04/26/2016 07:02 PM, Liviu Dudau wrote:
> > On Tue, Apr 26, 2016 at 06:28:52PM +0300, Grygorii Strashko wrote:
> >=20
> > Hi Grygorii,
> >=20
> > First time I'm seeing this patch, so I have a few questions, mostly
> > related to the commit message:
>=20
> Hm. You are in cc for RFC.
> Sry, forgot to add link [1].

Hmm, possibly fell through some cracks.

>=20
> >=20
> >> This patch intended to fix following cases:
> >> - SoC-A has ARM GT, defines DT node for ARM GT and selects
> >> ARM_GLOBAL_TIMER statically in Kconfig file. SoC-B has ARM GT and
> >> defines DT node for ARM GT, but do not selects ARM_GLOBAL_TIMER
> >> statically in Kconfig file. In case of multiplatform build ARM GT =
will
> >> be implicitly enabled for SoC-B.
> >=20
> > Well, SoC-B has the GT *and* the DT node, so what is the problem wi=
th
> > enabling it for SoC-B? If there are reasons not to use the Global T=
imer
> > on SoC-B, surely a better option would be to mark it in DT with sta=
tus =3D "disabled";
>=20
> This was rejected [2]. DT describes HW and if it is functional the st=
atus =3D "disabled"
> is not good choice.

They way I read that thread is that you are trying to disable the Globa=
l Timer
for the wrong reasons, not that having status =3D "disabled" is not a g=
ood choice.
DT *does* describe the HW, but there is nothing from stopping someone t=
o say in the DT
that a specific HW is OFF. Removing the node description from DT would =
be wrong, because
the HW is there, we just want it disabled. Having status =3D "disabled"=
 is similar to having
a software OFF button.

Now, the only issue one might have is when the HW is enabled at power o=
n and active. In
that case, marking it with status =3D "disabled" is indeed wrong, becau=
se there's going
to be a disconnect between the state of the HW and what the DT says is =
being active. But
the timers are not really active until setup, so you should be able to =
play with the
status property.

> ARM GT can't be used as clocksource/sched_clock/clockevent when CPUFr=
eq or
> CPUIdle are enabled :(, and this is Linux specific functionality and
> not HW description.=20

=46irst of all you probably need to separate the issues you have with T=
WD versus
the GT timer, they are two different pieces of IP and have individual d=
rivers.

When it comes to CPUidle, the TWD timer does the right thing: if there =
is no
"always-on" property in the DT then it will set the CLOCK_EVT_FEAT_C3ST=
OP bit in
the features and so the clk framework will know that the clock will be =
disabled
when the core goes idle and will look for another clock source for wake=
ups. What
it does seem to be missing is the CLOCK_EVT_FEAT_PERCPU flag though, bu=
t that seems
to be a very underused flag in kernel/time/tick-broadcast.c.

As for the GT timer and CPUidle, something similar to the TWD timer nee=
ds done (i.e
set C3STOP feature if the clock is not marked as always on).

=46or the issues that you are seeing with CPUfreq, I'm afraid I need mo=
re info on that.

>=20
> >=20
> >>
> >> - There is no way to disable ARM GT without modifying Kconfig file=
,
> >> once ARM_GLOBAL_TIMER is selected statically in Kconfig file.
> >=20
> > What about disabling the DT node?
> >=20
> > Not sure I properly understand the problem you are trying to solve =
here.
>=20
> I'd like to have way to enable/disable ARM GT without modifying Kerne=
l sources
> (Kconfig specifically) which is now impossible.
>=20
> >=20
> >>
> >> Hence, fix above case by defining both HAVE_ARM_GLOBAL_TIMER and
> >> ARM_GLOBAL_TIMER as recommended by 'Adding common features and mak=
e
> >> the usage configurable' section in kconfig-language.txt. All place=
s in
> >> ARM folder where ARM_GLOBAL_TIMER was used now replaced on
> >> HAVE_ARM_GLOBAL_TIMER.
> >=20
> > I'm OK with the way you have changed ARM_GLOBAL_TIMER from a sticky=
 config
> > option to a selectable one, but I would like more details on the pr=
oblem
> > this was causing you.
> >=20
>=20
> The same HW (board) could be used with PM features enabled (power sav=
ing)
> and disabled (-RT). Without this change it will require to have
> and maintain two branches, but with it - just separate defconfig.

I'm not NAK-ing the patch for the moment until we understand if there a=
re better
options (and patches) for your problem, but I still fail to see how you=
 are going
to use this patch in the scenario that your commit message describes. I=
f you compile
a kernel to work on both SoC-A and SoC-B you still end up having GT tim=
er enabled for
SoC-B.

Maybe commit message needs changed to say something like "Make ARM_GLOB=
AL_TIMER a
selectable feature for builds that want to disable the functionality".

Best regards,
Liviu

>=20
> [1] http://lists.infradead.org/pipermail/linux-rockchip/2016-February=
/007159.html
> [2] http://www.spinics.net/lists/devicetree/msg102918.html
>=20
> >=20
> >>
> >> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Cc: Florian Fainelli <f.fainelli@gmail.com>
> >> Cc: Russell King <linux@arm.linux.org.uk>
> >> Cc: Wei Xu <xuwei5@hisilicon.com>
> >> Cc: Shawn Guo <shawnguo@kernel.org>
> >> Cc: Sascha Hauer <kernel@pengutronix.de>
> >> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> >> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> >> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> Cc: Liviu Dudau <liviu.dudau@arm.com>
> >> Cc: Sudeep Holla <sudeep.holla@arm.com>
> >> Cc: Jun Nie <jun.nie@linaro.org>
> >> Cc: Michal Simek <michal.simek@xilinx.com>
> >> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> >> Cc: Lars Persson <lars.persson@axis.com>
> >> Cc: Mike Looijmans <mike.looijmans@topic.nl>
> >> Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
> >> Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
> >> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >> ---
> >> Changes is v1:
> >> - updated mach-artpec
> >> - rebased on top of tip: timers/core
> >>    commit: 86d3473 time: Introduce do_sys_settimeofday64()
> >>
> >>   arch/arm/mach-artpec/Kconfig   | 2 +-
> >>   arch/arm/mach-bcm/Kconfig      | 4 ++--
> >>   arch/arm/mach-hisi/Kconfig     | 2 +-
> >>   arch/arm/mach-imx/Kconfig      | 2 +-
> >>   arch/arm/mach-rockchip/Kconfig | 2 +-
> >>   arch/arm/mach-sti/Kconfig      | 2 +-
> >>   arch/arm/mach-uniphier/Kconfig | 2 +-
> >>   arch/arm/mach-vexpress/Kconfig | 2 +-
> >>   arch/arm/mach-zx/Kconfig       | 2 +-
> >>   arch/arm/mach-zynq/Kconfig     | 2 +-
> >>   drivers/clocksource/Kconfig    | 7 ++++++-
> >>   11 files changed, 17 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-artpec/Kconfig b/arch/arm/mach-artpec/K=
config
> >> index 6cbe5a2..6cbca77 100644
> >> --- a/arch/arm/mach-artpec/Kconfig
> >> +++ b/arch/arm/mach-artpec/Kconfig
> >> @@ -9,7 +9,7 @@ config MACH_ARTPEC6
> >>   	depends on ARCH_MULTI_V7
> >>   	select ARM_AMBA
> >>   	select ARM_GIC
> >> -	select ARM_GLOBAL_TIMER
>=20
> [...]
>=20
> --=20
> regards,
> -grygorii
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
