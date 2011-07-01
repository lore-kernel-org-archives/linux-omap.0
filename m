From: "Elaidi, Djamil" <d-elaidi@ti.com>
Subject: RE: [PATCH 2/6] OMAP4: hwmod data: Add MSTANDBY_SMART_WKUP flag
Date: Fri, 1 Jul 2011 15:50:27 +0200
Message-ID: <74583B8642AB8841B30447520659FCA901FB33D546@dnce01.ent.ti.com>
References: <1308862842-3933-1-git-send-email-b-cousson@ti.com>
 <1308862842-3933-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43655 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756463Ab1GANub convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 09:50:31 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1308862842-3933-3-git-send-email-b-cousson@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Benoit,

HSI has no RESET_STATUS bit in SYSCONFIG register.

The SYSC should be :

static struct omap_hwmod_class_sysconfig omap44xx_hsi_sysc =3D {
        .rev_offs       =3D 0x0000,
        .sysc_offs      =3D 0x0010,
        .syss_offs      =3D 0x0014,
        .sysc_flags     =3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_EMUFREE |
                           SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE |
---                        SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+++                        SYSC_HAS_SOFTRESET),
        .idlemodes      =3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
                           SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY=
_NO |
                           MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
        .sysc_fields    =3D &omap_hwmod_sysc_type1,

Best regards
Djamil ELA=CFDI
+33 (0)4 97 27 50 97
Software Systems Engineer
OMAP Platform Business Unit - PSI Modem Integration
Texas Instruments


Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Lo=
ubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----

=46rom: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.=
kernel.org] On Behalf Of Cousson, Benoit
Sent: jeudi 23 juin 2011 23:01
To: paul@pwsan.com
Cc: Nayak, Rajendra; linux-omap@vger.kernel.org; Cousson, Benoit
Subject: [PATCH 2/6] OMAP4: hwmod data: Add MSTANDBY_SMART_WKUP flag

Add the flag to every IPs that support it to allow the
framework to enable it instead of the SMART_STANDBY default
mode.
Without that, an IP with busmaster capability will not
be able to wakeup the interconnect at all.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index f7f4840..c531611 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -661,7 +661,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_a=
ess_sysc =3D {
        .sysc_offs      =3D 0x0010,
        .sysc_flags     =3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
        .idlemodes      =3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-                          MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMAR=
T),
+                          MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMAR=
T |
+                          MSTANDBY_SMART_WKUP),
        .sysc_fields    =3D &omap_hwmod_sysc_type2,
 };

@@ -2045,7 +2046,7 @@ static struct omap_hwmod_class_sysconfig omap44xx=
_hsi_sysc =3D {
                           SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
        .idlemodes      =3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
                           SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY=
_NO |
-                          MSTANDBY_SMART),
+                          MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
        .sysc_fields    =3D &omap_hwmod_sysc_type1,
 };

@@ -2447,7 +2448,7 @@ static struct omap_hwmod_class_sysconfig omap44xx=
_iss_sysc =3D {
                           SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
        .idlemodes      =3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
                           SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY=
_NO |
-                          MSTANDBY_SMART),
+                          MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
        .sysc_fields    =3D &omap_hwmod_sysc_type2,
 };

@@ -3421,7 +3422,7 @@ static struct omap_hwmod_class_sysconfig omap44xx=
_mmc_sysc =3D {
                           SYSC_HAS_SOFTRESET),
        .idlemodes      =3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
                           SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY=
_NO |
-                          MSTANDBY_SMART),
+                          MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
        .sysc_fields    =3D &omap_hwmod_sysc_type2,
 };

--
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
