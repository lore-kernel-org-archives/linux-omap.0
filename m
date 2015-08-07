From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 15/22] memory: omap-gpmc: Move device tree binding to correct location
Date: Fri, 7 Aug 2015 12:12:25 +0300
Message-ID: <1438938752-31010-16-git-send-email-rogerq@ti.com>
References: <1438938752-31010-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438938752-31010-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

omap-gpmc.c is a memory controller so move the binding to the
right place.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../bindings/{bus/ti-gpmc.txt => memory-controllers/omap-gpmc.txt}        | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{bus/ti-gpmc.txt => memory-controllers/omap-gpmc.txt} (100%)

diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/bus/ti-gpmc.txt
rename to Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
-- 
2.1.4
