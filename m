From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP MUX framework changes
Date: Fri, 19 Nov 2010 09:47:22 -0800
Message-ID: <20101119174721.GT9264@atomide.com>
References: <1290017211-2217-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27283 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab0KSRri (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 12:47:38 -0500
Content-Disposition: inline
In-Reply-To: <1290017211-2217-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com, khilman@deeprootsystems.com

* Dan Murphy <dmurphy@ti.com> [101117 09:58]:
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
>  
> +static struct omap_mux *omap_mux_get_by_mux(struct omap_mux_partition *partition,
> +					char *name)
> +{
> +	struct omap_mux_entry *e;
> +	int i = 0;
> +
> +	list_for_each_entry(e, &partition->muxmodes, node) {
> +		struct omap_mux *m = &e->mux;
> +		for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
> +			if (m->muxnames[i] == NULL)
> +				break;
> +			else if (!strcmp(name, m->muxnames[i]))
> +				return m;
> +		}
> +	}
> +
> +	return NULL;
> +}

Hmm turns out we almost have this already in _omap_mux_init_signal.
Also we need to know the mux mode value to make use of this, so
how about the patch below instead?

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 18 Nov 2010 18:55:53 -0800
Subject: [PATCH] omap: mux: Add omap_mux_get_by_name

Do this by splitting _omap_mux_init_signal as it already has most
of the necessary features.

Based on an earlier patch by Dan Murphy <dmurphy@ti.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -151,12 +151,14 @@ int __init omap_mux_init_gpio(int gpio, int val)
 	return -ENODEV;
 }
 
-static int __init _omap_mux_init_signal(struct omap_mux_partition *partition,
-					const char *muxname, int val)
+static int __init omap_mux_get_by_name(struct omap_mux_partition *partition,
+					const char *muxname,
+					struct omap_mux **found_mux)
 {
+	struct omap_mux *mux = NULL;
 	struct omap_mux_entry *e;
 	const char *mode_name;
-	int found = 0, mode0_len = 0;
+	int found = 0, mode, mode0_len = 0;
 	struct list_head *muxmodes = &partition->muxmodes;
 
 	mode_name = strchr(muxname, '.');
@@ -168,40 +170,34 @@ static int __init _omap_mux_init_signal(struct omap_mux_partition *partition,
 	}
 
 	list_for_each_entry(e, muxmodes, node) {
-		struct omap_mux *m = &e->mux;
-		char *m0_entry = m->muxnames[0];
+		char *m0_entry;
 		int i;
 
+		mux = &e->mux;
+		m0_entry = mux->muxnames[0];
+
 		/* First check for full name in mode0.muxmode format */
 		if (mode0_len && strncmp(muxname, m0_entry, mode0_len))
 			continue;
 
 		/* Then check for muxmode only */
 		for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
-			char *mode_cur = m->muxnames[i];
+			char *mode_cur = mux->muxnames[i];
 
 			if (!mode_cur)
 				continue;
 
 			if (!strcmp(mode_name, mode_cur)) {
-				u16 old_mode;
-				u16 mux_mode;
-
-				old_mode = omap_mux_read(partition,
-							 m->reg_offset);
-				mux_mode = val | i;
-				pr_debug("%s: Setting signal "
-					 "%s.%s 0x%04x -> 0x%04x\n", __func__,
-					 m0_entry, muxname, old_mode, mux_mode);
-				omap_mux_write(partition, mux_mode,
-					       m->reg_offset);
 				found++;
+				mode = i;
 			}
 		}
 	}
 
-	if (found == 1)
-		return 0;
+	if (found == 1) {
+		*found_mux = mux;
+		return mode;
+	}
 
 	if (found > 1) {
 		pr_err("%s: Multiple signal paths (%i) for %s\n", __func__,
@@ -209,7 +205,7 @@ static int __init _omap_mux_init_signal(struct omap_mux_partition *partition,
 		return -EINVAL;
 	}
 
-	pr_err("%s: Could not set signal %s\n", __func__, muxname);
+	pr_err("%s: Could not find signal %s\n", __func__, muxname);
 
 	return -ENODEV;
 }
@@ -217,12 +213,23 @@ static int __init _omap_mux_init_signal(struct omap_mux_partition *partition,
 int __init omap_mux_init_signal(const char *muxname, int val)
 {
 	struct omap_mux_partition *partition;
-	int ret;
 
 	list_for_each_entry(partition, &mux_partitions, node) {
-		ret = _omap_mux_init_signal(partition, muxname, val);
-		if (!ret)
-			return ret;
+		struct omap_mux *mux = NULL;
+		u16 old_mode;
+		u16 mux_mode;
+
+		mux_mode = omap_mux_get_by_name(partition, muxname, &mux);
+		if (mux_mode < 0)
+			continue;
+
+		old_mode = omap_mux_read(partition, mux->reg_offset);
+		mux_mode |= val;
+		pr_debug("%s: Setting signal %s 0x%04x -> 0x%04x\n",
+			 __func__, muxname, old_mode, mux_mode);
+		omap_mux_write(partition, mux_mode, mux->reg_offset);
+
+		return 0;
 	}
 
 	return -ENODEV;
