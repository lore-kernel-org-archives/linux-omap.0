From: Artem Bityutskiy <dedekind@yandex.ru>
Subject: Re: [PATCH][UPDATED] DSPBRIDGE: CLK_Enable and CLK_Disable Code cleanup
Date: Fri, 17 Apr 2009 18:49:33 +0300
Message-ID: <49E8A50D.2010602@yandex.ru>
References: <49E89649.9050103@yandex.ru> <1239981547-30944-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57870 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565AbZDQPtr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 11:49:47 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3HFn6Ne008574
	for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2009 10:49:46 -0500
In-Reply-To: <1239981547-30944-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org

I'm sorry. Authors of the code may delete this e-mail.
More flame and suggestions.

Ameya Palande wrote:
> diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/s=
ervices/clk.c
> index 440706f..b45603f 100644
> --- a/drivers/dsp/bridge/services/clk.c
> +++ b/drivers/dsp/bridge/services/clk.c
> @@ -188,7 +188,7 @@ DSP_STATUS CLK_Enable(IN enum SERVICES_ClkId clk_=
id)
>  	struct clk *pClk;
> =20
>  	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
> -       GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Enable: CLK %s, "
> +	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Enable: CLK %s, "
>  		"CLK dev id =3D %d\n", SERVICES_Clks[clk_id].clk_name,
>  		SERVICES_Clks[clk_id].id);

Is it possible to get rid of this crap? I mean trace.
=46irst of all, if you pretend your code is production-ready,
you should not need that much of this. Second of all, we
have tools like ftrace.

> =20
> @@ -197,18 +197,16 @@ DSP_STATUS CLK_Enable(IN enum SERVICES_ClkId cl=
k_id)
>  		if (clk_enable(pClk) =3D=3D 0x0) {
>  			/* Success ? */
>  		} else {
> -		       GT_2trace(CLK_debugMask, GT_7CLASS,
> -				 "CLK_Enable: failed to Enable CLK %s, "
> -				 "CLK dev id =3D %d\n",
> -				 SERVICES_Clks[clk_id].clk_name,
> -				 SERVICES_Clks[clk_id].id);
> +			pr_err("CLK_Enable: failed to Enable CLK %s, "
> +					"CLK dev id =3D %d\n",
> +					SERVICES_Clks[clk_id].clk_name,
> +					SERVICES_Clks[clk_id].id);

Is it possible to wake up, and realize you are writing
linux kernel code, and realize you should socialize?
Namely, these marginal naming conventions you use are
absolutely anti-social. DSPBRIGE is around for quite a
time already, its time to start socializing.

>  	} else if (clkUseCnt =3D=3D 0) {
> -	       GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Disable: CLK %s, "
> -			"CLK dev id=3D %d is already disabled\n",
> -			SERVICES_Clks[clk_id].clk_name,
> -			SERVICES_Clks[clk_id].id);
> +		pr_err("CLK_Disable: CLK %s, CLK dev id=3D %d is already"
> +				"disabled\n",
> +				SERVICES_Clks[clk_id].clk_name,
> +				SERVICES_Clks[clk_id].id);
>  		 return status;
>  	}
>  	if (clk_id =3D=3D SERVICESCLK_ssi_ick)
> @@ -291,10 +289,10 @@ DSP_STATUS CLK_Disable(IN enum SERVICES_ClkId c=
lk_id)

Is it possible to stop using excessive enums? This is not
C++, and C does not do any type-checking. Named enums
make almost zero sense.

> diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge=
/wmd/tiomap3430.c
> index df350c6..fb71e96 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
> @@ -2240,7 +2240,6 @@ static DSP_STATUS run_IdleBoot(u32 prm_base, u3=
2 cm_base,
>  {
>  	u32 temp;
>  	DSP_STATUS status =3D DSP_SOK;
> -	DSP_STATUS clk_status =3D DSP_SOK;

Is it possible to remove these insane types. Use normal types.

>  	enum HW_PwrState_t    pwrState;

Similar. What is the point of enums like this? Obfuscate
the code?

>  	udelay(20);
>  	GetHWRegs(prm_base, cm_base);
>  	/* Release Reset1 and Reset2 */
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/br=
idge/wmd/tiomap3430_pwr.c
> index 488a512..ffe2e3c 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> @@ -285,7 +285,7 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevCo=
ntext, IN void *pArgs)
>  #ifdef CONFIG_PM
>  	struct CFG_HOSTRES resources;
>  	enum HW_PwrState_t pwrState;
> -       u32 temp;
> +	u32 temp;

I'm not 100% sure about this particular case, but overall,
the code excessively uses these u32 types. This makse few
sense. Unless you work with registers, packets, or something
which needs some strict types, use int or long. Use natural
C types. Do not try to be too smart, do not try to limit
CPU and compiler by u32, if it is not necessary.


--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
