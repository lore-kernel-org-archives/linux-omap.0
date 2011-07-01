From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC 07/12] omap: mcbsp: Get rid of remaining is_omap tests
Date: Fri, 1 Jul 2011 17:05:17 +0300
Message-ID: <20110701170517.8b13c94d.jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
	<1309510356-27147-8-git-send-email-jhnikula@gmail.com>
	<CA+HSevrUgP8pKNjSgkpDB6hUX=cvCUOU8mpU2Ca5qa75Rnp36w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57667 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598Ab1GAOFV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 10:05:21 -0400
Received: by bwd5 with SMTP id 5so2633143bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 07:05:19 -0700 (PDT)
In-Reply-To: <CA+HSevrUgP8pKNjSgkpDB6hUX=cvCUOU8mpU2Ca5qa75Rnp36w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Hi

On Fri, 1 Jul 2011 16:41:23 +0530
"Varadarajan, Charulatha" <charu@ti.com> wrote:

> > @@ -712,7 +710,7 @@ static inline void omap34xx_mcbsp_free(struct o=
map_mcbsp *mcbsp)
> > =A0 =A0 =A0 =A0/*
> > =A0 =A0 =A0 =A0 * Disable wakup behavior, smart idle and all wakeup=
s
> > =A0 =A0 =A0 =A0 */
> > - =A0 =A0 =A0 if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> > + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type >=3D MCBSP_CONFIG_TYPE3)=
 {
>=20
>=20
> I think that it would be a good idea to not use
> MCBSP_CONFIG_TYPE* in plat-omap/* as it is the .rev info.
> At later point of time, this might make the code look uglier
> as it happened with GPIO_METHOD_* flags in OMAP GPIO driver.
> Instead use this .rev info in mach-omap*/ to fill the pdata and pass =
it
> to driver.
>=20
Exactly and this is already a little uggly here. Kind of simple
replacement for cpu_is_omap tests and definitely must be replaced with
some feature flags before moving code outside of plat-omap.

--=20
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
