From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Thu, 2 May 2013 14:45:43 -0400
Message-ID: <5182B457.5030009@ti.com>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk> <20130502153834.GR28721@atomide.com> <51829D65.7040109@ti.com> <201305022003.27037.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2RQKVFPTWGTUNJCXFUQVL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45839 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761813Ab3EBSqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 May 2013 14:46:37 -0400
In-Reply-To: <201305022003.27037.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Neil Brown <neilb@suse.de>, Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Durgadoss R <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

------enig2RQKVFPTWGTUNJCXFUQVL
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 02-05-2013 14:03, Arnd Bergmann wrote:
> On Thursday 02 May 2013, Eduardo Valentin wrote:
>> index e3c0ae9..e3f3cba 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -250,12 +250,6 @@ void thermal_unregister_governor(struct
>> thermal_governor *);
>>  #ifdef CONFIG_NET
>>  extern int thermal_generate_netlink_event(struct thermal_zone_device =
*tz,
>>                                                 enum events event);
>> -#else
>> -static int thermal_generate_netlink_event(struct thermal_zone_device =
*tz,
>> -                                               enum events event)
>> -{
>> -       return 0;
>> -}
>>  #endif
>=20
> Actually it seems this bug is already fixed in linux-next:
>=20
> commit f8b587055a793c7719f0d4f41b7b4aeeef43aa2d
> Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date:   Wed Mar 20 21:38:07 2013 +0000
>=20
>     thermal: Fix compiler warning
>    =20
>     The following warning is obtained when CONFIG_NET is not defined:
>    =20
>     In file included from drivers/thermal/mvebu_thermal.c:27:0:
>     include/linux/thermal.h:254:12: warning: 'thermal_generate_netlink_=
event'
>     defined but not used [-Wunused-function]
>    =20
>     This patch fixes the warning by properly inlining
>     thermal_generate_netlink_event().
>    =20
>     Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>=

>     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>=20
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f0bd7f9..fd7b8f3 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -251,7 +251,7 @@ void thermal_unregister_governor(struct thermal_gov=
ernor *);
>  extern int thermal_generate_netlink_event(struct thermal_zone_device *=
tz,
>                                                 enum events event);
>  #else
> -static int thermal_generate_netlink_event(struct thermal_zone_device *=
tz,
> +static inline int thermal_generate_netlink_event(struct thermal_zone_d=
evice *tz,
>                                                 enum events event)
>  {
>         return 0;
>=20
>=20
> Your patch also seems correct, but it would conflict with Ezequiel's.
> The problem was apparently that you removed the 'inline' keyword
> in 8ab3e6a08a "thermal: Use thermal zone device id in netlink messages"=
,
> I assume by accident, since defining a non-inline function in a header
> file is obviously wrong.

Yeah, that was my bad. I am fine with Ezequiel s patch.

Thanks.

>=20
> 	Arnd
>=20
>=20



------enig2RQKVFPTWGTUNJCXFUQVL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGCtFcACgkQCXcVR3XQvP3S1QEA5eW+Nf16ABtkldz7aPykVvQm
3Rrmxq1qwupjox3o8rwBAOJQrw9Aaa4t4vYoQMfHnOw6CoJF0g8jpEXz4VQFHE0l
=Ep71
-----END PGP SIGNATURE-----

------enig2RQKVFPTWGTUNJCXFUQVL--
