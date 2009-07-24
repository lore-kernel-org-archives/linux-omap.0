From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config
 option
Date: Fri, 24 Jul 2009 23:31:48 +0300 (EEST)
Message-ID: <20090724.233148.183047609.Hiroshi.DOYU@nokia.com>
References: <1248431051-26340-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E3A8CAD56@dlee03.ent.ti.com>
	<20090724.210005.226780464.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47698 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbZGXUbz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 16:31:55 -0400
In-Reply-To: <20090724.210005.226780464.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, ameya.palande@nokia.com, x0095840@ti.com, omar.ramirez@ti.com

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config option
Date: Fri, 24 Jul 2009 21:00:05 +0300 (EEST)

> Hi Hari,
> 
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: RE: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config option
> Date: Fri, 24 Jul 2009 19:28:47 +0200
> 
> > Hi Doyu-san,
> > 
> > > 
> > > "CONFIG_DSP_TRACEBUF" is introduced as a kernel config option to save
> > > some amount of unused memory and "#ifndef DSP_TRACEBUF_DISABLED" was
> > > not easy to understand.
> > >
> > 
> > I think we just use the Bridge DEBUG flag that is used in Bridge instead of introducing a new flag. 
> 
> It might be better if "CONFIG_DSP_TRACEBUF" had the dependecy on
> "DEBUG/CONFIG_BRIDGE_DEBUG", but it's not unfortunately.
> 
> The problem here is that now all TRACEBUF code is always compiled in
> in spite of setting "DEBUG". It doesn't print anything, but just
> wastes some memory.
> 
> I'll remove a new Kconfig entry and just add the dependency of
> "CONFIG_DSP_TRACEBUF" on "CONFIG_BRIDGE_DEBUG".

How about the following change?

	Modified drivers/dsp/bridge/Kconfig
diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index a43b19d..d73b097 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -32,12 +32,9 @@ config BRIDGE_MEMPOOL_SIZE
 config BRIDGE_DEBUG
 	bool "DSP Bridge Debug Support"
 	depends on MPU_BRIDGE
+	select DSP_TRACEBUF
 	help
 	  Say Y to enable Bridge debugging capabilities
 
 config DSP_TRACEBUF
-	bool "DSP Debug Trace Support"
-	depends on BRIDGE_DEBUG
-	help
-	  Say Y to enable DSP debugging capabilities. baseimage needs
-	  to be built with debug option.
+        bool

