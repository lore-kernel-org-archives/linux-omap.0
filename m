From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/12] bus: ti-sysc: Support 16-bit writes too
Date: Tue, 28 May 2019 05:27:22 -0700
Message-ID: <20190528122722.GO5447@atomide.com>
References: <20190527121348.45251-1-tony@atomide.com>
 <20190527121348.45251-2-tony@atomide.com>
 <5e9a31dfdfd843469c51106fce9ea353@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5e9a31dfdfd843469c51106fce9ea353@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* David Laight <David.Laight@ACULAB.COM> [190528 11:06]:
> From: Tony Lindgren
> > Sent: 27 May 2019 13:14
> > We need to also support 16-bit writes for i2c in addition to the reads
> > when we start configuring the sysconfig register for reset and idle modes.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/bus/ti-sysc.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> > --- a/drivers/bus/ti-sysc.c
> > +++ b/drivers/bus/ti-sysc.c
> > @@ -100,6 +100,13 @@ static void sysc_parse_dts_quirks(struct sysc *ddata, struct device_node *np,
> > 
> >  static void sysc_write(struct sysc *ddata, int offset, u32 value)
> >  {
> > +	if (ddata->cfg.quirks & SYSC_QUIRK_16BIT) {
> > +		writew_relaxed(value & 0xffff, ddata->module_va + offset);
> > +		writew_relaxed(value >> 16, ddata->module_va + offset + 4);
> 
> Should that be + 2 ???

Well the stride for I2C revision registers is 4. But while checking
that again, I noticed that the other registers do not have HI and LO
registers and should just use a single 16-bit read and write. So far
it's harmless, but should be fixed.

Updated patch below.

Regards,

Tony

8< ----------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 27 May 2019 04:51:53 -0700
Subject: [PATCH] bus: ti-sysc: Support 16-bit writes too

We need to also support 16-bit writes for i2c in addition to the reads
when we start configuring the sysconfig register for reset and idle modes.

Note that only i2c revision register has LO and HI registers, so let's
add a check also for 16-bit register read. This change is currently cosmetic
and does not affect anything until we enable the module specific quirk
handling for i2c reset and enable later on.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -100,6 +100,20 @@ static void sysc_parse_dts_quirks(struct sysc *ddata, struct device_node *np,
 
 static void sysc_write(struct sysc *ddata, int offset, u32 value)
 {
+	if (ddata->cfg.quirks & SYSC_QUIRK_16BIT) {
+		writew_relaxed(value & 0xffff, ddata->module_va + offset);
+
+		/* Only i2c revision has LO and HI register with stride of 4 */
+		if (ddata->offsets[SYSC_REVISION] >= 0 &&
+		    offset == ddata->offsets[SYSC_REVISION]) {
+			u16 hi = value >> 16;
+
+			writew_relaxed(hi, ddata->module_va + offset + 4);
+		}
+
+		return;
+	}
+
 	writel_relaxed(value, ddata->module_va + offset);
 }
 
@@ -109,7 +123,14 @@ static u32 sysc_read(struct sysc *ddata, int offset)
 		u32 val;
 
 		val = readw_relaxed(ddata->module_va + offset);
-		val |= (readw_relaxed(ddata->module_va + offset + 4) << 16);
+
+		/* Only i2c revision has LO and HI register with stride of 4 */
+		if (ddata->offsets[SYSC_REVISION] >= 0 &&
+		    offset == ddata->offsets[SYSC_REVISION]) {
+			u16 tmp = readw_relaxed(ddata->module_va + offset + 4);
+
+			val |= tmp << 16;
+		}
 
 		return val;
 	}
-- 
2.21.0
