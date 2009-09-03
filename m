From: Mike Chan <mike@android.com>
Subject: Re: Linux-omap PM: Fix dead lock condition in resource_release(vdd1_opp)
Date: Thu, 3 Sep 2009 10:45:28 -0700
Message-ID: <8bb80c380909031045m2112136dte10e0e9879105bce@mail.gmail.com>
References: <DF4DCBD3DB270B419320B577AC0C3C8602F4801A@zmy16exm62.ds.mot.com>
	 <DF4DCBD3DB270B419320B577AC0C3C8602F48030@zmy16exm62.ds.mot.com>
	 <87ws5bk58n.fsf@deeprootsystems.com>
	 <DF4DCBD3DB270B419320B577AC0C3C8602F94E6B@zmy16exm62.ds.mot.com>
	 <87d46zoojb.fsf@deeprootsystems.com>
	 <DF4DCBD3DB270B419320B577AC0C3C8602F95260@zmy16exm62.ds.mot.com>
	 <DF4DCBD3DB270B419320B577AC0C3C8602F95518@zmy16exm62.ds.mot.com>
	 <87ocqdi2oa.fsf@deeprootsystems.com>
	 <8bb80c380909022045xb5bf4f1kc472f6575756ab5b@mail.gmail.com>
	 <87eiqoxh3r.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:43425 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbZICRp2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 13:45:28 -0400
Received: by vws33 with SMTP id 33so136940vws.33
        for <linux-omap@vger.kernel.org>; Thu, 03 Sep 2009 10:45:29 -0700 (PDT)
In-Reply-To: <87eiqoxh3r.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Wang Limei-E12499 <E12499@motorola.com>, linux-omap@vger.kernel.org, Chunqiu Wang <cqwang@motorola.com>

On Thu, Sep 3, 2009 at 7:01 AM, Kevin Hilman<khilman@deeprootsystems.co=
m> wrote:
> Mike Chan <mike@android.com> writes:
>
>> On Tue, Aug 18, 2009 at 8:04 AM, Kevin
>> Hilman<khilman@deeprootsystems.com> wrote:
>>> "Wang Limei-E12499" <E12499@motorola.com> writes:
>>>
>>>> Seems like I did not submit the patch in the right way, before I s=
etup
>>>> my mail correctly, attach the patches in the mail.
>>>
>>> You're patches are still line-wrapped.
>>>
>>> I strongly recommend using git-format-patch and git-send-email to
>>> submit patches. Chunqiu was able to do this. =A0Please consult him.
>>>
>>> Also, no need to CC linux-omap-owner. =A0linux-omap is all that is =
needed.
>>>
>>
>> This patch has been reviewed and merged into our android-omap-2.6.29=
 tree
>> http://android.git.kernel.org/?p=3Dkernel/omap.git;a=3Dcommit;h=3D0b=
6a9b6514c7ccfa0c76e4defdaea3dcbc617633
>
> Hmm, I don't see any other review/signoff that the authors on that
> link.
>

Apologies, I was not aware of the reviewed-by policy but will keep
that in mind for future patches we pull into our branch. In general
any patches that have been applied to the android-omap-2.6.29 tree
have gone under some review/testing.

>> Kevin if you're having line wrap problems feel free to pull it from
>> here, assuming everyone's feedback has been addressed
>
> It's not me who has the line-wrap problem. I could unwrap pretty
> easily myself, but it gets very old working around various email
> client problems, so I choose to reject patches until they can be sent
> in a usable form.
>
> I'm still waiting for this so it can get a full review on-list.
>

Very understandable, if Chunqiu is still having problems I can push
one out to l-o for review on behalf of Chinqiu. Its in our best
interest to get this into mainline so we have less 1-off's to
maintain.

--Mike

> Thanks,
>
> Kevin
>
>>
>>> Thanks,
>>>
>>> Kevin
>>>
>>>
>>>> PATCH1:0001-Add-per-resource-mutex-for-OMAP-resource-framework.pat=
ch
>>>>
>>>> From b4e9cc01f9d1aaeec39cc1ee794e5efaec61c781 Mon Sep 17 00:00:00 =
2001
>>>> From: Chunqiu Wang <cqwang@motorola.com>
>>>> Date: Fri, 14 Aug 2009 17:34:32 +0800
>>>> Subject: [PATCH] Add per-resource mutex for OMAP resource framewor=
k
>>>>
>>>> Current OMAP resource fwk uses a global res_mutex
>>>> for resource_request and resource_release calls
>>>> for all the available resources.It may cause dead
>>>> lock if resource_request/resource_release is called
>>>> recursively.
>>>>
>>>> For current OMAP3 VDD1/VDD2 resource, the change_level
>>>> implementation is mach-omap2/resource34xx.c/set_opp(),
>>>> when using resource_release to remove vdd1 constraint,
>>>> this function may call resource_release again to release
>>>> Vdd2 constrait if target vdd1 level is less than OPP3.
>>>> in this scenario, the global res_mutex down operation
>>>> will be called again, this will cause the second
>>>> down operation hang there.
>>>>
>>>> To fix the problem, per-resource mutex is added
>>>> to avoid hangup when resource_request/resource_release
>>>> is called recursively.
>>>>
>>>> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
>>>> ---
>>>> =A0arch/arm/plat-omap/include/mach/resource.h | =A0 =A02 ++
>>>> =A0arch/arm/plat-omap/resource.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
27
>>>> +++++++++++++++------------
>>>> =A02 files changed, 17 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/arch/arm/plat-omap/include/mach/resource.h
>>>> b/arch/arm/plat-omap/include/mach/resource.h
>>>> index f91d8ce..d482fb8 100644
>>>> --- a/arch/arm/plat-omap/include/mach/resource.h
>>>> +++ b/arch/arm/plat-omap/include/mach/resource.h
>>>> @@ -46,6 +46,8 @@ struct shared_resource {
>>>> =A0 =A0 =A0 /* Shared resource operations */
>>>> =A0 =A0 =A0 struct shared_resource_ops *ops;
>>>> =A0 =A0 =A0 struct list_head node;
>>>> + =A0 =A0 /* Protect each resource */
>>>> + =A0 =A0 struct mutex resource_mutex;
>>>> =A0};
>>>>
>>>> =A0struct shared_resource_ops {
>>>> diff --git a/arch/arm/plat-omap/resource.c
>>>> b/arch/arm/plat-omap/resource.c
>>>> index ec31727..5eae4e8 100644
>>>> --- a/arch/arm/plat-omap/resource.c
>>>> +++ b/arch/arm/plat-omap/resource.c
>>>> @@ -264,6 +264,7 @@ int resource_register(struct shared_resource *=
resp)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EEXIST;
>>>>
>>>> =A0 =A0 =A0 INIT_LIST_HEAD(&resp->users_list);
>>>> + =A0 =A0 mutex_init(&resp->resource_mutex);
>>>>
>>>> =A0 =A0 =A0 down(&res_mutex);
>>>> =A0 =A0 =A0 /* Add the resource to the resource list */
>>>> @@ -326,14 +327,14 @@ int resource_request(const char *name, struc=
t
>>>> device *dev,
>>>> =A0 =A0 =A0 struct =A0users_list *user;
>>>> =A0 =A0 =A0 int =A0 =A0 found =3D 0, ret =3D 0;
>>>>
>>>> - =A0 =A0 down(&res_mutex);
>>>> - =A0 =A0 resp =3D _resource_lookup(name);
>>>> + =A0 =A0 resp =3D resource_lookup(name);
>>>> =A0 =A0 =A0 if (!resp) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "resource_request: Inv=
alid resource
>>>> name\n");
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 goto res_unlock;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 goto ret;
>>>> =A0 =A0 =A0 }
>>>>
>>>> + =A0 =A0 mutex_lock(&resp->resource_mutex);
>>>> =A0 =A0 =A0 /* Call the resource specific validate function */
>>>> =A0 =A0 =A0 if (resp->ops->validate_level) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D resp->ops->validate_level(resp=
, level);
>>>> @@ -362,7 +363,7 @@ int resource_request(const char *name, struct =
device
>>>> *dev,
>>>> =A0 =A0 =A0 user->level =3D level;
>>>>
>>>> =A0res_unlock:
>>>> - =A0 =A0 up(&res_mutex);
>>>> + =A0 =A0 mutex_unlock(&resp->resource_mutex);
>>>> =A0 =A0 =A0 /*
>>>> =A0 =A0 =A0 =A0* Recompute and set the current level for the resou=
rce.
>>>> =A0 =A0 =A0 =A0* NOTE: update_resource level moved out of spin_loc=
k, as it may
>>>> call
>>>> @@ -371,6 +372,7 @@ res_unlock:
>>>> =A0 =A0 =A0 =A0*/
>>>> =A0 =A0 =A0 if (!ret)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D update_resource_level(resp);
>>>> +ret:
>>>> =A0 =A0 =A0 return ret;
>>>> =A0}
>>>> =A0EXPORT_SYMBOL(resource_request);
>>>> @@ -393,14 +395,14 @@ int resource_release(const char *name, struc=
t
>>>> device *dev)
>>>> =A0 =A0 =A0 struct users_list *user;
>>>> =A0 =A0 =A0 int found =3D 0, ret =3D 0;
>>>>
>>>> - =A0 =A0 down(&res_mutex);
>>>> - =A0 =A0 resp =3D _resource_lookup(name);
>>>> + =A0 =A0 resp =3D resource_lookup(name);
>>>> =A0 =A0 =A0 if (!resp) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "resource_release: Inv=
alid resource
>>>> name\n");
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 goto res_unlock;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 goto ret;
>>>> =A0 =A0 =A0 }
>>>>
>>>> + =A0 =A0 mutex_lock(&resp->resource_mutex);
>>>> =A0 =A0 =A0 list_for_each_entry(user, &resp->users_list, node) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (user->dev =3D=3D dev) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D 1;
>>>> @@ -421,7 +423,9 @@ int resource_release(const char *name, struct =
device
>>>> *dev)
>>>> =A0 =A0 =A0 /* Recompute and set the current level for the resourc=
e */
>>>> =A0 =A0 =A0 ret =3D update_resource_level(resp);
>>>> =A0res_unlock:
>>>> - =A0 =A0 up(&res_mutex);
>>>> + =A0 =A0 mutex_unlock(&resp->resource_mutex);
>>>> +
>>>> +ret:
>>>> =A0 =A0 =A0 return ret;
>>>> =A0}
>>>> =A0EXPORT_SYMBOL(resource_release);
>>>> @@ -438,15 +442,14 @@ int resource_get_level(const char *name)
>>>> =A0 =A0 =A0 struct shared_resource *resp;
>>>> =A0 =A0 =A0 u32 ret;
>>>>
>>>> - =A0 =A0 down(&res_mutex);
>>>> - =A0 =A0 resp =3D _resource_lookup(name);
>>>> + =A0 =A0 resp =3D resource_lookup(name);
>>>> =A0 =A0 =A0 if (!resp) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "resource_release: Inv=
alid resource
>>>> name\n");
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 up(&res_mutex);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>>> =A0 =A0 =A0 }
>>>> + =A0 =A0 mutex_lock(&resp->resource_mutex);
>>>> =A0 =A0 =A0 ret =3D resp->curr_level;
>>>> - =A0 =A0 up(&res_mutex);
>>>> + =A0 =A0 mutex_unlock(&resp->resource_mutex);
>>>> =A0 =A0 =A0 return ret;
>>>> =A0}
>>>> =A0EXPORT_SYMBOL(resource_get_level);
>>>> --
>>>> 1.5.4.3
>>>>
>>>> PATCH2:0002-Move-the-resource-level-update-into-mutex_lock-block.p=
atch
>>>>
>>>>
>>>> From 9cc371b5d7f2e049fe72bc946dcb8ec8e1de826c Mon Sep 17 00:00:00 =
2001
>>>> From: Chunqiu Wang <cqwang@motorola.com>
>>>> Date: Fri, 14 Aug 2009 17:43:13 +0800
>>>> Subject: [PATCH] Move the resource level update into mutex_lock bl=
ock.
>>>>
>>>> The update_resource_level is called outside of
>>>> the mutex lock protection block due to an out of date
>>>> spin lock mechanism, now mutex is used, so move
>>>> the update_resource_level into mutex protection block.
>>>>
>>>> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
>>>> ---
>>>> =A0arch/arm/plat-omap/resource.c | =A0 11 +++--------
>>>> =A01 files changed, 3 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/arm/plat-omap/resource.c
>>>> b/arch/arm/plat-omap/resource.c
>>>> index 5eae4e8..e2a003a 100644
>>>> --- a/arch/arm/plat-omap/resource.c
>>>> +++ b/arch/arm/plat-omap/resource.c
>>>> @@ -362,16 +362,11 @@ int resource_request(const char *name, struc=
t
>>>> device *dev,
>>>> =A0 =A0 =A0 }
>>>> =A0 =A0 =A0 user->level =3D level;
>>>>
>>>> + =A0 =A0 /* Recompute and set the current level for the resource =
*/
>>>> + =A0 =A0 ret =3D update_resource_level(resp);
>>>> +
>>>> =A0res_unlock:
>>>> =A0 =A0 =A0 mutex_unlock(&resp->resource_mutex);
>>>> - =A0 =A0 /*
>>>> - =A0 =A0 =A0* Recompute and set the current level for the resourc=
e.
>>>> - =A0 =A0 =A0* NOTE: update_resource level moved out of spin_lock,=
 as it may
>>>> call
>>>> - =A0 =A0 =A0* pm_qos_add_requirement, which does a kzmalloc. This=
 won't be
>>>> allowed
>>>> - =A0 =A0 =A0* in iterrupt context. The spin_lock still protects a=
dd/remove
>>>> users.
>>>> - =A0 =A0 =A0*/
>>>> - =A0 =A0 if (!ret)
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D update_resource_level(resp);
>>>> =A0ret:
>>>> =A0 =A0 =A0 return ret;
>>>> =A0}
>>>> --
>>>> 1.5.4.3
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Wang Limei-E12499
>>>> Sent: Monday, August 17, 2009 11:13 AM
>>>> To: 'khilman@deeprootsystems.com'
>>>> Cc: Wang Limei-E12499; Wang Sawsd-A24013
>>>> Subject: RE: Linux-omap PM: Fix dead lock condition in
>>>> resource_release(vdd1_opp)
>>>>
>>>>
>>>> Kevin,
>>>>
>>>> Seems like I did not submit the patch in the recommended way,I wil=
l try
>>>> to be better in the future.
>>>>
>>>> If you can review =A0the patch and feedback, I will apperciate it.
>>>>
>>>> Thanks,
>>>> Limei
>>>>
>>>> -----Original Message-----
>>>> From: Wang Limei-E12499
>>>> Sent: Friday, August 14, 2009 5:44 PM
>>>> To: Kevin Hilman
>>>> Cc: Romit Dasgupta; linux-omap@vger.kernel.org; Wang Sawsd-A24013;=
 Wang
>>>> Limei-E12499
>>>> Subject: RE: Linux-omap PM: Fix dead lock condition in
>>>> resource_release(vdd1_opp)
>>>>
>>>>
>>>> Kevin,
>>>>
>>>> Thanks for reviewing the patch.
>>>>
>>>> Chunqiu and I revised the patch. Pls see the attachment.
>>>>
>>>>
>>>> Thanks,
>>>> Limei,chunqiu
>>>>
>>>> -----Original Message-----
>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>> Sent: Thursday, August 13, 2009 8:02 AM
>>>> To: Wang Limei-E12499
>>>> Cc: Romit Dasgupta; linux-omap@vger.kernel.org; Wang Sawsd-A24013
>>>> Subject: Re: Linux-omap PM: Fix dead lock condition in
>>>> resource_release(vdd1_opp)
>>>>
>>>> "Wang Limei-E12499" <E12499@motorola.com> writes:
>>>>
>>>>>
>>>>> Kevin and Romit,
>>>>>
>>>>> I agreed with you, thanks Kevin and Romit for the comments! =A0 C=
hunqiu
>>>>> Wang coded resource-based mutex, below is the patch. Pls review a=
nd
>>>>> let us know your feedback.
>>>>>
>>>>>
>>>>> From 31f87ffb8eb1f854a9adb7fd96011d490f4655fa Mon Sep 17 00:00:00=
 2001
>>>>> From: Chunqiu Wang <cqwang@motorola.com>
>>>>> Date: Wed, 12 Aug 2009 16:22:09 +0800
>>>>> Subject: [PATCH] Fix resource framework mutex lock issue when
>>>>> resource_get or resource_release are called nestedly.
>>>>>
>>>>
>>>> Could use a shorter summary (subject) and a more detailed changelo=
g.
>>>>
>>>> This patch is doing too many things in a single patch without enou=
gh
>>>> explanation.
>>>>
>>>> Not only does it convert the global semaphore to a resource-specif=
ic
>>>> semaphore, but it also changing the locking slightly by moving som=
e
>>>> things in/out of lock protection. =A0That should be described in t=
he
>>>> changelog as well.
>>>>
>>>> Even better would be a first patch that simply converts the semaph=
ore to
>>>> a resource-specific *mutex* (not resource-specific semaphore.) =A0=
IOW, use
>>>> mutex API in <linux/mutex.h>:
>>>>
>>>> =A0 struct mutex;
>>>> =A0 init_mutex()
>>>> =A0 mutex_lock()
>>>> =A0 mutex_unlock()
>>>> =A0 mutex_is_lockec()
>>>> =A0 ...
>>>>
>>>> Then, add a 2nd patch which does any reworking of the critical sec=
tions.
>>>>
>>>> Kevin
>>>>
>>>>
>>>>> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
>>>>> ---
>>>>> =A0arch/arm/plat-omap/include/mach/resource.h | =A0 =A02 +
>>>>> =A0arch/arm/plat-omap/resource.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 38
>>>>> +++++++++++++--------------
>>>>> =A02 files changed, 20 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/plat-omap/include/mach/resource.h
>>>>> b/arch/arm/plat-omap/include/mach/resource.h
>>>>> index f91d8ce..389cb67 100644
>>>>> --- a/arch/arm/plat-omap/include/mach/resource.h
>>>>> +++ b/arch/arm/plat-omap/include/mach/resource.h
>>>>> @@ -22,6 +22,7 @@
>>>>>
>>>>> =A0#include <linux/list.h>
>>>>> =A0#include <linux/mutex.h>
>>>>> +#include <linux/semaphore.h>
>>>>> =A0#include <linux/device.h>
>>>>> =A0#include <mach/cpu.h>
>>>>>
>>>>> @@ -46,6 +47,7 @@ struct shared_resource {
>>>>> =A0 =A0 =A0/* Shared resource operations */
>>>>> =A0 =A0 =A0struct shared_resource_ops *ops;
>>>>> =A0 =A0 =A0struct list_head node;
>>>>> + =A0 =A0struct semaphore resource_mutex;
>>>>> =A0};
>>>>>
>>>>> =A0struct shared_resource_ops {
>>>>> diff --git a/arch/arm/plat-omap/resource.c
>>>>> b/arch/arm/plat-omap/resource.c index ec31727..758a138 100644
>>>>> --- a/arch/arm/plat-omap/resource.c
>>>>> +++ b/arch/arm/plat-omap/resource.c
>>>>> @@ -264,6 +264,7 @@ int resource_register(struct shared_resource
>>>> *resp)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EEXIST;
>>>>>
>>>>> =A0 =A0 =A0INIT_LIST_HEAD(&resp->users_list);
>>>>> + =A0 =A0sema_init(&resp->resource_mutex, 1);
>>>>>
>>>>> =A0 =A0 =A0down(&res_mutex);
>>>>> =A0 =A0 =A0/* Add the resource to the resource list */ @@ -326,14=
 +327,14
>>>> @@
>>>>> int resource_request(const char *name, struct device *dev,
>>>>> =A0 =A0 =A0struct =A0users_list *user;
>>>>> =A0 =A0 =A0int =A0 =A0 found =3D 0, ret =3D 0;
>>>>>
>>>>> - =A0 =A0down(&res_mutex);
>>>>> - =A0 =A0resp =3D _resource_lookup(name);
>>>>> + =A0 =A0resp =3D resource_lookup(name);
>>>>> =A0 =A0 =A0if (!resp) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "resource_request: Inv=
alid resource
>>>> name\n");
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0goto res_unlock;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0goto ret;
>>>>> =A0 =A0 =A0}
>>>>>
>>>>> + =A0 =A0down(&resp->resource_mutex);
>>>>> =A0 =A0 =A0/* Call the resource specific validate function */
>>>>> =A0 =A0 =A0if (resp->ops->validate_level) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D resp->ops->validate_level(resp=
, level); @@ -361,16
>>>> +362,12 @@
>>>>> int resource_request(const char *name, struct device *dev,
>>>>> =A0 =A0 =A0}
>>>>> =A0 =A0 =A0user->level =3D level;
>>>>>
>>>>> + =A0 =A0/* Recompute and set the current level for the resource =
*/
>>>>> + =A0 =A0ret =3D update_resource_level(resp);
>>>>> =A0res_unlock:
>>>>> - =A0 =A0up(&res_mutex);
>>>>> - =A0 =A0/*
>>>>> - =A0 =A0 * Recompute and set the current level for the resource.
>>>>> - =A0 =A0 * NOTE: update_resource level moved out of spin_lock, a=
s it may
>>>>> call
>>>>> - =A0 =A0 * pm_qos_add_requirement, which does a kzmalloc. This w=
on't be
>>>>> allowed
>>>>> - =A0 =A0 * in iterrupt context. The spin_lock still protects add=
/remove
>>>>> users.
>>>>> - =A0 =A0 */
>>>>> - =A0 =A0if (!ret)
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0ret =3D update_resource_level(resp);
>>>>> + =A0 =A0up(&resp->resource_mutex);
>>>>> +
>>>>> +ret:
>>>>> =A0 =A0 =A0return ret;
>>>>> =A0}
>>>>> =A0EXPORT_SYMBOL(resource_request);
>>>>> @@ -393,14 +390,14 @@ int resource_release(const char *name, stru=
ct
>>>>> device *dev)
>>>>> =A0 =A0 =A0struct users_list *user;
>>>>> =A0 =A0 =A0int found =3D 0, ret =3D 0;
>>>>>
>>>>> - =A0 =A0down(&res_mutex);
>>>>> - =A0 =A0resp =3D _resource_lookup(name);
>>>>> + =A0 =A0resp =3D resource_lookup(name);
>>>>> =A0 =A0 =A0if (!resp) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "resource_release: Inv=
alid resource
>>>> name\n");
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0goto res_unlock;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0goto ret;
>>>>> =A0 =A0 =A0}
>>>>>
>>>>> + =A0 =A0down(&resp->resource_mutex);
>>>>> =A0 =A0 =A0list_for_each_entry(user, &resp->users_list, node) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0if (user->dev =3D=3D dev) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0found =3D 1;
>>>>> @@ -421,7 +418,9 @@ int resource_release(const char *name, struct
>>>>> device
>>>>> *dev)
>>>>> =A0 =A0 =A0/* Recompute and set the current level for the resourc=
e */
>>>>> =A0 =A0 =A0ret =3D update_resource_level(resp);
>>>>> =A0res_unlock:
>>>>> - =A0 =A0up(&res_mutex);
>>>>> + =A0 =A0up(&resp->resource_mutex);
>>>>> +
>>>>> +ret:
>>>>> =A0 =A0 =A0return ret;
>>>>> =A0}
>>>>> =A0EXPORT_SYMBOL(resource_release);
>>>>> @@ -438,15 +437,14 @@ int resource_get_level(const char *name)
>>>>> =A0 =A0 =A0struct shared_resource *resp;
>>>>> =A0 =A0 =A0u32 ret;
>>>>>
>>>>> - =A0 =A0down(&res_mutex);
>>>>> - =A0 =A0resp =3D _resource_lookup(name);
>>>>> + =A0 =A0resp =3D resource_lookup(name);
>>>>> =A0 =A0 =A0if (!resp) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "resource_release: Inv=
alid resource
>>>> name\n");
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0up(&res_mutex);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>>>> =A0 =A0 =A0}
>>>>> + =A0 =A0down(&resp->resource_mutex);
>>>>> =A0 =A0 =A0ret =3D resp->curr_level;
>>>>> - =A0 =A0up(&res_mutex);
>>>>> + =A0 =A0up(&resp->resource_mutex);
>>>>> =A0 =A0 =A0return ret;
>>>>> =A0}
>>>>> =A0EXPORT_SYMBOL(resource_get_level);
>>>>> --
>>>>> 1.5.4.3
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> -----Original Message-----
>>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>>> Sent: Monday, August 10, 2009 11:23 AM
>>>>> To: Wang Limei-E12499
>>>>> Cc: linux-omap@vger.kernel.org
>>>>> Subject: Re: Linux-omap PM: Fix dead lock condition in
>>>>> resource_release(vdd1_opp)
>>>>>
>>>>> "Wang Limei-E12499" <E12499@motorola.com> writes:
>>>>>
>>>>>> I am using linux-omap pm-2.6.29
>>>>>> <http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-=
pm.git;
>>>>>> a =3Ds hortlog;h=3Dpm-2.6.29> =A0branch,found a dead lock condit=
ion in:
>>>>>> arch/arm/plat-omap/resource.c->resource_release().
>>>>>>
>>>>>> The dead lock happens when using
>>>>>> resource_request("vdd1_opp",&dev,...)
>>>>>> and resource_release("vdd1_opp", &dev) to set and release vdd1 o=
pp
>>>>>> constraint. The =A0scenario is:
>>>>>>
>>>>>> plat-omap/resource.c/resource_release("vdd1_opp",
>>>>>> &dev)=3D=3D>resource.c/update_resource_level()=3D>mach-omap2/res=
ource34xx.c
>>>>>> / se t_opp(). =A0In set_opp(), =A0if the target_level of vdd1 is=
 less
>>>>>> than OPP3,will release the constraint set on VDD2 by calling
>>>>>> resource_release(), but it will never return because can not get=
 the
>>>>>> mutex which is holding =A0by the previous caller.
>>>>>>
>>>>>> int resource_release(const char *name, struct device *dev)
>>>>>> { =A0 =A0 =A0 =A0 =A0 .......
>>>>>> =A0 =A0 down(&res_mutex);
>>>>>> =A0 =A0 ........
>>>>>> =A0 =A0 /* Recompute and set the current level for the resource =
*/
>>>>>> =A0 =A0 ret =3D update_resource_level(resp);
>>>>>> res_unlock:
>>>>>> =A0 =A0 up(&res_mutex);
>>>>>> =A0 =A0 return ret;
>>>>>> }
>>>>>>
>>>>>> int set_opp(struct shared_resource *resp, u32 target_level) {
>>>>>> =A0 =A0 .....
>>>>>> =A0if (resp =3D=3D vdd1_resp) {
>>>>>> =A0 =A0 =A0 if (target_level < 3)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0resource_release("vdd2_opp", &vdd2_dev); =
}
>>>>>>
>>>>>> The patch to fix this issue is below, will you pls review it and=
 let
>>>>>> me know your feedback?
>>>>>>
>>>>>> From: Limei Wang <e12499@motorola.com>
>>>>>> Date: Fri, 7 Aug 2009 11:40:35 -0500
>>>>>> Subject: [PATCH] OMAP PM: Fix dead lock bug in
>>>>>> resourc_release(vdd1_opp).
>>>>>>
>>>>>>
>>>>>> Signed-off-by: Limei Wang <e12499@motorola.com>
>>>>>> ---
>>>>>> =A0arch/arm/plat-omap/resource.c | =A0 =A06 ++++--
>>>>>> =A01 files changed, 4 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/plat-omap/resource.c
>>>>>> b/arch/arm/plat-omap/resource.c index ec31727..876fd12 100644
>>>>>> --- a/arch/arm/plat-omap/resource.c
>>>>>> +++ b/arch/arm/plat-omap/resource.c
>>>>>> @@ -418,10 +418,12 @@ int resource_release(const char *name, str=
uct
>>>>>> device *dev)
>>>>>> =A0 =A0 list_del(&user->node);
>>>>>> =A0 =A0 free_user(user);
>>>>>>
>>>>>> - =A0 /* Recompute and set the current level for the resource */
>>>>>> - =A0 ret =3D update_resource_level(resp);
>>>>>> =A0res_unlock:
>>>>>> =A0 =A0 up(&res_mutex);
>>>>>> +
>>>>>> + =A0 /* Recompute and set the current level for the resource */
>>>>>> + =A0 if (!ret)
>>>>>> + =A0 =A0 =A0 ret =3D update_resource_level(resp);
>>>>>> =A0 =A0 return ret;
>>>>>> =A0}
>>>>>> =A0EXPORT_SYMBOL(resource_release);
>>>>>> --
>>>>>> 1.5.6.3
>>>>>
>>>>> This is wrong for several reasons.
>>>>>
>>>>> First, you're not fixing the problem, you're just moving the call
>>>>> outside of the lock, thus creating other locking problems.
>>>>>
>>>>> Second, the various error paths would break because
>>>>> update_resource_level() would be called on the 'res_unlock' error=
 path
>>>>
>>>>> where it is not currently being called.
>>>>>
>>>>> A per-resource mutex as suggest by Romit seems like the right app=
roach
>>>>
>>>>> to fixing this problem.
>>>>>
>>>>> Kevin
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
