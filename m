From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv2 08/12] ARM: OMAP4: hwmod data: add SL2IF hardreset line
Date: Fri, 15 Jun 2012 11:11:26 +0200
Message-ID: <4FDAFC3E.5010006@ti.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004614.20034.50895.stgit@dusk> <4FD9DF2A.3010000@ti.com> <alpine.DEB.2.00.1206141052240.30212@utopia.booyaka.com> <4FDA527D.9080401@ti.com> <alpine.DEB.2.00.1206141702120.25628@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53737 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978Ab2FOJLc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jun 2012 05:11:32 -0400
In-Reply-To: <alpine.DEB.2.00.1206141702120.25628@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

On 6/15/2012 1:02 AM, Paul Walmsley wrote:
> On Thu, 14 Jun 2012, Cousson, Benoit wrote:
>=20
>> Yep, but for that I'd rather add a flag than a information that is a
>> duplication of the parent data.
>=20
> Great, send a patch.

Cool.

Well, in fact the HWMOD_EXT_OPT_MAIN_CLK patch is already good enough a=
ssuming we make it a little bit more generic.

Here is your patch sightly updated manually to make it more generic.
The data will have to add some relevant comment on top of the flag to c=
leary
indicate the reason of that dependency.

Regards,
Benoit


---
ARM: OMAP2+: hwmod: add flag to prevent hwmod code from touching IP blo=
ck during init

Add HWMOD_HAS_EXT_DEP flag to indicate that this IP block is
dependent on an external resource that is not guaranteed to be
present during initialization. Typical resources are: External
clock from a off-chip device (Audio codec), clocks from a parent
subsystem or another IP, reset line from a parent subsystem.
IP blocks marked with this flag are left in the INITIALIZED state
during kernel init.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
[b-cousson@ti.com: Change the changelog and the flag name
to make it more generic]
Cc: Beno=EEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    3 +++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index d27bf48..e0b8131 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2140,6 +2140,9 @@ static int __init _setup_reset(struct omap_hwmod =
*oh)
 	if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
 		return -EINVAL;
=20
+	if (oh->flags & HWMOD_HAS_EXT_DEP)
+		return -EPERM;
+
 	if (oh->rst_lines_cnt =3D=3D 0) {
 		r =3D _enable(oh);
 		if (r) {
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index 2c53648..b5f3efc 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -417,6 +417,11 @@ struct omap_hwmod_omap4_prcm {
  *     running on the chip (e.g., the MPU is in idle).  For such modul=
es,
  *     fine-grained PM runtime-based idle control is simply a waste of
  *     CPU cycles.
+ * HWMOD_HAS_EXT_DEP: This IP block is dependent on an external
+ *     resource that is not guaranteed to be present during initializa=
tion.
+ *     Typical resources are: External clock from a off-chip device
+ *     (Audio codec), clocks from a parent subsystem, reset line from =
a
+ *     parent subsystem.
+ *     This prevents the hwmod code from being able to enable=20
+ *     and reset the IP block early.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -428,6 +433,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1 << 7)
 #define HWMOD_16BIT_REG				(1 << 8)
 #define HWMOD_ALWAYS_FORCE_SIDLE		(1 << 9)
+#define HWMOD_HAS_EXT_DEP			(1 << 10)
=20
 /*
  * omap_hwmod._int_flags definitions




--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
