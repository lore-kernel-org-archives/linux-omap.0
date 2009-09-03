From: "Wang Limei-E12499" <E12499@motorola.com>
Subject: RE: Linux-omap PM: Fix dead lock condition in resource_release(vdd1_opp)
Date: Fri, 4 Sep 2009 02:10:21 +0800
Message-ID: <DF4DCBD3DB270B419320B577AC0C3C860304F1B5@zmy16exm62.ds.mot.com>
References: <DF4DCBD3DB270B419320B577AC0C3C8602F4801A@zmy16exm62.ds.mot.com> <DF4DCBD3DB270B419320B577AC0C3C8602F48030@zmy16exm62.ds.mot.com> <87ws5bk58n.fsf@deeprootsystems.com> <DF4DCBD3DB270B419320B577AC0C3C8602F94E6B@zmy16exm62.ds.mot.com> <87d46zoojb.fsf@deeprootsystems.com> <DF4DCBD3DB270B419320B577AC0C3C8602F95260@zmy16exm62.ds.mot.com> <DF4DCBD3DB270B419320B577AC0C3C8602F95518@zmy16exm62.ds.mot.com> <87ocqdi2oa.fsf@deeprootsystems.com> <8bb80c380909022045xb5bf4f1kc472f6575756ab5b@mail.gmail.com> <87eiqoxh3r.fsf@deeprootsystems.com> <8bb80c380909031045m2112136dte10e0e9879105bce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail119.messagelabs.com ([216.82.241.195]:42569 "EHLO
	mail119.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756035AbZICSKq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 14:10:46 -0400
Received: from il27exr04.cig.mot.com (il27exr04.mot.com [10.17.196.73])
	by motgate4.mot.com (8.14.3/8.14.3) with ESMTP id n83IAk1t024059
	for <linux-omap@vger.kernel.org>; Thu, 3 Sep 2009 11:10:46 -0700 (MST)
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by il27exr04.cig.mot.com (8.13.1/Vontu) with SMTP id n83IAjqG018742
	for <linux-omap@vger.kernel.org>; Thu, 3 Sep 2009 13:10:45 -0500 (CDT)
Received: from zmy16exm62.ds.mot.com (zmy16exm62.ap.mot.com [10.179.4.33])
	by il27exr04.cig.mot.com (8.13.1/8.13.0) with ESMTP id n83IAhZs018728
	for <linux-omap@vger.kernel.org>; Thu, 3 Sep 2009 13:10:44 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <8bb80c380909031045m2112136dte10e0e9879105bce@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Wang Sawsd-A24013 <cqwang@motorola.com>, Wang Limei-E12499 <E12499@motorola.com>

=20


Hi Mike,

Actually chunqiu and I still have this problem, if you can push out the=
 patch, that will be good. =20
=20
Thanks,
Limei

-----Original Message-----
=46rom: Mike Chan [mailto:mike@android.com]=20
Sent: Thursday, September 03, 2009 12:45 PM
To: Kevin Hilman
Cc: Wang Limei-E12499; linux-omap@vger.kernel.org; Wang Sawsd-A24013
Subject: Re: Linux-omap PM: Fix dead lock condition in resource_release=
(vdd1_opp)

On Thu, Sep 3, 2009 at 7:01 AM, Kevin Hilman<khilman@deeprootsystems.co=
m> wrote:
> Mike Chan <mike@android.com> writes:
>
>> On Tue, Aug 18, 2009 at 8:04 AM, Kevin=20
>> Hilman<khilman@deeprootsystems.com> wrote:
>>> "Wang Limei-E12499" <E12499@motorola.com> writes:
>>>
>>>> Seems like I did not submit the patch in the right way, before I=20
>>>> setup my mail correctly, attach the patches in the mail.
>>>
>>> You're patches are still line-wrapped.
>>>
>>> I strongly recommend using git-format-patch and git-send-email to=20
>>> submit patches. Chunqiu was able to do this. =A0Please consult him.
>>>
>>> Also, no need to CC linux-omap-owner. =A0linux-omap is all that is =
needed.
>>>
>>
>> This patch has been reviewed and merged into our android-omap-2.6.29=
=20
>> tree
>> http://android.git.kernel.org/?p=3Dkernel/omap.git;a=3Dcommit;h=3D0b=
6a9b651
>> 4c7ccfa0c76e4defdaea3dcbc617633
>
> Hmm, I don't see any other review/signoff that the authors on that=20
> link.
>

Apologies, I was not aware of the reviewed-by policy but will keep that=
 in mind for future patches we pull into our branch. In general any pat=
ches that have been applied to the android-omap-2.6.29 tree have gone u=
nder some review/testing.

>> Kevin if you're having line wrap problems feel free to pull it from=20
>> here, assuming everyone's feedback has been addressed
>
> It's not me who has the line-wrap problem. I could unwrap pretty=20
> easily myself, but it gets very old working around various email=20
> client problems, so I choose to reject patches until they can be sent=
=20
> in a usable form.
>
> I'm still waiting for this so it can get a full review on-list.
>

Very understandable, if Chunqiu is still having problems I can push one=
 out to l-o for review on behalf of Chinqiu. Its in our best interest t=
o get this into mainline so we have less 1-off's to maintain.

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
c
>>>> h
>>>>
>>>> From b4e9cc01f9d1aaeec39cc1ee794e5efaec61c781 Mon Sep 17 00:00:00=20
>>>> 2001
>>>> From: Chunqiu Wang <cqwang@motorola.com>
>>>> Date: Fri, 14 Aug 2009 17:34:32 +0800
>>>> Subject: [PATCH] Add per-resource mutex for OMAP resource framewor=
k
>>>>
>>>> Current OMAP resource fwk uses a global res_mutex for=20
>>>> resource_request and resource_release calls for all the available=20
>>>> resources.It may cause dead lock if=20
>>>> resource_request/resource_release is called recursively.
>>>>
>>>> For current OMAP3 VDD1/VDD2 resource, the change_level=20
>>>> implementation is mach-omap2/resource34xx.c/set_opp(),
>>>> when using resource_release to remove vdd1 constraint, this=20
>>>> function may call resource_release again to release
>>>> Vdd2 constrait if target vdd1 level is less than OPP3.
>>>> in this scenario, the global res_mutex down operation will be=20
>>>> called again, this will cause the second down operation hang there=
=2E
>>>>
>>>> To fix the problem, per-resource mutex is added to avoid hangup=20
>>>> when resource_request/resource_release is called recursively.
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
>>>> diff --git a/arch/arm/plat-omap/resource.c=20
>>>> b/arch/arm/plat-omap/resource.c index ec31727..5eae4e8 100644
>>>> --- a/arch/arm/plat-omap/resource.c
>>>> +++ b/arch/arm/plat-omap/resource.c
>>>> @@ -264,6 +264,7 @@ int resource_register(struct shared_resource=20
>>>> *resp)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EEXIST;
>>>>
>>>> =A0 =A0 =A0 INIT_LIST_HEAD(&resp->users_list);
>>>> + =A0 =A0 mutex_init(&resp->resource_mutex);
>>>>
>>>> =A0 =A0 =A0 down(&res_mutex);
>>>> =A0 =A0 =A0 /* Add the resource to the resource list */ @@ -326,14=
=20
>>>> +327,14 @@ int resource_request(const char *name, struct device=20
>>>> *dev,
>>>> =A0 =A0 =A0 struct =A0users_list *user;
>>>> =A0 =A0 =A0 int =A0 =A0 found =3D 0, ret =3D 0;
>>>>
>>>> - =A0 =A0 down(&res_mutex);
>>>> - =A0 =A0 resp =3D _resource_lookup(name);
>>>> + =A0 =A0 resp =3D resource_lookup(name);
>>>> =A0 =A0 =A0 if (!resp) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "resource_request: Inv=
alid resource=20
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
, level); @@=20
>>>> -362,7 +363,7 @@ int resource_request(const char *name, struct=20
>>>> device *dev,
>>>> =A0 =A0 =A0 user->level =3D level;
>>>>
>>>> =A0res_unlock:
>>>> - =A0 =A0 up(&res_mutex);
>>>> + =A0 =A0 mutex_unlock(&resp->resource_mutex);
>>>> =A0 =A0 =A0 /*
>>>> =A0 =A0 =A0 =A0* Recompute and set the current level for the resou=
rce.
>>>> =A0 =A0 =A0 =A0* NOTE: update_resource level moved out of spin_loc=
k, as it=20
>>>> may call @@ -371,6 +372,7 @@ res_unlock:
>>>> =A0 =A0 =A0 =A0*/
>>>> =A0 =A0 =A0 if (!ret)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D update_resource_level(resp);
>>>> +ret:
>>>> =A0 =A0 =A0 return ret;
>>>> =A0}
>>>> =A0EXPORT_SYMBOL(resource_request);
>>>> @@ -393,14 +395,14 @@ int resource_release(const char *name, struc=
t=20
>>>> device *dev)
>>>> =A0 =A0 =A0 struct users_list *user;
>>>> =A0 =A0 =A0 int found =3D 0, ret =3D 0;
>>>>
>>>> - =A0 =A0 down(&res_mutex);
>>>> - =A0 =A0 resp =3D _resource_lookup(name);
>>>> + =A0 =A0 resp =3D resource_lookup(name);
>>>> =A0 =A0 =A0 if (!resp) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "resource_release: Inv=
alid resource=20
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
>>>> @@ -421,7 +423,9 @@ int resource_release(const char *name, struct=20
>>>> device
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
alid resource=20
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
a
>>>> tch
>>>>
>>>>
>>>> From 9cc371b5d7f2e049fe72bc946dcb8ec8e1de826c Mon Sep 17 00:00:00=20
>>>> 2001
>>>> From: Chunqiu Wang <cqwang@motorola.com>
>>>> Date: Fri, 14 Aug 2009 17:43:13 +0800
>>>> Subject: [PATCH] Move the resource level update into mutex_lock bl=
ock.
>>>>
>>>> The update_resource_level is called outside of the mutex lock=20
>>>> protection block due to an out of date spin lock mechanism, now=20
>>>> mutex is used, so move the update_resource_level into mutex=20
>>>> protection block.
>>>>
>>>> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
>>>> ---
>>>> =A0arch/arm/plat-omap/resource.c | =A0 11 +++--------
>>>> =A01 files changed, 3 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/arm/plat-omap/resource.c=20
>>>> b/arch/arm/plat-omap/resource.c index 5eae4e8..e2a003a 100644
>>>> --- a/arch/arm/plat-omap/resource.c
>>>> +++ b/arch/arm/plat-omap/resource.c
>>>> @@ -362,16 +362,11 @@ int resource_request(const char *name, struc=
t=20
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
 as it=20
>>>> may call
>>>> - =A0 =A0 =A0* pm_qos_add_requirement, which does a kzmalloc. This=
 won't=20
>>>> be allowed
>>>> - =A0 =A0 =A0* in iterrupt context. The spin_lock still protects=20
>>>> add/remove users.
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
l=20
>>>> try to be better in the future.
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
=20
>>>> Wang
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
>>>>> I agreed with you, thanks Kevin and Romit for the comments! =A0=20
>>>>> Chunqiu Wang coded resource-based mutex, below is the patch. Pls=20
>>>>> review and let us know your feedback.
>>>>>
>>>>>
>>>>> From 31f87ffb8eb1f854a9adb7fd96011d490f4655fa Mon Sep 17 00:00:00=
=20
>>>>> 2001
>>>>> From: Chunqiu Wang <cqwang@motorola.com>
>>>>> Date: Wed, 12 Aug 2009 16:22:09 +0800
>>>>> Subject: [PATCH] Fix resource framework mutex lock issue when=20
>>>>> resource_get or resource_release are called nestedly.
>>>>>
>>>>
>>>> Could use a shorter summary (subject) and a more detailed changelo=
g.
>>>>
>>>> This patch is doing too many things in a single patch without=20
>>>> enough explanation.
>>>>
>>>> Not only does it convert the global semaphore to a=20
>>>> resource-specific semaphore, but it also changing the locking=20
>>>> slightly by moving some things in/out of lock protection. =A0That=20
>>>> should be described in the changelog as well.
>>>>
>>>> Even better would be a first patch that simply converts the=20
>>>> semaphore to a resource-specific *mutex* (not resource-specific=20
>>>> semaphore.) =A0IOW, use mutex API in <linux/mutex.h>:
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
>>>>> diff --git a/arch/arm/plat-omap/resource.c=20
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
=20
>>>>> +327,14
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
, level); @@=20
>>>>> -361,16
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
s it=20
>>>>> may call
>>>>> - =A0 =A0 * pm_qos_add_requirement, which does a kzmalloc. This w=
on't=20
>>>>> be allowed
>>>>> - =A0 =A0 * in iterrupt context. The spin_lock still protects=20
>>>>> add/remove users.
>>>>> - =A0 =A0 */
>>>>> - =A0 =A0if (!ret)
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0ret =3D update_resource_level(resp);
>>>>> + =A0 =A0up(&resp->resource_mutex);
>>>>> +
>>>>> +ret:
>>>>> =A0 =A0 =A0return ret;
>>>>> =A0}
>>>>> =A0EXPORT_SYMBOL(resource_request);
>>>>> @@ -393,14 +390,14 @@ int resource_release(const char *name,=20
>>>>> struct device *dev)
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
>>>>> @@ -421,7 +418,9 @@ int resource_release(const char *name, struct=
=20
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
pm.
>>>>>> git; a =3Ds hortlog;h=3Dpm-2.6.29> =A0branch,found a dead lock=20
>>>>>> condition in:
>>>>>> arch/arm/plat-omap/resource.c->resource_release().
>>>>>>
>>>>>> The dead lock happens when using
>>>>>> resource_request("vdd1_opp",&dev,...)
>>>>>> and resource_release("vdd1_opp", &dev) to set and release vdd1=20
>>>>>> opp constraint. The =A0scenario is:
>>>>>>
>>>>>> plat-omap/resource.c/resource_release("vdd1_opp",
>>>>>> &dev)=3D=3D>resource.c/update_resource_level()=3D>mach-omap2/res=
ource34
>>>>>> xx.c / se t_opp(). =A0In set_opp(), =A0if the target_level of vd=
d1 is=20
>>>>>> less than OPP3,will release the constraint set on VDD2 by callin=
g=20
>>>>>> resource_release(), but it will never return because can not get=
=20
>>>>>> the mutex which is holding =A0by the previous caller.
>>>>>>
>>>>>> int resource_release(const char *name, struct device *dev) { =A0=
 =A0 =A0 =A0 =A0=20
>>>>>> .......
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
=20
>>>>>> let me know your feedback?
>>>>>>
>>>>>> From: Limei Wang <e12499@motorola.com>
>>>>>> Date: Fri, 7 Aug 2009 11:40:35 -0500
>>>>>> Subject: [PATCH] OMAP PM: Fix dead lock bug in=20
>>>>>> resourc_release(vdd1_opp).
>>>>>>
>>>>>>
>>>>>> Signed-off-by: Limei Wang <e12499@motorola.com>
>>>>>> ---
>>>>>> =A0arch/arm/plat-omap/resource.c | =A0 =A06 ++++--
>>>>>> =A01 files changed, 4 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/plat-omap/resource.c=20
>>>>>> b/arch/arm/plat-omap/resource.c index ec31727..876fd12 100644
>>>>>> --- a/arch/arm/plat-omap/resource.c
>>>>>> +++ b/arch/arm/plat-omap/resource.c
>>>>>> @@ -418,10 +418,12 @@ int resource_release(const char *name,=20
>>>>>> struct device *dev)
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
>>>>> First, you're not fixing the problem, you're just moving the call=
=20
>>>>> outside of the lock, thus creating other locking problems.
>>>>>
>>>>> Second, the various error paths would break because
>>>>> update_resource_level() would be called on the 'res_unlock' error=
=20
>>>>> path
>>>>
>>>>> where it is not currently being called.
>>>>>
>>>>> A per-resource mutex as suggest by Romit seems like the right=20
>>>>> approach
>>>>
>>>>> to fixing this problem.
>>>>>
>>>>> Kevin
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe=20
>>> linux-omap" in the body of a message to majordomo@vger.kernel.org=20
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
