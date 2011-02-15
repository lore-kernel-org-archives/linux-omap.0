From: "J, KEERTHY" <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c-omap: Double clear of ARDY status in IRQ handler
Date: Tue, 15 Feb 2011 10:13:58 +0530
Message-ID: <AANLkTikdDsq0mku6Jakq-cxA3jYYHQ7CL0sjwJ6wzXNh@mail.gmail.com>
References: <1297406718-24147-1-git-send-email-j-keerthy@ti.com>
	<877hd2xivn.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <877hd2xivn.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 15, 2011 at 5:35 AM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> writes:
>
>> From: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
>>
>> ProDB00017052 - ARDY interrupt reasserted after being cleared.
>
>> This errata caused intermittent i2c instabilty(1 error per 3 hours) =
on several
>> customer platforms. After applying the workaround the intermittent e=
rrors were
>> not seen. This is not captured in the usual errata documents.
>
> This (presumably internal) ProDB number above is meaningless in the
> public changelog. =A0In lieu of a public erratum number, just summari=
ze
> the erratum/instability seen, references to other relevant public
> errata (if any) would be useful too. =A0 IOW, "instability" isn't qui=
te
> accurate enough. =A0A more detailed description of the problem/instab=
ility
> is needed.
>

Kevin,

Yes the ProDB number is internal. I will remove it from the change log.
I will add a more detailed description of the problem.

--=20
Regards and Thanks,
Keerthy


> Thanks,
>
> Kevin
>
>>
>> The workaround is to have a double clear of ARDY status in
>> irq handler.
>>
>> Signed-off-by: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>> ---
>> =A0drivers/i2c/busses/i2c-omap.c | =A0 =A03 ++-
>> =A01 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-=
omap.c
>> index 445de08..9bcefae 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -851,7 +851,8 @@ complete:
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
>
