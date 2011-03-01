From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 5/9] OMAP2+: hwmod: rename some init functions
Date: Tue, 1 Mar 2011 12:23:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A21418B@dbde02.ent.ti.com>
References: <20110228210858.15286.3200.stgit@twilight.localdomain>
 <20110228211217.15286.26420.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45910 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755514Ab1CAGxX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 01:53:23 -0500
In-Reply-To: <20110228211217.15286.26420.stgit@twilight.localdomain>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>

[...]

/**
- * omap_hwmod_late_init - do some post-clock framework initialization
+ * omap_hwmod_setup - do some post-clock framework initialization
Very minor comment: omap_hwmod_setup_all
--
Tarun
  *
  * Must be called after omap2_clk_init().  Resolves the struct clk names
  * to struct clk pointers for each registered omap_hwmod.  Also calls
  * _setup() on each hwmod.  Returns 0.
  */
-static int __init omap_hwmod_late_init(void)
+static int __init omap_hwmod_setup_all(void)
 {
 	int r;
