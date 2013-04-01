From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Mon, 1 Apr 2013 09:59:50 -0700
Message-ID: <20130401165949.GI10155@atomide.com>
References: <2059303614.30062.1364731542427.JavaMail.apache@mail83.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11092 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759000Ab3DARAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 13:00:10 -0400
Content-Disposition: inline
In-Reply-To: <2059303614.30062.1364731542427.JavaMail.apache@mail83.abv.bg>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, juha.yrjola@solidboot.com, linux@arm.linux.org.uk, mpm@selenic.com, herbert@gondor.apana.org.au, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE =D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=
=80=D0=BE=D0=B2 <freemangordon@abv.bg> [130331 05:10]:
> =20
> Hi Pali,
>=20
> Yep, the code looks almost identical, I guess with some tweaks all SM=
C code from that patch could be removed and instead used the one from S=
MC PPA API.=20
>=20
> What I don't get, is why one needs to disable/enable fiqs/irqs:
>=20
> +static int call_sec_rom(u32 appl_id, u32 proc_id, u32 flag, ...)
> +{
> +	va_list ap;
> +	u32 ret;
> +	u32 val;
> +
> +	va_start(ap, flag);
> +	val =3D *(u32 *) &ap;
> +	local_irq_disable();
> +	local_fiq_disable();
> +	ret =3D omap3_rom_rng_call(appl_id, proc_id, flag,
> +				 (u32) virt_to_phys((void *) val));
> +	local_fiq_enable();
> +	local_irq_enable();
> +	va_end(ap);
> +
> +	return ret;
> +}
>=20
> Do you have any idea why is that needed? Any other code I've ever see=
n to call SM, does not disable fiqs/irqs, is RNG SMC somehow special? I=
 know this is Nokia's code, but still, if we can get some understanding=
=2E..

Sounds like the fiq handling can be dropped based on what
the TI guys posted recently about FIQs only be available in
the secure mode starting with omap2.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
