From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: palmas: Drop unnecessary static" to the regulator tree
Date: Tue, 23 May 2017 12:24:56 +0100
Message-ID: <E1dD7vs-0004V7-Lb@finisterre>
References: <1493928654-18768-7-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493928654-18768-7-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, keescook@chromium.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.orglinux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: palmas: Drop unnecessary static

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

>From 96e4f5232c8cdb64cb18721ea0871c849346cbf5 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Thu, 4 May 2017 22:10:51 +0200
Subject: [PATCH] regulator: palmas: Drop unnecessary static

Drop static on a local variable, when the variable is initialized before
any use, on every possible execution path through the function.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@bad exists@
position p;
identifier x;
type T;
@@

static T x@p;
...
x = <+...x...+>

@@
identifier x;
expression e;
type T;
position p != bad.p;
@@

-static
 T x@p;
 ... when != x
     when strict
?x = e;
// </smpl>

There is no reduction in code size in this case, but the change does reduce
the size of the bss segment, containing uninitialized static data.

before:
   text    data     bss     dec     hex filename
  12882    3480       8   16370    3ff2 drivers/regulator/palmas-regulator.o

after:
   text    data     bss     dec     hex filename
  12882    3480       0   16362    3fea drivers/regulator/palmas-regulator.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/palmas-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 31ae5ee3a80d..34d4a62283d7 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1491,7 +1491,7 @@ static int palmas_dt_to_pdata(struct device *dev,
 	}
 
 	for (idx = 0; idx < ddata->max_reg; idx++) {
-		static struct of_regulator_match *match;
+		struct of_regulator_match *match;
 		struct palmas_reg_init *rinit;
 		struct device_node *np;
 
-- 
2.11.0
