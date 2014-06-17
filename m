From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] omap2: fix parser-bug in platform muxing code
Date: Tue, 17 Jun 2014 01:46:16 -0700
Message-ID: <20140617084615.GN17845@atomide.com>
References: <20140616234251.GA10376@ganymede.118net.x>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37052 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbaFQIqS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 04:46:18 -0400
Content-Disposition: inline
In-Reply-To: <20140616234251.GA10376@ganymede.118net.x>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David R. Piegdon" <lkml@p23q.org>
Cc: linux-omap@vger.kernel.org

* David R. Piegdon <lkml@p23q.org> [140616 16:44]:
> Fix a parser-bug in the omap2 muxing code where muxtable-entries will be
> wrongly selected if the requested muxname is a *prefix* of their
> m0-entry and they have a matching mN-entry. Fix by additionally checking
> that the length of the m0_entry is equal.

OK thanks, applying the following cosmetically updated version
with formatting fixed up for checkpatch.pl.

Regards,

Tony

8< ------------
From: "David R. Piegdon" <lkml@p23q.org>
Date: Mon, 16 Jun 2014 23:42:51 +0000
Subject: [PATCH] ARM: OMAP2+: Fix parser-bug in platform muxing code

Fix a parser-bug in the omap2 muxing code where muxtable-entries will be
wrongly selected if the requested muxname is a *prefix* of their
m0-entry and they have a matching mN-entry. Fix by additionally checking
that the length of the m0_entry is equal.

For example muxing of "dss_data2.dss_data2" on omap32xx will fail
because the prefix "dss_data2" will match the mux-entries "dss_data2" as
well as "dss_data20", with the suffix "dss_data2" matching m0 (for
dss_data2) and m4 (for dss_data20). Thus both are recognized as signal
path candidates:

Relevant muxentries from mux34xx.c:
        _OMAP3_MUXENTRY(DSS_DATA20, 90,
                "dss_data20", NULL, "mcspi3_somi", "dss_data2",
                "gpio_90", NULL, NULL, "safe_mode"),
        _OMAP3_MUXENTRY(DSS_DATA2, 72,
                "dss_data2", NULL, NULL, NULL,
                "gpio_72", NULL, NULL, "safe_mode"),

This will result in a failure to mux the pin at all:

 _omap_mux_get_by_name: Multiple signal paths (2) for dss_data2.dss_data2

Patch should apply to linus' latest master down to rather old linux-2.6
trees.

Signed-off-by: David R. Piegdon <lkml@p23q.org>
Cc: stable@vger.kernel.org
[tony@atomide.com: updated description to include full description]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -183,8 +183,10 @@ static int __init _omap_mux_get_by_name(struct omap_mux_partition *partition,
 		m0_entry = mux->muxnames[0];
 
 		/* First check for full name in mode0.muxmode format */
-		if (mode0_len && strncmp(muxname, m0_entry, mode0_len))
-			continue;
+		if (mode0_len)
+			if (strncmp(muxname, m0_entry, mode0_len) ||
+			    (strlen(m0_entry) != mode0_len))
+				continue;
 
 		/* Then check for muxmode only */
 		for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
