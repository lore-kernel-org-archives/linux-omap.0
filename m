From: "Wang Limei-E12499" <E12499@motorola.com>
Subject: RE: Linux-omap PM:  Fix dead lock condition in resource_release(vdd1_opp)
Date: Sat, 15 Aug 2009 06:43:44 +0800
Message-ID: <DF4DCBD3DB270B419320B577AC0C3C8602F95260@zmy16exm62.ds.mot.com>
References: <DF4DCBD3DB270B419320B577AC0C3C8602F4801A@zmy16exm62.ds.mot.com><DF4DCBD3DB270B419320B577AC0C3C8602F48030@zmy16exm62.ds.mot.com><87ws5bk58n.fsf@deeprootsystems.com><DF4DCBD3DB270B419320B577AC0C3C8602F94E6B@zmy16exm62.ds.mot.com> <87d46zoojb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01CA1D31.350CD1D8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail153.messagelabs.com ([216.82.253.51]:11557 "EHLO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968AbZHNWrz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 18:47:55 -0400
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id n7EMlsp9015519
	for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 15:47:54 -0700 (MST)
Received: from zmy16exm62.ds.mot.com (zmy16exm62.ap.mot.com [10.179.4.33])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id n7EMlrkn006384
	for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 17:47:53 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <87d46zoojb.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Romit Dasgupta <romit@ti.com>, linux-omap@vger.kernel.org, Wang Sawsd-A24013 <cqwang@motorola.com>, Wang Limei-E12499 <E12499@motorola.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA1D31.350CD1D8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
Kevin,=20

Thanks for reviewing the patch.=20

Chunqiu and I revised the patch. Pls see the attachment.=20


Thanks,
Limei,chunqiu

-----Original Message-----
From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
Sent: Thursday, August 13, 2009 8:02 AM
To: Wang Limei-E12499
Cc: Romit Dasgupta; linux-omap@vger.kernel.org; Wang Sawsd-A24013
Subject: Re: Linux-omap PM: Fix dead lock condition in
resource_release(vdd1_opp)

"Wang Limei-E12499" <E12499@motorola.com> writes:

> =20
> Kevin and Romit,
>
> I agreed with you, thanks Kevin and Romit for the comments!   Chunqiu
> Wang coded resource-based mutex, below is the patch. Pls review and=20
> let us know your feedback.
>
>
> From 31f87ffb8eb1f854a9adb7fd96011d490f4655fa Mon Sep 17 00:00:00 2001
> From: Chunqiu Wang <cqwang@motorola.com>
> Date: Wed, 12 Aug 2009 16:22:09 +0800
> Subject: [PATCH] Fix resource framework mutex lock issue when =20
> resource_get or resource_release are called nestedly.
>

Could use a shorter summary (subject) and a more detailed changelog.

This patch is doing too many things in a single patch without enough
explanation.

Not only does it convert the global semaphore to a resource-specific
semaphore, but it also changing the locking slightly by moving some
things in/out of lock protection.  That should be described in the
changelog as well. =20

Even better would be a first patch that simply converts the semaphore to
a resource-specific *mutex* (not resource-specific semaphore.)  IOW, use
mutex API in <linux/mutex.h>:

  struct mutex;
  init_mutex()
  mutex_lock()
  mutex_unlock()
  mutex_is_lockec()
  ...

Then, add a 2nd patch which does any reworking of the critical sections.

Kevin


> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
> ---
>  arch/arm/plat-omap/include/mach/resource.h |    2 +
>  arch/arm/plat-omap/resource.c              |   38
> +++++++++++++--------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/mach/resource.h
> b/arch/arm/plat-omap/include/mach/resource.h
> index f91d8ce..389cb67 100644
> --- a/arch/arm/plat-omap/include/mach/resource.h
> +++ b/arch/arm/plat-omap/include/mach/resource.h
> @@ -22,6 +22,7 @@
> =20
>  #include <linux/list.h>
>  #include <linux/mutex.h>
> +#include <linux/semaphore.h>
>  #include <linux/device.h>
>  #include <mach/cpu.h>
> =20
> @@ -46,6 +47,7 @@ struct shared_resource {
>  	/* Shared resource operations */
>  	struct shared_resource_ops *ops;
>  	struct list_head node;
> +	struct semaphore resource_mutex;
>  };
> =20
>  struct shared_resource_ops {
> diff --git a/arch/arm/plat-omap/resource.c=20
> b/arch/arm/plat-omap/resource.c index ec31727..758a138 100644
> --- a/arch/arm/plat-omap/resource.c
> +++ b/arch/arm/plat-omap/resource.c
> @@ -264,6 +264,7 @@ int resource_register(struct shared_resource
*resp)
>  		return -EEXIST;
> =20
>  	INIT_LIST_HEAD(&resp->users_list);
> +	sema_init(&resp->resource_mutex, 1);
> =20
>  	down(&res_mutex);
>  	/* Add the resource to the resource list */ @@ -326,14 +327,14
@@=20
> int resource_request(const char *name, struct device *dev,
>  	struct  users_list *user;
>  	int 	found =3D 0, ret =3D 0;
> =20
> -	down(&res_mutex);
> -	resp =3D _resource_lookup(name);
> +	resp =3D resource_lookup(name);
>  	if (!resp) {
>  		printk(KERN_ERR "resource_request: Invalid resource
name\n");
>  		ret =3D -EINVAL;
> -		goto res_unlock;
> +		goto ret;
>  	}
> =20
> +	down(&resp->resource_mutex);
>  	/* Call the resource specific validate function */
>  	if (resp->ops->validate_level) {
>  		ret =3D resp->ops->validate_level(resp, level); @@ -361,16
+362,12 @@=20
> int resource_request(const char *name, struct device *dev,
>  	}
>  	user->level =3D level;
> =20
> +	/* Recompute and set the current level for the resource */
> +	ret =3D update_resource_level(resp);
>  res_unlock:
> -	up(&res_mutex);
> -	/*
> -	 * Recompute and set the current level for the resource.
> -	 * NOTE: update_resource level moved out of spin_lock, as it may
> call
> -	 * pm_qos_add_requirement, which does a kzmalloc. This won't be
> allowed
> -	 * in iterrupt context. The spin_lock still protects add/remove
> users.
> -	 */
> -	if (!ret)
> -		ret =3D update_resource_level(resp);
> +	up(&resp->resource_mutex);
> +
> +ret:
>  	return ret;
>  }
>  EXPORT_SYMBOL(resource_request);
> @@ -393,14 +390,14 @@ int resource_release(const char *name, struct=20
> device *dev)
>  	struct users_list *user;
>  	int found =3D 0, ret =3D 0;
> =20
> -	down(&res_mutex);
> -	resp =3D _resource_lookup(name);
> +	resp =3D resource_lookup(name);
>  	if (!resp) {
>  		printk(KERN_ERR "resource_release: Invalid resource
name\n");
>  		ret =3D -EINVAL;
> -		goto res_unlock;
> +		goto ret;
>  	}
> =20
> +	down(&resp->resource_mutex);
>  	list_for_each_entry(user, &resp->users_list, node) {
>  		if (user->dev =3D=3D dev) {
>  			found =3D 1;
> @@ -421,7 +418,9 @@ int resource_release(const char *name, struct=20
> device
> *dev)
>  	/* Recompute and set the current level for the resource */
>  	ret =3D update_resource_level(resp);
>  res_unlock:
> -	up(&res_mutex);
> +	up(&resp->resource_mutex);
> +
> +ret:
>  	return ret;
>  }
>  EXPORT_SYMBOL(resource_release);
> @@ -438,15 +437,14 @@ int resource_get_level(const char *name)
>  	struct shared_resource *resp;
>  	u32 ret;
> =20
> -	down(&res_mutex);
> -	resp =3D _resource_lookup(name);
> +	resp =3D resource_lookup(name);
>  	if (!resp) {
>  		printk(KERN_ERR "resource_release: Invalid resource
name\n");
> -		up(&res_mutex);
>  		return -EINVAL;
>  	}
> +	down(&resp->resource_mutex);
>  	ret =3D resp->curr_level;
> -	up(&res_mutex);
> +	up(&resp->resource_mutex);
>  	return ret;
>  }
>  EXPORT_SYMBOL(resource_get_level);
> --
> 1.5.4.3
>
>
>
>
>
> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Monday, August 10, 2009 11:23 AM
> To: Wang Limei-E12499
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Linux-omap PM: Fix dead lock condition in
> resource_release(vdd1_opp)
>
> "Wang Limei-E12499" <E12499@motorola.com> writes:
>
>> I am using linux-omap pm-2.6.29
>> =
<http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm.git;
>> a =3Ds hortlog;h=3Dpm-2.6.29>  branch,found a dead lock condition in:
>> arch/arm/plat-omap/resource.c->resource_release().  =20
>> =20
>> The dead lock happens when using=20
>> resource_request("vdd1_opp",&dev,...)
>> and resource_release("vdd1_opp", &dev) to set and release vdd1 opp=20
>> constraint. The  scenario is:
>> =20
>> plat-omap/resource.c/resource_release("vdd1_opp",
>> =
&dev)=3D=3D>resource.c/update_resource_level()=3D>mach-omap2/resource34xx=
.c
>> / se t_opp().  In set_opp(),  if the target_level of vdd1 is less=20
>> than OPP3,will release the constraint set on VDD2 by calling=20
>> resource_release(), but it will never return because can not get the=20
>> mutex which is holding  by the previous caller.
>> =20
>> int resource_release(const char *name, struct device *dev)
>> {           .......
>> 	down(&res_mutex);
>> 	........
>> 	/* Recompute and set the current level for the resource */
>> 	ret =3D update_resource_level(resp);
>> res_unlock:
>> 	up(&res_mutex);
>> 	return ret;
>> }
>>
>> int set_opp(struct shared_resource *resp, u32 target_level) {
>> 	.....
>>  if (resp =3D=3D vdd1_resp) {
>>       if (target_level < 3)
>>            resource_release("vdd2_opp", &vdd2_dev); }
>> =20
>> The patch to fix this issue is below, will you pls review it and let=20
>> me know your feedback?
>> =20
>> From: Limei Wang <e12499@motorola.com>
>> Date: Fri, 7 Aug 2009 11:40:35 -0500
>> Subject: [PATCH] OMAP PM: Fix dead lock bug in=20
>> resourc_release(vdd1_opp).
>> =20
>>
>> Signed-off-by: Limei Wang <e12499@motorola.com>
>> ---
>>  arch/arm/plat-omap/resource.c |    6 ++++--
>>  1 files changed, 4 insertions(+), 2 deletions(-)
>> =20
>> diff --git a/arch/arm/plat-omap/resource.c=20
>> b/arch/arm/plat-omap/resource.c index ec31727..876fd12 100644
>> --- a/arch/arm/plat-omap/resource.c
>> +++ b/arch/arm/plat-omap/resource.c
>> @@ -418,10 +418,12 @@ int resource_release(const char *name, struct=20
>> device *dev)
>>     list_del(&user->node);
>>     free_user(user);
>> =20
>> -   /* Recompute and set the current level for the resource */
>> -   ret =3D update_resource_level(resp);
>>  res_unlock:
>>     up(&res_mutex);
>> +
>> +   /* Recompute and set the current level for the resource */
>> +   if (!ret)
>> +       ret =3D update_resource_level(resp);
>>     return ret;
>>  }
>>  EXPORT_SYMBOL(resource_release);
>> --
>> 1.5.6.3
>
> This is wrong for several reasons.
>
> First, you're not fixing the problem, you're just moving the call=20
> outside of the lock, thus creating other locking problems.
>
> Second, the various error paths would break because
> update_resource_level() would be called on the 'res_unlock' error path

> where it is not currently being called.
>
> A per-resource mutex as suggest by Romit seems like the right approach

> to fixing this problem.
>
> Kevin

------_=_NextPart_001_01CA1D31.350CD1D8
Content-Type: application/octet-stream;
	name="0002-Move-the-resource-level-update-into-mutex_lock-block.patch"
Content-Transfer-Encoding: base64
Content-Description: 0002-Move-the-resource-level-update-into-mutex_lock-block.patch
Content-Disposition: attachment;
	filename="0002-Move-the-resource-level-update-into-mutex_lock-block.patch"

RnJvbSA5Y2MzNzFiNWQ3ZjJlMDQ5ZmU3MmJjOTQ2ZGNiOGVjOGUxZGU4MjZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHVucWl1IFdhbmcgPGNxd2FuZ0Btb3Rvcm9sYS5jb20+CkRh
dGU6IEZyaSwgMTQgQXVnIDIwMDkgMTc6NDM6MTMgKzA4MDAKU3ViamVjdDogW1BBVENIXSBNb3Zl
IHRoZSByZXNvdXJjZSBsZXZlbCB1cGRhdGUgaW50byBtdXRleF9sb2NrIGJsb2NrLgoKVGhlIHVw
ZGF0ZV9yZXNvdXJjZV9sZXZlbCBpcyBjYWxsZWQgb3V0c2lkZSBvZgp0aGUgbXV0ZXggbG9jayBw
cm90ZWN0aW9uIGJsb2NrIGR1ZSB0byBhbiBvdXQgb2YgZGF0ZQpzcGluIGxvY2sgbWVjaGFuaXNt
LCBub3cgbXV0ZXggaXMgdXNlZCwgc28gbW92ZQp0aGUgdXBkYXRlX3Jlc291cmNlX2xldmVsIGlu
dG8gbXV0ZXggcHJvdGVjdGlvbiBibG9jay4KClNpZ25lZC1vZmYtYnk6IENodW5xaXUgV2FuZyA8
Y3F3YW5nQG1vdG9yb2xhLmNvbT4KLS0tCiBhcmNoL2FybS9wbGF0LW9tYXAvcmVzb3VyY2UuYyB8
ICAgMTEgKysrLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9yZXNvdXJjZS5jIGIv
YXJjaC9hcm0vcGxhdC1vbWFwL3Jlc291cmNlLmMKaW5kZXggNWVhZTRlOC4uZTJhMDAzYSAxMDA2
NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL3Jlc291cmNlLmMKKysrIGIvYXJjaC9hcm0vcGxh
dC1vbWFwL3Jlc291cmNlLmMKQEAgLTM2MiwxNiArMzYyLDExIEBAIGludCByZXNvdXJjZV9yZXF1
ZXN0KGNvbnN0IGNoYXIgKm5hbWUsIHN0cnVjdCBkZXZpY2UgKmRldiwKIAl9CiAJdXNlci0+bGV2
ZWwgPSBsZXZlbDsKIAorCS8qIFJlY29tcHV0ZSBhbmQgc2V0IHRoZSBjdXJyZW50IGxldmVsIGZv
ciB0aGUgcmVzb3VyY2UgKi8KKwlyZXQgPSB1cGRhdGVfcmVzb3VyY2VfbGV2ZWwocmVzcCk7CisK
IHJlc191bmxvY2s6CiAJbXV0ZXhfdW5sb2NrKCZyZXNwLT5yZXNvdXJjZV9tdXRleCk7Ci0JLyoK
LQkgKiBSZWNvbXB1dGUgYW5kIHNldCB0aGUgY3VycmVudCBsZXZlbCBmb3IgdGhlIHJlc291cmNl
LgotCSAqIE5PVEU6IHVwZGF0ZV9yZXNvdXJjZSBsZXZlbCBtb3ZlZCBvdXQgb2Ygc3Bpbl9sb2Nr
LCBhcyBpdCBtYXkgY2FsbAotCSAqIHBtX3Fvc19hZGRfcmVxdWlyZW1lbnQsIHdoaWNoIGRvZXMg
YSBrem1hbGxvYy4gVGhpcyB3b24ndCBiZSBhbGxvd2VkCi0JICogaW4gaXRlcnJ1cHQgY29udGV4
dC4gVGhlIHNwaW5fbG9jayBzdGlsbCBwcm90ZWN0cyBhZGQvcmVtb3ZlIHVzZXJzLgotCSAqLwot
CWlmICghcmV0KQotCQlyZXQgPSB1cGRhdGVfcmVzb3VyY2VfbGV2ZWwocmVzcCk7CiByZXQ6CiAJ
cmV0dXJuIHJldDsKIH0KLS0gCjEuNS40LjMKCg==

------_=_NextPart_001_01CA1D31.350CD1D8
Content-Type: application/octet-stream;
	name="0001-Add-per-resource-mutex-for-OMAP-resource-framework.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Add-per-resource-mutex-for-OMAP-resource-framework.patch
Content-Disposition: attachment;
	filename="0001-Add-per-resource-mutex-for-OMAP-resource-framework.patch"

RnJvbSBiNGU5Y2MwMWY5ZDFhYWVlYzM5Y2MxZWU3OTRlNWVmYWVjNjFjNzgxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHVucWl1IFdhbmcgPGNxd2FuZ0Btb3Rvcm9sYS5jb20+CkRh
dGU6IEZyaSwgMTQgQXVnIDIwMDkgMTc6MzQ6MzIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBZGQg
cGVyLXJlc291cmNlIG11dGV4IGZvciBPTUFQIHJlc291cmNlIGZyYW1ld29yawoKQ3VycmVudCBP
TUFQIHJlc291cmNlIGZ3ayB1c2VzIGEgZ2xvYmFsIHJlc19tdXRleApmb3IgcmVzb3VyY2VfcmVx
dWVzdCBhbmQgcmVzb3VyY2VfcmVsZWFzZSBjYWxscwpmb3IgYWxsIHRoZSBhdmFpbGFibGUgcmVz
b3VyY2VzLkl0IG1heSBjYXVzZSBkZWFkIApsb2NrIGlmIHJlc291cmNlX3JlcXVlc3QvcmVzb3Vy
Y2VfcmVsZWFzZSBpcyBjYWxsZWQKcmVjdXJzaXZlbHkuIAoKRm9yIGN1cnJlbnQgT01BUDMgVkRE
MS9WREQyIHJlc291cmNlLCB0aGUgY2hhbmdlX2xldmVsCmltcGxlbWVudGF0aW9uIGlzIG1hY2gt
b21hcDIvcmVzb3VyY2UzNHh4LmMvc2V0X29wcCgpLAp3aGVuIHVzaW5nIHJlc291cmNlX3JlbGVh
c2UgdG8gcmVtb3ZlIHZkZDEgY29uc3RyYWludCwKdGhpcyBmdW5jdGlvbiBtYXkgY2FsbCByZXNv
dXJjZV9yZWxlYXNlIGFnYWluIHRvIHJlbGVhc2UKVmRkMiBjb25zdHJhaXQgaWYgdGFyZ2V0IHZk
ZDEgbGV2ZWwgaXMgbGVzcyB0aGFuIE9QUDMuCmluIHRoaXMgc2NlbmFyaW8sIHRoZSBnbG9iYWwg
cmVzX211dGV4IGRvd24gb3BlcmF0aW9uCndpbGwgYmUgY2FsbGVkIGFnYWluLCB0aGlzIHdpbGwg
Y2F1c2UgdGhlIHNlY29uZApkb3duIG9wZXJhdGlvbiBoYW5nIHRoZXJlLgoKVG8gZml4IHRoZSBw
cm9ibGVtLCBwZXItcmVzb3VyY2UgbXV0ZXggaXMgYWRkZWQKdG8gYXZvaWQgaGFuZ3VwIHdoZW4g
cmVzb3VyY2VfcmVxdWVzdC9yZXNvdXJjZV9yZWxlYXNlCmlzIGNhbGxlZCByZWN1cnNpdmVseS4K
ClNpZ25lZC1vZmYtYnk6IENodW5xaXUgV2FuZyA8Y3F3YW5nQG1vdG9yb2xhLmNvbT4KLS0tCiBh
cmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9tYWNoL3Jlc291cmNlLmggfCAgICAyICsrCiBhcmNo
L2FybS9wbGF0LW9tYXAvcmVzb3VyY2UuYyAgICAgICAgICAgICAgfCAgIDI3ICsrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9tYWNo
L3Jlc291cmNlLmggYi9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9tYWNoL3Jlc291cmNlLmgK
aW5kZXggZjkxZDhjZS4uZDQ4MmZiOCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2lu
Y2x1ZGUvbWFjaC9yZXNvdXJjZS5oCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL21h
Y2gvcmVzb3VyY2UuaApAQCAtNDYsNiArNDYsOCBAQCBzdHJ1Y3Qgc2hhcmVkX3Jlc291cmNlIHsK
IAkvKiBTaGFyZWQgcmVzb3VyY2Ugb3BlcmF0aW9ucyAqLwogCXN0cnVjdCBzaGFyZWRfcmVzb3Vy
Y2Vfb3BzICpvcHM7CiAJc3RydWN0IGxpc3RfaGVhZCBub2RlOworCS8qIFByb3RlY3QgZWFjaCBy
ZXNvdXJjZSAqLworCXN0cnVjdCBtdXRleCByZXNvdXJjZV9tdXRleDsKIH07CiAKIHN0cnVjdCBz
aGFyZWRfcmVzb3VyY2Vfb3BzIHsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9yZXNv
dXJjZS5jIGIvYXJjaC9hcm0vcGxhdC1vbWFwL3Jlc291cmNlLmMKaW5kZXggZWMzMTcyNy4uNWVh
ZTRlOCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL3Jlc291cmNlLmMKKysrIGIvYXJj
aC9hcm0vcGxhdC1vbWFwL3Jlc291cmNlLmMKQEAgLTI2NCw2ICsyNjQsNyBAQCBpbnQgcmVzb3Vy
Y2VfcmVnaXN0ZXIoc3RydWN0IHNoYXJlZF9yZXNvdXJjZSAqcmVzcCkKIAkJcmV0dXJuIC1FRVhJ
U1Q7CiAKIAlJTklUX0xJU1RfSEVBRCgmcmVzcC0+dXNlcnNfbGlzdCk7CisJbXV0ZXhfaW5pdCgm
cmVzcC0+cmVzb3VyY2VfbXV0ZXgpOwogCiAJZG93bigmcmVzX211dGV4KTsKIAkvKiBBZGQgdGhl
IHJlc291cmNlIHRvIHRoZSByZXNvdXJjZSBsaXN0ICovCkBAIC0zMjYsMTQgKzMyNywxNCBAQCBp
bnQgcmVzb3VyY2VfcmVxdWVzdChjb25zdCBjaGFyICpuYW1lLCBzdHJ1Y3QgZGV2aWNlICpkZXYs
CiAJc3RydWN0ICB1c2Vyc19saXN0ICp1c2VyOwogCWludCAJZm91bmQgPSAwLCByZXQgPSAwOwog
Ci0JZG93bigmcmVzX211dGV4KTsKLQlyZXNwID0gX3Jlc291cmNlX2xvb2t1cChuYW1lKTsKKwly
ZXNwID0gcmVzb3VyY2VfbG9va3VwKG5hbWUpOwogCWlmICghcmVzcCkgewogCQlwcmludGsoS0VS
Tl9FUlIgInJlc291cmNlX3JlcXVlc3Q6IEludmFsaWQgcmVzb3VyY2UgbmFtZVxuIik7CiAJCXJl
dCA9IC1FSU5WQUw7Ci0JCWdvdG8gcmVzX3VubG9jazsKKwkJZ290byByZXQ7CiAJfQogCisJbXV0
ZXhfbG9jaygmcmVzcC0+cmVzb3VyY2VfbXV0ZXgpOwogCS8qIENhbGwgdGhlIHJlc291cmNlIHNw
ZWNpZmljIHZhbGlkYXRlIGZ1bmN0aW9uICovCiAJaWYgKHJlc3AtPm9wcy0+dmFsaWRhdGVfbGV2
ZWwpIHsKIAkJcmV0ID0gcmVzcC0+b3BzLT52YWxpZGF0ZV9sZXZlbChyZXNwLCBsZXZlbCk7CkBA
IC0zNjIsNyArMzYzLDcgQEAgaW50IHJlc291cmNlX3JlcXVlc3QoY29uc3QgY2hhciAqbmFtZSwg
c3RydWN0IGRldmljZSAqZGV2LAogCXVzZXItPmxldmVsID0gbGV2ZWw7CiAKIHJlc191bmxvY2s6
Ci0JdXAoJnJlc19tdXRleCk7CisJbXV0ZXhfdW5sb2NrKCZyZXNwLT5yZXNvdXJjZV9tdXRleCk7
CiAJLyoKIAkgKiBSZWNvbXB1dGUgYW5kIHNldCB0aGUgY3VycmVudCBsZXZlbCBmb3IgdGhlIHJl
c291cmNlLgogCSAqIE5PVEU6IHVwZGF0ZV9yZXNvdXJjZSBsZXZlbCBtb3ZlZCBvdXQgb2Ygc3Bp
bl9sb2NrLCBhcyBpdCBtYXkgY2FsbApAQCAtMzcxLDYgKzM3Miw3IEBAIHJlc191bmxvY2s6CiAJ
ICovCiAJaWYgKCFyZXQpCiAJCXJldCA9IHVwZGF0ZV9yZXNvdXJjZV9sZXZlbChyZXNwKTsKK3Jl
dDoKIAlyZXR1cm4gcmV0OwogfQogRVhQT1JUX1NZTUJPTChyZXNvdXJjZV9yZXF1ZXN0KTsKQEAg
LTM5MywxNCArMzk1LDE0IEBAIGludCByZXNvdXJjZV9yZWxlYXNlKGNvbnN0IGNoYXIgKm5hbWUs
IHN0cnVjdCBkZXZpY2UgKmRldikKIAlzdHJ1Y3QgdXNlcnNfbGlzdCAqdXNlcjsKIAlpbnQgZm91
bmQgPSAwLCByZXQgPSAwOwogCi0JZG93bigmcmVzX211dGV4KTsKLQlyZXNwID0gX3Jlc291cmNl
X2xvb2t1cChuYW1lKTsKKwlyZXNwID0gcmVzb3VyY2VfbG9va3VwKG5hbWUpOwogCWlmICghcmVz
cCkgewogCQlwcmludGsoS0VSTl9FUlIgInJlc291cmNlX3JlbGVhc2U6IEludmFsaWQgcmVzb3Vy
Y2UgbmFtZVxuIik7CiAJCXJldCA9IC1FSU5WQUw7Ci0JCWdvdG8gcmVzX3VubG9jazsKKwkJZ290
byByZXQ7CiAJfQogCisJbXV0ZXhfbG9jaygmcmVzcC0+cmVzb3VyY2VfbXV0ZXgpOwogCWxpc3Rf
Zm9yX2VhY2hfZW50cnkodXNlciwgJnJlc3AtPnVzZXJzX2xpc3QsIG5vZGUpIHsKIAkJaWYgKHVz
ZXItPmRldiA9PSBkZXYpIHsKIAkJCWZvdW5kID0gMTsKQEAgLTQyMSw3ICs0MjMsOSBAQCBpbnQg
cmVzb3VyY2VfcmVsZWFzZShjb25zdCBjaGFyICpuYW1lLCBzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJ
LyogUmVjb21wdXRlIGFuZCBzZXQgdGhlIGN1cnJlbnQgbGV2ZWwgZm9yIHRoZSByZXNvdXJjZSAq
LwogCXJldCA9IHVwZGF0ZV9yZXNvdXJjZV9sZXZlbChyZXNwKTsKIHJlc191bmxvY2s6Ci0JdXAo
JnJlc19tdXRleCk7CisJbXV0ZXhfdW5sb2NrKCZyZXNwLT5yZXNvdXJjZV9tdXRleCk7CisKK3Jl
dDoKIAlyZXR1cm4gcmV0OwogfQogRVhQT1JUX1NZTUJPTChyZXNvdXJjZV9yZWxlYXNlKTsKQEAg
LTQzOCwxNSArNDQyLDE0IEBAIGludCByZXNvdXJjZV9nZXRfbGV2ZWwoY29uc3QgY2hhciAqbmFt
ZSkKIAlzdHJ1Y3Qgc2hhcmVkX3Jlc291cmNlICpyZXNwOwogCXUzMiByZXQ7CiAKLQlkb3duKCZy
ZXNfbXV0ZXgpOwotCXJlc3AgPSBfcmVzb3VyY2VfbG9va3VwKG5hbWUpOworCXJlc3AgPSByZXNv
dXJjZV9sb29rdXAobmFtZSk7CiAJaWYgKCFyZXNwKSB7CiAJCXByaW50ayhLRVJOX0VSUiAicmVz
b3VyY2VfcmVsZWFzZTogSW52YWxpZCByZXNvdXJjZSBuYW1lXG4iKTsKLQkJdXAoJnJlc19tdXRl
eCk7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KKwltdXRleF9sb2NrKCZyZXNwLT5yZXNvdXJjZV9t
dXRleCk7CiAJcmV0ID0gcmVzcC0+Y3Vycl9sZXZlbDsKLQl1cCgmcmVzX211dGV4KTsKKwltdXRl
eF91bmxvY2soJnJlc3AtPnJlc291cmNlX211dGV4KTsKIAlyZXR1cm4gcmV0OwogfQogRVhQT1JU
X1NZTUJPTChyZXNvdXJjZV9nZXRfbGV2ZWwpOwotLSAKMS41LjQuMwoK

------_=_NextPart_001_01CA1D31.350CD1D8--
