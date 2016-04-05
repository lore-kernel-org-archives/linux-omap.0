From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 02/20] mfd: Add resource management devm_mfd_{add,remove}_devices
Date: Tue, 5 Apr 2016 17:18:14 +0530
Message-ID: <1459856912-17859-3-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Add devm wrappers for the mfd_add_devices() and mfd_remove_devices()
in the list of managed interfaces.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 Documentation/driver-model/devres.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 73b98df..f752169 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -317,6 +317,10 @@ MEM
   devm_kvasprintf()
   devm_kzalloc()
 
+MFD
+ devm_mfd_add_devices()
+ devm_mfd_remove_devices()
+
 PCI
   pcim_enable_device()	: after success, all PCI ops become managed
   pcim_pin_device()	: keep PCI device enabled after release
-- 
2.1.4
