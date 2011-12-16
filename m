From: Ming Lei <tom.leiming@gmail.com>
Subject: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Fri, 16 Dec 2011 21:24:25 +0800
Message-ID: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

I found that face detection module(fdif) can't be enabled successfully
without the
change in [1].

Looks like it is not a good way to do it because the dynamic dependency of
CD_CAM on l3_2 is disabled at default, not like other ones, so I guess that
it may work if the dynamic dependency is enabled by setting bit L3_2_DYNDEP
to CM_CAM_DYNAMICDEP.  After greping over arch/arm/mach-omap2 and
arch/arm/plat-omap, I did not find any operations on CM_*_DYNAMICDEP
register, so I am wondering if dynamic dependency is not used on omap4 at a=
ll
now.

Also I have tried to add 'l3_2_clkdm' into dependency table of iss_clkdm in=
 [2],
and it doesn't work.

How could I cope with the clock domain dependency so that fdif can be
enabled successfully?


thanks,--=A0Ming Lei
[1], add static dependency
diff --git a/arch/arm/mach-omap2/pm44xx.c
b/arch/arm/mach-omap2/pm44xx.cindex c264ef7..23e1f8c 100644---
a/arch/arm/mach-omap2/pm44xx.c+++ b/arch/arm/mach-omap2/pm44xx.c@@
-198,6 +198,7 @@ static int __init omap4_pm_init(void)=A0	int ret;
	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;=A0	struct
clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;+	struct
clockdomain *iss_clkdm;=A0=A0	if (!cpu_is_omap44xx())=A0		return -ENODEV;@@
-227,8 +228,10 @@ static int __init omap4_pm_init(void)=A0	l3_2_clkdm =3D
clkdm_lookup("l3_2_clkdm");=A0	l4_per_clkdm =3D
clkdm_lookup("l4_per_clkdm");=A0	ducati_clkdm =3D
clkdm_lookup("ducati_clkdm");+	iss_clkdm =3D clkdm_lookup("iss_clkdm");
	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm)
||-		(!l3_2_clkdm) || (!ducati_clkdm) ||
(!l4_per_clkdm))+		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm)
||+		(!iss_clkdm))=A0		goto err2;=A0=A0	ret =3D clkdm_add_wkdep(mpuss_clkdm,
emif_clkdm);@@ -237,6 +240,7 @@ static int __init omap4_pm_init(void)
	ret |=3D clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);=A0	ret |=3D
clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);=A0	ret |=3D
clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);+	ret |=3D
clkdm_add_wkdep(iss_clkdm, l3_2_clkdm);=A0	if (ret) {=A0		pr_err("Failed
to add MPUSS -> L3/EMIF/L4PER, DUCATI -> L3 "=A0				"wakeup
dependency\n");
[2],

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 9299ac2..3f8f6a9 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -65,6 +65,7 @@ static struct clkdm_dep ducati_wkup_sleep_deps[] =3D {
 static struct clkdm_dep iss_wkup_sleep_deps[] =3D {
        { .clkdm_name =3D "ivahd_clkdm" },
        { .clkdm_name =3D "l3_1_clkdm" },
+       { .clkdm_name =3D "l3_2_clkdm" },
        { .clkdm_name =3D "l3_emif_clkdm" },
        { NULL },
 };
