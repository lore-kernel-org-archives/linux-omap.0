From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 27/50] staging: omap-thermal: add documentation for omap_bandgap_mcelsius_to_adc
Date: Fri, 15 Mar 2013 09:00:15 -0400
Message-ID: <1363352438-15935-28-git-send-email-eduardo.valentin@ti.com>
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
 drivers/staging/omap-thermal/omap-bandgap.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 963fcaf..39bfe8d 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -262,6 +262,16 @@ exit:
 	return ret;
 }
 
+/**
+ * omap_bandgap_mcelsius_to_adc() - converts a mCelsius value to ADC scale
+ * @bg_ptr: struct omap_bandgap pointer
+ * @temp: value in mCelsius
+ * @adc: address where to write the resulting temperature in ADC representation
+ *
+ * Simple conversion from mCelsius to ADC values. In case the temp value
+ * is out of the ADC conv table range, it returns -ERANGE, 0 on success.
+ * The conversion table is indexed by the ADC values.
+ */
 static
 int omap_bandgap_mcelsius_to_adc(struct omap_bandgap *bg_ptr, long temp,
 				 int *adc)
-- 
1.7.7.1.488.ge8e1c

