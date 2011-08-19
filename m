From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP4: clock: re-enable previous clockdomain enable/disable
 sequence (was Re: Oops on ehci_hcd when booting 3.0.0-rc2 on panda)
Date: Fri, 19 Aug 2011 16:48:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108191647430.9948@utopia.booyaka.com>
References: <1307356643.23002.413.camel@cumari> <20110606104417.GP18731@legolas.emea.dhcp.ti.com> <20110606110218.GS18731@legolas.emea.dhcp.ti.com> <1307358348.23002.419.camel@cumari> <1312889168.2407.148.camel@cumari> <CAK=WgbatbaSj=U7+SAva4Woh7uaOoCzQck5yjfLvVGLR-UCVHg@mail.gmail.com>
 <4E43C41E.1080808@ti.com> <1313065224.2407.857.camel@cumari> <CAP05o4+sBa_DO-ReoF20L=v5kbt5936_1vAGTQ10E4Lh+YXdNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-364542630-1313794132=:9948"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44016 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab1HSWsx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Aug 2011 18:48:53 -0400
In-Reply-To: <CAP05o4+sBa_DO-ReoF20L=v5kbt5936_1vAGTQ10E4Lh+YXdNQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, Luciano Coelho <coelho@ti.com>, Rajendra Nayak <rnayak@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Cousson, Benoit" <b-cousson@ti.com>, balbi@ti.com, sameo@linux.intel.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Kevin Hilman <khilman@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-364542630-1313794132=:9948
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


After commit 665d001338b494d6d62810aa99b4c0fa1a0884b9 ("OMAP2+: hwmod:
Follow the recommended PRCM module enable sequence"), device drivers
for OMAP IP blocks that do not use runtime PM can cause oopses or
kernel instability[1][2].

This is because those non-runtime PM drivers do not use the hwmod
code, which implements the correct IP block enable and disable
sequence.

Several options for dealing with this problem have been proposed:

1. Add a new field to the OMAP struct clk to mark clocks that are
   currently used by non-runtime PM drivers.  Modify the clock code to
   use the old clockdomain sequence for these marked clocks.  As
   drivers are converted to use runtime PM, remove the annotation from
   the clocks.

2. Similar to #1, but associate the flag with the struct omap_clk
   instead.

3. Add IDLEST wait support to the OMAP4 clock code, similar to the way
   it is implemented for OMAP2/3, and enable it in each struct clk
   currently used by non-runtime PM drivers.  As drivers are converted
   to use runtime PM, remove the annotation from the clocks.

4. Do nothing; leave the problem to those responsible for the
   unconverted drivers.

5. Re-enable clock-based clockdomain control in the OMAP4 clock code.
   This would revert back to the behavior of Linux 3.0, simply with a
   slightly longer module enable/disable latency.

Unfortunately, no approach seemed particularly good.  Options 1
through 3 seemed unwise due to the following reasons:

A. The OMAP struct clks are intended primarily to describe hardware
   clock nodes, and the intention is that no driver-specific data
   should be stored there (applies to #1)

B. The resulting patch would have been quite large for the -rc series
   (applies to #1, #2, #3)

C. The patch would have been a new, yet temporary hack; and similar fixes
   have drawn negative comments in the recent past (see for example [3])

Option 4 is undesirable because commit
665d001338b494d6d62810aa99b4c0fa1a0884b9 ("OMAP2+: hwmod: Follow the
recommended PRCM module enable sequence") has resulted in a less
stable kernel; and kernel stability is more important than OMAP4 power
management.

Option 5 is the approach taken in this patch.  This seemed to be the
least intrusive approach for 3.1-rc.

The approach in this patch was originally proposed by Ohad Ben-Cohen
<ohad@wizery.com>.  I'm simply writing the commit message and passing
it along.

=2E..

Thanks to Luciano Coelho <coelho@ti.com> for reporting the problem.
Thanks to Ohad Ben-Cohen <ohad@wizery.com> for tracking the problem
down, generating a temporary workaround, and proposing a patch to deal
with the problem.  Thanks to Rajendra Nayak <rnayak@ti.com> for
proposing another patch to deal with the problem.

This patch is intended for the 3.1-rc fixes series.

1. Coelho, Luciano <coelho@ti.com>.  _Re: Oops on ehci_hcd when
   booting 3.0.0-rc2 on panda_.  Tue, 09 Aug 2011 14:26:08 +0300.
   Posted to the <linux-omap@vger.kernel.org> mailing list.  Available
   from (among others)
   http://www.spinics.net/linux/lists/linux-omap/msg55213.html

2. Munegowda, Keshava <keshava_mgowda@ti.com>. _Re: Oops on ehci_hcd
   when booting 3.0.0-rc2 on panda_.  Thu, 11 Aug 2011 13:51:05 +0530.
   Posted to the <linux-omap@vger.kernel.org> mailing list.  Available
   from (among others)
   http://www.spinics.net/linux/lists/linux-omap/msg55371.html

3. King, Russell <linux@arm.linux.org.uk>.  _Re: [PATCH 5/8] OMAP4:
   PM: TEMP: Prevent l3init from idling/force sleep_.  Thu, 23 Jun
   2011 16:22:49 +0100.  Posted to the <linux-omap@vger.kernel.org>
   mailing list.  Available from (among others)
   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51392.html

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Luciano Coelho <coelho@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clo=
ck44xx_data.c
index 2af0e3f..fe6508d 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3379,7 +3379,7 @@ int __init omap4xxx_clk_init(void)
 =09}
=20
 =09clk_init(&omap2_clk_functions);
-=09omap2_clk_disable_clkdm_control();
+=09/* omap2_clk_disable_clkdm_control(); */
=20
 =09for (c =3D omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks)=
;
 =09=09=09=09=09=09=09=09=09  c++)
--=20
1.7.5.4

--155748971-364542630-1313794132=:9948--
