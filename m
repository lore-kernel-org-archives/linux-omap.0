From: Mike Chan <mike@android.com>
Subject: Re: [PATCH] omap: resource: Fix race in register_resource()
Date: Tue, 8 Sep 2009 16:55:44 -0700
Message-ID: <8bb80c380909081655m57022292jb9d55bcd8043d34@mail.gmail.com>
References: <1252006638-1697-1-git-send-email-mike@android.com>
	 <87k509kqnq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:38806 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbZIIAAq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 20:00:46 -0400
Received: by qw-out-2122.google.com with SMTP id 9so210319qwb.37
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2009 17:00:48 -0700 (PDT)
In-Reply-To: <87k509kqnq.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Tue, Sep 8, 2009 at 3:39 PM, Kevin Hilman<khilman@deeprootsystems.co=
m> wrote:
> Mike Chan <mike@android.com> writes:
>
>> Checking if the resource is already registered and adding to the lis=
t
>> must be atomic or bad things can happen.
>>
>> Signed-off-by: Mike Chan <mike@android.com>
>
> Functionally, this looks fine. =A0Some procedural details still to wo=
rk
> out:
>
> Are you the original author of this? =A0or was it Chunqiu or Limei? =A0=
The
> changelog should be prefixed with a From: line of the original author
> (handled by git-format-patch) if it was not you. =A0Also add the othe=
r's
> signoffs if appropriate.
>

I am the original author of this patch. Chunqiu sent two patches out
1) a per-resource level mutex (vs global).
2) Make update_resource_level() thread safe.

I've been meaning to send them out to l-o on behalf of Chunqiu.

> What tree does this apply to? =A0It's not specified, and does not app=
ly
> to either current PM branch or pm-2.6.29.
>

I thought I rebased this off of pm but I may have goofed. I can send a =
new one.

-- Mike

> Kevin
>
>> ---
>> =A0arch/arm/plat-omap/resource.c | =A0 14 +++++++++-----
>> =A01 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/reso=
urce.c
>> index e9ace13..9d20249 100644
>> --- a/arch/arm/plat-omap/resource.c
>> +++ b/arch/arm/plat-omap/resource.c
>> @@ -253,6 +253,7 @@ int resource_refresh(void)
>> =A0 */
>> =A0int resource_register(struct shared_resource *resp)
>> =A0{
>> + =A0 =A0 int ret =3D 0;
>> =A0 =A0 =A0 if (!resp)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> @@ -260,13 +261,15 @@ int resource_register(struct shared_resource *=
resp)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> =A0 =A0 =A0 /* Verify that the resource is not already registered */
>> - =A0 =A0 if (resource_lookup(resp->name))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -EEXIST;
>> + =A0 =A0 down(&res_mutex);
>> + =A0 =A0 if (_resource_lookup(resp->name)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EEXIST;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 INIT_LIST_HEAD(&resp->users_list);
>> =A0 =A0 =A0 mutex_init(&resp->resource_mutex);
>>
>> - =A0 =A0 down(&res_mutex);
>> =A0 =A0 =A0 /* Add the resource to the resource list */
>> =A0 =A0 =A0 list_add(&resp->node, &res_list);
>>
>> @@ -274,10 +277,11 @@ int resource_register(struct shared_resource *=
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
