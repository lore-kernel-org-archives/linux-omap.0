From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
Subject: [PATCH] ARM: omap2: gpmc: fix compilation warning
Date: Mon,  6 May 2013 17:38:49 +0200
Message-ID: <1367854729-11416-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Vincent=20Stehl=C3=A9?= <v-stehle@ti.com>, trivial@kernel.org
List-Id: linux-omap@vger.kernel.org

=46rom: Vincent Stehl=C3=A9 <v-stehle@ti.com>

=46ix the following compilation warning:

  arch/arm/mach-omap2/gpmc.c: In function 'gpmc_probe_generic_child':
  arch/arm/mach-omap2/gpmc.c:1477:4: warning: format '%x' expects argum=
ent of type 'unsigned int', but argument 4 has type 'resource_size_t' [=
-Wformat]

Signed-off-by: Vincent Stehl=C3=A9 <v-stehle@ti.com>
Cc: trivial@kernel.org
---

(This is a resend.)

 arch/arm/mach-omap2/gpmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index ed946df..3cd7074 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1474,7 +1474,7 @@ static int gpmc_probe_generic_child(struct platfo=
rm_device *pdev,
 	ret =3D gpmc_cs_remap(cs, res.start);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%x\n",
-			cs, res.start);
+			cs, (unsigned)res.start);
 		goto err;
 	}
=20
--=20
1.7.10.4
