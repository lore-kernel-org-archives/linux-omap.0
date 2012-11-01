From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: [RFC-v2 7/7] capebus: Documentation; capebus-summary
Date: Thu,  1 Nov 2012 17:32:32 +0200
Message-ID: <1351783952-11804-8-git-send-email-panto@antoniou-consulting.com>
References: <1351783952-11804-1-git-send-email-panto@antoniou-consulting.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351783952-11804-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Small summary of capebus.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 Documentation/capebus/capebus-summary | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/capebus/capebus-summary

diff --git a/Documentation/capebus/capebus-summary b/Documentation/capebus/capebus-summary
new file mode 100644
index 0000000..742e33c
--- /dev/null
+++ b/Documentation/capebus/capebus-summary
@@ -0,0 +1,40 @@
+Overview of Linux kernel Capebus support
+========================================
+
+30-Oct-2012
+
+What is Capebus?
+----------------
+Capebus is an abstract concept. There's no such thing as a vanilla physical
+capebus, what is there is a concept and a method on how various capebus
+based implementations can be made.
+
+Capebus is created to address the problem of many SoCs that can provide a
+multitude of hardware interfaces but in order to keep costs down the main
+boards only support a limited number of them. The rest are typically brought
+out to pin connectors on to which other boards, named capes are connected and
+allow those peripherals to be used.
+
+These capes connect to the SoC interfaces but might also contain various other
+parts that may need some kind of driver to work.
+
+Since SoCs have limited pins and pin muxing options, not all capes can work
+together so some kind of resource tracking (at least for the pins in use) is
+required.
+
+Before capebus all of this took place in the board support file, and frankly
+for boards with too many capes it was becoming unmanageable.
+
+Capebus provides a virtual bus, which along with a board specific controller,
+cape drivers can be written using the standard Linux device model.
+
+What kind of systems/boards capebus supports?
+---------------------------------------------
+
+The core capebus infrastructure is not depended on any specific board.
+However capebus needs a board controller to provide services to the cape devices
+it controls. Services like addressing and resource reservation are provided
+by the board controller.
+
+Capebus at the moment only support TI's Beaglebone platform.
+
-- 
1.7.12
