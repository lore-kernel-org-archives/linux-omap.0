From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/4] mfd: global Suspend and resume support of ehci and ohci
Date: Wed, 29 Jun 2011 22:07:21 +0530
Message-ID: <BANLkTi=pKL6RDBTDBStv+uhxVKp3-bwXbg@mail.gmail.com>
References: <1306934847-6098-1-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-2-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-3-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-4-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-5-git-send-email-keshava_mgowda@ti.com>
	<87d3ix5c6y.fsf@ti.com>
	<BANLkTim43pAKe1o-aFmgh79bNqSyZmW_Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTim43pAKe1o-aFmgh79bNqSyZmW_Fg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 29, 2011 at 8:52 PM, Munegowda, Keshava
<keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
> On Thu, Jun 2, 2011 at 5:36 AM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
>> Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org> writes:
>>
>>> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>>
>>> The global suspend and resume functions for usbhs core driver
>>> are implemented.These routine are called when the global suspend
>>> and resume occurs. Before calling these functions, the
>>> bus suspend and resume of ehci and ohci drivers are called
>>> from runtime pm.
>>>
>>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>
>> First, from what I can see, this is only a partial implementation of
>> runtime PM. =A0What I mean is that the runtime PM methods are used o=
nly
>> during the suspend path. =A0The rest of the time the USB host IP blo=
ck is
>> left enabled, even when nothing is connected.
>>
>> I tested this on my 3530/Overo board, and verified that indeed the
>> usbhost powerdomain hits retention on suspend, but while idle, when
>> nothing is connected, I would expect the driver could be clever enou=
gh
>> to use runtime PM (probably using autosuspend timeouts) to disable t=
he
>> hardware as well.
>>
>>> ---
>>> =A0drivers/mfd/omap-usb-host.c | =A0103 +++++++++++++++++++++++++++=
++++++++++++++++
>>> =A01 files changed, 103 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-hos=
t.c
>>> index 43de12a..32d19e2 100644
>>> --- a/drivers/mfd/omap-usb-host.c
>>> +++ b/drivers/mfd/omap-usb-host.c
>>> @@ -146,6 +146,10 @@
>>> =A0#define is_ehci_hsic_mode(x) (x =3D=3D OMAP_EHCI_PORT_MODE_HSIC)
>>>
>>>
>>> +/* USBHS state bits */
>>> +#define OMAP_USBHS_INIT =A0 =A0 =A0 =A0 =A0 =A0 =A00
>>> +#define OMAP_USBHS_SUSPEND =A0 4
>>
>> These additional state bits don't seem to be necessary.
>>
>> For suspend, just check 'pm_runtime_is_suspended()'
>>
>> The init flag is only used in the suspend/resume hooks, but the need=
 for
>> it is a side effect of not correctly using the runtime PM callbacks.
>>
>> Remember that the runtime PM get/put hooks have usage counting. =A0O=
nly
>> when the usage count transitions to/from zero is the actual
>> hardware-level enable/disable (via omap_hwmod) being done.
>>
>> The current code is making the assumption that every call to get/put=
 is
>> going to result in an enable/disable of the hardware.
>>
>> Instead, all of the code that needs to be run only upon actual
>> enable/disable of the hardware should be done in the driver's
>> runtime_suspend/runtime_resume callbacks. =A0These are only called w=
hen
>> the hardware actually changes state.
>>
>> Not knowing that much about the EHCI block, upon first glance, it lo=
oks
>> like mmuch of what is done in usbhs_enable() should actually be done=
 in
>> the ->runtime_resume() callback, and similarily, much of what is don=
e in
>> usbhs_disable() should be done in the ->runtime_suspend() callback.
>
> Kevin,
> =A0 do you mean driver->runtime_resume and driver->runtime_resume cal=
l backs.
> are these call backs from pm_runtime_get_sync and pm_runtime_put_sync=
?

for usb host case , I am seeing that the pm_runtime_get_sync


static int rpm_resume(struct device *dev, int rpmflags)
{
  ............
 ..........
	if (dev->pwr_domain) {
		callback =3D dev->pwr_domain->ops.runtime_resume;
		if(!strcmp(dev_name(dev),"usbhs_omap"))
			 pr_err("dev->pwr_domain->ops.runtime_resume");
	}=09
	else if (dev->type && dev->type->pm) {
		callback =3D dev->type->pm->runtime_resume;
		if(!strcmp(dev_name(dev),"usbhs_omap"))
			 pr_err("dev->type->pm->runtime_resume");
	}=09
	else if (dev->class && dev->class->pm) {
		callback =3D dev->class->pm->runtime_resume;
		if(!strcmp(dev_name(dev),"usbhs_omap"))
			 pr_err("ev->class->pm->runtime_resume");
	}=09
	else if (dev->bus && dev->bus->pm) {
		callback =3D dev->bus->pm->runtime_resume;
	if(!strcmp(dev_name(dev),"usbhs_omap"))
		 pr_err("dev->bus->pm->runtime_resume");
	}=09
	else
		callback =3D NULL;
}


I am seeing that below if statement was hitting true:

	if (dev->pwr_domain) {
		callback =3D dev->pwr_domain->ops.runtime_resume;
		if(!strcmp(dev_name(dev),"usbhs_omap"))
			 pr_err("dev->pwr_domain->ops.runtime_resume");


due to this; the driver->runtime_resume was not getting called.

Any idea on why I am seeing only the dev->pwr_domain is set not
dev->bus && dev->bus->pm is hitting here?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
