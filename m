From: Paul Walmsley <paul@pwsan.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 3 Apr 2012 17:29:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
References: <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com> <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com> <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com> <CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
 <20120403092524.GD17741@mudshark.cambridge.arm.com> <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com> <20120403094749.GH17741@mudshark.cambridge.arm.com> <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
 <20120403123444.GL17741@mudshark.cambridge.arm.com> <878vicsxef.fsf@ti.com> <20120403160706.GP17741@mudshark.cambridge.arm.com> <87ehs4pfw4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1669877870-1333495789=:8000"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45904 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab2DCX3u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 19:29:50 -0400
In-Reply-To: <87ehs4pfw4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Will Deacon <will.deacon@arm.com>, "Shilimkar\\, Santosh" <santosh.shilimkar@ti.com>, Ming Lei <ming.lei@canonical.com>, "eranian\\@gmail.com" <eranian@gmail.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list\\@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel\\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1669877870-1333495789=:8000
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi

On Tue, 3 Apr 2012, Kevin Hilman wrote:

> Indeed, like you, I have to change the EMU clock domain to SWSUP[1] in
> order to see any interrupts and see anything in perf top.  This isn't
> really a mergeable workaround, so I'll look into this a little closer
> with Santosh to see what we can do once we fully understand the HW
> problem.

Part of the problem is that the clockdomain data for the emu_sys=20
clockdomain is wrong.  Here's something to try to fix it.  It might just=20
be enough to get it to work.

- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 3 Apr 2012 17:13:48 -0600
Subject: [PATCH] ARM: OMAP44xx: clockdomain data: correct the emu_sys_clkdm
 CLKTRCTRL data

According to the 4430 ES2.0 TRM vX Table 3-744 "CM_EMU_CLKSTCTRL",
the emu_sys clockdomain data in mainline is incorrect.

The emu_sys clockdomain does not support the DISABLE_AUTO state, and
instead it supports the FORCE_WAKEUP state.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-om=
ap2/clockdomains44xx_data.c
index 9299ac2..bd7ed13 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm =3D {
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
 =09.cm_inst=09  =3D OMAP4430_PRM_EMU_CM_INST,
 =09.clkdm_offs=09  =3D OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
-=09.flags=09=09  =3D CLKDM_CAN_HWSUP,
+=09.flags=09=09  =3D CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_FORCE_WAKEUP,
 };
=20
 static struct clockdomain l3_dma_44xx_clkdm =3D {
--=20
1.7.9.5

--155748971-1669877870-1333495789=:8000--
