From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 1/4] ARM: OMAP3: Add SMSC911X support to Overo platform
	(V2)
Date: Sun, 15 Mar 2009 09:36:25 -0700
Message-ID: <5e088bd90903150936w45e68b63k1252cea38b48a5fc@mail.gmail.com>
References: <20090313224259.8810.3283.stgit@localhost>
	 <20090313224453.8810.41743.stgit@localhost>
	 <20090315153827.GA10541@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:25461 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbZCOQg1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 12:36:27 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1451142wfa.4
        for <linux-omap@vger.kernel.org>; Sun, 15 Mar 2009 09:36:25 -0700 (PDT)
In-Reply-To: <20090315153827.GA10541@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Sun, Mar 15, 2009 at 8:38 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Mar 13, 2009 at 03:44:53PM -0700, Tony Lindgren wrote:
>> Gumstix will soon be shipping a variant of their Summit board that
>> includes an SMSC LAN9221 ethernet interface. =A0This patch provides
>> support via the smsc911x driver when enabled in kernel config.
>
> Does this actually work with the smsc911x driver which is in mainline=
,
> or is it dependent on the smsc911x patches from Steve Glendinning?

=46or the shipping Overo kernel, I build with 2 of Steve's patches, cop=
ied below.

Steve

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

=46rom: Steve Glendinning <steve.glendinning@smsc.com>

This patch adds support for the platform_device's resources to indicate
additional flags to use when registering the irq, for example
IORESOURCE_IRQ_LOWLEVEL (which corresponds to IRQF_TRIGGER_LOW).  These
should be set in the irq resource flags field.

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 drivers/net/smsc911x.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/smsc911x.c b/drivers/net/smsc911x.c
index f513bdf..3565df1 100644
--- a/drivers/net/smsc911x.c
+++ b/drivers/net/smsc911x.c
@@ -1892,9 +1892,9 @@ static int __devinit smsc911x_drv_probe(struct
platform_device *pdev)
 	struct net_device *dev;
 	struct smsc911x_data *pdata;
 	struct smsc911x_platform_config *config =3D pdev->dev.platform_data;
-	struct resource *res;
+	struct resource *res, *irq_res;
 	unsigned int intcfg =3D 0;
-	int res_size;
+	int res_size, irq_flags;
 	int retval;
 	DECLARE_MAC_BUF(mac);

@@ -1919,6 +1919,14 @@ static int __devinit smsc911x_drv_probe(struct
platform_device *pdev)
 	}
 	res_size =3D res->end - res->start;

+	irq_res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!irq_res) {
+		pr_warning("%s: Could not allocate irq resource.\n",
+			SMSC_CHIPNAME);
+		retval =3D -ENODEV;
+		goto out_0;
+	}
+
 	if (!request_mem_region(res->start, res_size, SMSC_CHIPNAME)) {
 		retval =3D -EBUSY;
 		goto out_0;
@@ -1935,7 +1943,8 @@ static int __devinit smsc911x_drv_probe(struct
platform_device *pdev)

 	pdata =3D netdev_priv(dev);

-	dev->irq =3D platform_get_irq(pdev, 0);
+	dev->irq =3D irq_res->start;
+	irq_flags =3D irq_res->flags & IRQF_TRIGGER_MASK;
 	pdata->ioaddr =3D ioremap_nocache(res->start, res_size);

 	/* copy config parameters across to pdata */
@@ -1968,8 +1977,8 @@ static int __devinit smsc911x_drv_probe(struct
platform_device *pdev)
 	smsc911x_reg_write(pdata, INT_EN, 0);
 	smsc911x_reg_write(pdata, INT_STS, 0xFFFFFFFF);

-	retval =3D request_irq(dev->irq, smsc911x_irqhandler, IRQF_DISABLED,
-			     dev->name, dev);
+	retval =3D request_irq(dev->irq, smsc911x_irqhandler,
+			     irq_flags | IRQF_DISABLED, dev->name, dev);
 	if (retval) {
 		SMSC_WARNING(PROBE,
 			"Unable to claim requested irq: %d", dev->irq);

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

=46rom: Steve Glendinning <steve.glendinning@smsc.com>

The isr supports shared operation, so register it with the IRQF_SHARED
flag to indicate this.

This patch also removes the IRQF_DISABLED flag.  This driver doesn't
need it, and IRQF_DISABLED isn't guaranteed when using shared interrupt=
s.

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 drivers/net/smsc911x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/smsc911x.c b/drivers/net/smsc911x.c
index 3565df1..f882fd5 100644
--- a/drivers/net/smsc911x.c
+++ b/drivers/net/smsc911x.c
@@ -1978,7 +1978,7 @@ static int __devinit smsc911x_drv_probe(struct
platform_device *pdev)
 	smsc911x_reg_write(pdata, INT_STS, 0xFFFFFFFF);

 	retval =3D request_irq(dev->irq, smsc911x_irqhandler,
-			     irq_flags | IRQF_DISABLED, dev->name, dev);
+			     irq_flags | IRQF_SHARED, dev->name, dev);
 	if (retval) {
 		SMSC_WARNING(PROBE,
 			"Unable to claim requested irq: %d", dev->irq);
--=20
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe netdev" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
