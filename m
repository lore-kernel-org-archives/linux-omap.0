From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Sat, 07 Dec 2013 04:48:18 +0100
Message-ID: <52A29A82.106@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:44227 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986Ab3LGDtY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 22:49:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

Hi Tomi,

On Wed, Dec 4, 2013 at 1:28 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
> Here's a new version for DT support to OMAP Display Subsystem. See
> http://article.gmane.org/gmane.linux.ports.arm.omap/102689 for the intro of the
> previous version, which contains thoughts about the related problems.
>
> The major change in this version is the use of V4L2 and CDF style port/endpoint
> style in the DT data. However, note that even if the DT data contains proper
> port & endpoint data, the drivers only use the first endpoint. This is to
> simplify the patches, as adding full support for the ports and endpoints to the
> drivers will be a big task. This approach still works with more or less all the
> boards, as the only cases where the simpler model is an issue are the boards
> with multiple display devices connected to a single output.
>
> Laurent, I'd appreciate if you could have a look at the .dts changes, to see if
> there's anything that's clearly not CDF compatible.
>
> The patches can also be found from:
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt
>

I tested your branch on my DM3730 IGEPv2 board by cherry-picking the following
commits from latest Linus tree on top of your work/dss-dt branch:

d526daeb ("ARM: dts: omap3-igep0020: Add pinmux setup for i2c devices")
50592dc3 ("ARM: dts: omap3-igep0020: Add pinmuxing for DVI output")

And adding the display information using your DSS bindings to omap3-igep0020.dts
[0].

But it failed for me because of a probing order. The problem is that the probing
order is:

omap_i2c
pinctrl-single
OMAP DSS
connector-dvi
omapfb

Now DT good practices says that the pinmux setup needed for a device have to be
initialized in a pin control state for the device using these pins (i.e: i2c3)
instead of doing globally by being part of a pinctrl state of the pinmux device
(i.e: omap3_pmx_core).

But due this init order the omap_i2c probe is deferred due pinctrl-single not
being initialized yet:

[    0.565246] omap_i2c 48060000.i2c: could not find pctldev for node /ocp/pinmu


x@48002030/pinmux_i2c3_pins, deferring probe

This is ok since eventually the pinctrl-single driver will be initialized and
the next time the omap_i2c probe is called it will succeed. But before omap_i2c
has a chance to be probed again the connector-dvi driver is probed and fails due
the i2c bus not being initialized yet:

[    1.064300] OMAP DSS rev 2.0
[    1.073669] connector-dvi connector.12: failed to parse i2c-bus
[    1.073730] connector-dvi: probe of connector.12 failed with error -22
[    1.078216] omapfb omapfb: no displays
[    1.080871] omapfb omapfb: failed to setup omapfb
[    1.080932] platform omapfb: Driver omapfb requests probe deferral
..

Later the omap_i2c driver probe succees since the pinctrl-single driver was
initialized but by then it is already too late:

[    3.293914] omap_i2c 48070000.i2c: bus 0 rev4.4 at 2600 kHz
[    3.301940] omap_i2c 48072000.i2c: bus 1 rev4.4 at 400 kHz
[    3.310882] omap_i2c 48060000.i2c: bus 2 rev4.4 at 100 kHz
[    3.317565] omapfb omapfb: no displays
[    3.321716] omapfb omapfb: failed to setup omapfb
[    3.326751] platform omapfb: Driver omapfb requests probe deferral
..
[    3.694915] omapfb omapfb: no displays
[    3.699127] omapfb omapfb: failed to setup omapfb
[    3.704071] platform omapfb: Driver omapfb requests probe deferral
..

If I move the i2c3 pinmux definitions from the i2c3 device node to
omap3_pmx_core then the display works correctly.

So, I think that we should add deferred probing to drivers/video/omap2/*.c too
to avoid the scenario I described above.

Also, would you mind to include [0] on your patch-set so display continue
working for IGEPv2 after you remove the pdata-quirks and dss-common.c hacks?

Thanks a lot and best regards,
Javier

[0]:
>From a9af54a3b63bccade241e056d153d8bf04a6a5d5 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Fri, 6 Dec 2013 02:53:38 +0100
Subject: [PATCH 1/1] ARM: dts: omap3-igep0020: add display information

The IGEPv2 has a TFP410 DPI-to-DVI encoder attached
to OMAP's Display SubSystem (DSS). Add DeviceTree
nodes for these devices.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep0020.dts | 51 ++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts
b/arch/arm/boot/dts/omap3-igep0020.dts
index 76509de..2569d60 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -215,3 +215,54 @@
 &usbhsehci {
 	phys = <&hsusb1_phy>;
 };
+
+&dpi {
+	vdds_dsi-supply = <&vpll2>;
+
+	dpi_out: endpoint {
+		remote-endpoint = <&tfp410_in>;
+		data-lines = <24>;
+	};
+};
+
+
+/ {
+	aliases {
+		display0 = &dvi0;
+	};
+
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+		gpios = <&gpio6 10 GPIO_ACTIVE_HIGH>; /* 170, power-down */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tfp410_in: endpoint@0 {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tfp410_out: endpoint@1 {
+					remote-endpoint = <&dvi_connector_in>;
+				};
+			};
+		};
+	};
+
+	dvi0: connector@0 {
+		compatible = "ti,dvi-connector";
+		i2c-bus = <&i2c3>;
+
+		dvi_connector_in: endpoint {
+			remote-endpoint = <&tfp410_out>;
+		};
+	};
+};
-- 
1.8.4.2
