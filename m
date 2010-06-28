From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Mon, 28 Jun 2010 16:27:23 -0700
Message-ID: <87fx06viuc.fsf@deeprootsystems.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<874ogrng3j.fsf@deeprootsystems.com>
	<AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52857 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab0F1X10 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 19:27:26 -0400
Received: by pwj8 with SMTP id 8so3549467pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Jun 2010 16:27:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.miao@canonical.com>, Nicolas Pitre <nico@fluxnic.net>

Grant Likely <grant.likely@secretlab.ca> writes:

[...]

>
>> This affects many aspects of all drivers, from register and probe (f=
or
>> early devices/drivers too!) to all the plaform_get_resource() usage,=
 all
>> of which assumes a platform_driver and platform_device. =A0I didn't =
look
>> closely, but I didn't see if (or how) OF was handling early devices.
>
> You don't have to reimplement the entire platform bus.  You could
> simply create a new bus type, but reuse all the existing platform bus
> code.  All that changes is the bus type that the device and the drive=
r
> gets registered on.  Then you could easily replace only the functions
> that matter.  (do a git grep platform_bus_type to see how few
> references there actually are.  It looks like there are only 5
> references to it in drivers/base/platform.c that you'd need to work
> around; in platform_device_add(), platform_driver_register(), 2 in
> platform_driver_probe(), and the register in platform_bus_init().  Yo=
u
> may not even need to reimplement platform_driver_probe().
>
> It might even be as simple as doing this:
> -        pdev->dev.bus =3D &platform_bus_type;
> +       if (!pdev->dev.bus)
> +                pdev->dev.bus =3D &platform_bus_type;
>
> So that a different bus type can be selected at device registration
> time=20

just FYI...

as a quick proof of concept, I've done a quick hack just to prove to
myself that I could use platform_devices on a custom bus, and it indeed
works.  The small patch below[1] shows the changes required to the
platform code.

Next step was to hack up minimal custom bus code.  The quickest (and
dirtiest) way was to simply memcpy platform_bus_type into my new
omap_bus_type and then override the few dev_pm_ops functions I needed[2=
].

So, with these in place, and using the dev_pm_ops functions from
$SUBJECT patch, I was able register a platform_device and
platform_driver onto my custom bus and see my custom dev_pm_ops
functions being used as expected.

While admittedly a bit hacky, at least this paves the way in my head
that this is indeed do-able, and I can take my vacation in peace withou=
t
this particular problem haunting me (too much.)

Kevin

[1]
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4d99c8b..2cf55e2 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -241,7 +241,8 @@ int platform_device_add(struct platform_device *pde=
v)
 	if (!pdev->dev.parent)
 		pdev->dev.parent =3D &platform_bus;
=20
-	pdev->dev.bus =3D &platform_bus_type;
+	if (!pdev->dev.bus)
+		pdev->dev.bus =3D &platform_bus_type;
=20
 	if (pdev->id !=3D -1)
 		dev_set_name(&pdev->dev, "%s.%d", pdev->name,  pdev->id);
@@ -482,7 +483,8 @@ static void platform_drv_shutdown(struct device *_d=
ev)
  */
 int platform_driver_register(struct platform_driver *drv)
 {
-	drv->driver.bus =3D &platform_bus_type;
+	if (!drv->driver.bus)
+		drv->driver.bus =3D &platform_bus_type;
 	if (drv->probe)
 		drv->driver.probe =3D platform_drv_probe;
 	if (drv->remove)
@@ -539,12 +541,12 @@ int __init_or_module platform_driver_probe(struct=
 platform_driver *drv,
 	 * if the probe was successful, and make sure any forced probes of
 	 * new devices fail.
 	 */
-	spin_lock(&platform_bus_type.p->klist_drivers.k_lock);
+	spin_lock(&drv->driver.bus->p->klist_drivers.k_lock);
 	drv->probe =3D NULL;
 	if (code =3D=3D 0 && list_empty(&drv->driver.p->klist_devices.k_list)=
)
 		retval =3D -ENODEV;
 	drv->driver.probe =3D platform_drv_probe_fail;
-	spin_unlock(&platform_bus_type.p->klist_drivers.k_lock);
+	spin_unlock(&drv->driver.bus->p->klist_drivers.k_lock);
=20
 	if (code !=3D retval)
 		platform_driver_unregister(drv);


[2]=20
struct bus_type omap_bus_type;
EXPORT_SYMBOL_GPL(omap_bus_type);

static int __init omap_bus_init(void)
{
	int error;
	struct bus_type *bus =3D &omap_bus_type;

	pr_debug("%s\n", __func__);

	/*
	 * We're just a copy of platform_bus_type with special dev_pm_ops.
	 */
	memcpy(bus, &platform_bus_type, sizeof(struct bus_type));
	bus->name =3D "omap";
	bus->pm->suspend_noirq =3D omap_pm_suspend_noirq,
	bus->pm->resume_noirq =3D omap_pm_resume_noirq,
	bus->pm->runtime_suspend =3D omap_pm_runtime_suspend,
	bus->pm->runtime_resume =3D omap_pm_runtime_resume,
	bus->pm->runtime_idle =3D omap_pm_runtime_idle,

	error =3D device_register(&omap_bus);
	if (error)
		return error;
	error =3D  bus_register(&omap_bus_type);
	if (error)
		device_unregister(&omap_bus);

	return error;
}
arch_initcall(omap_bus_init);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
