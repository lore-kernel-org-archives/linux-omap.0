From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 1/5 v13] arm: omap: usb: ehci and ohci hwmod structures
 for omap4
Date: Mon, 10 Oct 2011 16:45:11 +0530
Message-ID: <CAP05o4JPrG1kH+x8F25OOteug+x++uTY8fEdaAsg+=6TaYB7Aw@mail.gmail.com>
References: <1317901099-2519-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1110070305040.4611@utopia.booyaka.com>
	<CAP05o4J39MotDTOv-O2ahvWfxL-7jC-L3FGsNXbmDy8HNg=W3g@mail.gmail.com>
	<alpine.DEB.2.00.1110070330220.4611@utopia.booyaka.com>
	<CAP05o4KLAnNHcvNbNWqJFN710JMNAy2emYzCt2xHF+m-Kvwveg@mail.gmail.com>
	<CAP05o4+ybhZwRaXZPgS-ZdTL_0gjz1VLf6LuUtMgm_txNPwrnw@mail.gmail.com>
	<20111010090330.GE6685@legolas.emea.dhcp.ti.com>
	<CAP05o4Kqrsr3Kzm=NDpEB7wHACzXkp2mQLuWdUAsZ8pVPdJafA@mail.gmail.com>
	<20111010092613.GF6685@legolas.emea.dhcp.ti.com>
	<20111010100507.GG6685@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111010100507.GG6685@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, Paul Walmsley <paul@pwsan.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com, Greg KH <greg@kroah.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 10, 2011 at 3:35 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, Oct 10, 2011 at 12:26:15PM +0300, Felipe Balbi wrote:
>> On Mon, Oct 10, 2011 at 02:47:42PM +0530, Munegowda, Keshava wrote:
>> > On Mon, Oct 10, 2011 at 2:33 PM, Felipe Balbi <balbi@ti.com> wrote=
:
>> > > Hi,
>> > >
>> > > On Mon, Oct 10, 2011 at 02:22:23PM +0530, Munegowda, Keshava wro=
te:
>> > >> Hi paul and Felipe
>> > >>
>> > >> Here is the highlights of the change in the design of =A0USB Ho=
st which
>> > >> we can do after kernel 3.2 release;
>> > >>
>> > >> 1. separate the TLL changes =A0from UHH
>> > >> 2. The TLL is be a new platform driver in ./drivers/mfd
>> > >> 3. the TLL platform driver will export apis =A0for enable/disab=
le clocks
>> > >> and settings.
>> > >
>> > > TLL should control its clocks through pm_runtime APIs like anyth=
ing
>> > > else. If you really must export APIs to be used by UHH, you need=
 to have
>> > > an API so that you can claim/release a TLL channel and get/put f=
or
>> > > increasing/decreasing PM counters.
>> > >
>> > > I still think though, you should try to avoid exporting OMAP-spe=
cific
>> > > APIs all over the place. Ideally, we would be able to have some =
way of
>> > > saying that UHH and TLL are closely related... something like ha=
ving the
>> > > ability to say e.g. two devices are sibblings of each other, so =
that we
>> > > could ask for a sibbling to wakeup/sleep depending if we need it=
 or not.
>> >
>> > do we have sibling structures today? I dont think so.
>>
>> no we don't.
>
> Ok, here's a first shot at it:
>
> From 600ae62f4b4a832d90a83d43227deb6f84b9def1 Mon Sep 17 00:00:00 200=
1
> From: Felipe Balbi <balbi@ti.com>
> Date: Mon, 10 Oct 2011 12:56:34 +0300
> Subject: [RFC/NOT-FOR-MERGING/PATCH] base: add the idea of sibling de=
vices
> Organization: Texas Instruments\n
>
> It's possible that some devices, which share a
> common parent, need to talk to each due to a
> very close relationship between them.
>
> Generally, one device will provide some sort of
> resources to the other (e.g. clocks) while still
> both sharing another common parent.
>
> In such cases, it seems necessary to define those
> two devices as siblings, rather than a virtual
> parent relationship, and have means for one device
> to ask the sibling device to e.g. turn on its clocks.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> =A0drivers/base/core.c =A0 =A0| =A0 41 ++++++++++++++++++++++++++++++=
+++++++++++
> =A0include/linux/device.h | =A0 =A07 +++++++
> =A02 files changed, 48 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index bc8729d..3b7f2e5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -589,6 +589,7 @@ void device_initialize(struct device *dev)
> =A0 =A0 =A0 =A0dev->kobj.kset =3D devices_kset;
> =A0 =A0 =A0 =A0kobject_init(&dev->kobj, &device_ktype);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&dev->dma_pools);
> + =A0 =A0 =A0 INIT_LIST_HEAD(&dev->siblings);
> =A0 =A0 =A0 =A0mutex_init(&dev->mutex);
> =A0 =A0 =A0 =A0lockdep_set_novalidate_class(&dev->mutex);
> =A0 =A0 =A0 =A0spin_lock_init(&dev->devres_lock);
> @@ -889,6 +890,7 @@ int device_private_init(struct device *dev)
> =A0*/
> =A0int device_add(struct device *dev)
> =A0{
> + =A0 =A0 =A0 struct device *sibling, *n;
> =A0 =A0 =A0 =A0struct device *parent =3D NULL;
> =A0 =A0 =A0 =A0struct class_interface *class_intf;
> =A0 =A0 =A0 =A0int error =3D -EINVAL;
> @@ -923,6 +925,10 @@ int device_add(struct device *dev)
> =A0 =A0 =A0 =A0parent =3D get_device(dev->parent);
> =A0 =A0 =A0 =A0setup_parent(dev, parent);
>
> + =A0 =A0 =A0 /* setup siblings */
> + =A0 =A0 =A0 list_for_each_entry_safe(sibling, n, &dev->siblings, si=
bling_node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_device(sibling);
> +
> =A0 =A0 =A0 =A0/* use parent numa_node */
> =A0 =A0 =A0 =A0if (parent)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_dev_node(dev, dev_to_node(parent))=
;
> @@ -1071,6 +1077,31 @@ void put_device(struct device *dev)
> =A0}
>
> =A0/**
> + * get_sibling_device_byname - finds a sibling device by its name
> + * @dev: device.
> + * @name: name for the sibling to find.
> + *
> + * This is here to help drivers which need to ask their siblings
> + * for something in particular (like ask sibling to turn clocks on)
> + * achieve that by first finding the correct device pointer for
> + * that sibling.
> + */
> +struct device *get_sibling_device_byname(struct device *dev, const c=
har *name)
> +{
> + =A0 =A0 =A0 struct device =A0 *sibling, *n;
> + =A0 =A0 =A0 struct device =A0 *found =3D NULL;
> +
> + =A0 =A0 =A0 list_for_each_entry_safe(sibling, n, &dev->siblings, si=
bling_node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(dev_name(sibling), name))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D sibling;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto found;
> + =A0 =A0 =A0 }
> +
> +found:
> + =A0 =A0 =A0 return found;
> +}
> +
> +/**
> =A0* device_del - delete device from system.
> =A0* @dev: device.
> =A0*
> @@ -1085,6 +1116,7 @@ void put_device(struct device *dev)
> =A0*/
> =A0void device_del(struct device *dev)
> =A0{
> + =A0 =A0 =A0 struct device *sibling, *n;
> =A0 =A0 =A0 =A0struct device *parent =3D dev->parent;
> =A0 =A0 =A0 =A0struct class_interface *class_intf;
>
> @@ -1120,6 +1152,15 @@ void device_del(struct device *dev)
> =A0 =A0 =A0 =A0device_remove_attrs(dev);
> =A0 =A0 =A0 =A0bus_remove_device(dev);
>
> + =A0 =A0 =A0 /* teardown siblings */
> + =A0 =A0 =A0 list_for_each_entry_safe(sibling, n, &dev->siblings, si=
bling_node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* siblings must have =A0the same paren=
t */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(sibling->parent !=3D parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "siblin=
gs must have a common parent\n");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_device(sibling);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Some platform devices are driven without driver att=
ached
> =A0 =A0 =A0 =A0 * and managed resources may have been acquired. =A0Ma=
ke sure
> diff --git a/include/linux/device.h b/include/linux/device.h
> index c20dfbf..ae9cec9 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -551,6 +551,9 @@ struct device_dma_parameters {
> =A0struct device {
> =A0 =A0 =A0 =A0struct device =A0 =A0 =A0 =A0 =A0 *parent;
>
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0sibling_node;
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0siblings;
> +
> =A0 =A0 =A0 =A0struct device_private =A0 *p;
>
> =A0 =A0 =A0 =A0struct kobject kobj;
> @@ -764,6 +767,10 @@ extern int (*platform_notify_remove)(struct devi=
ce *dev);
> =A0extern struct device *get_device(struct device *dev);
> =A0extern void put_device(struct device *dev);
>
> +/* finds a sibling struct device pointer */
> +extern struct device *get_sibling_device_byname(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *name);
> +
> =A0extern void wait_for_device_probe(void);
>
> =A0#ifdef CONFIG_DEVTMPFS
> --
> 1.7.6.396.ge0613
>
> one way to use this would be to mark both hwmods has having the same
> parent and pointing to each other as siblings. Then, from UHH you cou=
ld:
>
> if (port->mode =3D=3D TLL) {
> =A0 =A0 =A0 =A0tll =3D get_sibling_device_by_name(dev, "usbtll");
> =A0 =A0 =A0 =A0if (!tll)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error();
>
> =A0 =A0 =A0 =A0pm_runtime_get_sync(tll);
> }
>
> or something similar. As of now, I'm not so sure this is a very good
> idea, but decided to gather some comments anyway.
>
> Does anybody see any change of this getting used in more cases ? Greg=
,
> I'm adding you to this thread, if you have any comments to this, I'd
> like to hear them.


This design looks good and perfectly suits our requirements.

Paul/Others
          please provide your thoughts..

regards
keshava
