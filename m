From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] ARM: OMAP2+: Handle reset quirks for dynamically
 allocated modules
Date: Tue, 26 Mar 2019 08:36:01 -0700
Message-ID: <20190326153601.GB49658@atomide.com>
References: <20190325183819.15400-1-tony@atomide.com>
 <20190325183819.15400-8-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190325183819.15400-8-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190325 18:38]:
> For dynamically allocated struct omap_hwmod data, we need to populate
> the device IP specific reset quirks.
...
> +static const struct omap_hwmod_reset omap24xx_reset_quirks[] = {
> +	{ .match = "msdi", .len = 3, .reset = omap_msdi_reset, },
> +};

This patch needs the following fix for omap_msdi_reset() if
24xx is not selected.

Regards,

Tony

8< ---------------
diff --git a/arch/arm/mach-omap2/mmc.h b/arch/arm/mach-omap2/mmc.h
--- a/arch/arm/mach-omap2/mmc.h
+++ b/arch/arm/mach-omap2/mmc.h
@@ -7,7 +7,15 @@
 #define OMAP4_MMC_REG_OFFSET	0x100
 
 struct omap_hwmod;
+
+#ifdef CONFIG_SOC_OMAP2420
 int omap_msdi_reset(struct omap_hwmod *oh);
+#else
+static inline int omap_msdi_reset(struct omap_hwmod *oh)
+{
+	return 0;
+}
+#endif
 
 /* called from board-specific card detection service routine */
 extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
