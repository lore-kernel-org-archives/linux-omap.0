From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 09/13] OMAP2+: PM: export suspend_set_ops to PM modules
Date: Fri, 27 May 2011 09:48:33 +0200
Message-ID: <BANLkTimsOMLWX0gmYKdF6XzwhMduGt2Q0A@mail.gmail.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
	<1305739950-11695-10-git-send-email-j-pihet@ti.com>
	<87lixt9hz8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48970 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab1E0Hse convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 03:48:34 -0400
Received: by qyk7 with SMTP id 7so3149643qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 00:48:33 -0700 (PDT)
In-Reply-To: <87lixt9hz8.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, May 27, 2011 at 1:09 AM, Kevin Hilman <khilman@ti.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Export the suspend_set_ops API as omap_pm_suspend_set_ops in the pm
>> generic code, under CONFIG_SUSPEND.
>>
>> Note -hack warning-: since the 'suspend_valid_only_mem' function is
>> not exported to modules, fill the 'valid' field value of
>> 'struct platform_suspend_ops' in the common code.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Can you try the patch below instead? =A0 =A0If that works, I'll submi=
t to
> Rafael/linux-pm.
This is much cleaner! We need this pushed upstream.

Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks,
Jean

>
> Kevin
>
> From d3aca6317f5f92a5fd4fbaf1d039232c83cac4f4 Mon Sep 17 00:00:00 200=
1
> From: Kevin Hilman <khilman@ti.com>
> Date: Thu, 26 May 2011 16:10:13 -0700
> Subject: [PATCH] PM: export suspend_set_ops, suspend_valid_only_mem
>
> Some platforms wish to implement their PM core code as modules. =A0To
> do so, these functions need to be exported for modules.
>
> Reported-by: Jean Pihet <j-pihet@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0kernel/power/suspend.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 6275970..eca495d 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -44,6 +44,7 @@ void suspend_set_ops(const struct platform_suspend_=
ops *ops)
> =A0 =A0 =A0 =A0suspend_ops =3D ops;
> =A0 =A0 =A0 =A0mutex_unlock(&pm_mutex);
> =A0}
> +EXPORT_SYMBOL(suspend_set_ops);
>
> =A0bool valid_state(suspend_state_t state)
> =A0{
> @@ -65,6 +66,7 @@ int suspend_valid_only_mem(suspend_state_t state)
> =A0{
> =A0 =A0 =A0 =A0return state =3D=3D PM_SUSPEND_MEM;
> =A0}
> +EXPORT_SYMBOL(suspend_valid_only_mem);
>
> =A0static int suspend_test(int level)
> =A0{
> --
> 1.7.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
