From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/5] dt-bindings: ti-sysc: Add SPDX license identifier
Date: Tue, 25 Jun 2019 18:33:12 -0500
Message-ID: <20190625233315.22301-3-s-anna@ti.com>
References: <20190625233315.22301-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625233315.22301-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Add the appropriate SPDX license identifier to the common
TI sysc bindings header file.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 include/dt-bindings/bus/ti-sysc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/bus/ti-sysc.h b/include/dt-bindings/bus/ti-sysc.h
index 7138384e2ef9..babd08a1d226 100644
--- a/include/dt-bindings/bus/ti-sysc.h
+++ b/include/dt-bindings/bus/ti-sysc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* TI sysc interconnect target module defines */
 
 /* Generic sysc found on omap2 and later, also known as type1 */
-- 
2.21.0
