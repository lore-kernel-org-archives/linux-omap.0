From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv8 13/13] I2C: OMAP: simplify omap_i2c_ack_stat()
Date: Tue, 19 Jun 2012 14:50:23 +0530
Message-ID: <CAM=Q2ctOS19ToH7JRLxmEkoz8eUj8umcWFhaTQ-MWBbeh_DHtA@mail.gmail.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
	<1340029828-20751-14-git-send-email-shubhrajyoti@ti.com>
	<20120618153000.GC10768@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120618153000.GC10768-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 18, 2012 at 9:00 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
> On Mon, Jun 18, 2012 at 08:00:28PM +0530, Shubhrajyoti D wrote:
>> From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>
>> stat & BIT(1) is the same as BIT(1),
>
> Not true. I'd guess you are missing some context in the patch
> description.


See the explanation , hope I understood your concern correctly.

http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg70277.html

>
>> so let's
>> simplify things a bit by removing "stat &" from
>> all omap_i2c_ack_stat() calls.
>>
>> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> Reviewed-by : Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> ---
>> =A0drivers/i2c/busses/i2c-omap.c | =A0 19 ++++++++++---------
>> =A01 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-=
omap.c
>> index 6a79089..bac6305 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -763,7 +763,7 @@ static int errata_omap3_i462(struct omap_i2c_dev=
 *dev, u16 *stat, int *err)
>>
>> =A0 =A0 =A0 while (--timeout && !(*stat & OMAP_I2C_STAT_XUDF)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I=
2C_STAT_AL)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_ack_stat(dev, *st=
at & (OMAP_I2C_STAT_XRDY |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_ack_stat(dev, (OM=
AP_I2C_STAT_XRDY |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_STAT_XDR));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> @@ -824,10 +824,11 @@ complete:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2=
C_STAT_NACK |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 OMAP_I2C_STAT_AL)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_ack_stat(dev, sta=
t &
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OMAP_I2C_=
STAT_RRDY | OMAP_I2C_STAT_RDR |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_S=
TAT_XRDY | OMAP_I2C_STAT_XDR |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_S=
TAT_ARDY));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_ack_stat(dev, (OM=
AP_I2C_STAT_RRDY |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_STAT_RDR |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_STAT_XRDY |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_STAT_XDR |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_STAT_ARDY));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_complete_cmd(de=
v, err);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> @@ -874,8 +875,8 @@ complete:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_ack_stat(dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stat & (OM=
AP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_ack_stat(dev, (OM=
AP_I2C_STAT_RRDY |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_STAT_RDR));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> @@ -922,8 +923,8 @@ complete:
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c=
_write_reg(dev, OMAP_I2C_DATA_REG, w);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_ack_stat(dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stat & (OM=
AP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_ack_stat(dev, (OM=
AP_I2C_STAT_XRDY |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_STAT_XDR));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> --
>> 1.7.5.4
>>
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
