From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 6/9] regulator: palmas: Drop unnecessary static
Date: Thu,  4 May 2017 22:10:51 +0200
Message-ID: <1493928654-18768-7-git-send-email-Julia.Lawall@lip6.fr>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

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

---
 drivers/regulator/palmas-regulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 31ae5ee..34d4a62 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1491,7 +1491,7 @@ static int palmas_dt_to_pdata(struct device *dev,
 	}
 
 	for (idx = 0; idx < ddata->max_reg; idx++) {
-		static struct of_regulator_match *match;
+		struct of_regulator_match *match;
 		struct palmas_reg_init *rinit;
 		struct device_node *np;
 

