From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 5/8] OMAP2+: hwmod: rename omap_hwmod_mutex to	_hwmod_list_mutex
Date: Tue, 16 Nov 2010 18:32:13 +0100
Message-ID: <4CE2C01D.8010703@ti.com>
References: <20101116101615.22777.49212.stgit@twilight.localdomain> <20101116101808.22777.52852.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43295 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372Ab0KPRcU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 12:32:20 -0500
In-Reply-To: <20101116101808.22777.52852.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

=46unny, I was about to send you a RFC to get rid of that mutex :-)

Today that mutex is preventing us to be re-entrant during hwmod lookup=20
and for_each_by_class iteration, and we'd like to in order to manage=20
link between 2 hwmods.

The context is the link between mcbsp and sidetone on OMAP3. Since this=
=20
module are tightly coupled, I was suggesting to Kishon to add the=20
sidetone reference directly in the mcbsp hwmod in order to create a=20
omap_device that will handle the 2 hwmods at the same time.

Since we are using the iteration to get all the hwmod that belongs to=20
the mcbsp class we cannot call the lookup function to get the sidetone=20
hwmod at that time.
=46or the moment we need to do 2 iteration and use intermediate storage=
 to=20
workaround that.

After checking the purpose of the mutex, I was wondering if this is=20
useful. For the moment the creation of the hwmod list is done only at=20
init time, and nothing is supposed to change that at runtime except the=
=20
unregister function.

So I've started to get rid of this function, then of the mutex and I=20
added the __init to all these registration functions to avoid the usage=
=20
at runtime. It will save a little bit of memory as well.

Thanks to that we can now use the omap_hwmod_lookup inside the=20
omap_hwmod_for_each_by_class.

Does that make sense to you?
I can send you the patches if you want.

Regards,
Benoit



On 11/16/2010 11:18 AM, Paul Walmsley wrote:
> This trivial patch renames omap_hwmod_mutex to _hwmod_list_mutex to i=
ndicate
> clearly that it is only used for hwmod list manipulation operations.
>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Beno=C3=AEt Cousson<b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |   27 ++++++++++++++-------------
>   1 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index 12a0b9a..0e85278 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -156,7 +156,8 @@
>   /* omap_hwmod_list contains all registered struct omap_hwmods */
>   static LIST_HEAD(omap_hwmod_list);
>
> -static DEFINE_MUTEX(omap_hwmod_mutex);
> +/* _hwmod_list_mutex protects the list of registered hwmods */
> +static DEFINE_MUTEX(_hwmod_list_mutex);
>
>   /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
>   static struct omap_hwmod *mpu_oh;
> @@ -874,7 +875,7 @@ static void _shutdown_sysc(struct omap_hwmod *oh)
>    * @name: find an omap_hwmod by name
>    *
>    * Return a pointer to an omap_hwmod by name, or NULL if not found.
> - * Caller must hold omap_hwmod_mutex.
> + * Caller must hold _hwmod_list_mutex.
>    */
>   static struct omap_hwmod *_lookup(const char *name)
>   {
> @@ -1502,7 +1503,7 @@ int omap_hwmod_register(struct omap_hwmod *oh)
>   	    (oh->_state !=3D _HWMOD_STATE_UNKNOWN))
>   		return -EINVAL;
>
> -	mutex_lock(&omap_hwmod_mutex);
> +	mutex_lock(&_hwmod_list_mutex);
>
>   	pr_debug("omap_hwmod: %s: registering\n", oh->name);
>
> @@ -1528,7 +1529,7 @@ int omap_hwmod_register(struct omap_hwmod *oh)
>   	ret =3D 0;
>
>   ohr_unlock:
> -	mutex_unlock(&omap_hwmod_mutex);
> +	mutex_unlock(&_hwmod_list_mutex);
>   	return ret;
>   }
>
> @@ -1546,9 +1547,9 @@ struct omap_hwmod *omap_hwmod_lookup(const char=
 *name)
>   	if (!name)
>   		return NULL;
>
> -	mutex_lock(&omap_hwmod_mutex);
> +	mutex_lock(&_hwmod_list_mutex);
>   	oh =3D _lookup(name);
> -	mutex_unlock(&omap_hwmod_mutex);
> +	mutex_unlock(&_hwmod_list_mutex);
>
>   	return oh;
>   }
> @@ -1574,13 +1575,13 @@ int omap_hwmod_for_each(int (*fn)(struct omap=
_hwmod *oh, void *data),
>   	if (!fn)
>   		return -EINVAL;
>
> -	mutex_lock(&omap_hwmod_mutex);
> +	mutex_lock(&_hwmod_list_mutex);
>   	list_for_each_entry(temp_oh,&omap_hwmod_list, node) {
>   		ret =3D (*fn)(temp_oh, data);
>   		if (ret)
>   			break;
>   	}
> -	mutex_unlock(&omap_hwmod_mutex);
> +	mutex_unlock(&_hwmod_list_mutex);
>
>   	return ret;
>   }
> @@ -1663,10 +1664,10 @@ int omap_hwmod_unregister(struct omap_hwmod *=
oh)
>
>   	pr_debug("omap_hwmod: %s: unregistering\n", oh->name);
>
> -	mutex_lock(&omap_hwmod_mutex);
> +	mutex_lock(&_hwmod_list_mutex);
>   	iounmap(oh->_mpu_rt_va);
>   	list_del(&oh->node);
> -	mutex_unlock(&omap_hwmod_mutex);
> +	mutex_unlock(&_hwmod_list_mutex);
>
>   	return 0;
>   }
> @@ -2125,7 +2126,7 @@ int omap_hwmod_read_hardreset(struct omap_hwmod=
 *oh, const char *name)
>    * @user: arbitrary context data to pass to the callback function
>    *
>    * For each omap_hwmod of class @classname, call @fn.  Takes
> - * omap_hwmod_mutex to prevent the hwmod list from changing during t=
he
> + * _hwmod_list_mutex to prevent the hwmod list from changing during =
the
>    * iteration.  If the callback function returns something other tha=
n
>    * zero, the iterator is terminated, and the callback function's re=
turn
>    * value is passed back to the caller.  Returns 0 upon success, -EI=
NVAL
> @@ -2145,7 +2146,7 @@ int omap_hwmod_for_each_by_class(const char *cl=
assname,
>   	pr_debug("omap_hwmod: %s: looking for modules of class %s\n",
>   		 __func__, classname);
>
> -	mutex_lock(&omap_hwmod_mutex);
> +	mutex_lock(&_hwmod_list_mutex);
>
>   	list_for_each_entry(temp_oh,&omap_hwmod_list, node) {
>   		if (!strcmp(temp_oh->class->name, classname)) {
> @@ -2157,7 +2158,7 @@ int omap_hwmod_for_each_by_class(const char *cl=
assname,
>   		}
>   	}
>
> -	mutex_unlock(&omap_hwmod_mutex);
> +	mutex_unlock(&_hwmod_list_mutex);
>
>   	if (ret)
>   		pr_debug("omap_hwmod: %s: iterator terminated early: %d\n",
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
