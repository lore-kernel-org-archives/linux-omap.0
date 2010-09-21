From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: hwmod: Enable module wakeup if in smartidle
Date: Tue, 21 Sep 2010 14:02:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009211400460.4677@utopia.booyaka.com>
References: <1285079310-15888-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-40226568-1285099368=:4677"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39973 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab0IUUCt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 16:02:49 -0400
In-Reply-To: <1285079310-15888-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-40226568-1285099368=:4677
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Rajendra,

On Tue, 21 Sep 2010, Rajendra Nayak wrote:

> If a module's OCP slave port is programmed to be in smartidle,
> its also necessary that they have module level wakeup enabled.
> Update _sysc_enable in hwmod framework to do this.

Thanks, queued for 2.6.37 with a slightly modified changelog.  One brief=20
comment:

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Beno????t Cousson <b-cousson@ti.com>

Looks like something in your mail path is mangling 8-bit characters...=20
fixed in the queued version.


- Paul


From: Rajendra Nayak <rnayak@ti.com>
Date: Tue, 21 Sep 2010 19:58:30 +0530
Subject: [PATCH] OMAP: hwmod: Enable module wakeup if in smartidle
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

If a module's OCP slave port is programmed to be in smartidle,
its also necessary that they have module level wakeup enabled.
Update _sysc_enable in hwmod framework to do this.

The thread "[PATCH 7/8] : Hwmod api changes" archived here:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34212.html

has additional technical information on the rationale of this patch.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Beno=EEt Cousson <b-cousson@ti.com>
[paul@pwsan.com: revised patch description]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 8c27923..d3431bf 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -661,8 +661,6 @@ static void _sysc_enable(struct omap_hwmod *oh)
 =09=09_set_module_autoidle(oh, idlemode, &v);
 =09}
=20
-=09/* XXX OCP ENAWAKEUP bit? */
-
 =09/*
 =09 * XXX The clock framework should handle this, by
 =09 * calling into this code.  But this must wait until the
@@ -673,6 +671,10 @@ static void _sysc_enable(struct omap_hwmod *oh)
 =09=09_set_clockactivity(oh, oh->class->sysc->clockact, &v);
=20
 =09_write_sysconfig(v, oh);
+
+=09/* If slave is in SMARTIDLE, also enable wakeup */
+=09if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
+=09=09=09_enable_wakeup(oh);
 }
=20
 /**
--=20
1.7.1

--155748971-40226568-1285099368=:4677--
