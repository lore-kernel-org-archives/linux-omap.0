From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v2 4/7] OMAP: PM CONSTRAINTS: implement the constraints
 management code
Date: Fri, 18 Mar 2011 12:33:22 +0100
Message-ID: <AANLkTin4T1Tk88Ud-TSQ1SOEWuZnv-XXwm8V2wUSUvr_@mail.gmail.com>
References: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
	<1299779247-20511-5-git-send-email-j-pihet@ti.com>
	<874o71zdpu.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49983 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab1CRLdY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Mar 2011 07:33:24 -0400
Received: by qwk3 with SMTP id 3so2735760qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Mar 2011 04:33:23 -0700 (PDT)
In-Reply-To: <874o71zdpu.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Jean Pihet <j-pihet@ti.com>

Kevin,

Thanks for reviewing!
All comments below fixed in the code. The updated series is coming asap=
=2E

More comments inlined below.

On Thu, Mar 17, 2011 at 9:36 PM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> The code at omap device level manages the constraints: storage,
>> tracking of requesters and dispatching to the low level
>> code (e.g. powerdomain for the wake-up latency constraints).
>>
>> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constra=
ints
>> on MPU, CORE and PER.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Subject prefix should be: OMAP2+: omap_device: ...
>
>> ---
>> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 14 ++
>> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
202 +++++++++++++++++++++++++
>> =A02 files changed, 216 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/ar=
m/plat-omap/include/plat/omap_device.h
>> index e4c349f..d4766c4 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_device.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
>> @@ -32,9 +32,11 @@
>> =A0#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_DEVICE_H
>>
>> =A0#include <linux/kernel.h>
>> +#include <linux/plist.h>
>> =A0#include <linux/platform_device.h>
>>
>> =A0#include <plat/omap_hwmod.h>
>> +#include <plat/omap-pm.h>
>>
>> =A0extern struct device omap_device_parent;
>>
>> @@ -73,6 +75,15 @@ struct omap_device {
>> =A0 =A0 =A0 s8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0pm_lat_level;
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0hwmods_cnt;
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0_state;
>> +
>> +};
>> +
>> +/* Linked list for the devices constraints entries */
>> +struct omap_device_constraints_entry {
>> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *req_dev=
;
>> + =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*target;
>> + =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 constrai=
nt_value;
>
> constratint_ prefix not needed
>
> Also, should this be 'long' (instead of unsigned long' to match the
> value from the API below?
>
>> + =A0 =A0 struct plist_node =A0 =A0 =A0 =A0 =A0 =A0 =A0 node;
>> =A0};
>>
>> =A0/* Device driver interface (call via platform_data fn ptrs) */
>> @@ -107,6 +118,9 @@ void __iomem *omap_device_get_rt_va(struct omap_=
device *od);
>> =A0int omap_device_align_pm_lat(struct platform_device *pdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 new_wakeu=
p_lat_limit);
>> =A0struct powerdomain *omap_device_get_pwrdm(struct omap_device *od)=
;
>> +int omap_device_set_dev_constraint(enum omap_pm_constraint_class cl=
ass,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct device *req_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct device *dev, long t);
>> =A0u32 omap_device_get_context_loss_count(struct platform_device *pd=
ev);
>>
>> =A0/* Other */
>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/o=
map_device.c
>> index 9bbda9a..9199d3e 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -292,10 +292,205 @@ static void _add_optional_clock_clkdev(struct=
 omap_device *od,
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +/* plist that stores the devices wake-up latency constraints */
>> +static struct plist_head _wkup_lat_constraints_list;
>> +/* Spinlock that protects the constraints lists */
>> +static spinlock_t _constraints_lock;
>> +/* Mutex that protects the constraints lists ops */
>> +static struct mutex _constraints_mutex;
>> +
>> +/*
>> + * _store_constraint: add/update/remove a constraint from a plist
>> + *
>> + * @constraints_list: plist to use
>> + * @req_dev: constraint requester, used to track the requests
>> + * @target: target which the constraint applies to (e.g. power doma=
in ID or
>> + * =A0ptr for wake-up latency constraints)
>> + * @value: constraint value. The plist is sorted by the value. -1 r=
emove the
>> + * =A0constraint from the list
>> + * @ascending: return the lowest constraint value if set to 1, retu=
rn the
>> + * =A0highest value if not.
>> + *
>> + * Returns the strongest constraint value for the given target, 0 i=
n the
>> + * case there is no constraint on the given target or a negative va=
lue in
>> + * case of error.
>> + * The caller must check the validity of the parameters.
>> + */
>> +static long _store_constraint(struct plist_head *constraints_list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device =
*req_dev, void *target,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 long value, in=
t ascending)
>> +{
>> + =A0 =A0 struct omap_device_constraints_entry *user;
>> + =A0 =A0 int found =3D 0, ret =3D 0;
>> +
>> + =A0 =A0 mutex_lock(&_constraints_mutex);
>> +
>> + =A0 =A0 /* Check if the constraint requester is already in the lis=
t */
>> + =A0 =A0 plist_for_each_entry(user, constraints_list, node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (user->req_dev =3D=3D req_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>
> You should probably release the mutex here so it's not held over the
> kzalloc (which can sleep.)
The mutex is removed and only the spinlock is used to protect the list =
ops.

>
> Minor: I'm not a fan of this common 'found =3D 1' technique. =A0Rathe=
r, use
> a temporary list iterator, e.g:
>
> =A0 =A0 =A0 =A0struct omap_device_constraints_entry *user =3D NULL, *=
tmp_user;
>
> =A0 =A0 =A0 =A0plist_for_each_entry(tmp_user, constraints_list, node)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (user->req_dev =3D=3D req_dev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0user =3D tmp_user;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> Then, rather than checking 'found' below, check 'user'.
That is indeed cleaner.

>
>> + =A0 =A0 if (value >=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Add new entry to the list or update exi=
sting request */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (found &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->constraint_value =3D=3D valu=
e &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->target =3D=3D target) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_ok;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (!found) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user =3D kzalloc(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(str=
uct omap_device_constraints_entry),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!user) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s=
: FATAL ERROR: kzalloc failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0__func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -E=
NOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_=
error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->req_dev =3D req_dev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&user->node, con=
straints_list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_node_init(&user->node, value);
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_add(&user->node, constraints_list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 user->node.prio =3D user->constraint_value=
 =3D value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 user->target =3D target;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Remove the constraint from the list */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!found) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: no prio=
r constraint to release\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&user->node, constraints_list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(user);
>> + =A0 =A0 }
>> +
>> +exit_ok:
>> + =A0 =A0 /* Find the strongest constraint for the given target */
>> + =A0 =A0 ret =3D 0;
>> + =A0 =A0 if (ascending) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(user, &(constraints_li=
st)->node_list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 no=
de.plist.node_list) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Find the lowest (i.e. f=
irst) value for the target */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (user->target =3D=3D ta=
rget) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D us=
er->constraint_value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry_reverse(user,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 &(constraints_list)->node_list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 node.plist.node_list) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Find the highest (i.e. =
last) value for the target */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (user->target =3D=3D ta=
rget) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D us=
er->constraint_value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>
> Hmm, why can't you use plist_first() and plist_last() here?
Because the plist is sorted by the 'prio' field (which is 'value' in
this code) and this function searches for the strongest constraint for
a given target. So it is needed to iterate through the list in order
to find the first (or last) constraint with the right target.

>
>> +exit_error:
>> + =A0 =A0 mutex_unlock(&_constraints_mutex);
>> +
>> + =A0 =A0 return ret;
>> +}
>>
>> =A0/* Public functions for use by core code */
>>
>> =A0/**
>> + * omap_device_set_dev_constraint - set/release a device constraint
>> + * @class: constraint class
>> + * @req_dev: constraint requester, used for tracking the constraint=
s
>> + * @dev: device to apply the constraint to. Must have an associated=
 omap_device
>> + * @t: constraint value. A value of -1 removes the constraint.
>> + *
>> + * Using the primary hwmod, set/release a device constraint for the=
 dev
>> + * device, requested by the req_dev device. Depending of the constr=
aint class
>> + * this code calls the appropriate low level code, e.g. power domai=
n for
>> + * the wake-up latency constraints.
>> + *
>> + * If any hwmods exist for the omap_device assoiated with @dev,
>> + * set/release the constraint for the corresponding hwmods, otherwi=
se return
>> + * -EINVAL.
>> + */
>> +int omap_device_set_dev_constraint(enum omap_pm_constraint_class cl=
ass,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct device *req_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct device *dev, long t)
>> +{
>> + =A0 =A0 struct omap_device *od;
>> + =A0 =A0 struct omap_hwmod *oh;
>> + =A0 =A0 struct platform_device *pdev;
>> + =A0 =A0 struct powerdomain *pwrdm =3D NULL;
>> + =A0 =A0 u32 ret =3D -EINVAL;
>> +
>> + =A0 =A0 /* Look for the platform device for dev */
>> + =A0 =A0 pdev =3D to_platform_device(dev);
>> +
>> + =A0 =A0 /* Try to catch non platform devices. */
>> + =A0 =A0 if (pdev->name =3D=3D NULL) {
>
> This should check for a valid omap_device, not platform_device.
This check remains but the check below is changed, see below.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: platform device for dev=
ice %s not valid\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, dev_name(dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Find the associated omap_device for dev */
>> + =A0 =A0 od =3D _find_by_pdev(pdev);
>> + =A0 =A0 if (!(od->hwmods_cnt)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: No hwmod for device %s\=
n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, dev_name(dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
Changed to:
+       if (!od || (od->hwmods_cnt !=3D 1)) {
+               pr_err("%s: Error: No unique hwmod for device %s\n",
+                      __func__, dev_name(dev));
+               return -EINVAL;
+       }

>> +
>> + =A0 =A0 /* Find the associated omap_hwmod for dev */
>> + =A0 =A0 oh =3D od->hwmods[0];
>> +
>> + =A0 =A0 switch (class) {
>> + =A0 =A0 case OMAP_PM_CONSTRAINT_WKUP_LAT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Find the pwrdm associated to dev */
>
> comment doesn't add anything to code
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 pwrdm =3D omap_device_get_pwrdm(od);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pwrdm) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: No pwrd=
m for device %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, d=
ev_name(dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Store the constraint in the appropria=
te list and find the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* strongest constraint for the given pw=
rdm
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D _store_constraint(&_wkup_lat_const=
raints_list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 req_dev, (void *) pwrdm, t, 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Apply the constraint to the correspondi=
ng pwrdm */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret >=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hwmod_update_=
power_state(oh, ret);
>
> This function doesn't exist yet, so the series up to here will not
> compile.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error storing =
the constraint for device "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s\n", __f=
unc__, dev_name(dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case OMAP_PM_CONSTRAINT_THROUGHPUT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: Bus throughput const=
raint class \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0not implemented\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid constraint c=
lass %d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, class);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/**
>> =A0 * omap_device_get_context_loss_count - get lost context count
>> =A0 * @od: struct omap_device *
>> =A0 *
>> @@ -824,6 +1019,13 @@ struct device omap_device_parent =3D {
>>
>> =A0static int __init omap_device_init(void)
>> =A0{
>> + =A0 =A0 /* Initialize priority ordered list for wakeup latency con=
straint */
>> + =A0 =A0 spin_lock_init(&_constraints_lock);
>> + =A0 =A0 plist_head_init(&_wkup_lat_constraints_list, &_constraints=
_lock);
>> +
>> + =A0 =A0 /* res_mutex protects res_list add and del ops */
>> + =A0 =A0 mutex_init(&_constraints_mutex);
>> +
>> =A0 =A0 =A0 return device_register(&omap_device_parent);
>> =A0}
>> =A0core_initcall(omap_device_init);
>
> Kevin
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
