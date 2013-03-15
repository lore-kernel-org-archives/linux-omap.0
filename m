From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 23/50] staging: omap-thermal: add documentation for omap_bandgap_adc_to_mcelsius
Date: Fri, 15 Mar 2013 09:00:11 -0400
Message-ID: <1363352438-15935-24-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Document the conversion function.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 0068c66..8279cca 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -233,6 +233,17 @@ static irqreturn_t omap_bandgap_tshut_irq_handler(int irq, void *data)
 
 /***   Helper functions which manipulate conversion ADC <-> mi Celsius   ***/
 
+/**
+ * omap_bandgap_adc_to_mcelsius() - converts an ADC value to mCelsius scale
+ * @bg_ptr: struct omap_bandgap pointer
+ * @id: sensor id
+ * @adc_val: value in ADC representation
+ * @t: address where to write the resulting temperature in mCelsius
+ *
+ * Simple conversion from ADC representation to mCelsius. In case the ADC value
+ * is out of the ADC conv table range, it returns -ERANGE, 0 on success.
+ * The conversion table is indexed by the ADC values.
+ */
 static
 int omap_bandgap_adc_to_mcelsius(struct omap_bandgap *bg_ptr, int id,
 				 int adc_val, int *t)
-- 
1.7.7.1.488.ge8e1c

