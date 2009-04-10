From: Kim Kyuwon <chammoru@gmail.com>
Subject: [PATCH] Fix the size of twl4030 script
Date: Fri, 10 Apr 2009 13:30:30 +0900
Message-ID: <4d34a0a70904092130r215f0eb3p6a45c4950c92e5c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:1186 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbZDJEaq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Apr 2009 00:30:46 -0400
Received: by wf-out-1314.google.com with SMTP id 29so933360wff.4
        for <linux-omap@vger.kernel.org>; Thu, 09 Apr 2009 21:30:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

The array size of wrst_seq is ARRAY_SIZE(wrst_seq)

Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    2 +-
 arch/arm/mach-omap2/board-ldp.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c
b/arch/arm/mach-omap2/board-3430sdp.c
index 03acac7..38550e2 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -473,7 +473,7 @@ static struct twl4030_ins wrst_seq[] __initdata =3D=
 {
 };
 static struct twl4030_script wrst_script __initdata =3D {
 	.script =3D wrst_seq,
-	.size   =3D ARRAY_SIZE(wakeup_seq),
+	.size   =3D ARRAY_SIZE(wrst_seq),
 	.flags  =3D TRITON_WRST_SCRIPT,
 };

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/boar=
d-ldp.c
index 804fd8e..da814d7 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -450,7 +450,7 @@ static struct twl4030_ins wrst_seq[] __initdata =3D=
 {

 static struct twl4030_script wrst_script __initdata =3D {
 	.script =3D wrst_seq,
-	.size   =3D ARRAY_SIZE(wakeup_seq),
+	.size   =3D ARRAY_SIZE(wrst_seq),
 	.flags  =3D TRITON_WRST_SCRIPT,
 };

--=20
1.5.2.5

--=20
Kyuwon (=B1=D4=BF=F8)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
