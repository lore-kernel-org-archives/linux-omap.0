From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Sat, 24 Mar 2018 07:25:17 -0700
Message-ID: <20180324142517.GA94954@atomide.com>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180322135553.GA27648@amd>
 <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dcbw@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Dan Williams <dcbw@redhat.com> [180324 14:00]:
> On Fri, 2018-03-23 at 21:13 +0100, Pavel Machek wrote:
> > Does ofonod work for you? I could not get that one to work...
> 
> Because it's looking for a Gobi modem but the MDM6600 isn't one and
> doesn't expose that layout (and doesn't really need to anyway).  I
> don't think ofono has a generic QMI driver, so you'd either need to for
> ce it to use the telitqmi or quectelqmi drivers, or write your own
> generic QMI one.

We also get five USB uarts if we add the device id with something
like the patch below. I don't quite get why we get five UARTS?

Also not sure if we should be using drivers/usb/serial/qcaux.c
instead of qcserial.c?

And from what I recall trying it out, adding the USB UARTs
somehow confused ModemManager I think, that needs to be retested
though :)

And the USB UARTs added do not offer the same set of AT commands
as the n_gsm serial mux.

Regards,

Tony

8< ------------------
diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -181,6 +181,9 @@ static const struct usb_device_id id_table[] = {
 	/* Huawei devices */
 	{DEVICE_HWI(0x03f0, 0x581d)},	/* HP lt4112 LTE/HSPA+ Gobi 4G Modem (Huawei me906e) */
 
+	/* Motorola devices */
+	{DEVICE_HWI(0x22b8, 0x2a70)},	/* Droid 4 mdm6600 */
+
 	{ }				/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.16.2
