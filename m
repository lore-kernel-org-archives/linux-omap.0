From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/4] ARM: dts: am335x/am43xx: wkup_m3_ipc support patches
Date: Fri, 17 Jul 2015 16:08:00 -0500
Message-ID: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Suman Anna <s-anna@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds the necessary dt nodes for the wkup_m3_ipc on am335x
and am437x and also adds the ti,mbox-send-noirq flag to the wkup_m3
mailbox on both platforms as well so that we can use mailbox from
noirq context when needed. This series is to make use of the
driver introduced here [1].

Regards,
Dave

[1] http://www.spinics.net/lists/arm-kernel/msg432612.html

Dave Gerlach (1):
  ARM: dts: AM33xx: Add ti,mbox-send-noirq to wkup_m3 mailbox

Keerthy (1):
  ARM: dts: AM4372: Add ti,mbox-send-noirq to wkup_m3 mailbox

Suman Anna (2):
  ARM: dts: AM33xx: Add the wkup_m3_ipc node
  ARM: dts: AM4372: Add the wkup_m3_ipc node

 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
 arch/arm/boot/dts/am4372.dtsi | 9 +++++++++
 2 files changed, 18 insertions(+)

-- 
2.4.5
