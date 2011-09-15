From: <gregkh@suse.de>
Subject: patch "[PATCH] OMAP4: clock: re-enable previous clockdomain enable/disable" failed to apply to 3.0-stable tree
Date: Thu, 15 Sep 2011 09:22:43 +0200
Message-ID: <13160713632634@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56624 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754629Ab1IOH1W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 03:27:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, balbi@ti.com, b-cousson@ti.com, coelho@ti.com, keshava_mgowda@ti.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, ohad@wizery.com, rnayak@ti.com, santosh.shili
Cc: stable@kernel.org


The patch below does not apply to the 3.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@kernel.org>.

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

=46rom 9c5f560173a466582d91bb06f4e3d2bafb0fee5c Mon Sep 17 00:00:00 200=
1
=46rom: Paul Walmsley <paul@pwsan.com>
Date: Fri, 19 Aug 2011 16:59:56 -0600
Subject: [PATCH] OMAP4: clock: re-enable previous clockdomain enable/di=
sable
 sequence
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

After commit 665d001338b494d6d62810aa99b4c0fa1a0884b9 ("OMAP2+: hwmod:
=46ollow the recommended PRCM module enable sequence"), device drivers
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

C. The patch would have been a new, yet temporary hack; and similar fix=
es
   have drawn negative comments in the recent past (see for example [3]=
)

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
proposing another patch to deal with the problem.  Thanks to Felipe
Balbi <balbi@ti.com> for comments.

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
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2=
/clock44xx_data.c
index 2af0e3f..a3a1827 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3379,7 +3379,13 @@ int __init omap4xxx_clk_init(void)
 	}
=20
 	clk_init(&omap2_clk_functions);
-	omap2_clk_disable_clkdm_control();
+
+	/*
+	 * Must stay commented until all OMAP SoC drivers are
+	 * converted to runtime PM, or drivers may start crashing
+	 *
+	 * omap2_clk_disable_clkdm_control();
+	 */
=20
 	for (c =3D omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clk=
s);
 									  c++)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
