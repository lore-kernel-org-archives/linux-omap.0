From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: hwmod: Handle opt clocks node using
 clk_add_alias
Date: Tue, 21 Sep 2010 15:00:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009211427230.4677@utopia.booyaka.com>
References: <1285089784-2786-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-775748362-1285101477=:4677"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36192 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab0IUVAg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 17:00:36 -0400
In-Reply-To: <1285089784-2786-1-git-send-email-b-cousson@ti.com>
Content-ID: <alpine.DEB.2.00.1009211445140.4677@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, "Basak, Partha" <p-basak2@ti.com>, Charulatha V <charu@ti.com>, Rajendra Nayak <rnayak@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-775748362-1285101477=:4677
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1009211445141.4677@utopia.booyaka.com>

Hi Partha, Beno=EEt,

On Tue, 21 Sep 2010, Benoit Cousson wrote:

> From: Basak, Partha <p-basak2@ti.com>
>=20
> For every optional clock present per hwmod per omap-device, this function
> adds an entry in the clocks list of the form <dev-id=3Ddev_name, con-id=
=3Drole>,
> if an entry is already present in the list of the form <dev-id=3DNULL, co=
n-id=3Drole>.
>=20
> The function is called from within the framework inside omap_device_build=
_ss(),
> after omap_device_register.
>=20
> This allows drivers to get a pointer to its optional clocks based on its =
role
> by calling clk_get(<dev*>, <role>).
>=20
> Link to discussions related to this patch:
> http://www.spinics.net/lists/linux-omap/msg34809.html

I've queued a modified version of this patch for 2.6.37 with a few=20
changes.  The modified version is below.  Could you please test=20
it at your earliest opportunity and also comment as to your opinion on the=
=20
changes?

The major changes are:

- Remove the secondary index in the for() and convert to an array index in=
=20
the loop body (I once was bit by a difficult-to-find bug with pointer=20
arithmetic with a secondary index, so am a little gun-shy of such code;=20
plus I think the array index is easier to read)

- Walk the omap_hwmod_opt_clks in order, rather than in reverse

- Remove the clk_get() test, since clk_add_alias() does it for us if the=20
'dev' parameter is supplied

- Supply a 'dev' parameter for clk_add_alias() (see the above)

- Continue iterating the loop even if one of the opt clks was not=20
resolved during init, rather than bailing out immediately


- Paul


From: Basak, Partha <p-basak2@ti.com>
Date: Tue, 21 Sep 2010 19:23:04 +0200
Subject: [PATCH] OMAP: hwmod: Handle opt clocks node using clk_add_alias

For every optional clock present per hwmod per omap-device, this function
adds an entry in the clocks list of the form <dev-id=3Ddev_name, con-id=3Dr=
ole>,
if an entry is already present in the list of the form <dev-id=3DNULL, con-=
id=3Drole>.

The function is called from within the framework inside omap_device_build_s=
s(),
after omap_device_register.

This allows drivers to get a pointer to its optional clocks based on its ro=
le
by calling clk_get(<dev*>, <role>).

Link to discussions related to this patch:
http://www.spinics.net/lists/linux-omap/msg34809.html

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: simplified loop iterator; removed the superfluous clk_get(=
),
 using the clk_get() in clk_add_alias() instead]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/omap_device.c |   43 ++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_dev=
ice.c
index d2b1609..ceba58a 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -82,6 +82,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/clk.h>
=20
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
@@ -243,6 +244,44 @@ static inline struct omap_device *_find_by_pdev(struct=
 platform_device *pdev)
 =09return container_of(pdev, struct omap_device, pdev);
 }
=20
+/**
+ * _add_optional_clock_alias - Add clock alias for hwmod optional clocks
+ * @od: struct omap_device *od
+ *
+ * For every optional clock present per hwmod per omap_device, this functi=
on
+ * adds an entry in the clocks list of the form <dev-id=3Ddev_name, con-id=
=3Drole>
+ * if an entry is already present in it with the form <dev-id=3DNULL, con-=
id=3Drole>
+ *
+ * The function is called from inside omap_device_build_ss(), after
+ * omap_device_register.
+ *
+ * This allows drivers to get a pointer to its optional clocks based on it=
s role
+ * by calling clk_get(<dev*>, <role>).
+ *
+ * No return value.
+ */
+static void _add_optional_clock_alias(struct omap_device *od,
+=09=09=09=09      struct omap_hwmod *oh)
+{
+=09int i;
+
+=09for (i =3D 0; i < oh->opt_clks_cnt; i++) {
+=09=09struct omap_hwmod_opt_clk *oc;
+=09=09int r;
+
+=09=09oc =3D &oh->opt_clks[i];
+
+=09=09if (!oc->_clk)
+=09=09=09continue;
+
+=09=09r =3D clk_add_alias(oc->role, dev_name(&od->pdev.dev),
+=09=09=09=09  (char *)oc->clk, &od->pdev.dev);
+=09=09if (r)
+=09=09=09pr_err("omap_device: %s: clk_add_alias for %s failed\n",
+=09=09=09       dev_name(&od->pdev.dev), oc->role);
+=09}
+}
+
=20
 /* Public functions for use by core code */
=20
@@ -421,8 +460,10 @@ struct omap_device *omap_device_build_ss(const char *p=
dev_name, int pdev_id,
 =09else
 =09=09ret =3D omap_device_register(od);
=20
-=09for (i =3D 0; i < oh_cnt; i++)
+=09for (i =3D 0; i < oh_cnt; i++) {
 =09=09hwmods[i]->od =3D od;
+=09=09_add_optional_clock_alias(od, hwmods[i]);
+=09}
=20
 =09if (ret)
 =09=09goto odbs_exit4;
--=20
1.7.1
--155748971-775748362-1285101477=:4677--
