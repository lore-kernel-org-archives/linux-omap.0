From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [linux-pm] [PATCH] PM: export suspend_set_ops, suspend_valid_only_mem
Date: Mon, 30 May 2011 09:43:37 +0200
Message-ID: <BANLkTi=pQEp=_RpNyJ9o=mxjA+PMhgTKZQ@mail.gmail.com>
References: <1306542839-5688-1-git-send-email-khilman@ti.com>
	<201105281101.13691.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37869 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab1E3Hnk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 03:43:40 -0400
Received: by qwk3 with SMTP id 3so1567460qwk.19
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 00:43:39 -0700 (PDT)
In-Reply-To: <201105281101.13691.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

Rafael,

On Sat, May 28, 2011 at 11:01 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote=
:
> On Saturday, May 28, 2011, Kevin Hilman wrote:
>> Some platforms wish to implement their PM core suspend code as
>> modules. =A0To do so, these functions need to be exported to modules=
=2E
>
> Hmm. =A0What happens if the module is not loaded and the user attempt=
s to
> suspend?
In that case suspend_ops is NULL and suspending has no effect
(pm_suspend returns -ENODEV).
Note that this also happens after the module unload.

Is that the expected behavior?

>
> Rafael

Regards,
Jean

>
>
>> Reported-by: Jean Pihet <j-pihet@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> Applies against v2.6.39
>>
>> =A0kernel/power/suspend.c | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>> index 6275970..eca495d 100644
>> --- a/kernel/power/suspend.c
>> +++ b/kernel/power/suspend.c
>> @@ -44,6 +44,7 @@ void suspend_set_ops(const struct platform_suspend=
_ops *ops)
>> =A0 =A0 =A0 suspend_ops =3D ops;
>> =A0 =A0 =A0 mutex_unlock(&pm_mutex);
>> =A0}
>> +EXPORT_SYMBOL(suspend_set_ops);
>>
>> =A0bool valid_state(suspend_state_t state)
>> =A0{
>> @@ -65,6 +66,7 @@ int suspend_valid_only_mem(suspend_state_t state)
>> =A0{
>> =A0 =A0 =A0 return state =3D=3D PM_SUSPEND_MEM;
>> =A0}
>> +EXPORT_SYMBOL(suspend_valid_only_mem);
>>
>> =A0static int suspend_test(int level)
>> =A0{
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
