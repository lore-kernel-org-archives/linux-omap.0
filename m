From: Tony Lindgren <tony@atomide.com>
Subject: Re: TLV320AIC23 not patched
Date: Tue, 28 Oct 2008 09:40:31 -0700
Message-ID: <20081028164030.GF7539@atomide.com>
References: <490702CC.9070008@instramed.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57841 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYJ1Qkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Oct 2008 12:40:35 -0400
Content-Disposition: inline
In-Reply-To: <490702CC.9070008@instramed.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Ram=F3n?= Finger Lilienthal <ramon@instramed.com.br>
Cc: linux-omap@vger.kernel.org

Hi,

* Ram=C3=B3n Finger Lilienthal <ramon@instramed.com.br> [081028 05:17]:
> Fellows,
>
> I have just got the v2.6.28-rc2, and errors while compiling still hap=
pening.

We're in process of getting rid of all the various old audio drivers
for omap. The new way is to use the ASoC drivers, see sound/soc/omap
and sound/soc/codecs.

Regards,

Tony


> ---
> CHK include/linux/compile.h
> CC drivers/i2c/chips/tlv320aic23.o
> drivers/i2c/chips/tlv320aic23.c: In function =E2=80=98omap_mcbsp3_aic=
23_clock_init=E2=80=99:
> drivers/i2c/chips/tlv320aic23.c:113: error: implicit declaration of =20
> function =E2=80=98OMAP_MCBSP_WRITE=E2=80=99
> drivers/i2c/chips/tlv320aic23.c:113: error: =E2=80=98SPCR1=E2=80=99 u=
ndeclared (first =20
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:113: error: (Each undeclared identifi=
er =20
> is reported only once
> drivers/i2c/chips/tlv320aic23.c:113: error: for each function it appe=
ars =20
> in.)
> drivers/i2c/chips/tlv320aic23.c:114: error: =E2=80=98SPCR2=E2=80=99 u=
ndeclared (first =20
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:117: error: =E2=80=98PCR0=E2=80=99 un=
declared (first use =20
> in this function)
> drivers/i2c/chips/tlv320aic23.c:120: error: =E2=80=98SRGR1=E2=80=99 u=
ndeclared (first =20
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:121: error: =E2=80=98SRGR2=E2=80=99 u=
ndeclared (first =20
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:124: error: implicit declaration of =20
> function =E2=80=98OMAP_MCBSP_READ=E2=80=99
> make[3]: *** [drivers/i2c/chips/tlv320aic23.o] Error 1
> make[2]: *** [drivers/i2c/chips] Error 2
> make[1]: *** [drivers/i2c] Error 2
> make: *** [drivers] Error 2
> ---
>
> These errors was solved by some patchs in August. Why these patchs =20
> wasn't applied in the kernel tree?
>
>
> --=20
> Regards,
> Eng. Ramon F. Lilienthal
> Project Engineer
> Instramed Ltda. - www.instramed.com.br
> +55 (51) 33344199 ext. 213
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
