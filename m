From: Neeraj Dantu <dantuguf14105@gmail.com>
Subject: [PATCH v2] Fix file permission for am335x-osd3358-sm-red.dts
Date: Tue, 28 Aug 2018 16:37:58 +0000
Message-ID: <20180828163758.1305-1-neeraj.dantu@octavosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, Neeraj Dantu <neeraj.dantu@octavosystems.com>
List-Id: linux-omap@vger.kernel.org

Fix wrong mode for dts file added by 
commit bb3e3fbbac862fa72951283e3632e1cf21a68223
("ARM: dts: Add DT support for Octavo Systems OSD3358-SM-RED
based on TI AM335x").

Signed-off-by: Neeraj Dantu <neeraj.dantu@octavosystems.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Robert Nelson <robertcnelson@gmail.com>
CC: Jason Kridner <jkridner@gmail.com>
---
Changes in v2:
- Fix patch description
---
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/arm/boot/dts/am335x-osd3358-sm-red.dts

diff --git a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
old mode 100755
new mode 100644
-- 
2.7.4
