From: Mike Chan <mike@android.com>
Subject: Re: [PATCH] omap: resource: Fix race in register_resource()
Date: Thu, 17 Sep 2009 16:41:27 -0700
Message-ID: <8bb80c380909171641h22c1f863wdc33351a3d407fa7@mail.gmail.com>
References: <1253230331-701-1-git-send-email-mike@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:63722 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbZIQXlX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Sep 2009 19:41:23 -0400
Received: by vws33 with SMTP id 33so627828vws.33
        for <linux-omap@vger.kernel.org>; Thu, 17 Sep 2009 16:41:27 -0700 (PDT)
In-Reply-To: <1253230331-701-1-git-send-email-mike@android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

On Thu, Sep 17, 2009 at 4:32 PM, Mike Chan <mike@android.com> wrote:
> Checking if the resource is already registered and adding to the list
> must be atomic or bad things can happen.
>
> Signed-off-by: Mike Chan <mike@android.com>
> ---
> =A0arch/arm/plat-omap/resource.c | =A0 13 ++++++++-----
> =A01 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resou=
rce.c
> index 111020a..4631912 100644
> --- a/arch/arm/plat-omap/resource.c
> +++ b/arch/arm/plat-omap/resource.c
> @@ -255,6 +255,7 @@ int resource_refresh(void)
> =A0*/
> =A0int resource_register(struct shared_resource *resp)
> =A0{
> + =A0 =A0 =A0 int ret =3D 0;
> =A0 =A0 =A0 =A0if (!resp)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> @@ -262,12 +263,13 @@ int resource_register(struct shared_resource *r=
esp)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> =A0 =A0 =A0 =A0/* Verify that the resource is not already registered =
*/
> - =A0 =A0 =A0 if (resource_lookup(resp->name))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EEXIST;
> + =A0 =A0 =A0 down(&res_mutex);
> + =A0 =A0 =A0 if (_resource_lookup(resp->name))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EEXIST;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&resp->users_list);
>
> - =A0 =A0 =A0 down(&res_mutex);
> =A0 =A0 =A0 =A0/* Add the resource to the resource list */
> =A0 =A0 =A0 =A0list_add(&resp->node, &res_list);
>
> @@ -275,10 +277,11 @@ int resource_register(struct shared_resource *r=
esp)
> =A0 =A0 =A0 =A0if (resp->ops->init)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resp->ops->init(resp);
>
> - =A0 =A0 =A0 up(&res_mutex);
> =A0 =A0 =A0 =A0pr_debug("resource: registered %s\n", resp->name);
>
> - =A0 =A0 =A0 return 0;
> +out:
> + =A0 =A0 =A0 up(&res_mutex);
> + =A0 =A0 =A0 return ret;
> =A0}
> =A0EXPORT_SYMBOL(resource_register);
>
> --
> 1.5.4.5
>
>

Kevin, this should be based off of your pm branch (2.6.30?)

-- Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
