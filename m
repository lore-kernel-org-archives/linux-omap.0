From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP1: pm.c : fix warning
Date: Wed, 4 Jan 2006 17:19:57 -0800
Message-ID: <20060105011956.GF4286@atomide.com>
References: <20060104164108.22099.qmail@web32913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060104164108.22099.qmail@web32913.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060104 08:47]:
> Tony,
>=20
> Attached patch fixes following warning:
>=20
> arch/arm/mach-omap1/pm.c: In function `omap_pm_idle':
> arch/arm/mach-omap1/pm.c:140: warning: unused variable `vbus_active'
>=20
> Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>
>=20
> ---Komal Shah
> http://komalshah.blogspot.com/
>=20
>=20
> 	=09
> __________________________________________=20
> Yahoo! DSL =96 Something to write home about.=20
> Just $16.99/mo. or less.=20
> dsl.yahoo.com=20

Content-Description: 2034432102-pm-fix.patch
> diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
> index 382ddaa..d483ac4 100644
> --- a/arch/arm/mach-omap1/pm.c
> +++ b/arch/arm/mach-omap1/pm.c
> @@ -137,9 +137,9 @@ void omap_pm_idle(void)
> =20
>  	do_sleep =3D 0;
>  	while (enable_dyn_sleep) {
> -		extern int vbus_active;
> =20
>  #ifdef CONFIG_CBUS_TAHVO_USB
> +		extern int vbus_active;
>  		/* Clock requirements? */
>  		if (vbus_active)
>  			break;

Thanks, pushed.

Tony
