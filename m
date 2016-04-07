From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 02/20] mfd: Add devm_mfd_add_devices() in list of managed interfaces
Date: Fri, 8 Apr 2016 00:12:56 +0530
Message-ID: <1460054594-32325-3-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Add devm wrappers for the mfd_add_devices() in the list of managed
interfaces.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
Changes from V1:
- Reformat the commit message.
- Remove devm_ for mfd_remove_devices() as this is not used.

 Documentation/driver-model/devres.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 73b98df..7f8c416 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -317,6 +317,9 @@ MEM
   devm_kvasprintf()
   devm_kzalloc()
 
+MFD
+ devm_mfd_add_devices()
+
 PCI
   pcim_enable_device()	: after success, all PCI ops become managed
   pcim_pin_device()	: keep PCI device enabled after release
-- 
2.1.4
