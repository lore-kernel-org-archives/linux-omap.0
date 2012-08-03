From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: omap_device: query on "fck" clk alias created
Date: Fri, 3 Aug 2012 06:26:24 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA7F0F2@DBDE01.ent.ti.com>
References: <50191F00.1040501@ti.com>
 <20120801141414.GM7405@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A83EA7DF5C@DBDE01.ent.ti.com>
 <20120802131250.GO7405@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59469 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab2HCG0k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 02:26:40 -0400
In-Reply-To: <20120802131250.GO7405@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Thu, Aug 02, 2012 at 18:42:50, Russell King - ARM Linux wrote:
> On Thu, Aug 02, 2012 at 01:04:37PM +0000, Hiremath, Vaibhav wrote:
> > On Wed, Aug 01, 2012 at 19:44:14, Russell King - ARM Linux wrote:
> > > On Wed, Aug 01, 2012 at 05:50:16PM +0530, Vaibhav Hiremath wrote:
> > > > The clk_get() api will not work, unless we pass both the arguments (dev,
> > > > con_id) properly. Now expecting driver to always label con_id with "fck"
> > > > is undesirable, as the same driver can be reused on multiple platforms,
> > > > which can be non-omap and/or non-ti platforms.
> > > 
> > > Why not?
> > > 
> > > The connection ID is defined by the driver, and the platform stuff is
> > > expected to provide drivers with what they require.  It's not the other
> > > way around (platforms don't tell drivers what they require.)
> > > 
> > > In other words, if the device has two clocks, one called ick and one called
> > > fck, then the device _should_ use clk_get() specifying "ick" for one, and
> > > "fck" for the other.
> > > 
> > > And platforms better provide an "ick" and a "fck" for the device, even if
> > > they have no respresentation for one or other of them (in which case you
> > > supply a dummy clock.)
> > > 
> > 
> > Russell, I completely agree with you, infact I am on the same page.
> > Let me give you a real example, which I am dealing with now,
> > 
> > On AM335x device we have integrated DCAN, this IP is not from TI.
> > IP is from Bosch and doesn't follow any of the TI IP standards, like 
> > HighLander spec. The IP is just integrated with interconnect bus and given a 
> > required clocksource (in this case its one clock). 
> > 
> > The driver for this IP is generic, (drivers/net/can/c_can/c_can_platform.c) 
> > obviously used across non-ti devices already and driver is implemented with,
> >     clk_get(dev, NULL);
> 
> So, elsewhere it only has one clock.  Are there any other clocks it needs
> on OMAP?
> 
> If the answer is no, then the driver is doing the right thing, and OMAP's
> clk stuff needs to be adjusted to suit the drivers requirements.
> 
> I've said many times over the years that clock connection IDs are defined
> by the device or driver and *nothing* else - they're certainly *not* source
> names.
> 
> That's why, when I modified OMAP drivers to fix them, and they take an
> interface and function clock, they end up asking for "ick" and "fck" not
> "blah_ick" and "blah_fck".
> 

I am in agreement with you and I believe I came to the solution for this 
issue, I used "of_dev_auxdata" to manipulate dev_id and updated clock-tree 
table with required clock entry and it works, I tried it on BeagleBone 
platform.

Can you please review it?




diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 6f93a20..893cc0c 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -37,11 +37,24 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
        { }
 };

+/*
+ * Lookup table for attaching a specific name and platform_data        pointer to
+ * devices as they get created by of_platform_populate().  Ideally this table
+ * would not exist, but the current clock implementation depends on some devices
+ * having a specific name.
+ */
+static const struct of_dev_auxdata omap_auxdata_lookup[] __initconst = {
+       OF_DEV_AUXDATA("bosch,d_can", 0x481cc000, "d_can.0", NULL),
+       OF_DEV_AUXDATA("bosch,d_can", 0x481d0000, "d_can.1", NULL),
+       { },
+};
+
+
 static void __init omap_generic_init(void)
 {
        omap_sdrc_init(NULL, NULL);

-       of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
+       of_platform_populate(NULL, omap_dt_match_table, omap_auxdata_lookup, NULL);
}

 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index ae27de8..f061834 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -1028,6 +1028,8 @@ static struct omap_clk am33xx_clks[] = {
        CLK(NULL,       "clkdiv32k_ick",        &clkdiv32k_ick, CK_AM33XX),
        CLK(NULL,       "dcan0_fck",            &dcan0_fck,     CK_AM33XX),
        CLK(NULL,       "dcan1_fck",            &dcan1_fck,     CK_AM33XX),
+       CLK("d_can.0",  NULL,           &dcan0_fck,     CK_AM33XX),
+       CLK("d_can.1",  NULL,           &dcan1_fck,     CK_AM33XX),
        CLK(NULL,       "debugss_ick",          &debugss_ick,   CK_AM33XX),
        CLK(NULL,       "pruss_ocp_gclk",       &pruss_ocp_gclk,        CK_AM33XX),
        CLK("davinci-mcasp.0",  NULL,           &mcasp0_fck,    CK_AM33XX),


