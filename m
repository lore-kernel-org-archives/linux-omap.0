From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
Subject: [PATCH, v2] ARM: omap2: gpmc: fix compilation warning
Date: Tue, 14 May 2013 19:20:43 +0200
Message-ID: <1368552043-3764-1-git-send-email-vincent.stehle@laposte.net>
References: <20130508222639.GM32546@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130508222639.GM32546@atomide.com>
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

Tony wrote:
> You should just change the format for dev_err instead of the casting.

Hi,

Sorry for the late answer; it seems this is a bit more complicated afte=
r all,
as res.start can be 32b or 64b in LPAE. The common solution seems to be=
: cast
to long long in all cases and print accordingly. Would you like this be=
tter?

Best regards,

V.


 arch/arm/mach-omap2/gpmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 6c4da12..e74501e 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1473,8 +1473,8 @@ static int gpmc_probe_generic_child(struct platfo=
rm_device *pdev,
 	 */
 	ret =3D gpmc_cs_remap(cs, res.start);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%x\n",
-			cs, res.start);
+		dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%llx\n",
+			cs, (long long)res.start);
 		goto err;
 	}
=20
--=20
1.7.10.4
