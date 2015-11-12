From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/2] arm: beaglex15: fix USB Gadget
Date: Thu, 12 Nov 2015 11:52:59 -0600
Message-ID: <1447350781-20649-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

with the following patches I can get USB Gadget working
with my beagle x15 with today's Linus' tree.

regards

Felipe Balbi (2):
  arm: boot: dts: beaglex15: Remove ID GPIO
  arm: boot: beaglex15: pass correct interrupt

 arch/arm/boot/dts/am57xx-beagle-x15.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.6.2
