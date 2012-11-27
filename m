From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Wed, 28 Nov 2012 07:06:48 +0800
Message-ID: <CACVXFVP8dSvenY-LAdJ02Dr5s1GjD5VFoTXok1A3p-jYoznKMA@mail.gmail.com>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com>
	<Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org>
	<CACVXFVM_hPJcNSWp0qCVpexetDBcKgXZRCzR293KAYtK_fpOOg@mail.gmail.com>
	<50B4FE7D.9030505@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50B4FE7D.9030505-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 28, 2012 at 1:55 AM, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 11/28/2012 01:22 AM, the mail apparently from Ming Lei included:
>
>> On Wed, Nov 28, 2012 at 12:30 AM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
>> wrote:
>>>
>>> On Tue, 27 Nov 2012, Ming Lei wrote:
>>>
>>>> IMO, all matches mean the devices are inside the ehci-omap bus, so
>>>> the direct/simple way is to enable/disable the regulators in the probe()
>>>> and
>>>> remove() of ehci-omap controller driver.
>>>
>>>
>>> When this discussion started, Felipe argued against such an approach.
>>> He pointed out that the same chip could be used in other platforms, and
>>> then the code added to ehci-omap.c would have to be duplicated in
>>> several other places.
>>
>>
>>  From Andy's implementation, the 'general' code is to enable/disable
>> the regulators(patch 3/5), I am wondering if it is general enough, so the
>> 'duplicated' code are just several lines of
>> regulator_enable/regulator_disable,
>> which should be implemented in many platform drivers.
>
>
> Fair enough; my main interest was in the device path side when writing the
> patches.  I stuck enough in one place to confirm the series works on Panda
> case for power control.  So long as it doesn't get obsessed with just
> regulators some common implementation that seems to be discussed will be
> better.
>
> (BTW let me take this opportunity to thank you for your great urbs-in-flight
> limiting patch on smsc95xx a while back)
>
>
>> Also from my intuition, power domain should be involved in the problem,
>> because these hard-wired and self-powered USB devices should have
>> its own power domains, and the ehci-omap driver may enable/disable
>> these power domains before adding the bus.
>
>
> I don't know enough to have an opinion, but the arrangement on Panda is
> literally a linear regulator is being controlled by a gpio, which fits into
> struct regulator model.  What else would a power domain for that buy us?

One problem is that you are addressing to, another is that we may extend
Tianyu's per port power off/on mechanism into non-acpi world.

Considered that our discussion has been extended to general case instead
of pandaboard only, there might be several bus devices which have different
power control method, which should be the idea of power domain.

I have a draft idea and let me describe it by a pseudo_patch, see below:

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index ac17a7c..c97538f 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -220,6 +220,11 @@ static int ehci_hcd_omap_probe(struct
platform_device *pdev)
 		goto err_io;
 	}

+	list_for_each_entry(ppd, pdata, port_power_domain) {
+		usb_unregister_port_pm_domain(&hcd->self, ppd);
+		ppd->port_power.power_on(ppd, on)
+	}
+
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 	hcd->regs = regs;
@@ -290,6 +295,11 @@ static int ehci_hcd_omap_remove(struct
platform_device *pdev)
 	struct usb_hcd *hcd				= dev_get_drvdata(dev);
 	struct ehci_hcd_omap_platform_data *pdata	= dev->platform_data;

+	list_for_each_entry(ppd, pdata, port_power_domain) {
+		usb_unregister_port_pm_domain(&hcd->self, ppd);
+		ppd->port_power.power_off(ppd, on)
+	}
+
 	usb_remove_hcd(hcd);
 	disable_put_regulator(dev->platform_data);
 	iounmap(hcd->regs);
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
index 608050b..89c31c0 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -448,6 +448,30 @@ extern void usb_disconnect(struct usb_device **);
 extern int usb_get_configuration(struct usb_device *dev);
 extern void usb_destroy_configuration(struct usb_device *dev);

+/*
+ * Only apply in hardwired self-powered devices in bus
+ */
+struct port_power_domain {
+	struct usb_bus *bus;
+	/*
+	 * physical port location in which the power domain provides power on it,
+	 * the first number is the root hub port, and the second number is the
+	 * port number on the second layer hub, ...
+	 */
+	char port_info[32];		/*N-N-N...*/
+
+	/*
+	 * struct power_domain should be generic power thing, and should be
+	 * defined in power core
+	 */
+	struct power_domain port_power;
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

>
>>> We should have a more generic solution in a more central location, like
>>> the device core.
>>>
>>> For example, each struct platform_device could have a list of resources
>>> to be enabled when the device is bound to a driver and disabled when
>>> the device is unbound.  Such a list could include regulators, clocks,
>>> and whatever else people can invent.
>>>
>>> In this case, when it is created the ehci-omap.0 platform device could
>>> get an entry pointing to the LAN95xx's regulator.  Then the regulator
>>> would automatically be turned on when the platform device is bound to
>>> the ehci-omap driver.
>>
>>
>> The LAN95xx's regulator is still platform dependent(even for same LAN95xx
>> USB devices on different platforms(omap, tegra, ..)) , so I am wondering
>> why we don't enable it directly in probe() of ehci-omap.0 platform device?
>
>
> I didn't get this point, ehci-omap doesn't help if it's non-omap platform.

The other platform just does their way simply to support its power on/off.


Thanks,
-- 
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
