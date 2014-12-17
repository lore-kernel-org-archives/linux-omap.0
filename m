From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP 4430 SDP: rather sick with recent kernels
Date: Wed, 17 Dec 2014 09:52:52 +0000
Message-ID: <20141217095252.GH11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:35554 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751274AbaLQJw7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Dec 2014 04:52:59 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

As the IOMMU stuff was merged last night, which removed a really quite
horrid conflict resolution, I updated my nightly build tree from its
previous state last Thursday.

Now, SDP4430 seems to be really quite broken.

ti_dt_clocks_register: failed to lookup clock node dss_fck
ti_dt_clocks_register: failed to lookup clock node dss_fck
ti_dt_clocks_register: failed to lookup clock node div_ts_ck
ti_dt_clocks_register: failed to lookup clock node bandgap_ts_fclk
...
omap_hwmod: l3_main_3 using broken dt data from ocp
omap_hwmod: l3_main_2 using broken dt data from ocp
...
irq: no irq domain found for /ocp/pinmux@4a100040 !
irq: no irq domain found for /ocp/pinmux@4a100040 !
irq: no irq domain found for /ocp/pinmux@4a100040 !
platform 4b501000.aes: Cannot lookup hwmod 'aes'
platform 480a5000.des: Cannot lookup hwmod 'des'
...
twl: not initialized
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1410000 Vs max 1316660
omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu
omap2_set_init_voltage: unable to set vdd_mpu
omap2_set_init_voltage: unable to find boot up OPP for vdd_core
omap2_set_init_voltage: unable to set vdd_core
omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
omap2_set_init_voltage: unable to set vdd_iva
...

>From there, the system crash'n'burns badly due to an ASoC DAPM oops.

The "combined" kernel boot follows a similar pattern, but yets a bit
further before oopsing, with ASoC DAPM code printing random bits of
kernel memory.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
