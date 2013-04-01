From: =?UTF-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?=
	<freemangordon@abv.bg>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Mon, 1 Apr 2013 23:37:11 +0300 (EEST)
Message-ID: <414980284.76676.1364848631348.JavaMail.apache@mail82.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.abv.bg ([194.153.145.99]:40414 "EHLO smtp-out.abv.bg"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757230Ab3DAUhN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Apr 2013 16:37:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, juha.yrjola@solidboot.com, linux@arm.linux.org.uk, mpm@selenic.com, herbert@gondor.apana.org.au, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

 It could be that I am misreading something, but RX51 is OMAP3.

Regards,
Ivo


 >-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------
 >=D0=9E=D1=82:  Tony Lindgren=20
 >=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: [PATCH] OMAP3 ROM Ran=
dom Number Generator support
 >=D0=94=D0=BE: =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE =D0=94=D0=B8=D0=BC=
=D0=B8=D1=82=D1=80=D0=BE=D0=B2=20
 >=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0: =
=D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D0=BD=D0=B8=D0=BA, 2013, =D0=
=90=D0=BF=D1=80=D0=B8=D0=BB 1 19:59:50 EEST
 >
 >
 >* =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE =D0=94=D0=B8=D0=BC=D0=B8=D1=82=
=D1=80=D0=BE=D0=B2  [130331 05:10]:
 >> =20
 >> Hi Pali,
 >>=20
 >> Yep, the code looks almost identical, I guess with some tweaks all =
SMC code from that patch could be removed and instead used the one from=
 SMC PPA API.=20
 >>=20
 >> What I don't get, is why one needs to disable/enable fiqs/irqs:
 >>=20
 >> +static int call_sec_rom(u32 appl_id, u32 proc_id, u32 flag, ...)
 >> +{
 >> +	va_list ap;
 >> +	u32 ret;
 >> +	u32 val;
 >> +
 >> +	va_start(ap, flag);
 >> +	val =3D *(u32 *) &amp;ap;
 >> +	local_irq_disable();
 >> +	local_fiq_disable();
 >> +	ret =3D omap3_rom_rng_call(appl_id, proc_id, flag,
 >> +				 (u32) virt_to_phys((void *) val));
 >> +	local_fiq_enable();
 >> +	local_irq_enable();
 >> +	va_end(ap);
 >> +
 >> +	return ret;
 >> +}
 >>=20
 >> Do you have any idea why is that needed? Any other code I've ever s=
een to call SM, does not disable fiqs/irqs, is RNG SMC somehow special?=
 I know this is Nokia's code, but still, if we can get some understandi=
ng...
 >
 >Sounds like the fiq handling can be dropped based on what
 >the TI guys posted recently about FIQs only be available in
 >the secure mode starting with omap2.
 >
 >Regards,
 >
 >Tony
 >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
