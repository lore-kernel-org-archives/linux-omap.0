From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Thu, 16 Sep 2010 05:32:03 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C014F09CDD5@dlee02.ent.ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
 <1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03294424E7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44934 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245Ab0IPKcK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 06:32:10 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03294424E7@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gopinath, Thara

[...]
> >>diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-
> omap/include/plat/opp.h
> >>new file mode 100644
> >>index 0000000..997b56e
> >>--- /dev/null
> >>+++ b/arch/arm/plat-omap/include/plat/opp.h
[..]
> >>+
> >>+#ifdef CONFIG_PM
> >>+
[..]
> >>+struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long
> *freq);
> >>+
> >>+int opp_add(const struct omap_opp_def *opp_def);
> >>+
> >>+int opp_enable(struct omap_opp *opp);
> >>+
> >>+int opp_disable(struct omap_opp *opp);
> >>+
> >>+void opp_init_cpufreq_table(struct device *dev,
> >>+			    struct cpufreq_frequency_table **table);
> >>+#else
> 
> Hello Kevin,
> 
> IN case of CONFIG_PM not being defined the else part will cause a
> compilation break as
> the signature of these APIs defined in the else part do not match with the
> signature in
> the if part.
> 
Thanks for the catch. Will send a patch for this.
Regards,
Nishanth Menon
