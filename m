From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/6] OMAP4: Add missing clock divider for OCP_ABE_ICLK
Date: Fri, 15 Jul 2011 09:34:36 -0500
Message-ID: <4E204FFC.5080700@ti.com>
References: <1310685865-3249-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1107150216380.16606@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35074 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab1GOOei (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 10:34:38 -0400
In-Reply-To: <alpine.DEB.2.00.1107150216380.16606@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, b-cousson@ti.com

Hi Paul,

On 7/15/2011 3:21, Paul Walmsley wrote:
> cc'ing Beno=EEt
>
> Hi Jon
>
> On Thu, 14 Jul 2011, Jon Hunter wrote:
>
>> From: Jon Hunter<jon-hunter@ti.com>
>>
>> The parent clock of the OCP_ABE_ICLK is the AESS_FCLK and the
>> parent clock of the AESS_FCLK is the ABE_FCLK...
>>
>> ABE_FCLK -->  AESS_FCLK -->  OCP_ABE_ICLK
>>
>> The AESS_FCLK and OCP_ABE_ICLK clocks both have dividers which
>> determine their operational frequency. However, the dividers for
>> the AESS_FCLK and OCP_ABE_ICLK are controlled via a single bit,
>> which is the CM1_ABE_AESS_CLKCTRL[24] bit.>  When this bit is set to
>> 0, the AESS_FCLK divider is 1 and the OCP_ABE_ICLK divider is 2.
>> Similarly, when this bit is set to 1, the AESS_FCLK divider is 2
>> and the OCP_ABE_ICLK is 1.
>
> Sigh.  This type of hardware design makes software design difficult :=
-(

Hopefully, because this is a interface clock the impact is really=20
minimal...more below...

>> The above relationship between the AESS_FCLK and OCP_ABE_ICLK
>> dividers ensure that the OCP_ABE_ICLK clock is always half the
>> frequency of the ABE_CLK...
>>
>> OCP_ABE_ICLK =3D ABE_FCLK/2
>>
>> The divider for the OCP_ABE_ICLK is currently missing so add a
>> divider that will ensure the OCP_ABE_ICLK frequency is always half
>> the ABE_FCLK frequency.
>>
>> Signed-off-by: Jon Hunter<jon-hunter@ti.com>
>> ---
>>   arch/arm/mach-omap2/clock44xx_data.c |   16 +++++++++++++++-
>>   1 files changed, 15 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-om=
ap2/clock44xx_data.c
>> index 8c96567..6e158ce 100644
>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>> @@ -1301,11 +1301,25 @@ static struct clk mcasp3_fclk =3D {
>>   	.recalc		=3D&followparent_recalc,
>>   };
>>
>> +static const struct clksel_rate div2_2to1_rates[] =3D {
>> +	{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_4430 },
>> +	{ .div =3D 2, .val =3D 0, .flags =3D RATE_IN_4430 },
>> +	{ .div =3D 0 },
>> +};
>> +
>> +static const struct clksel ocp_abe_iclk_div[] =3D {
>> +	{ .parent =3D&aess_fclk, .rates =3D div2_2to1_rates },
>> +	{ .parent =3D NULL },
>> +};
>> +
>>   static struct clk ocp_abe_iclk =3D {
>>   	.name		=3D "ocp_abe_iclk",
>>   	.parent		=3D&aess_fclk,
>> +	.clksel		=3D ocp_abe_iclk_div,
>> +	.clksel_reg	=3D OMAP4430_CM1_ABE_AESS_CLKCTRL,
>> +	.clksel_mask	=3D OMAP4430_CLKSEL_AESS_FCLK_MASK,
>>   	.ops		=3D&clkops_null,
>> -	.recalc		=3D&followparent_recalc,
>> +	.recalc		=3D&omap2_clksel_recalc,
>>   };
>>
>>   static struct clk per_abe_24m_fclk =3D {
>
> I guess the reason that this patch can get away with this is because =
it
> doesn't allow software to change the rate of ocp_abe_iclk, and the
> ocp_abe_iclk is a child of aess_fclk, so when aess_fclk is changed, i=
t
> will recalc ocp_abe_iclk.
>
> Beno=EEt, what do you think?  Is this a reasonable approach for the s=
cript?
> Or do we need to deal with some kind of 'linked clock' implementation=
=2E..

If you want my two cents on this matter, I would say that...

1). People should not need to configure the "ocp_abe_iclk" clock=20
directly, because regardless of the divider setting it is always 1/2 th=
e=20
"abe_fclk". In other words, only the "aess_fclk" frequency is really=20
changing because of the divider and the above relationship ensures that=
=20
the "ocp_abe_iclk" is always the same frequency. So a user only cares=20
about the "aess_fclk" frequency and the "ocp_abe_iclk" frequency is=20
handled for them.

2). The "ocp_abe_iclk" is an interface clock and is not a parent to any=
=20
other functional clock and therefore, is not driving any internal logic=
=20
in a peripheral which would have a direct impact of the speed of that=20
peripheral. However, there does appear to be another bug here in the=20
clock44xx_data.c as it shows that the "ocp_abe_iclk" is parent to the=20
"slimbus1_fck" which I believe is incorrect. According to the TRM, the=20
the ocp_abe_iclk is parent to the slimbus1_iclk. I can send another=20
patch for this. However, I will let Benoit chime in first.

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
