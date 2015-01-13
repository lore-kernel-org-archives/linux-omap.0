From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Add support for dm81xx to omap intc, remove unused legacy support
Date: Tue, 13 Jan 2015 14:23:24 -0800
Message-ID: <1421187806-6804-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here's a patch to get the ti81xx interrupt support working properly,
and to remove some unused legacy code.

Regards,

Tony

clone of "xxx-81xx-mainline"

Tony Lindgren (2):
  irqchip: omap-intc: Fix support for dm814 and dm816
  irqchip: omap-intc: Remove unused legacy interface for omap2

 .../interrupt-controller/ti,omap-intc-irq.txt      | 28 ++++++++++++++++++++++
 drivers/irqchip/irq-omap-intc.c                    | 22 ++++-------------
 include/linux/irqchip/irq-omap-intc.h              |  2 --
 3 files changed, 33 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,omap-intc-irq.txt

-- 
2.1.4
