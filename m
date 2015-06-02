From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 5/6] phy: twl4030-usb: add support for reading resistor on ID pin.
Date: Tue, 2 Jun 2015 16:06:47 +0200
Message-ID: <C1222390-F14D-4E47-9F53-CD4646BF4450@goldelico.com>
References: <20150416075945.23307.24424.stgit@notabene.brown>	<20150416080304.23307.41913.stgit@notabene.brown>	<556C5FF4.3050603@ti.com> <20150602073731.26edbd3b@notabene.brown> <556DB481.3080906@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <556DB481.3080906@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, linux-omap <linux-omap@vger.kernel.org>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Am 02.06.2015 um 15:49 schrieb Kishon Vijay Abraham I <kishon@ti.com>:

> Hi,
>=20
> On Tuesday 02 June 2015 03:07 AM, NeilBrown wrote:
>> On Mon, 1 Jun 2015 19:06:52 +0530 Kishon Vijay Abraham I <kishon@ti.=
com>
>> wrote:
>>=20
>>> Hi,
>>>=20
>>> On Thursday 16 April 2015 01:33 PM, NeilBrown wrote:
>>>> From: NeilBrown <neilb@suse.de>
>>>>=20
>>>> The twl4030 phy can measure, with low precision, the
>>>> resistance-to-ground of the ID pin.
>>>>=20
>>>> Add a function to read the value, and export the result
>>>> via sysfs.
>>>=20
>>> Little sceptical about adding new sysfs entries. Do you have a good=
 reason to
>>> add this?
>>=20
>> The hardware can report the value, so why not present it to user-spa=
ce?
>>=20
>> I originally used this with a udev rule which would configure the ma=
ximum
>> current based on the resistance measure - to work with the particula=
r charger
>> hardware I have.
>>=20
>> More recent patches try to do all of the max-current configuration i=
n the
>> kernel, so I could live without exporting the value via sysfs if tha=
t is a
>> show-stopper.
>>=20
>> I can't see where the scepticism comes from though.  It is a well de=
fined
>> and cleary documented feature of the hardware.  Why not expose it?
>=20
> ABI can never be removed or modified later. So should be really caref=
ul before adding it.

Is /sys considered ABI? It is permanently changing. At least in what I =
see.

User space developers are always reminded not to rely on /sys nodes.
Or if they do they have to follow kernel changes at their own risk.

And if something is useful (and has a use case as Neil mentioned), why =
shouldn=92t
it be provided.

There are use cases where user space needs to know the value. Udev rule=
 being
an example. E.g. to make LEDs show the state.

Or see it as a debugging tool. Just cat /sys/=85path=85/id to check if =
your 3 types
of charger are recognised properly.

Or write a tool that displays the charger type.

So isn=92t that a little too narrow view applied here?

Just my opinion.

BR,
Nikolaus

>=20
> Thanks
> Kishon
>=20
>>=20
>> Thanks,
>> NeilBrown
>>=20
>>=20
>>>=20
>>> Thanks
>>> Kishon
>>>>=20
>>>> If the read fails, which it does sometimes, try again in 50msec.
>>>>=20
>>>> Acked-by: Pavel Machek <pavel@ucw.cz>
>>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>>> ---
>>>>   .../ABI/testing/sysfs-platform-twl4030-usb         |   22 ++++++=
+
>>>>   drivers/phy/phy-twl4030-usb.c                      |   63 ++++++=
++++++++++++++
>>>>   2 files changed, 85 insertions(+)
>>>>=20
>>>> diff --git a/Documentation/ABI/testing/sysfs-platform-twl4030-usb =
b/Documentation/ABI/testing/sysfs-platform-twl4030-usb
>>>> index 512c51be64ae..425d23676f8a 100644
>>>> --- a/Documentation/ABI/testing/sysfs-platform-twl4030-usb
>>>> +++ b/Documentation/ABI/testing/sysfs-platform-twl4030-usb
>>>> @@ -6,3 +6,25 @@ Description:
>>>>   	Possible values: "on", "off".
>>>>=20
>>>>   	Changes are notified via select/poll.
>>>> +
>>>> +What: /sys/bus/platform/devices/*twl4030-usb/id
>>>> +Description:
>>>> +	Read-only report on measurement of USB-OTG ID pin.
>>>> +
>>>> +	The ID pin may be floating, grounded, or pulled to
>>>> +	ground by a resistor.
>>>> +
>>>> +	A very course grained reading of the resistance is
>>>> +	available.  The numbers given in kilo-ohms are roughly
>>>> +	the center-point of the detected range.
>>>> +
>>>> +	Possible values are:
>>>> +		ground
>>>> +		102k
>>>> +		200k
>>>> +		440k
>>>> +		floating
>>>> +		unknown
>>>> +
>>>> +	"unknown" indicates a problem with trying to detect
>>>> +	the resistance.
>>>> diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl40=
30-usb.c
>>>> index 3a707dd14238..1d6f3e70193e 100644
>>>> --- a/drivers/phy/phy-twl4030-usb.c
>>>> +++ b/drivers/phy/phy-twl4030-usb.c
>>>> @@ -379,6 +379,56 @@ static void twl4030_i2c_access(struct twl4030=
_usb *twl, int on)
>>>>   	}
>>>>   }
>>>>=20
>>>> +enum twl4030_id_status {
>>>> +	TWL4030_GROUND,
>>>> +	TWL4030_102K,
>>>> +	TWL4030_200K,
>>>> +	TWL4030_440K,
>>>> +	TWL4030_FLOATING,
>>>> +	TWL4030_ID_UNKNOWN,
>>>> +};
>>>> +static char *twl4030_id_names[] =3D {
>>>> +	"ground",
>>>> +	"102k",
>>>> +	"200k",
>>>> +	"440k",
>>>> +	"floating",
>>>> +	"unknown"
>>>> +};
>>>> +
>>>> +enum twl4030_id_status twl4030_get_id(struct twl4030_usb *twl)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	pm_runtime_get_sync(twl->dev);
>>>> +	if (twl->usb_mode =3D=3D T2_USB_MODE_ULPI)
>>>> +		twl4030_i2c_access(twl, 1);
>>>> +	ret =3D twl4030_usb_read(twl, ULPI_OTG_CTRL);
>>>> +	if (ret < 0 || !(ret & ULPI_OTG_ID_PULLUP)) {
>>>> +		/* Need pull-up to read ID */
>>>> +		twl4030_usb_set_bits(twl, ULPI_OTG_CTRL,
>>>> +				     ULPI_OTG_ID_PULLUP);
>>>> +		mdelay(50);
>>>> +	}
>>>> +	ret =3D twl4030_usb_read(twl, ID_STATUS);
>>>> +	if (ret < 0 || (ret & 0x1f) =3D=3D 0) {
>>>> +		mdelay(50);
>>>> +		ret =3D twl4030_usb_read(twl, ID_STATUS);
>>>> +	}
>>>> +
>>>> +	if (twl->usb_mode =3D=3D T2_USB_MODE_ULPI)
>>>> +		twl4030_i2c_access(twl, 0);
>>>> +	pm_runtime_put_autosuspend(twl->dev);
>>>> +
>>>> +	if (ret < 0)
>>>> +		return TWL4030_ID_UNKNOWN;
>>>> +	ret =3D ffs(ret) - 1;
>>>> +	if (ret < TWL4030_GROUND || ret > TWL4030_FLOATING)
>>>> +		return TWL4030_ID_UNKNOWN;
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>   static void __twl4030_phy_power(struct twl4030_usb *twl, int on)
>>>>   {
>>>>   	u8 pwr =3D twl4030_usb_read(twl, PHY_PWR_CTRL);
>>>> @@ -532,6 +582,16 @@ static ssize_t twl4030_usb_vbus_show(struct d=
evice *dev,
>>>>   }
>>>>   static DEVICE_ATTR(vbus, 0444, twl4030_usb_vbus_show, NULL);
>>>>=20
>>>> +static ssize_t twl4030_usb_id_show(struct device *dev,
>>>> +				   struct device_attribute *attr,
>>>> +				   char *buf)
>>>> +{
>>>> +	struct twl4030_usb *twl =3D dev_get_drvdata(dev);
>>>> +	return scnprintf(buf, PAGE_SIZE, "%s\n",
>>>> +			 twl4030_id_names[twl4030_get_id(twl)]);
>>>> +}
>>>> +static DEVICE_ATTR(id, 0444, twl4030_usb_id_show, NULL);
>>>> +
>>>>   static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
>>>>   {
>>>>   	struct twl4030_usb *twl =3D _twl;
>>>> @@ -709,6 +769,8 @@ static int twl4030_usb_probe(struct platform_d=
evice *pdev)
>>>>   	platform_set_drvdata(pdev, twl);
>>>>   	if (device_create_file(&pdev->dev, &dev_attr_vbus))
>>>>   		dev_warn(&pdev->dev, "could not create sysfs file\n");
>>>> +	if (device_create_file(&pdev->dev, &dev_attr_id))
>>>> +		dev_warn(&pdev->dev, "could not create sysfs file\n");
>>>>=20
>>>>   	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
>>>>=20
>>>> @@ -753,6 +815,7 @@ static int twl4030_usb_remove(struct platform_=
device *pdev)
>>>>   	pm_runtime_get_sync(twl->dev);
>>>>   	cancel_delayed_work(&twl->id_workaround_work);
>>>>   	device_remove_file(twl->dev, &dev_attr_vbus);
>>>> +	device_remove_file(twl->dev, &dev_attr_id);
>>>>=20
>>>>   	/* set transceiver mode to power on defaults */
>>>>   	twl4030_usb_set_mode(twl, -1);
>>>>=20
>>>>=20
>>=20
> _______________________________________________
> Gta04-owner mailing list
> Gta04-owner@goldelico.com
> http://lists.goldelico.com/mailman/listinfo.cgi/gta04-owner
