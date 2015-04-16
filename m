From: NeilBrown <neil@brown.name>
Subject: [PATCH 4/6] phy: twl4030-usb: add ABI documentation
Date: Thu, 16 Apr 2015 18:03:04 +1000
Message-ID: <20150416080304.23307.7824.stgit@notabene.brown>
References: <20150416075945.23307.24424.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150416075945.23307.24424.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-omap@vger.kernel.org

From: NeilBrown <neilb@suse.de>

This driver device one local attribute: vbus.
Describe that in Documentation/ABI/testing/sysfs-platform/twl4030-usb.

Signed-off-by: NeilBrown <neil@brown.name>
---
 .../ABI/testing/sysfs-platform-twl4030-usb         |    8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-twl4030-usb

diff --git a/Documentation/ABI/testing/sysfs-platform-twl4030-usb b/Documentation/ABI/testing/sysfs-platform-twl4030-usb
new file mode 100644
index 000000000000..512c51be64ae
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-twl4030-usb
@@ -0,0 +1,8 @@
+What: /sys/bus/platform/devices/*twl4030-usb/vbus
+Description:
+	Read-only status reporting if VBUS (approx 5V)
+	is being supplied by the USB bus.
+
+	Possible values: "on", "off".
+
+	Changes are notified via select/poll.
