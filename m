From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 03/11] PM QoS: support the dynamic devices insertion and removal
Date: Wed, 20 Jul 2011 11:16:01 +0200
Message-ID: <CAORVsuWukz1xNfMEu61cgCYvokBVDhxHsNKDuOjK0Ay5JaH0tQ@mail.gmail.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<1309446685-17502-4-git-send-email-j-pihet@ti.com>
	<201107022314.21713.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44269 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab1GTJQD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jul 2011 05:16:03 -0400
Received: by qyk29 with SMTP id 29so2549221qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Jul 2011 02:16:01 -0700 (PDT)
In-Reply-To: <201107022314.21713.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, Jean Pihet <j-pihet@ti.com>

Hi Rafael,

2011/7/2 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The devices wake-up latency constraints class of PM QoS is
>> storing the constraints list using the device pm_info struct.
>>
>> This patch adds the init and de-init of the per-device constraints
>> list in order to support the dynamic insertion and removal
>> of the devices in the system.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> The number of times this patch special cases PM_QOS_DEV_WAKEUP_LATENC=
Y with
> respect to the other PM QoS classes indicates a design issue, which k=
ind of
> corresponds with my comments on [3/11].
Do you mean 02/11? Indeed the special cases changes are introduced by
02/11. Re-designing 02/11 will solve those special cases issues.

Thanks,
Jean

>
> Thanks,
> Rafael
>
>
>> ---
>> =A0drivers/base/power/main.c =A0 =A0 | =A0 =A08 +++--
>> =A0include/linux/pm.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0include/linux/pm_qos_params.h | =A0 =A02 +
>> =A0kernel/pm_qos_params.c =A0 =A0 =A0 =A0| =A0 70 ++++++++++++++++++=
++++++++++++++--------
>> =A04 files changed, 64 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index b1fd96b..51f5526 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -27,6 +27,7 @@
>> =A0#include <linux/sched.h>
>> =A0#include <linux/async.h>
>> =A0#include <linux/suspend.h>
>> +#include <linux/pm_qos_params.h>
>>
>> =A0#include "../base.h"
>> =A0#include "power.h"
>> @@ -96,8 +97,8 @@ void device_pm_add(struct device *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(dev->parent));
>> =A0 =A0 =A0 list_add_tail(&dev->power.entry, &dpm_list);
>> =A0 =A0 =A0 mutex_unlock(&dpm_list_mtx);
>> - =A0 =A0 /* ToDo: call PM QoS to init the per-device wakeup latency=
 constraints */
>> - =A0 =A0 plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->p=
ower.lock);
>> + =A0 =A0 /* Call PM QoS to init the per-device wakeup latency const=
raints */
>> + =A0 =A0 pm_qos_dev_wakeup_lat_init(dev);
>> =A0}
>>
>> =A0/**
>> @@ -108,7 +109,8 @@ void device_pm_remove(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 pr_debug("PM: Removing info for %s:%s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->bus ? dev->bus->name : "No Bus",=
 dev_name(dev));
>> - =A0 =A0 /* ToDo: call PM QoS to de-init the per-device wakeup late=
ncy constraints */
>> + =A0 =A0 /* Call PM QoS to de-init the per-device wakeup latency co=
nstraints */
>> + =A0 =A0 pm_qos_dev_wakeup_lat_deinit(dev);
>> =A0 =A0 =A0 complete_all(&dev->power.completion);
>> =A0 =A0 =A0 mutex_lock(&dpm_list_mtx);
>> =A0 =A0 =A0 list_del_init(&dev->power.entry);
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index 35fe682..d9b6092 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -464,6 +464,7 @@ struct dev_pm_info {
>> =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*subsys_data=
; =A0/* Owned by the subsystem. */
>> =A0#endif
>> =A0 =A0 =A0 struct plist_head =A0 =A0 =A0 wakeup_lat_plist_head;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wakeup_lat_ini=
t;
>> =A0};
>>
>> =A0extern void update_pm_runtime_accounting(struct device *dev);
>> diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_pa=
rams.h
>> index e6e16cb..5b6707a 100644
>> --- a/include/linux/pm_qos_params.h
>> +++ b/include/linux/pm_qos_params.h
>> @@ -45,4 +45,6 @@ int pm_qos_add_notifier(int class, struct notifier=
_block *notifier);
>> =A0int pm_qos_remove_notifier(int class, struct notifier_block *noti=
fier);
>> =A0int pm_qos_request_active(struct pm_qos_request_list *req);
>>
>> +void pm_qos_dev_wakeup_lat_init(struct device *dev);
>> +void pm_qos_dev_wakeup_lat_deinit(struct device *dev);
>> =A0#endif
>> diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
>> index d61c8e5..6f25ccb 100644
>> --- a/kernel/pm_qos_params.c
>> +++ b/kernel/pm_qos_params.c
>> @@ -275,11 +275,21 @@ void pm_qos_add_request(struct pm_qos_request_=
list *pm_qos_req,
>> =A0 =A0 =A0 struct pm_qos_object *o =3D =A0pm_qos_array[pm_qos_param=
s->class];
>> =A0 =A0 =A0 int new_value;
>>
>> - =A0 =A0 if ((pm_qos_params->class !=3D PM_QOS_DEV_WAKEUP_LATENCY) =
&&
>> - =A0 =A0 =A0 =A0 (pm_qos_request_active(pm_qos_req))) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_add_request() cal=
led for already "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"added request\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 if (pm_qos_params->class =3D=3D PM_QOS_DEV_WAKEUP_LATENCY)=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_qos_params->dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_a=
dd_request() called for "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "invalid d=
evice\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Silently return if the device is being =
released */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_qos_params->dev->power.wakeup_lat_=
init)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pm_qos_request_active(pm_qos_req)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_a=
dd_request() called for "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "already a=
dded request\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (pm_qos_params->value =3D=3D PM_QOS_DEFAULT_VALUE)
>> @@ -312,11 +322,16 @@ void pm_qos_update_request(struct pm_qos_reque=
st_list *pm_qos_req,
>> =A0 =A0 =A0 if (!pm_qos_req) /*guard against callers passing in null=
 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> - =A0 =A0 if ((pm_qos_req->class !=3D PM_QOS_DEV_WAKEUP_LATENCY) &&
>> - =A0 =A0 =A0 =A0 (!pm_qos_request_active(pm_qos_req))) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_update_request() =
called for unknown "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"object\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 if (pm_qos_req->class =3D=3D PM_QOS_DEV_WAKEUP_LATENCY) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Silently return if the device is being =
released */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_qos_req->dev->power.wakeup_lat_ini=
t)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_qos_request_active(pm_qos_req)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_u=
pdate_request() called "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for unkno=
wn object\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (new_value =3D=3D PM_QOS_DEFAULT_VALUE)
>> @@ -343,11 +358,16 @@ void pm_qos_remove_request(struct pm_qos_reque=
st_list *pm_qos_req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* silent return to keep pcm code cleane=
r */
>>
>> - =A0 =A0 if ((pm_qos_req->class !=3D PM_QOS_DEV_WAKEUP_LATENCY) &&
>> - =A0 =A0 =A0 =A0 (!pm_qos_request_active(pm_qos_req))) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_remove_request() =
called for unknown "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"object\n");
>> + =A0 =A0 if (pm_qos_req->class =3D=3D PM_QOS_DEV_WAKEUP_LATENCY) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Silently return if the device is being =
released */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_qos_req->dev->power.wakeup_lat_ini=
t)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_qos_request_active(pm_qos_req)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_r=
emove_request() called "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for unkno=
wn object\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 update_target(pm_qos_req, 1, PM_QOS_DEFAULT_VALUE);
>> @@ -393,6 +413,28 @@ int pm_qos_remove_notifier(int class, struct no=
tifier_block *notifier)
>> =A0}
>> =A0EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
>>
>> +/* Called from the device PM subsystem at device init */
>> +void pm_qos_dev_wakeup_lat_init(struct device *dev)
>> +{
>> + =A0 =A0 plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->p=
ower.lock);
>> + =A0 =A0 dev->power.wakeup_lat_init =3D 1;
>> +}
>> +
>> +/* Called from the device PM subsystem at device release */
>> +void pm_qos_dev_wakeup_lat_deinit(struct device *dev)
>> +{
>> + =A0 =A0 struct pm_qos_request_list *req, *tmp;
>> +
>> + =A0 =A0 dev->power.wakeup_lat_init =3D 0;
>> +
>> + =A0 =A0 /* Flush the constraints list for the device */
>> + =A0 =A0 plist_for_each_entry_safe(req, tmp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &dev->=
power.wakeup_lat_plist_head,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list)
>> + =A0 =A0 =A0 =A0 =A0 =A0 update_target(req, 1, PM_QOS_DEFAULT_VALUE=
);
>> + =A0 =A0 plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->p=
ower.lock);
>> +}
>> +
>> =A0static int pm_qos_power_open(struct inode *inode, struct file *fi=
lp)
>> =A0{
>> =A0 =A0 =A0 struct pm_qos_parameters pm_qos_params;
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
