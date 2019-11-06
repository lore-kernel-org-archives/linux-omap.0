From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] bus: ti-sysc: Adjust exception handling in
 sysc_child_add_named_clock()
Date: Wed, 6 Nov 2019 19:22:05 +0100
Message-ID: <8874d0c5-856a-809f-cba6-1b970df68d13@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Nov 2019 19:12:30 +0100

Add a jump target so that a call of the function =E2=80=9Cclk_put=E2=80=9D
can be better reused at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/bus/ti-sysc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 97b85493aa43..2042f6e45163 100644
=2D-- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1766,9 +1766,8 @@ static int sysc_child_add_named_clock(struct sysc *d=
data,

 	clk =3D clk_get(child, name);
 	if (!IS_ERR(clk)) {
-		clk_put(clk);
-
-		return -EEXIST;
+		error =3D -EEXIST;
+		goto put_clk;
 	}

 	clk =3D clk_get(ddata->dev, name);
@@ -1778,7 +1777,7 @@ static int sysc_child_add_named_clock(struct sysc *d=
data,
 	l =3D clkdev_create(clk, name, dev_name(child));
 	if (!l)
 		error =3D -ENOMEM;
-
+put_clk:
 	clk_put(clk);

 	return error;
=2D-
2.24.0
