From: Artem Bityutskiy <dedekind@yandex.ru>
Subject: Re: [PATCH] OMAP3: lessen amount of noisy messages
Date: Wed, 15 Apr 2009 15:22:32 +0300
Message-ID: <49E5D188.8060508@yandex.ru>
References: <1239288072.3390.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63672 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758937AbZDOMXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 08:23:13 -0400
In-Reply-To: <1239288072.3390.8.camel@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind@infradead.org
Cc: Tony Lindgen <tony@atomide.com>, linux-omap@vger.kernel.org

Artem Bityutskiy wrote:
> From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> Date: Thu, 9 Apr 2009 17:15:47 +0300
> Subject: [PATCH] OMAP3: lessen amount of noisy messages
>=20
> On our system we see the following messages:
>=20
> Disabling unused clock "gpt2_ick"
> Disabling unused clock "gpt3_ick"
> Disabling unused clock "gpt4_ick"
> Disabling unused clock "gpt5_ick"
> Disabling unused clock "gpt6_ick"
> Disabling unused clock "gpt7_ick"
> Disabling unused clock "gpt8_ick"
> Disabling unused clock "gpt9_ick"
> Disabling unused clock "gpio2_dbck"
> Disabling unused clock "gpio3_dbck"
> Disabling unused clock "gpio4_dbck"
> Disabling unused clock "gpio5_dbck"
> Disabling unused clock "gpio6_dbck"
> Disabling unused clock "gpt9_fck"
> Disabling unused clock "gpt8_fck"
> Disabling unused clock "gpt7_fck"
> Disabling unused clock "gpt6_fck"
> Disabling unused clock "gpt5_fck"
> Disabling unused clock "gpt4_fck"
> Disabling unused clock "gpt3_fck"
> Disabling unused clock "gpt2_fck"
> Disabling unused clock "wdt2_ick"
> Disabling unused clock "wdt2_fck"
> Disabling unused clock "gpio1_dbck"
> Disabling unused clock "rng_ick"
> Disabling unused clock "ssi_ick"
> Disabling unused clock "gpt10_ick"
> Disabling unused clock "gpt11_ick"
> Disabling unused clock "uart1_ick"
> Disabling unused clock "uart2_ick"
> Disabling unused clock "usbtll_ick"
> Disabling unused clock "ssi_ssr_fck"
> Disabling unused clock "uart1_fck"
> Disabling unused clock "uart2_fck"
> Disabling unused clock "usbtll_fck"
> Disabling unused clock "ts_fck"
> Disabling unused clock "cpefuse_fck"
> Disabling unused clock "gpt11_fck"
> Disabling unused clock "gpt10_fck"
> Disabling unused clock "dpll5_ck"
> Disabling unused clock "dpll4_m6x2_ck"
> Disabling unused clock "dpll4_m5x2_ck"
> Disabling unused clock "dpll3_m3x2_ck"
> Disabling unused clock "sys_clkout1"
>=20
> The messages have KERN_INFO level and if you have serial
> console, they normally go there. I do not think it is good
> idea to print that much stuff there. Moreover, messages
> are not properly prefixed and for mortals it is not
> immeadietly clear where they come from.
>=20
> Let's give them debugging level instead.
>=20
> Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

Hi, what is the destiny of this patch?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
