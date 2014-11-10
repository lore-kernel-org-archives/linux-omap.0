From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv3 4/4] [media] si4713: cleanup platform data
Date: Mon, 10 Nov 2014 21:34:44 +0100
Message-ID: <1415651684-3894-5-git-send-email-sre@kernel.org>
References: <1415651684-3894-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415651684-3894-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hans.verkuil@cisco.com>, linux-media@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Remove unreferenced members from the platform
data's structure.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 include/media/si4713.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/media/si4713.h b/include/media/si4713.h
index 343b8fb5..be4f58e 100644
--- a/include/media/si4713.h
+++ b/include/media/si4713.h
@@ -23,9 +23,6 @@
  * Platform dependent definition
  */
 struct si4713_platform_data {
-	const char * const *supply_names;
-	unsigned supplies;
-	int gpio_reset; /* < 0 if not used */
 	bool is_platform_device;
 };
 
-- 
2.1.1
