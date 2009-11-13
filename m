From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/14] omap3: move check_revision above check_features,
 v2
Date: Fri, 13 Nov 2009 12:55:53 -0800
Message-ID: <20091113205553.GF3684@atomide.com>
References: <20091113000444.9034.41293.stgit@localhost>
 <20091113000932.9034.66321.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55749 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbZKMUz6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 15:55:58 -0500
Content-Disposition: inline
In-Reply-To: <20091113000932.9034.66321.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Mika Westerberg <mika.westerberg@iki.fi>, linux-omap@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [091112 16:09]:
> From: Tony Lindgren <Menon>

Looks like the From: got messed up. Here's a fixed version.

Tony

--7JfCtLOvnd9MIVvH
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="cpu-omap3-move-check_revision-above-check_features.patch"

>From b6c79698403f9926fb43d7e5cef9503a30b5709f Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Fri, 13 Nov 2009 12:41:25 -0800
Subject: [PATCH] omap3: move check_revision above check_features

omap3_check_revision() does not depend on omap3_check_features()
move this above so that we can add logic based on revision
detected in check_features.

Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 441ca26..6c11b41 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -352,8 +352,8 @@ void __init omap2_check_revision(void)
 	if (cpu_is_omap24xx())
 		omap24xx_check_revision();
 	else if (cpu_is_omap34xx()) {
-		omap3_check_features();
 		omap3_check_revision();
+		omap3_check_features();
 		omap3_cpuinfo();
 	}
 	else if (cpu_is_omap44xx()) {

--7JfCtLOvnd9MIVvH--
