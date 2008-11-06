From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3 powerdomains: remove RET from SGX power states
 list
Date: Thu, 6 Nov 2008 04:08:44 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811060401150.11718@utopia.booyaka.com>
References: <alpine.DEB.2.00.0811051152150.15612@utopia.booyaka.com> <20081106033327.GQ21736@atomide.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1201022891-1225969724=:11718"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39291 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbYKFLJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 06:09:07 -0500
In-Reply-To: <20081106033327.GQ21736@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, "Stoppa Igor (Nokia-D/Helsinki)" <Igor.Stoppa@nokia.com>, r-woodruff2@ti.com, Kevin Hilman <khilman@deeprootsystems.com>, "Sawant, Anand" <sawant@ti.com>, Poussa Sakari <sakari.poussa@nokia.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1201022891-1225969724=:11718
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 5 Nov 2008, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [081105 11:39]:
> >=20
> > The SGX device on OMAP3 does not support retention, so remove RET from =
the=20
> > list of possible SGX power states.  Problem debugged by Richard Woodruf=
f=20
> > <r-woodruff2@ti.com>.
>=20
> Pushing.

Just FYI, that patch prevents the kernel from booting due to a bug in=20
pm34xx.c; patch below.

Even with the follwoing patch, the initial power state setup code in=20
pm34xx.c will bail out early since it still tries to set the SGX next=20
power state to retention, which it does not support.


- Paul


OMAP3 PM: use list_for_each_entry_safe() when deleting list entries

From: Paul Walmsley <paul@pwsan.com>

The error path in clkdms_setup() needs to use list_for_each_entry_safe()
when deleting entries from the list, or the kernel will crash.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jouni H=F6gander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a11a657..da098d2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -540,7 +540,7 @@ static int __init clkdms_setup(struct clockdomain *clkd=
m)
=20
 int __init omap3_pm_init(void)
 {
-=09struct power_state *pwrst;
+=09struct power_state *pwrst, *tmp;
 =09int ret;
=20
 =09printk(KERN_ERR "Power Management for TI OMAP3.\n");
@@ -583,7 +583,7 @@ err1:
 =09return ret;
 err2:
 =09free_irq(INT_34XX_PRCM_MPU_IRQ, NULL);
-=09list_for_each_entry(pwrst, &pwrst_list, node) {
+=09list_for_each_entry_safe(pwrst, tmp, &pwrst_list, node) {
 =09=09list_del(&pwrst->node);
 =09=09kfree(pwrst);
 =09}
--155748971-1201022891-1225969724=:11718--
