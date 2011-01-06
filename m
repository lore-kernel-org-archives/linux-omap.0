From: Koen Kooi <koen@beagleboard.org>
Subject: Re: [PATCH 2/2] OMAP3: beagle xm: enable upto 800MHz OPP
Date: Thu, 6 Jan 2011 14:00:59 +0100
Message-ID: <579AA000-EB86-4DD3-B3B7-29F7A72E0415@beagleboard.org>
References: <1294260576-20237-1-git-send-email-nm@ti.com>	<1294260576-20237-3-git-send-email-nm@ti.com> <874o9nvskt.fsf@ti.com> <4D25B482.3080709@ti.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: multipart/mixed; boundary=Apple-Mail-11-331563288
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57084 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab1AFNBD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 08:01:03 -0500
Received: by wwa36 with SMTP id 36so17379186wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 05:01:02 -0800 (PST)
In-Reply-To: <4D25B482.3080709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>


--Apple-Mail-11-331563288
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


Op 6 jan 2011, om 13:24 heeft Nishanth Menon het volgende geschreven:

> Kevin Hilman wrote, on 01/05/2011 05:28 PM:
>> Nishanth Menon<nm@ti.com>  writes:
>>=20
>>> Beagle XM uses 3730 and the board design allows enabling 800MHz and =
1GHz
>>> OPPs. However, We need Smart reflex class 1.5 and ABB to enable 1GHz =
safely.
>>> For the moment, we tweak the default table to allow for 800Mhz OPP =
usage.
>>=20
>> Isn't this common to any board using 3730 (or 3630?)
>=20
> no it is not. only certain boards are capable of higher frequencies - =
there is a procedure called PDN analysis and vmin search that needs to =
be performed to guarentee this.

What about the "new" 3530s that can run at 720MHz? Those have been speed =
binned and given a different SKU. I'm using the attached 4 patches (Tony =
master + beagle patches _+ dvfs: =
http://dominion.thruhere.net/git/cgit.cgi/linux-omap/log/?h=3Dkoen/beagle-=
next) on my beagle C4 and overo tide to get 720MHz. They don't really =
work:

root@usrp-e1xx:~# cpufreq-set -f 720000
[  104.976318] platform iva.0: omap_voltage_scale: Already at the =
requestedrate 430000000
[  104.986236] platform mpu.0: omap_voltage_scale: Already at the =
requestedrate 600000000
[  104.996032] platform iva.0: omap_voltage_scale: Already at the =
requestedrate 430000000
[  105.006408] platform mpu.0: omap_voltage_scale: Already at the =
requestedrate 600000000

But:

root@usrp-e1xx:~# dmesg | grep 720
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp 720mhz )
[    0.000000] Kernel command line: console=3DttyO2,115200n8 mpurate=3D720=
 vram=3D16M mem=3D99M@0x80000000 mem=3D384M@0x88000000 =
omapfb.mode=3Ddvi:1024x768MR-24@60 omapfb.vram=3D0:8M,1:4M,2:4M =
omapdss.def_disp=3Ddvi root=3D/dev/mmcblk0p2 rw rootfstype=3Dext3 =
rootwait
[    0.000000] overo_opp_init: 720MHz MPU OPPs enabled!
[    0.000000] Switched to new clocking rate (Crystal/Core/MPU): =
26.0/224/720 MHz


root@usrp-e1xx:~# cpufreq-info=20
cpufrequtils 006: cpufreq-info (C) Dominik Brodowski 2004-2009
Report errors and bugs to cpufreq@vger.kernel.org, please.
analyzing CPU 0:
  driver: omap
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency: 300 us.
  hardware limits: 125 MHz - 720 MHz
  available frequency steps: 125 MHz, 250 MHz, 500 MHz, 550 MHz, 600 =
MHz, 720 MHz
  available cpufreq governors: conservative, ondemand, userspace, =
powersave, performance
  current policy: frequency should be within 125 MHz and 720 MHz.
                  The governor "userspace" may decide which speed to use
                  within this range.
  current CPU frequency is 600 MHz (asserted by call to hardware).
  cpufreq stats: 125 MHz:0.00%, 250 MHz:0.00%, 500 MHz:0.00%, 550 =
MHz:0.00%, 600 MHz:100.00%, 720 MHz:0.00%  (1)

So how do I "properly" get 720MHz on those parts?


regards,

Koen

--Apple-Mail-11-331563288
Content-Disposition: attachment;
	filename=0001-omap3-add-support-for-720MHz-MPU-OPP.patch
Content-Type: application/octet-stream;
	name="0001-omap3-add-support-for-720MHz-MPU-OPP.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20fe693a9d05c58aa7e5157f695b9af00688a2b91d=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Koen=20Kooi=20<koen@dominion.thruhere.net>=0A=
Date:=20Thu,=206=20Jan=202011=2013:05:55=20+0100=0ASubject:=20[PATCH=20=
1/4]=20omap3:=20add=20support=20for=20720MHz=20MPU=20OPP=0A=0AThe=20=
720MHz=20capability=20can=20be=20probed=20run-time=20by=20reading=20the=0A=
PRODID.SKUID[3:0]=20at=200x4830A20C.=0A=0ASigned-off-by:=20Koen=20Kooi=20=
<koen@dominion.thruhere.net>=0A---=0A=20=
arch/arm/mach-omap2/opp3xxx_data.c=20|=20=20=20=204=20++++=0A=201=20=
files=20changed,=204=20insertions(+),=200=20deletions(-)=0A=0Adiff=20=
--git=20a/arch/arm/mach-omap2/opp3xxx_data.c=20=
b/arch/arm/mach-omap2/opp3xxx_data.c=0Aindex=20fd3a1af..a861f5e=20100644=0A=
---=20a/arch/arm/mach-omap2/opp3xxx_data.c=0A+++=20=
b/arch/arm/mach-omap2/opp3xxx_data.c=0A@@=20-34,6=20+34,8=20@@=20static=20=
struct=20omap_opp_def=20__initdata=20omap34xx_opp_def_list[]=20=3D=20{=0A=
=20=09OPP_INITIALIZER("mpu",=20true,=20550000000,=201270000),=0A=20=09/*=20=
MPU=20OPP5=20*/=0A=20=09OPP_INITIALIZER("mpu",=20true,=20600000000,=20=
1350000),=0A+=09/*=20MPU=20OPP6=20*/=0A+=09OPP_INITIALIZER("mpu",=20=
false,=20720000000,=201350000),=0A=20=0A=20=09/*=0A=20=09=20*=20L3=20=
OPP1=20-=2041.5=20MHz=20is=20disabled=20because:=20The=20voltage=20for=20=
that=20OPP=20is=0A@@=20-59,6=20+61,8=20@@=20static=20struct=20=
omap_opp_def=20__initdata=20omap34xx_opp_def_list[]=20=3D=20{=0A=20=09=
OPP_INITIALIZER("iva",=20true,=20400000000,=201270000),=0A=20=09/*=20DSP=20=
OPP5=20*/=0A=20=09OPP_INITIALIZER("iva",=20true,=20430000000,=20=
1350000),=0A+=09/*=20DSP=20OPP6=20*/=0A+=09OPP_INITIALIZER("iva",=20=
false,=20520000000,=201350000),=0A=20};=0A=20=0A=20static=20struct=20=
omap_opp_def=20__initdata=20omap36xx_opp_def_list[]=20=3D=20{=0A--=20=0A=
1.6.6.1=0A=0A=

--Apple-Mail-11-331563288
Content-Disposition: attachment;
	filename=0002-OMAP35x-Add-support-for-720MHz-part.patch
Content-Type: application/octet-stream;
	name="0002-OMAP35x-Add-support-for-720MHz-part.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20154571d1620731a3207da126eb4f139a1534f293=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Koen=20Kooi=20<koen@dominion.thruhere.net>=0A=
Date:=20Thu,=206=20Jan=202011=2013:13:18=20+0100=0ASubject:=20[PATCH=20=
2/4]=20OMAP35x:=20Add=20support=20for=20720MHz=20part=0A=0AThis=20patch=20=
adds=20support=20for=20ARM=20running=20at=20720MHz=20part.=0A=0AThe=20=
720MHz=20capability=20can=20be=20probed=20run-time=20by=20reading=20the=0A=
PRODID.SKUID[3:0]=20at=200x4830A20C.=0A=0A=20=20[1]=20=
http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf=0A=0AThis=20is=20a=20=
forward=20port=20of=20https://patchwork.kernel.org/patch/53125/=0A=0A=
Signed-off-by:=20Koen=20Kooi=20<koen@dominion.thruhere.net>=0A---=0A=20=
arch/arm/mach-omap2/control.h=20=20=20=20=20=20=20=20=20|=20=20=20=207=20=
+++++++=0A=20arch/arm/mach-omap2/id.c=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20|=20=20=2010=20++++++++++=0A=20=
arch/arm/plat-omap/include/plat/cpu.h=20|=20=20=20=202=20++=0A=203=20=
files=20changed,=2019=20insertions(+),=200=20deletions(-)=0A=0Adiff=20=
--git=20a/arch/arm/mach-omap2/control.h=20=
b/arch/arm/mach-omap2/control.h=0Aindex=20f0629ae..b9671d3=20100644=0A=
---=20a/arch/arm/mach-omap2/control.h=0A+++=20=
b/arch/arm/mach-omap2/control.h=0A@@=20-365,7=20+365,14=20@@=0A=20=
#define=09=09FEAT_NEON=09=090=0A=20#define=09=09FEAT_NEON_NONE=09=091=0A=20=
=0A+/*=0A+=20*=20Product=20ID=20register=0A+=20*/=0A+#define=20=
OMAP3_PRODID=09=09=090x020C=0A=20=0A+#define=20OMAP3_SKUID_MASK=09=09=
0x0f=0A+#define=09=09OMAP3_SKUID_720MHZ=090x08=0A+=20=0A=20#ifndef=20=
__ASSEMBLY__=0A=20#ifdef=20CONFIG_ARCH_OMAP2PLUS=0A=20extern=20void=20=
__iomem=20*omap_ctrl_base_get(void);=0Adiff=20--git=20=
a/arch/arm/mach-omap2/id.c=20b/arch/arm/mach-omap2/id.c=0Aindex=20=
5f9086c..53fbe01=20100644=0A---=20a/arch/arm/mach-omap2/id.c=0A+++=20=
b/arch/arm/mach-omap2/id.c=0A@@=20-195,6=20+195,15=20@@=20static=20void=20=
__init=20omap3_check_features(void)=0A=20=09=20*=20TODO:=20Get=20=
additional=20info=20(where=20applicable)=0A=20=09=20*=20=20=20=20=20=20=20=
e.g.=20Size=20of=20L2=20cache.=0A=20=09=20*/=0A+=0A+=09/*=0A+=09=20*=20=
Does=20it=20support=20720MHz?=0A+=09=20*/=0A+=09status=20=3D=20=
(OMAP3_SKUID_MASK=20&=20read_tap_reg(OMAP3_PRODID));=0A+=0A+=09if=20=
(status=20&=20OMAP3_SKUID_720MHZ)=20{=0A+=09=09omap3_features=20|=3D=20=
OMAP3_HAS_720MHZ;=0A+=09}=0A=20}=0A=20=0A=20static=20void=20__init=20=
omap3_check_revision(void)=0A@@=20-445,6=20+454,7=20@@=20static=20void=20=
__init=20omap3_cpuinfo(void)=0A=20=09OMAP3_SHOW_FEATURE(neon);=0A=20=09=
OMAP3_SHOW_FEATURE(isp);=0A=20=09OMAP3_SHOW_FEATURE(192mhz_clk);=0A+=09=
OMAP3_SHOW_FEATURE(720mhz);=0A=20=0A=20=09printk(")\n");=0A=20}=0Adiff=20=
--git=20a/arch/arm/plat-omap/include/plat/cpu.h=20=
b/arch/arm/plat-omap/include/plat/cpu.h=0Aindex=201a8c347..7d24faa=20=
100644=0A---=20a/arch/arm/plat-omap/include/plat/cpu.h=0A+++=20=
b/arch/arm/plat-omap/include/plat/cpu.h=0A@@=20-510,6=20+510,7=20@@=20=
extern=20u32=20omap3_features;=0A=20#define=20OMAP3_HAS_ISP=09=09=09=
BIT(4)=0A=20#define=20OMAP3_HAS_192MHZ_CLK=09=09BIT(5)=0A=20#define=20=
OMAP3_HAS_IO_WAKEUP=09=09BIT(6)=0A+#define=20OMAP3_HAS_720MHZ=09=09=
BIT(7)=0A=20=0A=20#define=20OMAP3_HAS_FEATURE(feat,flag)=09=09=09\=0A=20=
static=20inline=20unsigned=20int=20omap3_has_=20##feat(void)=09\=0A@@=20=
-524,5=20+525,6=20@@=20OMAP3_HAS_FEATURE(neon,=20NEON)=0A=20=
OMAP3_HAS_FEATURE(isp,=20ISP)=0A=20OMAP3_HAS_FEATURE(192mhz_clk,=20=
192MHZ_CLK)=0A=20OMAP3_HAS_FEATURE(io_wakeup,=20IO_WAKEUP)=0A=
+OMAP3_HAS_FEATURE(720mhz,=20720MHZ)=0A=20=0A=20#endif=0A--=20=0A1.6.6.1=0A=
=0A=

--Apple-Mail-11-331563288
Content-Disposition: attachment;
	filename=0003-OMAP3-beagle-C4-enable-upto-720MHz-OPP.patch
Content-Type: application/octet-stream;
	name="0003-OMAP3-beagle-C4-enable-upto-720MHz-OPP.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=201a97a3600227fd0b52ee3bfd67bac6dde034af0d=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Koen=20Kooi=20<koen@dominion.thruhere.net>=0A=
Date:=20Thu,=206=20Jan=202011=2013:23:45=20+0100=0ASubject:=20[PATCH=20=
3/4]=20OMAP3:=20beagle=20C4:=20enable=20upto=20720MHz=20OPP=0A=0ABeagle=20=
C4=20uses=20a=20recent=203530=20and=20the=20board=20design=20allows=20=
enabling=20720MHz=0AOPP.=20tweak=20the=20default=20table=20to=20allow=20=
for=20higher=20OPP=20tables=0A=0ASigned-off-by:=20Koen=20Kooi=20=
<koen@dominion.thruhere.net>=0A---=0A=20=
arch/arm/mach-omap2/board-omap3beagle.c=20|=20=20=2035=20=
+++++++++++++++++++++++++++++++=0A=201=20files=20changed,=2035=20=
insertions(+),=200=20deletions(-)=0A=0Adiff=20--git=20=
a/arch/arm/mach-omap2/board-omap3beagle.c=20=
b/arch/arm/mach-omap2/board-omap3beagle.c=0Aindex=209393e75..a0462b9=20=
100644=0A---=20a/arch/arm/mach-omap2/board-omap3beagle.c=0A+++=20=
b/arch/arm/mach-omap2/board-omap3beagle.c=0A@@=20-829,6=20+829,41=20@@=20=
static=20void=20__init=20beagle_opp_init(void)=0A=20=09=09=09pr_err("%s:=20=
turbo=20OPPs=20enabled!\n",=20__func__);=0A=20=09=09}=0A=20=09}=0A+=09/*=20=
Custom=20OPP=20enabled=20for=20C4=20*/=0A+=09if=20=
(omap3_beagle_get_rev()=20=3D=3D=20OMAP3BEAGLE_BOARD_C4)=20{=0A+=09=09=
struct=20omap_hwmod=20*mh=20=3D=20omap_hwmod_lookup("mpu");=0A+=09=09=
struct=20omap_hwmod=20*dh=20=3D=20omap_hwmod_lookup("iva");=0A+=09=09=
struct=20device=20*dev;=0A+=0A+=09=09if=20(!mh=20||=20!dh)=20{=0A+=09=09=09=
pr_err("%s:=20Aiee..=20no=20mpu/dsp=20devices?=20%p=20%p\n",=0A+=09=09=09=
=09__func__,=20mh,=20dh);=0A+=09=09=09r=20=3D=20-EINVAL;=0A+=09=09}=20=
else=20{=0A+=09=09=09/*=20Enable=20MPU=20720MHz=20*/=0A+=09=09=09dev=20=3D=
=20&mh->od->pdev.dev;=0A+=09=09=09r=20=3D=20opp_enable(dev,=20=
720000000);=0A+=0A+=09=09=09/*=20Enable=20IVA=20520MHz=20and=20lower=20=
opps=20*/=0A+=09=09=09dev=20=3D=20&dh->od->pdev.dev;=0A+=09=09=09r=20|=3D=20=
opp_enable(dev,=20520000000);=0A+=09=09}=0A+=09=09if=20(r)=20{=0A+=09=09=09=
pr_err("%s:=20failed=20to=20enable=20higher=20opp=20%d\n",=0A+=09=09=09=09=
__func__,=20r);=0A+=09=09=09/*=0A+=09=09=09=20*=20Cleanup=20-=20disable=20=
the=20higher=20freqs=20-=20we=20dont=20care=0A+=09=09=09=20*=20about=20=
the=20results=0A+=09=09=09=20*/=0A+=09=09=09dev=20=3D=20=
&mh->od->pdev.dev;=0A+=09=09=09opp_disable(dev,=20720000000);=0A+=09=09=09=
dev=20=3D=20&dh->od->pdev.dev;=0A+=09=09=09opp_disable(dev,=20=
520000000);=0A+=09=09}=20else=20{=0A+=09=09=09pr_err("%s:=20720MHz=20MPU=20=
OPPs=20enabled!\n",=20__func__);=0A+=09=09}=0A+=09}=0A+=09=0A=20}=0A=20=0A=
=20static=20void=20__init=20omap3_beagle_init(void)=0A--=20=0A1.6.6.1=0A=0A=

--Apple-Mail-11-331563288
Content-Disposition: attachment;
	filename=0004-OMAP3-Overo-Tide-enable-upto-720MHz-OPP.patch
Content-Type: application/octet-stream;
	name="0004-OMAP3-Overo-Tide-enable-upto-720MHz-OPP.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=2002b008bc50c79aeaa666917bcd2a58049d1ab68c=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Koen=20Kooi=20<koen@dominion.thruhere.net>=0A=
Date:=20Thu,=206=20Jan=202011=2013:32:19=20+0100=0ASubject:=20[PATCH=20=
4/4]=20OMAP3:=20Overo=20Tide:=20enable=20upto=20720MHz=20OPP=0A=0AOvero=20=
Tide=20uses=20a=20recent=203530=20and=20the=20board=20design=20allows=20=
enabling=20720MHz=0AOPP.=20tweak=20the=20default=20table=20to=20allow=20=
for=20higher=20OPP=20tables=0A=0ASigned-off-by:=20Koen=20Kooi=20=
<koen@dominion.thruhere.net>=0A---=0A=20=
arch/arm/mach-omap2/board-overo.c=20|=20=20=2051=20=
+++++++++++++++++++++++++++++++++++++=0A=201=20files=20changed,=2051=20=
insertions(+),=200=20deletions(-)=0A=0Adiff=20--git=20=
a/arch/arm/mach-omap2/board-overo.c=20=
b/arch/arm/mach-omap2/board-overo.c=0Aindex=208686015..2fa0c96=20100644=0A=
---=20a/arch/arm/mach-omap2/board-overo.c=0A+++=20=
b/arch/arm/mach-omap2/board-overo.c=0A@@=20-29,6=20+29,7=20@@=0A=20=
#include=20<linux/i2c/twl.h>=0A=20#include=20<linux/regulator/machine.h>=0A=
=20#include=20<linux/spi/spi.h>=0A+#include=20<linux/opp.h>=0A=20=0A=20=
#include=20<linux/mtd/mtd.h>=0A=20#include=20<linux/mtd/nand.h>=0A@@=20=
-52,10=20+53,12=20@@=0A=20#include=20<plat/mcspi.h>=0A=20#include=20=
<plat/mux.h>=0A=20#include=20<plat/usb.h>=0A+#include=20=
<plat/omap_device.h>=0A=20=0A=20#include=20"mux.h"=0A=20#include=20=
"sdram-micron-mt46h32m32lf-6.h"=0A=20#include=20"hsmmc.h"=0A+#include=20=
"pm.h"=0A=20=0A=20#define=20OVERO_GPIO_BT_XGATE=0915=0A=20#define=20=
OVERO_GPIO_W2W_NRESET=0916=0A@@=20-788,6=20+791,53=20@@=20static=20void=20=
__init=20usrp1_e_init(void)=0A=20=0A=20}=0A=20=0A+static=20void=20__init=20=
overo_opp_init(void)=0A+{=0A+=09int=20r=20=3D=200;=0A+=09=0A+=09/*=20=
Initialize=20the=20omap3=20opp=20table=20*/=0A+=09if=20=
(omap3_opp_init())=20{=0A+=09=09pr_err("%s:=20opp=20default=20init=20=
failed\n",=20__func__);=0A+=09=09return;=0A+=09}=0A+=09=0A+=09/*=20=
Custom=20OPP=20enabled=20for=20Tide=20*/=0A+=09if=20(omap3_has_720mhz())=20=
{=0A+=09=09struct=20omap_hwmod=20*mh=20=3D=20omap_hwmod_lookup("mpu");=0A=
+=09=09struct=20omap_hwmod=20*dh=20=3D=20omap_hwmod_lookup("iva");=0A+=09=
=09struct=20device=20*dev;=0A+=09=09=0A+=09=09if=20(!mh=20||=20!dh)=20{=0A=
+=09=09=09pr_err("%s:=20Aiee..=20no=20mpu/dsp=20devices?=20%p=20%p\n",=0A=
+=09=09=09=09=20=20=20__func__,=20mh,=20dh);=0A+=09=09=09r=20=3D=20=
-EINVAL;=0A+=09=09}=20else=20{=0A+=09=09=09/*=20Enable=20MPU=20720MHz=20=
*/=0A+=09=09=09dev=20=3D=20&mh->od->pdev.dev;=0A+=09=09=09r=20=3D=20=
opp_enable(dev,=20720000000);=0A+=09=09=09=0A+=09=09=09/*=20Enable=20IVA=20=
520MHz=20and=20lower=20opps=20*/=0A+=09=09=09dev=20=3D=20=
&dh->od->pdev.dev;=0A+=09=09=09r=20|=3D=20opp_enable(dev,=20520000000);=0A=
+=09=09}=0A+=09=09if=20(r)=20{=0A+=09=09=09pr_err("%s:=20failed=20to=20=
enable=20higher=20opp=20%d\n",=0A+=09=09=09=09=20=20=20__func__,=20r);=0A=
+=09=09=09/*=0A+=09=09=09=20*=20Cleanup=20-=20disable=20the=20higher=20=
freqs=20-=20we=20dont=20care=0A+=09=09=09=20*=20about=20the=20results=0A=
+=09=09=09=20*/=0A+=09=09=09dev=20=3D=20&mh->od->pdev.dev;=0A+=09=09=09=
opp_disable(dev,=20720000000);=0A+=09=09=09dev=20=3D=20=
&dh->od->pdev.dev;=0A+=09=09=09opp_disable(dev,=20520000000);=0A+=09=09}=20=
else=20{=0A+=09=09=09pr_err("%s:=20720MHz=20MPU=20OPPs=20enabled!\n",=20=
__func__);=0A+=09=09}=0A+=09}=0A+=09=0A+}=0A+=0A=20static=20void=20=
__init=20overo_init(void)=0A=20{=0A=20=09omap3_mux_init(board_mux,=20=
OMAP_PACKAGE_CBB);=0A@@=20-846,6=20+896,7=20@@=20static=20void=20__init=20=
overo_init(void)=0A=20=09else=0A=20=09=09printk(KERN_ERR=20"could=20not=20=
obtain=20gpio=20for=20"=0A=20=09=09=09=09=09"OVERO_GPIO_USBH_CPEN\n");=0A=
+=09overo_opp_init();=0A=20}=0A=20=0A=20MACHINE_START(OVERO,=20"Gumstix=20=
Overo")=0A--=20=0A1.6.6.1=0A=0A=

--Apple-Mail-11-331563288--
