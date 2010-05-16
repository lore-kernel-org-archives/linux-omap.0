From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 14/14] dspbridge: deh: update copyright notice
Date: Sun, 16 May 2010 18:46:05 +0300
Message-ID: <1274024765-21076-15-git-send-email-felipe.contreras@gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:5081 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab0EPPqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:37 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2359940fga.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:36 -0700 (PDT)
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Add myself... git blame seems to agree :)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdeh.h |    1 +
 drivers/dsp/bridge/core/_deh.h                |    1 +
 drivers/dsp/bridge/core/ue_deh.c              |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdeh.h b/arch/arm/plat-omap/include/dspbridge/dspdeh.h
index e5e83b4..28734f2 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdeh.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdeh.h
@@ -10,6 +10,7 @@
  *   Function comment headers reside with the function typedefs in dspdefs.h.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
+ * Copyright (C) 2010 Felipe Contreras
  *
  * This package is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/dsp/bridge/core/_deh.h b/drivers/dsp/bridge/core/_deh.h
index 9fb727b..16723cd 100644
--- a/drivers/dsp/bridge/core/_deh.h
+++ b/drivers/dsp/bridge/core/_deh.h
@@ -6,6 +6,7 @@
  * Private header for DEH module.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
+ * Copyright (C) 2010 Felipe Contreras
  *
  * This package is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 6ff73a2..315672b 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -6,6 +6,7 @@
  * Implements upper edge DSP exception handling (DEH) functions.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
+ * Copyright (C) 2010 Felipe Contreras
  *
  * This package is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.7.1

