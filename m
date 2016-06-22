From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "regulator: of: setup initial suspend state" to the regulator tree
Date: Wed, 22 Jun 2016 16:29:02 +0100
Message-ID: <E1bFk5O-0002RF-W0@debutante>
References: <1466412218-5906-3-git-send-email-j-keerthy@ti.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466412218-5906-3-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.orgbroonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgt-kristo-l0cyMroinI0@public.gmane.org, russ.dill-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.orgDave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: of: setup initial suspend state

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a0f78bc89c0396d14b6102c6f72485e14c8821f3 Mon Sep 17 00:00:00 2001
From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Date: Mon, 20 Jun 2016 14:13:31 +0530
Subject: [PATCH] regulator: of: setup initial suspend state

Setup initial suspend state to mem, if suspend state is defined for
mem state. This makes sure that the regulators are in proper mode
already from boot.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/regulator/of_regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index cd828dbf9d52..4f613ec99500 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -163,6 +163,9 @@ static void of_get_regulation_constraints(struct device_node *np,
 					"regulator-suspend-microvolt", &pval))
 			suspend_state->uV = pval;
 
+		if (i == PM_SUSPEND_MEM)
+			constraints->initial_state = PM_SUSPEND_MEM;
+
 		of_node_put(suspend_np);
 		suspend_state = NULL;
 		suspend_np = NULL;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
