From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 02/17] remoteproc/omap: Switch to SPDX license identifiers
Date: Mon, 28 Oct 2019 14:42:23 +0200
Message-ID: <20191028124238.19224-3-t-kristo@ti.com>
References: <20191028124238.19224-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191028124238.19224-1-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Use the appropriate SPDX license identifiers in various OMAP remoteproc
source files and drop the previous boilerplate license text.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/remoteproc/omap_remoteproc.h | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.h b/drivers/remoteproc/omap_remoteproc.h
index f6d2036d383d..1e6fef753c4f 100644
--- a/drivers/remoteproc/omap_remoteproc.h
+++ b/drivers/remoteproc/omap_remoteproc.h
@@ -1,35 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * Remote processor messaging
  *
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2011 Google, Inc.
  * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * * Redistributions of source code must retain the above copyright
- *   notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- *   notice, this list of conditions and the following disclaimer in
- *   the documentation and/or other materials provided with the
- *   distribution.
- * * Neither the name Texas Instruments nor the names of its
- *   contributors may be used to endorse or promote products derived
- *   from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #ifndef _OMAP_RPMSG_H
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
