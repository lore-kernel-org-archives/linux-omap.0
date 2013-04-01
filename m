From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] ARM:OMAP2: an issue about curr_pwrst, u8 is never < 0
Date: Mon, 01 Apr 2013 18:41:11 +0800
Message-ID: <51596447.9070000@asianux.com>
References: <51415048.6000607@asianux.com> <alpine.DEB.2.00.1304011024090.28273@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:10542 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758507Ab3DAKmN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 06:42:13 -0400
In-Reply-To: <alpine.DEB.2.00.1304011024090.28273@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org

On 2013=E5=B9=B404=E6=9C=8801=E6=97=A5 18:25, Paul Walmsley wrote:
> Hi,
>=20
> On Thu, 14 Mar 2013, Chen Gang wrote:
>=20
>>
>>   if pwrdm_read_pwrst returns negative number, curr_pwrst can not no=
tice it.
>>   since really need check curr_pwrst whether is negative,
>>     need let the check valid in _pwrdm_save_clkdm_state_and_activate=
=2E
>>     and also better to check the return value of pwrdm_read_pwrst, f=
irstly.
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>=20
> thanks for reporting this and sending a suggested fix.  The following=
=20
> patch is what I've queued here, which should deal with the root cause=
=20
> without the casts.
>=20
>=20

  yours (patch below) is simpler and clearer than mine.

  thanks.

  :-)


> - Paul
>=20
> From: Paul Walmsley <paul@pwsan.com>
> Date: Sun, 31 Mar 2013 20:22:22 -0600
> Subject: [PATCH] ARM: OMAP2+: powerdomain: avoid testing whether an u=
nsigned
>  char is less than 0
>=20
> _pwrdm_save_clkdm_state_and_activate() tried to test one of its
> unsigned arguments to determine whether it was less than zero.  Fix b=
y
> moving the error test to the caller.
>=20
> Reported-by: Chen Gang <gang.chen@asianux.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |   18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index 8e61d80..89cad4a 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -52,7 +52,6 @@ enum {
>  #define ALREADYACTIVE_SWITCH		0
>  #define FORCEWAKEUP_SWITCH		1
>  #define LOWPOWERSTATE_SWITCH		2
> -#define ERROR_SWITCH			3
> =20
>  /* pwrdm_list contains all registered struct powerdomains */
>  static LIST_HEAD(pwrdm_list);
> @@ -233,10 +232,7 @@ static u8 _pwrdm_save_clkdm_state_and_activate(s=
truct powerdomain *pwrdm,
>  {
>  	u8 sleep_switch;
> =20
> -	if (curr_pwrst < 0) {
> -		WARN_ON(1);
> -		sleep_switch =3D ERROR_SWITCH;
> -	} else if (curr_pwrst < PWRDM_POWER_ON) {
> +	if (curr_pwrst < PWRDM_POWER_ON) {
>  		if (curr_pwrst > pwrst &&
>  		    pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE &&
>  		    arch_pwrdm->pwrdm_set_lowpwrstchange) {
> @@ -1091,7 +1087,8 @@ int pwrdm_post_transition(struct powerdomain *p=
wrdm)
>   */
>  int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
>  {
> -	u8 curr_pwrst, next_pwrst, sleep_switch;
> +	u8 next_pwrst, sleep_switch;
> +	int curr_pwrst;
>  	int ret =3D 0;
>  	bool hwsup =3D false;
> =20
> @@ -1107,16 +1104,17 @@ int omap_set_pwrdm_state(struct powerdomain *=
pwrdm, u8 pwrst)
>  	pwrdm_lock(pwrdm);
> =20
>  	curr_pwrst =3D pwrdm_read_pwrst(pwrdm);
> +	if (curr_pwrst < 0) {
> +		ret =3D -EINVAL;
> +		goto osps_out;
> +	}
> +
>  	next_pwrst =3D pwrdm_read_next_pwrst(pwrdm);
>  	if (curr_pwrst =3D=3D pwrst && next_pwrst =3D=3D pwrst)
>  		goto osps_out;
> =20
>  	sleep_switch =3D _pwrdm_save_clkdm_state_and_activate(pwrdm, curr_p=
wrst,
>  							    pwrst, &hwsup);
> -	if (sleep_switch =3D=3D ERROR_SWITCH) {
> -		ret =3D -EINVAL;
> -		goto osps_out;
> -	}
> =20
>  	ret =3D pwrdm_set_next_pwrst(pwrdm, pwrst);
>  	if (ret)
>=20


--=20
Chen Gang

Asianux Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
