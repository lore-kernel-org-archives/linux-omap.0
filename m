From: "J, KEERTHY" <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] i2c-omap: Double clear of ARDY status in IRQ handler
Date: Fri, 18 Feb 2011 07:37:35 +0530
Message-ID: <AANLkTin+g7RcMvuGY8FgFuxA+AWqyrhdZQQ+-PfGC1oQ@mail.gmail.com>
References: <1297832056-28142-1-git-send-email-j-keerthy@ti.com>
	<20110218000843.GP20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110218000843.GP20795-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 18, 2011 at 5:38 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote=
:
> * Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [110215 20:53]:
>> From: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
>>
>> This errata occurs when the ARDY interrupt generation is enabled.
>> At the begining of every new transaction the ARDY interrupt is clear=
ed.
>>
>> On continuous i2c transactions where after clearing the ARDY bit fro=
m
>> I2C_STAT register (clearing the interrupt), the IRQ line is reassert=
ed and the
>> I2C_STAT[ARDY] bit set again on 1. In fact, the ARDY status bit is n=
ot cleared
>> at the write access to I2C_STAT[ARDY] and only the IRQ line is deass=
erted and
>> then reasserted. This is not captured in the usual errata documents.
>>
>> The workaround is to have a double clear of ARDY status in irq handl=
er.
>
> I'll add this to omap-testing for few days and then if no issue Ben
> can merge this.

Thanks Tony.
>
> Regards,
>
> Tony
>
>> Signed-off-by: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>> ---
>> =A0drivers/i2c/busses/i2c-omap.c | =A0 =A06 +++++-
>> =A01 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-=
omap.c
>> index b605ff3..5b35cf4 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -847,11 +847,15 @@ complete:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev->dev, "Arbit=
ration lost\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D OMAP_I2C_STAT_A=
L;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* ProDB0017052: Clear ARDY bit twice
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2=
C_STAT_NACK |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 OMAP_I2C_STAT_AL)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_ack_stat(dev, s=
tat &
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OMAP_I2=
C_STAT_RRDY | OMAP_I2C_STAT_RDR |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_S=
TAT_XRDY | OMAP_I2C_STAT_XDR));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_S=
TAT_XRDY | OMAP_I2C_STAT_XDR |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_S=
TAT_ARDY));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_complete_cmd(de=
v, err);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c"=
 in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Regards and Thanks,
Keerthy
