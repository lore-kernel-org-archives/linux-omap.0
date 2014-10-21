From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] MAINTAINERS: Update entry for omap related .dts files to cover new SoCs
Date: Tue, 21 Oct 2014 09:24:22 -0500
Message-ID: <1413901462-32181-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

DRA7(including AM5x) and AM47x series are handled under OMAP umbrella.
These SoC support and dts have been added since 3.14 kernel and Pull
requests for these have come in from OMAP till date.

So just ensure that get_maintainers can pick up this list as well.

Cc: Beno=C3=AEt Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 MAINTAINERS |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a20df9b..e205bd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6585,6 +6585,9 @@ L:	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 F:	arch/arm/boot/dts/*omap*
 F:	arch/arm/boot/dts/*am3*
+F:	arch/arm/boot/dts/*am4*
+F:	arch/arm/boot/dts/*am5*
+F:	arch/arm/boot/dts/*dra7*
=20
 OMAP CLOCK FRAMEWORK SUPPORT
 M:	Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
