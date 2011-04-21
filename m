From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
Date: Thu, 21 Apr 2011 18:57:26 +0530
Message-ID: <BANLkTin4jETyDMDAE70M7rook=D4cW_mqQ@mail.gmail.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB033D7EB768@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:46733 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752584Ab1DUN11 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 09:27:27 -0400
Received: by mail-bw0-f49.google.com with SMTP id 1so2483197bwz.22
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 06:27:26 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB033D7EB768@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>, Paul Wamsley <paul@pwsan.com>

Hi,

On Wed, Apr 20, 2011 at 7:05 PM, Janorkar, Mayuresh <mayur@ti.com> wrot=
e:
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Gulati, Shweta
>> Sent: Wednesday, April 20, 2011 2:55 PM
>> To: linux-omap@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org; Gulati, Shweta; Nayak, Raj=
endra;
>> Paul Wamsley
>> Subject: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set=
_rate'
>>
>> From: Gulati, Shweta <shweta.gulati@ti.com>
>>
>> Core Clk Tree shows incorrect Clk rates at OPP50, as
>> in commit e07f469d284ca3d1f5dcf5438c22982be98bc071
>> calling of 'recalc' in API clk_set_rate is unintentionally
>> removed, because of which clock's tree rates get goofed
>> up when DVFS happens. This Patch adds recalc API back.
>
> I see that the patch is not adding API back.
> It is adding a call to the API.
Will Modify Commit message.
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
>
> checking if (!ret) is an intelligent way.
> But it is an individual's choice.
It doesn't make much difference.
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
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
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
