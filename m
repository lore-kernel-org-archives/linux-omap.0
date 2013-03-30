From: =?UTF-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?=
	<freemangordon@abv.bg>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Sun, 31 Mar 2013 00:31:18 +0200 (EET)
Message-ID: <1838509461.25809.1364682678664.JavaMail.apache@mail83.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=20
Hi,

 >-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------
 >=D0=9E=D1=82:  Pavel Machek=20
 >=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: [PATCH] arm: omap: RX=
-51: ARM errata 430973 workaround
 >=D0=94=D0=BE: Pali Roh=C3=A1r=20
 >=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0: =
=D0=A1=D1=8A=D0=B1=D0=BE=D1=82=D0=B0, 2013, =D0=9C=D0=B0=D1=80=D1=82 30=
 20:36:54 EET
 >
 >
 >Hi!
 >
 >> +u32 rx51_secure_dispatcher(u32 idx, u32 flag, u32 nargs, u32 arg1,=
 u32 arg2,
 >> +			   u32 arg3, u32 arg4)
 >> +{
 >> +	u32 ret;
 >> +	u32 param[5];
 >> +
 >> +	param[0] =3D nargs+1;
 >> +	param[1] =3D arg1;
 >> +	param[2] =3D arg2;
 >> +	param[3] =3D arg3;
 >> +	param[4] =3D arg4;
 >> +
 >> +	/*
 >> +	 * Secure API needs physical address
 >> +	 * pointer for the parameters
 >> +	 */
 >> +	flush_cache_all();
 >> +	outer_clean_range(__pa(param), __pa(param + 5));
 >> +	ret =3D rx51_ppa_smc(idx, flag, __pa(param));
 >> +
 >> +	return ret;
 >> +}
 >
 >You can do without ret variable... Also more detailed changelog would
 >be nice... like what exact problem this works around.
 >

Sure i can, but I don't see a reason to ignore SM's return value. Chang=
elog of what?
 >
 >
 >So... some CPU errata where code sharing virtual addresses could be
 >executed improperly?
 >							=09
 >> @@ -103,6 +104,12 @@ static void __init rx51_init(void)
 >>  	rx51_peripherals_init();
 >>  	rx51_camera_init();
 >> =20
 >> +#ifdef CONFIG_ARM_ERRATA_430973
 >> +	printk(KERN_INFO &quot;Enabling ARM errata 430973 workaround.&#92=
;n&quot;);
 >> +	/* set IBE to 1 */
 >> +	rx51_secure_update_aux_cr(1 << 6, 0);
 >> +#endif
 >> +
 >
 >Thanks,
 >								Pavel
 >
 >--=20
 >(english) http://www.livejournal.com/~pavelmachek
 >(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
 >

I guess if you read the thread over the ML you'll have your questions a=
lready answered.=20
Or google for "ARM errata 430973 workaround" :).

Regards,
Ivo
