From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 2/6] OMAP4: Clock: Associate clocks for OMAP temperature sensor
Date: Fri, 23 Sep 2011 11:23:08 +0530
Message-ID: <CAJ6a13aKoca1ny3ek7R3+T6GKVEKF1OhoxoDywcaPfpCnk0WzQ@mail.gmail.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
	<1316705361-12175-3-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1109222316350.10719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:37347 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325Ab1IWFxK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 01:53:10 -0400
Received: by mail-wy0-f175.google.com with SMTP id 5so3820959wyh.20
        for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 22:53:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109222316350.10719@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Fri, Sep 23, 2011 at 10:48 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Thu, 22 Sep 2011, Keerthy wrote:
>
>> div_ts_ck feeds only the temperature sensor functional clock
>> and also has a clksel associated (for divider selection). Mapping th=
is
>> as well as the bandgap_ts_fclk the fclk of temperature sensor in clk=
dev table,
>> so a clk_set_rate() on the div_ts_ck in the driver would have the ef=
fect of
>> changing the temperature sensor clock rate indirectly.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
>> Cc: tony@atomide.com
>> Cc: paul@pwsan.com
>
> Your cc's didn't take effect...

Yes :(. I mistakenly had supress cc in my git send command.

>
>> ---
>> =A0arch/arm/mach-omap2/clock44xx_data.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-om=
ap2/clock44xx_data.c
>> index 946bf04..c51e513 100644
>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>> @@ -3185,9 +3185,9 @@ static struct omap_clk omap44xx_clks[] =3D {
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "aes2_fck", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 &aes2_fck, =A0 =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "aess_fck", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 &aess_fck, =A0 =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "bandgap_fclk", =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 &bandgap_fclk, =A0CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "bandgap_ts_fclk", =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&bandgap_ts_fclk, =A0 =A0 =A0 CK_446X),
>> + =A0 =A0 CLK("omap4460plus_scm.0", =A0 =A0 =A0 "fck", =A0 =A0 =A0 =A0=
 =A0&bandgap_ts_fclk, =A0 =A0 =A0 CK_446X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "des3des_fck", =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0&des3des_fck, =A0 CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "div_ts_ck", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0&div_ts_ck, =A0 =A0 CK_446X),
>> + =A0 =A0 CLK("omap4460plus_scm.0", =A0 =A0 =A0 "div_ck", =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &div_ts_ck, =A0 =A0 CK_446X),
>
> Clearly this device is incorrectly named. =A0You're setting up a clkd=
ev
> entry that's marked as being valid for OMAP4430, but your device is c=
alled
> "omap4460plus_scm". =A0They can't both be right...

This is addressed in Patch 06.

>
>
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "dmic_sync_mux_ck", =A0 =A0 =A0 =A0=
 =A0 =A0 &dmic_sync_mux_ck, =A0 =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "dmic_fck", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 &dmic_fck, =A0 =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "dsp_fck", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0&dsp_fck, =A0 =A0 =A0 CK_443X),
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
> - Paul
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
