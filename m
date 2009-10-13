From: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND] I2C: OMAP: Add missing wakeup events
Date: Tue, 13 Oct 2009 12:52:16 +0300
Message-ID: <4AD44DD0.7000708@nokia.com>
References: <1255342885-15786-1-git-send-email-aaro.koskinen@nokia.com> <CD8CC2B65FEE304DA95744A5472698F2029E37200E@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F2029E37200E-UmuGNrFEPrGIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>
Cc: "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello,

Sonasath, Moiz wrote:
>> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor-l0cyMroinI0@public.gmane.org>
>>
>> Include wake up events for receiver overflow and transmitter
>> underflow in OMAP_I2C_WE_REG configuration. Also fix a small
>> typo.
>>
>> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 827da08..34ea9ed 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -92,8 +92,10 @@
>>  #define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
>>
>>  /* I2C WE wakeup enable register */
>> -#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakup */
>> +#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakeup */
>>  #define OMAP_I2C_WE_RDR_WE	(1 << 13)	/* RX drain wakeup */
>> +#define OMAP_I2C_WE_ROVR_WE	(1 << 11)	/* RX overflow wakeup */
>> +#define OMAP_I2C_WE_XUDF_WE	(1 << 10)	/* TX underflow wakeup */
> 
> These bits are not documented in OMAP3430, they are reserved. How can they be used?

Hmm, that's a valid point. I will have to check if I can find more info on the background of this patch.

A.
