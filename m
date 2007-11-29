From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 1/1] ARM: OMAP: Fix Siemens SX1 building failure
Date: Thu, 29 Nov 2007 11:14:06 -0400
Message-ID: <474ED73E.70104@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

This patch redefines CN_IDX_SX1SND and CN_VAL_SX1SND macros at include/linux/connector.h.
It is based on Komal Shah' earlier patch.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 include/linux/connector.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/connector.h b/include/linux/connector.h
index 13fc454..29ddd3f 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -36,6 +36,8 @@
 #define CN_VAL_CIFS                     0x1
 #define CN_W1_IDX			0x3	/* w1 communication */
 #define CN_W1_VAL			0x1
+#define CN_IDX_SX1SND			0x4
+#define CN_VAL_SX1SND			0x1
 #define CN_IDX_V86D			0x4
 #define CN_VAL_V86D_UVESAFB		0x1
 
-- 1.5.3.GIT
