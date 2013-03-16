From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 1/8] memory: emif: Fix the lpmode timeout calculation
Date: Sat, 16 Mar 2013 11:46:41 +0530
Message-ID: <1363414608-7448-2-git-send-email-lokeshvutla@ti.com>
References: <1363414608-7448-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363414608-7448-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org

The driver tries to round up the specified timeout cycles to
the next power of 2 value. This should be done defore updating
timeout variable.
Correcting this here.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Changes since V1: 
	Updated Changelog and $subject
	Added a comment describing timeout calculation.

 drivers/memory/emif.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index df08736..508763c 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -728,13 +728,17 @@ static u32 get_pwr_mgmt_ctrl(u32 freq, struct emif_data *emif, u32 ip_rev)
 	/* Timeout based on DDR frequency */
 	timeout = freq >= freq_threshold ? timeout_perf : timeout_pwr;
 
-	/* The value to be set in register is "log2(timeout) - 3" */
+	/*
+	 * The value to be set in register is "log2(timeout) - 3"
+	 * if timeout < 16 load 0 in register
+	 * if timeout is not a power of 2, round to next highest power of 2
+	 */
 	if (timeout < 16) {
 		timeout = 0;
 	} else {
-		timeout = __fls(timeout) - 3;
 		if (timeout & (timeout - 1))
-			timeout++;
+			timeout <<= 1;
+		timeout = __fls(timeout) - 3;
 	}
 
 	switch (lpmode) {
-- 
1.7.9.5
