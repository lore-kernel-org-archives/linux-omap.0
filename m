From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH 09/13] Add dummy smsc911x regulators to omap3evm.
Date: Thu, 22 Mar 2012 00:16:13 -0700
Message-ID: <CA+Bv8XYuNdS_C8GbBog2d_bvJBYPA5FQwVApmhJQBfru-PQBpQ@mail.gmail.com>
References: <20120321194133.GP9859@atomide.com>
	<1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
	<1332393594-23993-10-git-send-email-Russ.Dill@ti.com>
	<8F060D80-6F86-49C2-A30F-A2728D48A025@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51715 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab2CVHQO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 03:16:14 -0400
Received: by pbcun15 with SMTP id un15so1383776pbc.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 00:16:13 -0700 (PDT)
In-Reply-To: <8F060D80-6F86-49C2-A30F-A2728D48A025@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org

On Thu, Mar 22, 2012 at 12:07 AM, Koen Kooi <koen@dominion.thruhere.net=
> wrote:
>
> Op 22 mrt. 2012, om 06:19 heeft Russ Dill het volgende geschreven:
>
>> Signed-off-by: Russ Dill <russ.dill@ti.com>
>> ---
>> arch/arm/mach-omap2/board-omap3evm.c | =C2=A0 15 ++++++---------
>> 1 files changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-om=
ap2/board-omap3evm.c
>> index a659e19..6a5e57c 100644
>> --- a/arch/arm/mach-omap2/board-omap3evm.c
>> +++ b/arch/arm/mach-omap2/board-omap3evm.c
>> @@ -114,15 +114,6 @@ static struct omap_smsc911x_platform_data smsc9=
11x_cfg =3D {
>>
>> static inline void __init omap3evm_init_smsc911x(void)
>> {
>> - =C2=A0 =C2=A0 struct clk *l3ck;
>> - =C2=A0 =C2=A0 unsigned int rate;
>> -
>> - =C2=A0 =C2=A0 l3ck =3D clk_get(NULL, "l3_ck");
>> - =C2=A0 =C2=A0 if (IS_ERR(l3ck))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rate =3D 100000000;
>> - =C2=A0 =C2=A0 else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rate =3D clk_get_rate(l3=
ck);
>
> The above hunk gets added/removed multiple times during this patch se=
ries, a rebase -i mishap?

Yes, its a rebase -i mishap. I have no idea how it did that as all I
was doing was rewording. I can resend the series
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
