From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP4: clock data: Lock ABE DPLL on all revisions
Date: Fri, 4 Jan 2013 16:46:21 +0100
Message-ID: <50E6F94D.7090706@ti.com>
References: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com> <1357294163-4317-2-git-send-email-peter.ujfalusi@ti.com> <50E6F0CA.60309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59872 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751Ab3ADPqa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 10:46:30 -0500
In-Reply-To: <50E6F0CA.60309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>

On 01/04/2013 04:10 PM, Jon Hunter wrote:
>=20
> On 01/04/2013 04:09 AM, Peter Ujfalusi wrote:
>> To avoid issues with audio caused by non locked ABE DPLL we should
>> make sure it is locked in all OMAP4 revisions.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>
>> asda d
>=20
> Not sure what the above is ;-)

Argh, squashed patches without commit message cleanup...
Paul: can you fix this up, or should I resend?

>=20
>> ---
>>  arch/arm/mach-omap2/cclock44xx_data.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-o=
map2/cclock44xx_data.c
>> index 5789a5e..a2cc046 100644
>> --- a/arch/arm/mach-omap2/cclock44xx_data.c
>> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
>> @@ -2026,14 +2026,13 @@ int __init omap4xxx_clk_init(void)
>>  	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
>>  	 * state when turning the ABE clock domain. Workaround this by
>>  	 * locking the ABE DPLL on boot.
>> +	 * Lock the ABE DPLL in any case to avoid issues with audio.
>>  	 */
>> -	if (cpu_is_omap446x()) {
>> -		rc =3D clk_set_parent(&abe_dpll_refclk_mux_ck, &sys_32k_ck);
>> -		if (!rc)
>> -			rc =3D clk_set_rate(&dpll_abe_ck, OMAP4_DPLL_ABE_DEFFREQ);
>> -		if (rc)
>> -			pr_err("%s: failed to configure ABE DPLL!\n", __func__);
>> -	}
>> +	rc =3D clk_set_parent(&abe_dpll_refclk_mux_ck, &sys_32k_ck);
>> +	if (!rc)
>> +		rc =3D clk_set_rate(&dpll_abe_ck, OMAP4_DPLL_ABE_DEFFREQ);
>> +	if (rc)
>> +		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
>> =20
>>  	return 0;
>>  }
>=20
> Acked-by: Jon Hunter <jon-hunter@ti.com>
>=20
> Cheers
> Jon
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
