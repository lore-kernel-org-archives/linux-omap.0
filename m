From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Fix omap_4430sdp_defconfig for make oldconfig
Date: Fri, 6 Aug 2010 14:50:10 +0300
Message-ID: <20100806115009.GL23778@atomide.com>
References: <8739uu9em0.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0323E6947D@dbde02.ent.ti.com>
 <87tyn8ptkl.fsf@deeprootsystems.com>
 <20100806070301.GA23778@atomide.com>
 <20100806070519.GB23778@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032401CFA6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="L6iaP+gRLNZHKoI4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54460 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab0HFLtn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 07:49:43 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032401CFA6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Nayak, Rajendra <rnayak@ti.com> [100806 14:22]:
> 
> Now with this, omap4 build using omap_4430sdp_defconfig seems to
> go through, but like you said, boot is still an issue.

Hmm, I guess these issues pop up if you do yes "" | make oldconfig.

Can you try the patch below? After applying the patch, you need
to:

$ rm .config
$ cp arch/arm/configs/omap_4430sdp_defconfig .config
$ yes "" | ARCH=arm make oldconfig

Then omap2 and 3 won't get selected by make oldconfig.

Regards,

Tony

--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=omap4-defconfig

>From 96214d5365a10f370e7690a3aa2dc24dbca39e79 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 6 Aug 2010 14:40:46 +0300
Subject: [PATCH] omap: Fix omap_4430sdp_defconfig for make oldconfig

We don't want to select select the other omaps at this
point because otherwise we would have to disable
CONFIG_SMP.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 63e0c2d..14c1e18 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -13,6 +13,9 @@ CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_OMAP=y
 CONFIG_ARCH_OMAP4=y
+# CONFIG_ARCH_OMAP2PLUS_TYPICAL is not set
+# CONFIG_ARCH_OMAP2 is not set
+# CONFIG_ARCH_OMAP3 is not set
 # CONFIG_OMAP_MUX is not set
 CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_DM_TIMER=y

--L6iaP+gRLNZHKoI4--
