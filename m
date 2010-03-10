From: Mike Chan <mike@android.com>
Subject: Re: [PATCH] omap: resource: Add per-resource mutex for OMAP resource
	framework
Date: Tue, 9 Mar 2010 16:11:52 -0800
Message-ID: <8bb80c381003091611l7211439ief40c5cf31e782a0@mail.gmail.com>
References: <-1645286213079228429@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:7186 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab0CJALx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 19:11:53 -0500
Received: by qw-out-2122.google.com with SMTP id 8so157237qwh.37
        for <linux-omap@vger.kernel.org>; Tue, 09 Mar 2010 16:11:52 -0800 (PST)
In-Reply-To: <-1645286213079228429@unknownmsgid>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: android-kernel@googlegroups.com, Chunqiu Wang <cqwang@motorola.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, Jouni Hogander <jouni.hogander@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Mar 9, 2010 at 4:09 PM,  <y@google.com> wrote:
> From: Chunqiu Wang <cqwang@motorola.com>
>
> Current OMAP resource fwk uses a global res_mutex
> for resource_request and resource_release calls
> for all the available resources.It may cause dead
> lock if resource_request/resource_release is called
> recursively.
>
> For current OMAP3 VDD1/VDD2 resource, the change_level
> implementation is mach-omap2/resource34xx.c/set_opp(),
> when using resource_release to remove vdd1 constraint,
> this function may call resource_release again to release
> Vdd2 constrait if target vdd1 level is less than OPP3.
> in this scenario, the global res_mutex down operation
> will be called again, this will cause the second
> down operation hang there.
>
> To fix the problem, per-resource mutex is added
> to avoid hangup when resource_request/resource_release
> is called recursively.
>
> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
> Signed-off-by: Mike Chan <mike@android.com>
> ---
> =A0arch/arm/plat-omap/include/plat/resource.h | =A0 =A02 ++
> =A0arch/arm/plat-omap/resource.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 21 =
++++++++++-----------
> =A02 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/resource.h b/arch/arm/pl=
at-omap/include/plat/resource.h
> index 9acebcc..b5aff1f 100644
> --- a/arch/arm/plat-omap/include/plat/resource.h
> +++ b/arch/arm/plat-omap/include/plat/resource.h
> @@ -54,6 +54,8 @@ struct shared_resource {
> =A0 =A0 =A0 =A0/* Shared resource operations */
> =A0 =A0 =A0 =A0struct shared_resource_ops *ops;
> =A0 =A0 =A0 =A0struct list_head node;
> + =A0 =A0 =A0 /* Protect each resource */
> + =A0 =A0 =A0 struct mutex resource_mutex;
> =A0};
>
> =A0struct shared_resource_ops {
> diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resou=
rce.c
> index f1cdecf..0a7b79b 100644
> --- a/arch/arm/plat-omap/resource.c
> +++ b/arch/arm/plat-omap/resource.c
> @@ -277,6 +277,7 @@ int resource_register(struct shared_resource *res=
p)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&resp->users_list);
> + =A0 =A0 =A0 mutex_init(&resp->resource_mutex);
>
> =A0 =A0 =A0 =A0/* Add the resource to the resource list */
> =A0 =A0 =A0 =A0list_add(&resp->node, &res_list);
> @@ -339,14 +340,13 @@ int resource_request(const char *name, struct d=
evice *dev,
> =A0 =A0 =A0 =A0struct =A0users_list *user;
> =A0 =A0 =A0 =A0int =A0 =A0 found =3D 0, ret =3D 0;
>
> - =A0 =A0 =A0 down(&res_mutex);
> - =A0 =A0 =A0 resp =3D _resource_lookup(name);
> + =A0 =A0 =A0 resp =3D resource_lookup(name);
> =A0 =A0 =A0 =A0if (!resp) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "resource_request: Inv=
alid resource name\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto res_unlock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 mutex_lock(&resp->resource_mutex);
> =A0 =A0 =A0 =A0/* Call the resource specific validate function */
> =A0 =A0 =A0 =A0if (resp->ops->validate_level) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D resp->ops->validate_level(resp=
, level);
> @@ -375,7 +375,7 @@ int resource_request(const char *name, struct dev=
ice *dev,
> =A0 =A0 =A0 =A0user->level =3D level;
>
> =A0res_unlock:
> - =A0 =A0 =A0 up(&res_mutex);
> + =A0 =A0 =A0 mutex_unlock(&resp->resource_mutex);
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Recompute and set the current level for the resourc=
e.
> =A0 =A0 =A0 =A0 * NOTE: update_resource level moved out of spin_lock,=
 as it may call
> @@ -406,14 +406,13 @@ int resource_release(const char *name, struct d=
evice *dev)
> =A0 =A0 =A0 =A0struct users_list *user;
> =A0 =A0 =A0 =A0int found =3D 0, ret =3D 0;
>
> - =A0 =A0 =A0 down(&res_mutex);
> - =A0 =A0 =A0 resp =3D _resource_lookup(name);
> + =A0 =A0 =A0 resp =3D resource_lookup(name);
> =A0 =A0 =A0 =A0if (!resp) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "resource_release: Inv=
alid resource name\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto res_unlock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 mutex_lock(&resp->resource_mutex);
> =A0 =A0 =A0 =A0list_for_each_entry(user, &resp->users_list, node) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (user->dev =3D=3D dev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0found =3D 1;
> @@ -434,7 +433,7 @@ int resource_release(const char *name, struct dev=
ice *dev)
> =A0 =A0 =A0 =A0/* Recompute and set the current level for the resourc=
e */
> =A0 =A0 =A0 =A0ret =3D update_resource_level(resp);
> =A0res_unlock:
> - =A0 =A0 =A0 up(&res_mutex);
> + =A0 =A0 =A0 mutex_unlock(&resp->resource_mutex);
> =A0 =A0 =A0 =A0return ret;
> =A0}
> =A0EXPORT_SYMBOL(resource_release);
> @@ -458,7 +457,7 @@ int resource_get_level(const char *name)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up(&res_mutex);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 ret =3D resp->curr_level;
> + =A0 =A0 =A0 ret =3D =A0resp->curr_level;
> =A0 =A0 =A0 =A0up(&res_mutex);
> =A0 =A0 =A0 =A0return ret;
> =A0}
> --
> 1.6.6.2
>
>

Oops, my git client was slightly screwed up, apologies, I meant to
send this from mike@android.com, the patch is still good though :)

-- Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
