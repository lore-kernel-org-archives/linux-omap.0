From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] mfd: twl6040: Handle mclk used for HPPLL and optional
 internal clock source
Date: Mon, 20 Jun 2016 11:53:57 +0300
Message-ID: <b4bd5fed-fd64-26b6-45ce-976169ec7208@ti.com>
References: <1462965209-6955-1-git-send-email-peter.ujfalusi@ti.com>
 <20160616151658.GA21702@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160616151658.GA21702@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/16/2016 06:16 PM, Lee Jones wrote:
> On Wed, 11 May 2016, Peter Ujfalusi wrote:
>=20
>> On some boards, like omap5-uevm the MCLK is gated by default and in =
order
>> to be able to use the High performance modes of twl6040 it need to b=
e
>> enabled by SW.
>> Add support for handling the MCLK source clock via CCF.
>> At the same time lover the print priority of the notification that t=
he 32K
>=20
> Mr Lover Lover!

Oh. :D

>>  	twl6040->supplies[0].supply =3D "vio";
>> diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040=
=2Eh
>> index 8f9fc3d26e6d..a7c50e54f3e0 100644
>> --- a/include/linux/mfd/twl6040.h
>> +++ b/include/linux/mfd/twl6040.h
>> @@ -224,7 +224,8 @@ struct twl6040 {
>>  	struct regmap *regmap;
>>  	struct regmap_irq_chip_data *irq_data;
>>  	struct regulator_bulk_data supplies[2]; /* supplies for vio, v2v1 =
*/
>> -	struct clk *clk32k;
>> +	struct clk *clk32k_clk;
>> +	struct clk *mclk_clk;
>
> Not sure I get the naming here.
>=20
> What's wrong with clk32k and mclk?

The struct already have mclk (unsigned int) member to store the rate of=
 the
reference clock (32768 in case of LPPLL or the rate of the mclk clock i=
n case
of HPPLL). I could use clk32k and mclk for the clk and rename the curre=
nt mclk
to refclk_rate or something if that is better. This value is only impor=
tant
for the HPPLL usage, if I restructure the driver I might be able to ren=
ame it
as mclk_rate and store only the MCLK freq there.

>=20
>>  	struct mutex mutex;
>>  	struct mutex irq_mutex;
>>  	struct mfd_cell cells[TWL6040_CELLS];
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
