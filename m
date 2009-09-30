From: Mike Chan <mike@android.com>
Subject: Re: [PATCH] omap: resource: Fix race in register_resource()
Date: Wed, 30 Sep 2009 16:58:19 -0700
Message-ID: <8bb80c380909301658v1155ba22ned015b2c59c519b@mail.gmail.com>
References: <1253230331-701-1-git-send-email-mike@android.com>
	 <874oqkj8mx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:62102 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709AbZI3X6P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 19:58:15 -0400
Received: by pxi32 with SMTP id 32so5914093pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 16:58:20 -0700 (PDT)
In-Reply-To: <874oqkj8mx.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Wed, Sep 30, 2009 at 4:49 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Mike Chan <mike@android.com> writes:
>
>> Checking if the resource is already registered and adding to the lis=
t
>> must be atomic or bad things can happen.
>>
>> Signed-off-by: Mike Chan <mike@android.com>
>> ---
>> =A0arch/arm/plat-omap/resource.c | =A0 13 ++++++++-----
>> =A01 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/reso=
urce.c
>> index 111020a..4631912 100644
>> --- a/arch/arm/plat-omap/resource.c
>> +++ b/arch/arm/plat-omap/resource.c
>> @@ -255,6 +255,7 @@ int resource_refresh(void)
>> =A0 */
>> =A0int resource_register(struct shared_resource *resp)
>> =A0{
>> + =A0 =A0 int ret =3D 0;
>> =A0 =A0 =A0 if (!resp)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> @@ -262,12 +263,13 @@ int resource_register(struct shared_resource *=
resp)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> =A0 =A0 =A0 /* Verify that the resource is not already registered */
>> - =A0 =A0 if (resource_lookup(resp->name))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -EEXIST;
>> + =A0 =A0 down(&res_mutex);
>> + =A0 =A0 if (_resource_lookup(resp->name))
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EEXIST;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> Ahem, you're rebased version has a little problem. =A0Missing {} bloc=
k
> mans this goto is always executed and no resources are ever added.
>
> I'll fix this up manually before applying, but some more testing next
> time would be helpful
>

Opps, sorry about that :/ and thanks for cleaning it up.

-- Mike

> Thanks,
>
> Kevin
>
>
>> =A0 =A0 =A0 INIT_LIST_HEAD(&resp->users_list);
>>
>> - =A0 =A0 down(&res_mutex);
>> =A0 =A0 =A0 /* Add the resource to the resource list */
>> =A0 =A0 =A0 list_add(&resp->node, &res_list);
>>
>> @@ -275,10 +277,11 @@ int resource_register(struct shared_resource *=
resp)
>> =A0 =A0 =A0 if (resp->ops->init)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 resp->ops->init(resp);
>>
>> - =A0 =A0 up(&res_mutex);
>> =A0 =A0 =A0 pr_debug("resource: registered %s\n", resp->name);
>>
>> - =A0 =A0 return 0;
>> +out:
>> + =A0 =A0 up(&res_mutex);
>> + =A0 =A0 return ret;
>> =A0}
>> =A0EXPORT_SYMBOL(resource_register);
>>
>> --
>> 1.5.4.5
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
