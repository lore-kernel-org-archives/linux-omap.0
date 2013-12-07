From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Sat, 07 Dec 2013 05:28:31 +0100
Message-ID: <52A2A3EF.1030306@collabora.co.uk>
References: <52A29A82.106@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:44240 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab3LGE3h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 23:29:37 -0500
In-Reply-To: <52A29A82.106@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

On 12/07/2013 04:48 AM, Javier Martinez Canillas wrote:
> Hi Tomi,
> 
> On Wed, Dec 4, 2013 at 1:28 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> Hi,
>>
>> Here's a new version for DT support to OMAP Display Subsystem. See
>> http://article.gmane.org/gmane.linux.ports.arm.omap/102689 for the intro of the
>> previous version, which contains thoughts about the related problems.
>>
>> The major change in this version is the use of V4L2 and CDF style port/endpoint
>> style in the DT data. However, note that even if the DT data contains proper
>> port & endpoint data, the drivers only use the first endpoint. This is to
>> simplify the patches, as adding full support for the ports and endpoints to the
>> drivers will be a big task. This approach still works with more or less all the
>> boards, as the only cases where the simpler model is an issue are the boards
>> with multiple display devices connected to a single output.
>>
>> Laurent, I'd appreciate if you could have a look at the .dts changes, to see if
>> there's anything that's clearly not CDF compatible.
>>
>> The patches can also be found from:
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt
>>
> 
> I tested your branch on my DM3730 IGEPv2 board by cherry-picking the following
> commits from latest Linus tree on top of your work/dss-dt branch:
> 
> d526daeb ("ARM: dts: omap3-igep0020: Add pinmux setup for i2c devices")
> 50592dc3 ("ARM: dts: omap3-igep0020: Add pinmuxing for DVI output")
> 
> And adding the display information using your DSS bindings to omap3-igep0020.dts
> [0].
> 
> But it failed for me because of a probing order. The problem is that the probing
> order is:
> 
> omap_i2c
> pinctrl-single
> OMAP DSS
> connector-dvi
> omapfb
> 
> Now DT good practices says that the pinmux setup needed for a device have to be
> initialized in a pin control state for the device using these pins (i.e: i2c3)
> instead of doing globally by being part of a pinctrl state of the pinmux device
> (i.e: omap3_pmx_core).
> 
> But due this init order the omap_i2c probe is deferred due pinctrl-single not
> being initialized yet:
> 
> [    0.565246] omap_i2c 48060000.i2c: could not find pctldev for node /ocp/pinmu
> 
> 
> x@48002030/pinmux_i2c3_pins, deferring probe
> 
> This is ok since eventually the pinctrl-single driver will be initialized and
> the next time the omap_i2c probe is called it will succeed. But before omap_i2c
> has a chance to be probed again the connector-dvi driver is probed and fails due
> the i2c bus not being initialized yet:
> 
> [    1.064300] OMAP DSS rev 2.0
> [    1.073669] connector-dvi connector.12: failed to parse i2c-bus
> [    1.073730] connector-dvi: probe of connector.12 failed with error -22
> [    1.078216] omapfb omapfb: no displays
> [    1.080871] omapfb omapfb: failed to setup omapfb
> [    1.080932] platform omapfb: Driver omapfb requests probe deferral
> ..
> 
> Later the omap_i2c driver probe succees since the pinctrl-single driver was
> initialized but by then it is already too late:
> 
> [    3.293914] omap_i2c 48070000.i2c: bus 0 rev4.4 at 2600 kHz
> [    3.301940] omap_i2c 48072000.i2c: bus 1 rev4.4 at 400 kHz
> [    3.310882] omap_i2c 48060000.i2c: bus 2 rev4.4 at 100 kHz
> [    3.317565] omapfb omapfb: no displays
> [    3.321716] omapfb omapfb: failed to setup omapfb
> [    3.326751] platform omapfb: Driver omapfb requests probe deferral
> ..
> [    3.694915] omapfb omapfb: no displays
> [    3.699127] omapfb omapfb: failed to setup omapfb
> [    3.704071] platform omapfb: Driver omapfb requests probe deferral
> ..
> 
> If I move the i2c3 pinmux definitions from the i2c3 device node to
> omap3_pmx_core then the display works correctly.
> 
> So, I think that we should add deferred probing to drivers/video/omap2/*.c too
> to avoid the scenario I described above.
> 

Actually, I looked at drivers/video/omap2/connector-dvi.c and it does the right
thing for legacy platform data probing but no for DT probing:

static int dvic_probe_pdata(struct platform_device *pdev)
{
..
		adapter = i2c_get_adapter(i2c_bus_num);
		if (!adapter) {
			dev_err(&pdev->dev,
					"Failed to get I2C adapter, bus %d\n",
					i2c_bus_num);
			return -EPROBE_DEFER;
		}
..
}

static int dvic_probe_of(struct platform_device *pdev)
{
..
               adapter = of_find_i2c_adapter_by_node(adapter_node);
                if (adapter == NULL) {
                        dev_err(&pdev->dev, "failed to parse i2c-bus\n");
                        omap_dss_put_device(ddata->in);
                        return -EINVAL;
                }
..
}

The following patch solves the issue if you want to include in your patch-set:

>From c85d46b94c3d27d30218af23a6a8d61e6c7d2ae8 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Sat, 7 Dec 2013 05:18:56 +0100
Subject: [PATCH 1/1] OMAPDSS: connector-dvi: add deferred probing support for
 OF path

When booting with Device Trees the order in which device drivers
are probed is not defined so drivers should be able to defer its
probing if a dependency is not found (such as an i2c bus) instead
of just failing.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/video/omap2/displays-new/connector-dvi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays-new/connector-dvi.c
b/drivers/video/omap2/displays-new/connector-dvi.c
index 8f7e576..f94344a 100644
--- a/drivers/video/omap2/displays-new/connector-dvi.c
+++ b/drivers/video/omap2/displays-new/connector-dvi.c
@@ -299,7 +299,7 @@ static int dvic_probe_of(struct platform_device *pdev)
 		if (adapter == NULL) {
 			dev_err(&pdev->dev, "failed to parse i2c-bus\n");
 			omap_dss_put_device(ddata->in);
-			return -EINVAL;
+			return -EPROBE_DEFER;
 		}

 		ddata->i2c_adapter = adapter;
-- 
1.8.4.2

