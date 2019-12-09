From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 02/13] linux/kernel.h: Add PTR_ALIGN_DOWN macro
Date: Mon, 9 Dec 2019 14:51:36 +0530
Message-ID: <20191209092147.22901-3-kishon@ti.com>
References: <20191209092147.22901-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191209092147.22901-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Murray <andrew.murray@arm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Add a macro for aligning down a pointer. This is useful to get an
aligned register address when a device allows only word access and
doesn't allow half word or byte access.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3adcb39fa6f5..888ad70a80aa 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -34,6 +34,7 @@
 #define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
 #define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
 #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
+#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
 #define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
 
 /* generic data direction definitions */
-- 
2.17.1
