From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] clk: don't use __initconst for non-const arrays
Date: Fri, 12 Sep 2014 09:42:29 +0200
Message-ID: <CAKv+Gu9LubyPHoYJsRfRoqgONAApb3nEoXAxUa9g6tecP=McOw@mail.gmail.com>
References: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20140911220445.GQ3755@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:41675 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbaILHmc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2014 03:42:32 -0400
Received: by mail-lb0-f175.google.com with SMTP id v6so386855lbi.6
        for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2014 00:42:29 -0700 (PDT)
In-Reply-To: <20140911220445.GQ3755@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, linux-samsung-soc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Tomasz Figa <tomasz.figa@gmail.com>, Tero Kristo <t-kristo@ti.com>, linux-rockchip@lists.infradead.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, kernel@pengutronix.de, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12 September 2014 00:04, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> On Thu, Sep 11, 2014 at 11:04:31PM +0200, Uwe Kleine-K=C3=B6nig wrote=
:
>>  /* Mux parent lists. */
>> -static const char *fin_pll_p[] __initconst =3D {
>> +static const char *fin_pll_p[] __initdata =3D {
>>       "xxti",
>>       "xusbxti"
>>  };
> As discussed with Tomasz on irc: The sad thing here is that for this
> array only 8 bytes are freed when .init.rodata is thrown away (that i=
s
> two pointers). The actual data---5 + 8 bytes + maybe aligning---isn't
> freed though.
>
> We wondered if there is a nice and easy way to throw away the
> characters, too.
>
> The only way I currently see is:
>
>         const char xxti[] __initconst =3D "xxti";
>         ...
>
>         static const char *fin_pll_p[] __initdata =3D {
>                 xxti,
>                 ...
>         };
>
> but this definitively doesn't qualify as "nice and easy". Is there an
> alternative?
>

What about doing

static const char fin_pll_p[][8] __initconst =3D {
     "xxti",
     "xusbxti"
};
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
