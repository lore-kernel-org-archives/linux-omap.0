From: Mike Chan <mike@android.com>
Subject: Re: [PATCH] [ARM] omap: resource: Make resource_refresh() thread
	safe.
Date: Fri, 11 Sep 2009 15:50:29 -0700
Message-ID: <8bb80c380909111550o7041b1c5h1913f9290200429b@mail.gmail.com>
References: <1252019887-4463-1-git-send-email-mike@android.com>
	 <87eiqhkqch.fsf@deeprootsystems.com> <4AA9CE36.3080903@ti.com>
	 <87ws455gs2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:41530 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbZIKWu0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 18:50:26 -0400
Received: by vws33 with SMTP id 33so1013164vws.33
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 15:50:29 -0700 (PDT)
In-Reply-To: <87ws455gs2.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Mike Turquette <mturquette@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Sep 11, 2009 at 2:10 PM, Kevin
Hilman<khilman@deeprootsystems.com> wrote:
> Mike Turquette <mturquette@ti.com> writes:
>
>> Kevin Hilman wrote:
>>> Mike Chan <mike@android.com> writes:
>>>
>>>> Need to lock the res_mutex when traversing the res_list.
>>>>
>>>> Signed-off-by: Mike Chan <mike@android.com>
>>>
>>> Looks good, thanks.
>>
>> This patch causes a hang for me when transitioning to OFF mode. =A0T=
his
>> was tested on the Android 2.6.29 tree and is 100% reproducible. =A0T=
he
>> moment a user runs 'echo 1 > /sys/power/enable_off_mode' the board
>> hangs without any further output.
>>
>> Reverting the patch allows me to hit OFF mode again. =A0I haven't ye=
t
>> tested this on vanilla 2.6.29 or latest L-O.
>>
>
> OK, reverting this in both PM branches. =A0Looks like a deadlock to m=
e,
> as update_resource_level() must cause a call to something else that
> takes the mutex.
>

Good catch, I see the deadlock are in the change_level function
pointers. Where set_xxx will call resource_request() or
resource_release() =3D> resource_lookup() which grabs the list mutex we
grabbed in resource_refresh().

Thoughts on changing the mutex to a RW semaphore?

-- Mike

> Kevin
>
>>
>>> Pushed to PM branch and pm-2.6.29.
>>>
>>> Kevin
>>>
>>>> ---
>>>> =A0arch/arm/plat-omap/resource.c | =A0 =A02 ++
>>>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/re=
source.c
>>>> index 25072cd..4631912 100644
>>>> --- a/arch/arm/plat-omap/resource.c
>>>> +++ b/arch/arm/plat-omap/resource.c
>>>> @@ -234,11 +234,13 @@ int resource_refresh(void)
>>>> =A0 =A0 struct shared_resource *resp =3D NULL;
>>>> =A0 =A0 int ret =3D 0;
>>>> =A0+ =A0down(&res_mutex);
>>>> =A0 =A0 list_for_each_entry(resp, &res_list, node) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 ret =3D update_resource_level(resp);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> =A0 =A0 }
>>>> + =A0 up(&res_mutex);
>>>> =A0 =A0 return ret;
>>>> =A0}
>>>> =A0--
>>>> 1.5.4.5
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
