From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: Nokia N900: Proper C-states
Date: Sat, 2 Jan 2016 23:00:48 +0100
Message-ID: <56884890.9080306@linaro.org>
References: <201601021526.28687@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201601021526.28687@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Jean Pihet <j-pihet@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
List-Id: linux-omap@vger.kernel.org

On 01/02/2016 03:26 PM, Pali Roh=C3=A1r wrote:
> Hello,
>
> due to this Daniel Lezcano commit (ARM: OMAP3: cpuidle - remove rx51
> cpuidle parameters table)
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D231900afba52d6faddfb480cde4132d4edc089bc
>
> we need patch cpuidle34xx.c code to fix commit for Nokia N900. See:
>
> https://github.com/pali/linux-n900/commit/e147fd4b678f1f3d7a523528791=
0960bd41e04dc
>
> As Nokia N900 code is converting from legacy board code to DST, I wou=
ld
> like to know how to patch correctly omap3_idle_driver in DTS with
> correct values measured for Nokia N900. Thanks!

Hi Pali,

the conversion to the DT based arm cpuidle driver could be a bit comple=
x=20
with one issue (index 0 !=3D cpu_do_idle()) and one performance regress=
ion=20
(cpu_pm_enter/exit will be called in retention mode, even if this is no=
t=20
needed).

It will result in a PM code only on one side and on the other side, the=
=20
generic cpuidle-arm.c driver will be used instead with the DT=20
definition. It is worth to the conversion because the result will be=20
nice IMO.

Added Lorenzo who is initially author of the arm generic driver. We=20
already discussed in the past about those two issues above and I think=20
this is something we should improve.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
