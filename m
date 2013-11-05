From: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V3 5/7] ARM: DTS: DRA7: Add routable-irqs property for gic node
Date: Tue, 5 Nov 2013 18:44:15 +0530
Message-ID: <1383657257-3458-6-git-send-email-r.sricharan@ti.com>
References: <1383657257-3458-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1383657257-3458-1-git-send-email-r.sricharan-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, r.sricharan-l0cyMroinI0@public.gmane.org
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

There is a IRQ crossbar device in the soc, which maps the
irq requests from the peripherals to the mpu interrupt
controller's inputs. The gic provides the support for such
IPs in the form of routable-irqs. So adding the property
here to gic node.

Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8b93b7a..fd58a09 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -67,6 +67,7 @@
 		compatible = "arm,cortex-a15-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
+		arm,routable-irqs = <160>;
 		reg = <0x48211000 0x1000>,
 		      <0x48212000 0x1000>,
 		      <0x48214000 0x2000>,
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
