From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PM-WIP-OPP][PATCH 3/4] omap: pm: opp: add ability to store
 data per opp
Date: Fri, 19 Mar 2010 11:14:48 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9EBAC2649@dnce01.ent.ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>
 <1268937891-19445-2-git-send-email-nm@ti.com>
 <1268937891-19445-3-git-send-email-nm@ti.com>
 <1268937891-19445-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39944 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab0CSKQq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 06:16:46 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1268937891-19445-4-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Linux-Omap <linux-omap@vger.kernel.org>
Cc: "K, Ambresh" <ambresh@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Hi Nishanth,

>From: Menon, Nishanth
>Sent: Thursday, March 18, 2010 7:45 PM
>
>Many modules seem to need some sort of flexible storage mechanism
>which is corresponds to a specific opp. To cater to this need, we
>provide store, restore and removal apis.

Do we really need that level of flexibility for the moment?
The type of information that belong to an OPP are kind of static for a dedicated SoC (i.e. SR gain, Ntarget, ABB).
Cannot a simple pointer to a static struct do the job?

That's just my two cents.

Regards,
Benoit


>Cc: Ambresh K <ambresh@ti.com>
>Cc: Benoit Cousson <b-cousson@ti.com>
>Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>
>Cc: Sanjeev Premi <premi@ti.com>
>Cc: Tero Kristo <tero.kristo@nokia.com>
>Cc: Thara Gopinath <thara@ti.com>
>
>Signed-off-by: Nishanth Menon <nm@ti.com>
>---
> arch/arm/plat-omap/include/plat/opp.h |   56 ++++++++++++++++++++++++++++
> arch/arm/plat-omap/opp.c              |   66
>+++++++++++++++++++++++++++++++++
> 2 files changed, 122 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-
>omap/include/plat/opp.h
>index dc9a0d9..666c514 100644
>--- a/arch/arm/plat-omap/include/plat/opp.h
>+++ b/arch/arm/plat-omap/include/plat/opp.h
>@@ -231,6 +231,47 @@ struct omap_opp * __deprecated opp_find_by_opp_id(enum
>opp_t opp_type,
>                                                 u8 opp_id);
> u8 __deprecated opp_get_opp_id(struct omap_opp *opp);
>
>+/**
>+ * opp_store_data() - Store a data corresponding to an opp
>+ * @opp: opp where to store
>+ * @name: unique string to identify the type of data stored
>+ * @data: The pointer which is used to the actual data
>+ *
>+ * Many scenarios require a custom data to be stored corresponding to a
>+ * specific OPP which may need to be retrieved for operations. The actual
>+ * type of data might be very specific to a CPU, allowing opp layer to
>store
>+ * any type or mixture of types of data to be adequately retrieved
>+ * by corresponding modules which consume that data.
>+ * typical examples are Smart reflex nTarget values, L3 threshold
>dependencies
>+ *
>+ * Returns 0 if successful or a corresponding error value if failed.
>+ */
>+int opp_store_data(struct omap_opp *opp, char *name, void *data);
>+
>+/**
>+ * opp_get_data() - get a stored data corresponding to an opp
>+ * @opp: pointer to opp
>+ * @name: unique string to identify the type of data stored
>+ *
>+ * Retrieve a stored data identified by the name allowing usage
>+ * accross modules on a need basis
>+ *
>+ * Returns ERR_PTRs and should be checked with IS_ERR() macros
>+ */
>+void *opp_get_data(struct omap_opp *opp, char *name);
>+
>+/**
>+ * opp_remove_data() - remove the stored data corresponding to an opp
>+ * @opp: pointer to opp
>+ * @name: unique string to identify the type of data stored
>+ *
>+ * Remove a stored data identified by the name allowing replacing
>+ * old values with new or removing the information altogether if needed
>+ *
>+ * Returns 0 if successfully removed, else returns corresponding error
>value
>+ */
>+int opp_remove_data(struct omap_opp *opp, char *name);
>+
> void opp_init_cpufreq_table(enum opp_t opp_type,
>                           struct cpufreq_frequency_table **table);
> #else
>@@ -300,6 +341,21 @@ static inline u8 __deprecated opp_get_opp_id(struct
>omap_opp *opp)
>       return 0;
> }
>
>+int opp_store_data(struct omap_opp *opp, char *name, void *data)
>+{
>+      return -EINVAL;
>+}
>+
>+void *opp_get_data(struct omap_opp *opp, char *name)
>+{
>+      return ERR_PTR(-EINVAL);
>+}
>+
>+int opp_remove_data(struct omap_opp *opp, char *name)
>+{
>+      return -EINVAL;
>+}
>+
> static inline void opp_init_cpufreq_table(struct omap_opp *opps,
>                           struct cpufreq_frequency_table **table)
> {
>diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
>index bb8120e..15f6f7c 100644
>--- a/arch/arm/plat-omap/opp.c
>+++ b/arch/arm/plat-omap/opp.c
>@@ -14,12 +14,19 @@
> #include <linux/errno.h>
> #include <linux/err.h>
> #include <linux/init.h>
>+#include <linux/list.h>
> #include <linux/slab.h>
> #include <linux/cpufreq.h>
>
> #include <plat/opp_twl_tps.h>
> #include <plat/opp.h>
>
>+struct omap_opp_data {
>+      char *name;
>+      void *data;
>+      struct list_head list;
>+};
>+
> /**
>  * struct omap_opp - OMAP OPP description structure
>  * @enabled:  true/false - marking this OPP as enabled/disabled
>@@ -37,6 +44,7 @@ struct omap_opp {
>       unsigned long rate;
>       unsigned long u_volt;
>       u8 opp_id;
>+      struct list_head data_list;
> };
>
> /*
>@@ -218,6 +226,7 @@ static void omap_opp_populate(struct omap_opp *opp,
>       opp->rate = opp_def->freq;
>       opp->enabled = opp_def->enabled;
>       opp->u_volt = opp_def->u_volt;
>+      INIT_LIST_HEAD(&opp->data_list);
> }
>
> int opp_add(enum opp_t opp_type, const struct omap_opp_def *opp_def)
>@@ -352,6 +361,63 @@ int opp_disable(struct omap_opp *opp)
>       return 0;
> }
>
>+void *opp_get_data(struct omap_opp *opp, char *name)
>+{
>+      void *data = ERR_PTR(-EINVAL);
>+      struct omap_opp_data *tmp;
>+
>+      if (unlikely(!opp || !name))
>+              return ERR_PTR(-EINVAL);
>+
>+      list_for_each_entry(tmp, &opp->data_list, list)
>+              if (!strcmp(name, tmp->name)) {
>+                      data = tmp->data;
>+                      break;
>+              }
>+      return data;
>+}
>+
>+int opp_store_data(struct omap_opp *opp, char *name, void *data)
>+{
>+      struct omap_opp_data *new;
>+      if (unlikely(!opp || !name))
>+              return -EINVAL;
>+      /* NAK to double registration */
>+      if (unlikely(!IS_ERR(opp_get_data(opp, name))))
>+              return -EINVAL;
>+
>+      new = kmalloc(sizeof(struct omap_opp), GFP_KERNEL);
>+      if (!new)
>+              return -ENOMEM;
>+      new->name = kmalloc(strlen(name) + 1, GFP_KERNEL);
>+      if (!new->name) {
>+              kfree(new);
>+              return -ENOMEM;
>+      }
>+      new->data = data;
>+      strcpy(new->name, name);
>+      INIT_LIST_HEAD(&new->list);
>+      list_add(&new->list, &opp->data_list);
>+      return 0;
>+}
>+
>+int opp_remove_data(struct omap_opp *opp, char *name)
>+{
>+      struct omap_opp_data *tmp;
>+
>+      if (unlikely(!opp || !name))
>+              return -EINVAL;
>+
>+      list_for_each_entry(tmp, &opp->data_list, list)
>+              if (!strcmp(name, tmp->name)) {
>+                      list_del(&tmp->list);
>+                      kfree(tmp->name);
>+                      kfree(tmp);
>+                      return 0;
>+              }
>+      return -EINVAL;
>+}
>+
> /* XXX document */
> void opp_init_cpufreq_table(enum opp_t opp_type,
>                           struct cpufreq_frequency_table **table)
>--
>1.6.3.3


Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



