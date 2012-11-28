From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Wed, 28 Nov 2012 09:16:01 +0800
Message-ID: <CACVXFVPjkmyU3NHetJnMHaRbxhD+sNzc=N26+fdZuyoyg31kDA@mail.gmail.com>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com>
	<Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org>
	<CACVXFVM_hPJcNSWp0qCVpexetDBcKgXZRCzR293KAYtK_fpOOg@mail.gmail.com>
	<50B4FE7D.9030505@linaro.org>
	<CACVXFVP8dSvenY-LAdJ02Dr5s1GjD5VFoTXok1A3p-jYoznKMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:39035 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab2K1BQD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Nov 2012 20:16:03 -0500
In-Reply-To: <CACVXFVP8dSvenY-LAdJ02Dr5s1GjD5VFoTXok1A3p-jYoznKMA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, USB list <linux-usb@vger.kernel.org>, rogerq@ti.com

On Wed, Nov 28, 2012 at 7:06 AM, Ming Lei <tom.leiming@gmail.com> wrote:
>>> Also from my intuition, power domain should be involved in the problem,
>>> because these hard-wired and self-powered USB devices should have
>>> its own power domains, and the ehci-omap driver may enable/disable
>>> these power domains before adding the bus.
>>
>>
>> I don't know enough to have an opinion, but the arrangement on Panda is
>> literally a linear regulator is being controlled by a gpio, which fits into
>> struct regulator model.  What else would a power domain for that buy us?
>
> One problem is that you are addressing to, another is that we may extend
> Tianyu's per port power off/on mechanism into non-acpi world.
>
> Considered that our discussion has been extended to general case instead
> of pandaboard only, there might be several bus devices which have different
> power control method, which should be the idea of power domain.
>
> I have a draft idea and let me describe it by a pseudo_patch, see below:

Sorry, looks sending it too quick, the below pseudo_patch may be
more readable about the idea.

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index ac17a7c..c187a11 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -184,6 +184,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	int					irq;
 	int					i;
 	char					supply[7];
+	struct port_power_domain		*ppd;

 	if (usb_disabled())
 		return -ENODEV;
@@ -220,6 +221,17 @@ static int ehci_hcd_omap_probe(struct
platform_device *pdev)
 		goto err_io;
 	}

+	/*
+	 * register usb per port power domain and enable power on
+	 * this port, to which only hardwired and self-powered device
+	 * attached. And the platform code should provide the
+	 * port power domain list to the usb host controller driver.
+	 */
+	list_for_each_entry(ppd, &pdata->port_power_domain, list) {
+		usb_register_port_pm_domain(&hcd->self, ppd);
+		usb_enable_port_pm_domain(&hcd->self, ppd);
+	}
+
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 	hcd->regs = regs;
@@ -289,6 +301,12 @@ static int ehci_hcd_omap_remove(struct
platform_device *pdev)
 	struct device *dev				= &pdev->dev;
 	struct usb_hcd *hcd				= dev_get_drvdata(dev);
 	struct ehci_hcd_omap_platform_data *pdata	= dev->platform_data;
+	struct port_power_domain			*ppd;
+
+	list_for_each_entry(ppd, &pdata->port_power_domain, list) {
+		usb_disable_port_pm_domain(&hcd->self, ppd);
+		usb_unregister_port_pm_domain(&hcd->self, ppd);
+	}

 	usb_remove_hcd(hcd);
 	disable_put_regulator(dev->platform_data);
diff --git a/include/linux/platform_data/usb-omap.h
b/include/linux/platform_data/usb-omap.h
index 8570bcf..30516c9 100644
--- a/include/linux/platform_data/usb-omap.h
+++ b/include/linux/platform_data/usb-omap.h
@@ -47,6 +47,8 @@ struct ehci_hcd_omap_platform_data {
 	int				reset_gpio_port[OMAP3_HS_USB_PORTS];
 	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
 	unsigned			phy_reset:1;
+
+	struct list_head		port_power_domain;
 };

 struct ohci_hcd_omap_platform_data {
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 608050b..6b86d01 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -448,6 +448,39 @@ extern void usb_disconnect(struct usb_device **);
 extern int usb_get_configuration(struct usb_device *dev);
 extern void usb_destroy_configuration(struct usb_device *dev);

+/*
+ * Only used for describing power domain which provide power to
+ * hardwired self-powered devices
+ */
+struct port_power_domain {
+	struct list_head list;
+	struct usb_bus *bus;
+
+	/*
+	 * physical port path, and the power domain of 'port_power' provides
+	 * power on the device attatched to the last non-zero port(Pn-1) of
+	 * the n-1 tier hub, the first number(P1) is the root hub port in
+	 * the path, and the second number(P2) is the port number on the
+	 * second tier hub, ..., until the last number Pn which is zero always.
+	 */
+	char port_path[32];		/* P1-P2-..Pn-1-Pn */
+
+	/*
+	 * struct power_domain should be generic power thing, and should be
+	 * defined in device power core, maybe it can reuse some kind of
+	 * current power domain structure.
+	 *
+	 * Many ports can share one same power domain, so make the below field
+	 * as pointer.
+	 */
+	struct power_domain *port_power;
+};
+
+extern int usb_register_port_pm_domain(struct usb_bus *bus, struct
port_power_domain *ppd);
+extern int usb_unregister_port_pm_domain(struct usb_bus *bus, struct
port_power_domain *ppd);
+extern int usb_enable_port_pm_domain(struct usb_bus *bus, struct
port_power_domain *ppd);
+extern int usb_disable_port_pm_domain(struct usb_bus *bus, struct
port_power_domain *ppd);
+
 /*-------------------------------------------------------------------------*/

 /*


Thanks,
-- 
Ming Lei
