From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PM-WIP-OPP][PATCH 3/4] omap: pm: opp: add ability to store
 data per opp
Date: Fri, 19 Mar 2010 16:43:33 +0200
Message-ID: <20100319144333.GU18995@nokia.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>
 <1268937891-19445-2-git-send-email-nm@ti.com>
 <1268937891-19445-3-git-send-email-nm@ti.com>
 <1268937891-19445-4-git-send-email-nm@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55978 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab0CSOo0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 10:44:26 -0400
Content-Disposition: inline
In-Reply-To: <1268937891-19445-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: Linux-Omap <linux-omap@vger.kernel.org>, Ambresh K <ambresh@ti.com>, Benoit Cousson <b-cousson@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, Sanjeev Premi <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, Thara Gopinath <thara@ti.com>

hi,

On Thu, Mar 18, 2010 at 07:44:50PM +0100, ext Nishanth Menon wrote:
>+int opp_store_data(struct omap_opp *opp, char *name, void *data)
>+{
>+	return -EINVAL;

Would -ENODATA fit better ??

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
>+	char *name;
>+	void *data;
>+	struct list_head list;
>+};
>+
> /**
>  * struct omap_opp - OMAP OPP description structure
>  * @enabled:	true/false - marking this OPP as enabled/disabled
>@@ -37,6 +44,7 @@ struct omap_opp {
> 	unsigned long rate;
> 	unsigned long u_volt;
> 	u8 opp_id;
>+	struct list_head data_list;
> };
>
> /*
>@@ -218,6 +226,7 @@ static void omap_opp_populate(struct omap_opp *opp,
> 	opp->rate = opp_def->freq;
> 	opp->enabled = opp_def->enabled;
> 	opp->u_volt = opp_def->u_volt;
>+	INIT_LIST_HEAD(&opp->data_list);
> }
>
> int opp_add(enum opp_t opp_type, const struct omap_opp_def *opp_def)
>@@ -352,6 +361,63 @@ int opp_disable(struct omap_opp *opp)
> 	return 0;
> }
>
>+void *opp_get_data(struct omap_opp *opp, char *name)
>+{
>+	void *data = ERR_PTR(-EINVAL);
>+	struct omap_opp_data *tmp;
>+
>+	if (unlikely(!opp || !name))
>+		return ERR_PTR(-EINVAL);
>+
>+	list_for_each_entry(tmp, &opp->data_list, list)
>+		if (!strcmp(name, tmp->name)) {
>+			data = tmp->data;
>+			break;
>+		}
>+	return data;
>+}
>+
>+int opp_store_data(struct omap_opp *opp, char *name, void *data)
>+{
>+	struct omap_opp_data *new;
>+	if (unlikely(!opp || !name))
>+		return -EINVAL;
>+	/* NAK to double registration */
>+	if (unlikely(!IS_ERR(opp_get_data(opp, name))))
>+		return -EINVAL;
>+
>+	new = kmalloc(sizeof(struct omap_opp), GFP_KERNEL);
>+	if (!new)
>+		return -ENOMEM;
>+	new->name = kmalloc(strlen(name) + 1, GFP_KERNEL);
>+	if (!new->name) {
>+		kfree(new);
>+		return -ENOMEM;
>+	}
>+	new->data = data;
>+	strcpy(new->name, name);
>+	INIT_LIST_HEAD(&new->list);
>+	list_add(&new->list, &opp->data_list);
>+	return 0;
>+}

will you really want to add several data entries there ? I don't see the 
point. Maybe I'm missing something.

I like the idea of having a void * to allow you to store anything there. 
But generally that's a 1 - 1 relation:

1 device/bus/(in this case) opp - 1 data.

by doing that, the API will look like 
dev_set_drvdata()/dev_get_drvdata() and could be implemented simply as:

void opp_set_data(struct omap_opp *opp, void *data)
{
	opp->data = data;

	return 0;
}

void *opp_get_data(struct omap_opp *opp)
{
	return opp->data;
}

-- 
balbi
