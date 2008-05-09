From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] powerdomain: convert pwrdm_mutex to rwsem
Date: Fri, 9 May 2008 14:42:50 -0700
Message-ID: <20080509214250.GC5976@atomide.com>
References: <alpine.DEB.1.00.0805071840260.8498@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54048 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbYEIVmv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2008 17:42:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805071840260.8498@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, jouni.hogander@nokia.com

* Paul Walmsley <paul@pwsan.com> [080507 17:42]:
>=20
> Convert pwrdm_mutex to pwrdm_rwsem to avoid trying to relock mutex in=
 the=20
> event that the pwrdm_for_each() callback function calls something tha=
t=20
> triggers a pwrdm_lookup().  Problem found by Jouni H=F6gander=20
> <jouni.hogander@nokia.com>

Pushing.

Tony


>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>=20
> ---
>=20
>  arch/arm/mach-omap2/powerdomain.c |   69 ++++++++++++++++++++-------=
----------
>  1 files changed, 37 insertions(+), 32 deletions(-)
>=20
>=20
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index dd9f40e..e1cfbbb 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -18,7 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/delay.h>
> -#include <linux/mutex.h>
> +#include <linux/rwsem.h>
>  #include <linux/list.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
> @@ -37,8 +37,12 @@
>  /* pwrdm_list contains all registered struct powerdomains */
>  static LIST_HEAD(pwrdm_list);
> =20
> -/* pwrdm_mutex protects pwrdm_list add and del ops */
> -static DEFINE_MUTEX(pwrdm_mutex);
> +/*=20
> + * pwrdm_rwsem protects pwrdm_list add and del ops - also reused to=20
> + * protect pwrdm_clkdms[] during clkdm add/del ops
> + */
> +static DECLARE_RWSEM(pwrdm_rwsem);
> +
> =20
>  /* Private functions */
> =20
> @@ -135,7 +139,7 @@ int pwrdm_register(struct powerdomain *pwrdm)
>  	if (!omap_chip_is(pwrdm->omap_chip))
>  		return -EINVAL;
> =20
> -	mutex_lock(&pwrdm_mutex);
> +	down_write(&pwrdm_rwsem);
>  	if (_pwrdm_lookup(pwrdm->name)) {
>  		ret =3D -EEXIST;
>  		goto pr_unlock;
> @@ -147,7 +151,7 @@ int pwrdm_register(struct powerdomain *pwrdm)
>  	ret =3D 0;
> =20
>  pr_unlock:
> -	mutex_unlock(&pwrdm_mutex);
> +	up_write(&pwrdm_rwsem);
> =20
>  	return ret;
>  }
> @@ -164,9 +168,9 @@ int pwrdm_unregister(struct powerdomain *pwrdm)
>  	if (!pwrdm)
>  		return -EINVAL;
> =20
> -	mutex_lock(&pwrdm_mutex);
> +	down_write(&pwrdm_rwsem);
>  	list_del(&pwrdm->node);
> -	mutex_unlock(&pwrdm_mutex);
> +	up_write(&pwrdm_rwsem);
> =20
>  	pr_debug("powerdomain: unregistered %s\n", pwrdm->name);
> =20
> @@ -187,9 +191,9 @@ struct powerdomain *pwrdm_lookup(const char *name=
)
>  	if (!name)
>  		return NULL;
> =20
> -	mutex_lock(&pwrdm_mutex);
> +	down_read(&pwrdm_rwsem);
>  	pwrdm =3D _pwrdm_lookup(name);
> -	mutex_unlock(&pwrdm_mutex);
> +	up_read(&pwrdm_rwsem);
> =20
>  	return pwrdm;
>  }
> @@ -198,15 +202,15 @@ struct powerdomain *pwrdm_lookup(const char *na=
me)
>   * pwrdm_for_each - call function on each registered clockdomain
>   * @fn: callback function *
>   *
> - * Call the supplied function for each registered powerdomain.
> - * The callback function can return anything but 0 to bail
> - * out early from the iterator.	 The callback function is called wit=
h
> - * the pwrdm_mutex held, so no powerdomain structure manipulation
> + * Call the supplied function for each registered powerdomain.  The
> + * callback function can return anything but 0 to bail out early fro=
m
> + * the iterator.  The callback function is called with the pwrdm_rws=
em
> + * held for reading, so no powerdomain structure manipulation
>   * functions should be called from the callback, although hardware
>   * powerdomain control functions are fine.  Returns the last return
>   * value of the callback function, which should be 0 for success or
> - * anything else to indicate failure; or -EINVAL if the function poi=
nter
> - * is null.
> + * anything else to indicate failure; or -EINVAL if the function
> + * pointer is null.
>   */
>  int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm))
>  {
> @@ -216,13 +220,13 @@ int pwrdm_for_each(int (*fn)(struct powerdomain=
 *pwrdm))
>  	if (!fn)
>  		return -EINVAL;
> =20
> -	mutex_lock(&pwrdm_mutex);
> +	down_read(&pwrdm_rwsem);
>  	list_for_each_entry(temp_pwrdm, &pwrdm_list, node) {
>  		ret =3D (*fn)(temp_pwrdm);
>  		if (ret)
>  			break;
>  	}
> -	mutex_unlock(&pwrdm_mutex);
> +	up_read(&pwrdm_rwsem);
> =20
>  	return ret;
>  }
> @@ -247,7 +251,8 @@ int pwrdm_add_clkdm(struct powerdomain *pwrdm, st=
ruct clockdomain *clkdm)
> =20
>  	pr_debug("powerdomain: associating clockdomain %s with powerdomain =
"
>  		 "%s\n", clkdm->name, pwrdm->name);
> -	mutex_lock(&pwrdm_mutex);
> +
> +	down_write(&pwrdm_rwsem);
> =20
>  	for (i =3D 0; i < PWRDM_MAX_CLKDMS; i++) {
>  		if (!pwrdm->pwrdm_clkdms[i])
> @@ -273,13 +278,13 @@ int pwrdm_add_clkdm(struct powerdomain *pwrdm, =
struct clockdomain *clkdm)
>  	ret =3D 0;
> =20
>  pac_exit:
> -	mutex_unlock(&pwrdm_mutex);
> +	up_write(&pwrdm_rwsem);
> =20
>  	return ret;
>  }
> =20
>  /**
> - * pwrdm_del_clkdm - remove a clockdomain to a powerdomain
> + * pwrdm_del_clkdm - remove a clockdomain from a powerdomain
>   * @pwrdm: struct powerdomain * to add the clockdomain to
>   * @clkdm: struct clockdomain * to associate with a powerdomain
>   *
> @@ -299,25 +304,25 @@ int pwrdm_del_clkdm(struct powerdomain *pwrdm, =
struct clockdomain *clkdm)
>  	pr_debug("powerdomain: dissociating clockdomain %s from powerdomain=
 "
>  		 "%s\n", clkdm->name, pwrdm->name);
> =20
> -	mutex_lock(&pwrdm_mutex);
> -
> +	down_write(&pwrdm_rwsem);
> +=09
>  	for (i =3D 0; i < PWRDM_MAX_CLKDMS; i++)
>  		if (pwrdm->pwrdm_clkdms[i] =3D=3D clkdm)
>  			break;
> -
> +=09
>  	if (i =3D=3D PWRDM_MAX_CLKDMS) {
>  		pr_debug("powerdomain: clkdm %s not associated with pwrdm "
>  			 "%s ?!\n", clkdm->name, pwrdm->name);
>  		ret =3D -ENOENT;
>  		goto pdc_exit;
>  	}
> -
> +=09
>  	pwrdm->pwrdm_clkdms[i] =3D NULL;
> -
> +	=09
>  	ret =3D 0;
> =20
>  pdc_exit:
> -	mutex_unlock(&pwrdm_mutex);
> +	up_write(&pwrdm_rwsem);
> =20
>  	return ret;
>  }
> @@ -330,10 +335,10 @@ pdc_exit:
>   * Call the supplied function for each clockdomain in the powerdomai=
n
>   * 'pwrdm'.  The callback function can return anything but 0 to bail
>   * out early from the iterator.  The callback function is called wit=
h
> - * the pwrdm_mutex held, so no powerdomain structure manipulation
> - * functions should be called from the callback, although hardware
> - * powerdomain control functions are fine.  Returns -EINVAL if
> - * presented with invalid pointers; or passes along the last return
> + * the pwrdm_rwsem held for reading, so no powerdomain structure
> + * manipulation functions should be called from the callback, althou=
gh
> + * hardware powerdomain control functions are fine.  Returns -EINVAL
> + * if presented with invalid pointers; or passes along the last retu=
rn
>   * value of the callback function, which should be 0 for success or
>   * anything else to indicate failure.
>   */
> @@ -347,12 +352,12 @@ int pwrdm_for_each_clkdm(struct powerdomain *pw=
rdm,
>  	if (!fn)
>  		return -EINVAL;
> =20
> -	mutex_lock(&pwrdm_mutex);
> +	down_read(&pwrdm_rwsem);
> =20
>  	for (i =3D 0; i < PWRDM_MAX_CLKDMS && !ret; i++)
>  		ret =3D (*fn)(pwrdm, pwrdm->pwrdm_clkdms[i]);
> =20
> -	mutex_unlock(&pwrdm_mutex);
> +	up_read(&pwrdm_rwsem);
> =20
>  	return ret;
>  }
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
