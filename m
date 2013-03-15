From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 19/50] staging: omap-thermal: IRQ handler section
Date: Fri, 15 Mar 2013 09:00:07 -0400
Message-ID: <1363352438-15935-20-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Section of IRQ handlers

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 7927c59..ded2c8c 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -150,6 +150,8 @@ static u32 omap_bandgap_read_temp(struct omap_bandgap *bg_ptr, int id)
 	return temp;
 }
 
+/***   IRQ handlers   ***/
+
 /**
  * omap_bandgap_talert_irq_handler() - handles Temperature alert IRQs
  * @irq: IRQ number
-- 
1.7.7.1.488.ge8e1c
