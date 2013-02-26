From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 12/15] staging: omap-thermal: add DT example for OMAP54xx
 devices
Date: Tue, 26 Feb 2013 18:53:35 -0400
Message-ID: <1361919218-9788-13-git-send-email-eduardo.valentin@ti.com>
References: <1361919218-9788-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1361919218-9788-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Update documentation with DT example for OMAP54xx devices.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap_bandgap.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap_bandgap.txt b/drivers/staging/omap-thermal/omap_bandgap.txt
index e30dc1c..a4a33d1 100644
--- a/drivers/staging/omap-thermal/omap_bandgap.txt
+++ b/drivers/staging/omap-thermal/omap_bandgap.txt
@@ -49,3 +49,12 @@ bandgap {
 	interrupts = <0 126 4>; /* talert */
 	ti,tshut-gpio = <86>;
 };
+
+OMAP5430:
+bandgap {
+	reg = <0x4a0021e0 0xc
+		0x4a00232c 0xc
+		0x4a002380 0x2c
+		0x4a0023C0 0x3c>;
+	compatible = "ti,omap5430-bandgap";
+};
-- 
1.7.7.1.488.ge8e1c
