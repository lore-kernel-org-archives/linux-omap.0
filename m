From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for v3.4
Date: Tue, 27 Mar 2012 16:57:40 +0300
Message-ID: <CANOLnOMfsdGn-B0zftcV-zh+tSCGgmf0g1BsrFB0+Kh-HnNq0g@mail.gmail.com>
References: <877gywjhht.fsf@ti.com>
	<20120308021843.GQ12083@atomide.com>
	<87399jc6cj.fsf@ti.com>
	<20120309003217.GB12083@atomide.com>
	<20120309114731.GA3273@opensource.wolfsonmicro.com>
	<87zkbp4wtj.fsf@ti.com>
	<20120311204232.GC3171@opensource.wolfsonmicro.com>
	<87399dzq5e.fsf@ti.com>
	<20120312173215.GL3110@opensource.wolfsonmicro.com>
	<87pqchv1pc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49841 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332Ab2C0N5l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Mar 2012 09:57:41 -0400
Received: by iagz16 with SMTP id z16so9855077iag.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 06:57:41 -0700 (PDT)
In-Reply-To: <87pqchv1pc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue, Mar 13, 2012 at 1:28 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tony, updated pull request below. =C2=A0This includes all the TWL dep=
encies
> merged from the 'topic/twl' tag in Mark's tree.
>

Has this been lost now? It seems regulator parts got merged, but
voltage parts are missing from Arnd's pull requests and are not
showing up in linux-next.
Was looking forward for voltage control in 3.4 to achieve higher clock
rates on our aging OMAP3 hardware.

>
> The following changes since commit b01543dfe67bb1d191998e90d20534dc35=
4de059:
>
> =C2=A0Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)
>
> are available in the git repository at:
>
> =C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-oma=
p-pm.git for_3.4/pm/smps-regulator
>
> for you to fetch changes up to 39358f2b57f37fe079eff4159307c844a0bfb1=
76:
>
> =C2=A0Merge branch 'pm-wip/smps-regulator' into for_3.4/pm/smps-regul=
ator (2012-03-12 15:36:45 -0700)
>
> ----------------------------------------------------------------
>
> Kevin Hilman (3):
> =C2=A0 =C2=A0 =C2=A0ARM: OMAP2+: voltage: ensure voltage used is exac=
t voltage from OPP table
> =C2=A0 =C2=A0 =C2=A0Merge tag 'topic/twl' into for_3.4/pm/smps-regula=
tor
> =C2=A0 =C2=A0 =C2=A0Merge branch 'pm-wip/smps-regulator' into for_3.4=
/pm/smps-regulator
>
> Laxman Dewangan (1):
> =C2=A0 =C2=A0 =C2=A0regulator: twl6030: Fix voltage selection logic
>
> Peter Ujfalusi (2):
> =C2=A0 =C2=A0 =C2=A0regulator: twl-regulator: Add fixed LDO for V1V8,=
 V2V1 supply
> =C2=A0 =C2=A0 =C2=A0mfd: twl-core: regulator configuration for twl603=
0 V1V8, V2V1 SMPS
>
> Rajendra Nayak (1):
> =C2=A0 =C2=A0 =C2=A0regulator: twl: adapt twl-regulator driver to dt
>
> Tero Kristo (6):
> =C2=A0 =C2=A0 =C2=A0arm: omap3: voltage: fix channel configuration
> =C2=A0 =C2=A0 =C2=A0arm: omap3: add common twl configurations for vdd=
1 and vdd2
> =C2=A0 =C2=A0 =C2=A0arm: omap3: twl: add external controllers for cor=
e voltage regulators
> =C2=A0 =C2=A0 =C2=A0arm: omap4: add common twl configurations for vdd=
1, vdd2 and vdd3
> =C2=A0 =C2=A0 =C2=A0regulator: twl4030: add support for external volt=
age get/set
> =C2=A0 =C2=A0 =C2=A0regulator: twl6030: add support for vdd1, vdd2 an=
d vdd3 regulators
>
> =C2=A0.../bindings/regulator/twl-regulator.txt =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 68 ++++
> =C2=A0arch/arm/mach-omap2/twl-common.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0147 +++++++++
> =C2=A0arch/arm/mach-omap2/vc3xxx_data.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0arch/arm/mach-omap2/voltage.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 21 +-
> =C2=A0drivers/mfd/twl-core.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 41 ++=
-
> =C2=A0drivers/regulator/twl-regulator.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0327 +++++++++++++++-----
> =C2=A0include/linux/i2c/twl.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 14 +-
> =C2=A07 files changed, 532 insertions(+), 87 deletions(-)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/regulator/=
twl-regulator.txt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml


--
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
