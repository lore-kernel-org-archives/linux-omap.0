From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 13/13] staging: ti dspbridge: deh: update copyright notice
Date: Sun,  4 Jul 2010 16:34:39 +0300
Message-ID: <1278250479-16982-14-git-send-email-felipe.contreras@gmail.com>
References: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56879 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757781Ab0GDNfI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 09:35:08 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so2295391bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 06:35:07 -0700 (PDT)
In-Reply-To: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Felipe Contreras <felipe.contreras@gmail.com>

Add myself... git blame seems to agree :)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/core/_deh.h            |    1 +
 drivers/staging/tidspbridge/core/ue_deh.c          |    1 +
 .../staging/tidspbridge/include/dspbridge/dspdeh.h |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/_deh.h b/drivers/staging/tidspbridge/core/_deh.h
index 9fb727b..16723cd 100644
--- a/drivers/staging/tidspbridge/core/_deh.h
+++ b/drivers/staging/tidspbridge/core/_deh.h
@@ -6,6 +6,7 @@
  * Private header for DEH module.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
+ * Copyright (C) 2010 Felipe Contreras
  *
  * This package is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/staging/tidspbridge/core/ue_deh.c b/drivers/staging/tidspbridge/core/ue_deh.c
index ae6ee9f..f73604f 100644
--- a/drivers/staging/tidspbridge/core/ue_deh.c
+++ b/drivers/staging/tidspbridge/core/ue_deh.c
@@ -6,6 +6,7 @@
  * Implements upper edge DSP exception handling (DEH) functions.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
+ * Copyright (C) 2010 Felipe Contreras
  *
  * This package is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/staging/tidspbridge/include/dspbridge/dspdeh.h b/drivers/staging/tidspbridge/include/dspbridge/dspdeh.h
index eca56a5..d258ab6 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/dspdeh.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/dspdeh.h
@@ -10,6 +10,7 @@
  *   Function comment headers reside with the function typedefs in dspdefs.h.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
+ * Copyright (C) 2010 Felipe Contreras
  *
  * This package is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.7.1

