From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
Date: Thu, 21 Apr 2011 19:02:43 +0530
Message-ID: <BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
	<alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:34670 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750981Ab1DUNco convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 09:32:44 -0400
Received: by mail-bw0-f43.google.com with SMTP id 14so1665490bwz.30
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 06:32:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi,

On Thu, Apr 21, 2011 at 1:25 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Wed, 20 Apr 2011, Shweta Gulati wrote:
>
>> From: Gulati, Shweta <shweta.gulati@ti.com>
>>
>> Core Clk Tree shows incorrect Clk rates at OPP50, as
>> in commit e07f469d284ca3d1f5dcf5438c22982be98bc071
>> calling of 'recalc' in API clk_set_rate is unintentionally
>> removed,
>
> That's intentional. =A0struct clk.set_rate functions need to set the =
struct
> clk.rate before returning. =A0If they don't do that, it's a bug in th=
e
> struct clk's .set_rate function.
Yes, but in current code clk_set_rate of dpll3_m2 -
'omap3_core_dpll_m2_set_rate'
doesn't update clk.rate, I will submit patch fixing that bug and will
make sure that
set_rate of all clocks should update clk.rate
>
>> because of which clock's tree rates get goofed up when DVFS happens.
>
> Clearly this isn't on the mainline kernel...
If you check for OPP50, the core clocks would show wrong rates.

Thanks for reviewing.
>
>> This Patch adds recalc API back.
>>
>> Tested on OMAP3630 SDP Board.
>>
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Paul Wamsley <paul@pwsan.com>
>> ---
>> =A0arch/arm/plat-omap/clock.c | =A0 =A05 ++++-
>> =A01 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
>> index c9122dd..5a0d06b 100644
>> --- a/arch/arm/plat-omap/clock.c
>> +++ b/arch/arm/plat-omap/clock.c
>> @@ -130,8 +130,11 @@ int clk_set_rate(struct clk *clk, unsigned long=
 rate)
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&clockfw_lock, flags);
>> =A0 =A0 =A0 ret =3D arch_clock->clk_set_rate(clk, rate);
>> - =A0 =A0 if (ret =3D=3D 0)
>> + =A0 =A0 if (ret =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (clk->recalc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->rate =3D clk->recalc(=
clk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 propagate_rate(clk);
>> + =A0 =A0 }
>> =A0 =A0 =A0 spin_unlock_irqrestore(&clockfw_lock, flags);
>>
>> =A0 =A0 =A0 return ret;
>> --
>> 1.7.0.4
>>
>
>
> - Paul
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
