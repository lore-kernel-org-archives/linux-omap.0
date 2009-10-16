From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [RFC][Patch] OMAP3 PM: sysfs vdd_opp change  to use Constraint
 Framework
Date: Sat, 17 Oct 2009 00:57:40 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA174C99@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA174C98@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_FCCFB4CDC6E5564B9182F639FC35608702FA174C99dbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49559 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbZJPT1n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Oct 2009 15:27:43 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9GJRju4025172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:27:47 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9GJRiPx009192
	for <linux-omap@vger.kernel.org>; Sat, 17 Oct 2009 00:57:44 +0530 (IST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA174C98@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>

--_002_FCCFB4CDC6E5564B9182F639FC35608702FA174C99dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Note that this patch has dependency on Patch sent by Romit (in attached ema=
il).

Vishwanath

-----Original Message-----
From: Sripathy, Vishwanath=20
Sent: Friday, October 16, 2009 2:26 PM
To: Sripathy, Vishwanath; linux-omap@vger.kernel.org; Hilman, Kevin
Subject: [RFC][Patch] OMAP3 PM: sysfs vdd_opp change to use Constraint Fram=
ework

Sysfs entry vdd_opp currently does not use constraint framework.=20
Because of this, even if you set the opp via this entry, it has no effect=20
since it can be overridden by on demand governor any time.
This patch has changes to make vdd_opp to use constraint framework.=20
vdd_lock variable has to be used when application wants to disable DVFS
altogether. This will override any other constraints and will lock the
OPP to given value.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 13783f3..bcdc00d 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -47,6 +47,8 @@ static ssize_t idle_store(struct kobject *k, struct kobj_=
attribute *,
 static ssize_t vdd_opp_show(struct kobject *, struct kobj_attribute *, cha=
r *);
 static ssize_t vdd_opp_store(struct kobject *k, struct kobj_attribute *,
 			  const char *buf, size_t n);
+static ssize_t vdd_opp_lock_store(struct kobject *k, struct kobj_attribute=
 *,
+			  const char *buf, size_t n);
 static struct kobj_attribute vdd1_opp_attr =3D
 	__ATTR(vdd1_opp, 0644, vdd_opp_show, vdd_opp_store);
=20
@@ -103,6 +105,41 @@ static ssize_t vdd_opp_store(struct kobject *kobj, str=
uct kobj_attribute *attr,
 			  const char *buf, size_t n)
 {
 	unsigned short value;
+	struct omap_opp *opp_table;
+
+	if (sscanf(buf, "%hu", &value) !=3D 1)
+		return -EINVAL;
+
+	if (attr =3D=3D &vdd1_opp_attr) {
+		if (value < MIN_VDD1_OPP || value > MAX_VDD1_OPP) {
+			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
+			return -EINVAL;
+		}
+		opp_table =3D omap_get_mpu_rate_table();
+		omap_pm_cpu_set_freq(&sysfs_cpufreq_dev,
+					opp_table[value].rate);
+	} else if (attr =3D=3D &vdd2_opp_attr) {
+		if (value < MIN_VDD2_OPP || (value > MAX_VDD2_OPP)) {
+			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
+			return -EINVAL;
+		}
+		if (value =3D=3D VDD2_OPP2)
+			omap_pm_set_min_bus_tput(&sysfs_cpufreq_dev,
+					OCP_INITIATOR_AGENT, 83*1000*4);
+		else if (value =3D=3D VDD2_OPP3)
+			omap_pm_set_min_bus_tput(&sysfs_cpufreq_dev,
+					OCP_INITIATOR_AGENT, 166*1000*4);
+
+	} else {
+		return -EINVAL;
+	}
+	return n;
+}
+
+static ssize_t vdd_opp_lock_store(struct kobject *kobj,
+	struct kobj_attribute *attr, const char *buf, size_t n)
+{
+	unsigned short value;
 	int flags =3D 0;
=20
 	if (sscanf(buf, "%hu", &value) !=3D 1)
@@ -121,6 +158,11 @@ static ssize_t vdd_opp_store(struct kobject *kobj, str=
uct kobj_attribute *attr,
 		if (vdd1_locked =3D=3D 0 && value !=3D 0) {
 			resource_lock_opp(VDD1_OPP);
 			vdd1_locked =3D 1;
+			if (value < MIN_VDD1_OPP || value > MAX_VDD1_OPP) {
+				printk(KERN_ERR "vdd_opp_store: Invalid value\n");
+				return -EINVAL;
+				}
+		resource_set_opp_level(VDD1_OPP, value, flags);
 		}
 	} else if (attr =3D=3D &vdd2_lock_attr) {
 		flags =3D OPP_IGNORE_LOCK;
@@ -134,21 +176,12 @@ static ssize_t vdd_opp_store(struct kobject *kobj, st=
ruct kobj_attribute *attr,
 		if (vdd2_locked =3D=3D 0 && value !=3D 0) {
 			resource_lock_opp(VDD2_OPP);
 			vdd2_locked =3D 1;
+			if (value < MIN_VDD2_OPP || value > MAX_VDD2_OPP) {
+				printk(KERN_ERR "vdd_opp_store: Invalid value\n");
+				return -EINVAL;
+			}
+			resource_set_opp_level(VDD2_OPP, value, flags);
 		}
-	}
-
-	if (attr =3D=3D &vdd1_opp_attr) {
-		if (value < 1 || value > 5) {
-			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
-			return -EINVAL;
-		}
-		resource_set_opp_level(VDD1_OPP, value, flags);
-	} else if (attr =3D=3D &vdd2_opp_attr) {
-		if (value < 2 || value > 3) {
-			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
-			return -EINVAL;
-		}
-		resource_set_opp_level(VDD2_OPP, value, flags);
 	} else {
 		return -EINVAL;
 	}

--_002_FCCFB4CDC6E5564B9182F639FC35608702FA174C99dbde02enttico_
Content-Type: message/rfc822

Received: from dflp51.itg.ti.com (128.247.22.94) by DBDE70.ent.ti.com
 (172.24.170.148) with Microsoft SMTP Server id 8.1.358.0; Wed, 7 Oct 2009
 18:23:45 +0530
Received: from red.ext.ti.com (localhost [127.0.0.1])	by dflp51.itg.ti.com
 (8.13.7/8.13.7) with ESMTP id n97Cre2s012969;	Wed, 7 Oct 2009 07:53:40 -0500
 (CDT)
Received: from mail178-va3-R.bigfish.com (mail-va3.bigfish.com
 [216.32.180.114])	by red.ext.ti.com (8.13.7/8.13.7) with ESMTP id
 n97CrdSP032248	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=FAIL);	Wed, 7 Oct 2009 07:53:39 -0500
Received: from mail178-va3 (localhost.localdomain [127.0.0.1])	by
 mail178-va3-R.bigfish.com (Postfix) with ESMTP id 5288BDF0394;	Wed,  7 Oct
 2009 12:53:39 +0000 (UTC)
Received: by mail178-va3 (MessageSwitch) id 1254920016812052_32329; Wed,  7
 Oct 2009 12:53:36 +0000 (UCT)
Received: from VA3EHSMHS023.bigfish.com (unknown [10.7.14.251])	by
 mail178-va3.bigfish.com (Postfix) with ESMTP id 78C2FA68068;	Wed,  7 Oct 2009
 12:53:36 +0000 (UTC)
Received: from vger.kernel.org (209.132.176.167) by VA3EHSMHS023.bigfish.com
 (10.7.99.33) with Microsoft SMTP Server id 14.0.482.32; Wed, 7 Oct 2009
 12:53:34 +0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand	id
 S1758932AbZJGMmf (ORCPT <rfc822;wwang@ti.com> + 86 others);	Wed, 7 Oct 2009
 08:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758944AbZJGMmf
	(ORCPT <rfc822;linux-omap-outgoing>); Wed, 7 Oct 2009 08:42:35 -0400
Received: from comal.ext.ti.com ([198.47.26.152]:47496 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP	id S1758932AbZJGMme
 convert rfc822-to-8bit (ORCPT	<rfc822;linux-omap@vger.kernel.org>); Wed, 7
 Oct 2009 08:42:34 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])	by comal.ext.ti.com
 (8.13.7/8.13.7) with ESMTP id n97Cfsul005371	(version=TLSv1/SSLv3
 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);	Wed, 7 Oct 2009 07:41:56 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])	by dbdp20.itg.ti.com
 (8.13.8/8.13.8) with ESMTP id n97Cfr2L019082;	Wed, 7 Oct 2009 18:11:53 +0530
 (IST)
Received: from dbde02.ent.ti.com ([172.24.170.145]) by dbde71.ent.ti.com
 ([172.24.170.149]) with mapi; Wed, 7 Oct 2009 18:11:53 +0530
From: "Dasgupta, Romit" <romit@ti.com>
To: Kevin H <khilman@deeprootsystems.com>
CC: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Sender: "linux-omap-owner@vger.kernel.org" <linux-omap-owner@vger.kernel.org>
Date: Wed, 7 Oct 2009 18:11:50 +0530
Subject: [PATCH] omap-pm: Fixes behaviour of some shared resource framework
 functions
Thread-Topic: [PATCH] omap-pm: Fixes behaviour of some shared resource
 framework functions
Thread-Index: AcpHS4pTWD2Y91YESfyx2Sta5wjYgw==
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDCE4650@dbde02.ent.ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 10
X-MS-Exchange-Organization-AuthSource: dbde70.ent.ti.com
X-MS-Has-Attach: 
X-Auto-Response-Suppress: All
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
list-id: <linux-omap.vger.kernel.org>
x-bigfish: vps9(z34a4jzzz1202hzza509lz2dh6bhadk61h)
x-mailing-list: linux-omap@vger.kernel.org
x-fb-ss: 5,
x-spamscore: 9
x-spam-tcs-scl: 0:0
x-reverse-dns: vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

(Tested on Zoom2).

'omap_pm_dsp_set_min_opp' & 'omap_pm_cpu_set_freq' were using their own
struct device *. This is a problem because invoking these functions from
different clients would result in setting of the resource level as requeste=
d by
the last caller. Fixes this by introducing a struct device * to the paramet=
er
list for these functions.
Signed-off-by: Romit Dasgupta <romit@ti.com>
---

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 8e67861..e9adc67 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -47,6 +47,7 @@ static struct cpufreq_frequency_table *freq_table;
 #define MPU_CLK                "virt_prcm_set"
 #endif

+DEFINE_PER_CPU(struct device , cpu_freq_dev);
 static struct clk *mpu_clk;

 /* TODO: Add support for SDRAM timing changes */
@@ -115,8 +116,9 @@ static int omap_target(struct cpufreq_policy *policy,
                int ind;
                for (ind =3D 1; ind <=3D MAX_VDD1_OPP; ind++) {
                        if (mpu_opps[ind].rate/1000 >=3D target_freq) {
-                               omap_pm_cpu_set_freq
-                                       (mpu_opps[ind].rate);
+                               omap_pm_cpu_set_freq(
+                                       &__get_cpu_var(cpu_freq_dev),
+                                       mpu_opps[ind].rate);
                                break;
                        }
                }
diff --git a/arch/arm/plat-omap/include/mach/omap-pm.h b/arch/arm/plat-omap=
/include/mach/omap-pm.h
index 583e540..5b26ba1 100644
--- a/arch/arm/plat-omap/include/mach/omap-pm.h
+++ b/arch/arm/plat-omap/include/mach/omap-pm.h
@@ -226,6 +226,7 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void);

 /**
  * omap_pm_dsp_set_min_opp - receive desired OPP target ID from DSP Bridge
+ * @dev: Identifies the client that wants to set the VDD1 OPP.
  * @opp_id: target DSP OPP ID
  *
  * Set a minimum OPP ID for the DSP.  This is intended to be called
@@ -233,7 +234,7 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void);
  * information that code receives from the DSP/BIOS load estimator is the
  * target OPP ID; hence, this interface.  No return value.
  */
-void omap_pm_dsp_set_min_opp(u8 opp_id);
+void omap_pm_dsp_set_min_opp(struct device *dev, u8 opp_id);

 /**
  * omap_pm_dsp_get_opp - report the current DSP OPP ID
@@ -283,6 +284,7 @@ struct cpufreq_frequency_table **omap_pm_cpu_get_freq_t=
able(void);

 /**
  * omap_pm_cpu_set_freq - set the current minimum MPU frequency
+ * @dev: Identifies the client that wants to set the frequency.
  * @f: MPU frequency in Hz
  *
  * Set the current minimum CPU frequency.  The actual CPU frequency
@@ -290,7 +292,7 @@ struct cpufreq_frequency_table **omap_pm_cpu_get_freq_t=
able(void);
  * Intended to be called by plat-omap/cpu_omap.c:omap_target().  No
  * return value.
  */
-void omap_pm_cpu_set_freq(unsigned long f);
+void omap_pm_cpu_set_freq(struct device *dev, unsigned long f);

 /**
  * omap_pm_cpu_get_freq - report the current CPU frequency
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm=
-noop.c
index 10463a4..6546527 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -159,7 +159,7 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void)
 }
 EXPORT_SYMBOL(omap_pm_dsp_get_opp_table);

-void omap_pm_dsp_set_min_opp(u8 opp_id)
+void omap_pm_dsp_set_min_opp(struct device *dev, u8 opp_id)
 {
        if (opp_id =3D=3D 0) {
                WARN_ON(1);
@@ -244,7 +244,7 @@ struct cpufreq_frequency_table **omap_pm_cpu_get_freq_t=
able(void)
        return NULL;
 }

-void omap_pm_cpu_set_freq(unsigned long f)
+void omap_pm_cpu_set_freq(struct device *dev, unsigned long f)
 {
        if (f =3D=3D 0) {
                WARN_ON(1);
diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-=
srf.c
index 4350650..aece740 100644
--- a/arch/arm/plat-omap/omap-pm-srf.c
+++ b/arch/arm/plat-omap/omap-pm-srf.c
@@ -169,8 +169,6 @@ void omap_pm_set_max_sdma_lat(struct device *dev, long =
t)
        }
 }

-static struct device dummy_dsp_dev;
-
 /*
  * DSP Bridge-specific constraints
  */
@@ -187,20 +185,15 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void=
)
 }
 EXPORT_SYMBOL(omap_pm_dsp_get_opp_table);

-void omap_pm_dsp_set_min_opp(u8 opp_id)
+void omap_pm_dsp_set_min_opp(struct device *dev, u8 opp_id)
 {
-       if (opp_id =3D=3D 0) {
+       if (dev =3D=3D NULL || opp_id =3D=3D 0) {
                WARN_ON(1);
                return;
        }

        pr_debug("OMAP PM: DSP requests minimum VDD1 OPP to be %d\n", opp_i=
d);
-
-       /*
-        * For now pass a dummy_dev struct for SRF to identify the caller.
-        * Maybe its good to have DSP pass this as an argument
-        */
-       resource_request("vdd1_opp", &dummy_dsp_dev, opp_id);
+       resource_request("vdd1_opp", dev, opp_id);
        return;
 }
 EXPORT_SYMBOL(omap_pm_dsp_set_min_opp);
@@ -246,19 +239,16 @@ struct cpufreq_frequency_table **omap_pm_cpu_get_freq=
_table(void)
        return NULL;
 }

-static struct device dummy_cpufreq_dev;
-
-void omap_pm_cpu_set_freq(unsigned long f)
+void omap_pm_cpu_set_freq(struct device *dev, unsigned long f)
 {
-       if (f =3D=3D 0) {
+       if (dev =3D=3D NULL || f =3D=3D 0) {
                WARN_ON(1);
                return;
        }

        pr_debug("OMAP PM: CPUFreq requests CPU frequency to be set to %lu\=
n",
                 f);
-
-       resource_request("mpu_freq", &dummy_cpufreq_dev, f);
+       resource_request("mpu_freq", dev, f);
        return;
 }
 EXPORT_SYMBOL(omap_pm_cpu_set_freq);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--_002_FCCFB4CDC6E5564B9182F639FC35608702FA174C99dbde02enttico_--
