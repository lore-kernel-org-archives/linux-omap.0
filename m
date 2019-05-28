From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/13] bus: ti-sysc: Set ENAWAKEUP if available
Date: Mon, 27 May 2019 23:24:09 -0700
Message-ID: <20190528062414.27192-9-tony@atomide.com>
References: <20190528062414.27192-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528062414.27192-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Some modules have ENAWAKEUP bit that we need to configure when not
relying on platform data callbacks.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -881,6 +881,11 @@ static int sysc_enable_module(struct device *dev)
 			dev_err(dev, "%s: invalid sidlemode\n", __func__);
 			return -EINVAL;
 		}
+
+		/* Set WAKEUP */
+		if (regbits->enwkup_shift >= 0 &&
+		    ddata->cfg.sysc_val & BIT(regbits->enwkup_shift))
+			reg |= BIT(regbits->enwkup_shift);
 	}
 
 	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
-- 
2.21.0
