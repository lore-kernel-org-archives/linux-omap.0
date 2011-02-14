From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH] i2c-omap: Double clear of ARDY status in IRQ handler
Date: Mon, 14 Feb 2011 15:31:32 +0530
Message-ID: <AANLkTinh8Y63jwcfbQKoNC0ZjFNKiMDnAadwzbq765e0@mail.gmail.com>
References: <1297406718-24147-1-git-send-email-j-keerthy@ti.com>
	<20110211125059.04f17162.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:38840 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753089Ab1BNKBe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 05:01:34 -0500
In-Reply-To: <20110211125059.04f17162.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: ben-i2c@fluff.org, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Richard woodruff <r-woodruff2@ti.com>

On Fri, Feb 11, 2011 at 4:20 PM, Jarkko Nikula <jhnikula@gmail.com> wro=
te:
> On Fri, 11 Feb 2011 12:15:18 +0530
> Keerthy <j-keerthy@ti.com> wrote:
>
>> From: Richard woodruff <r-woodruff2@ti.com>
>>
>> ProDB00017052 - ARDY interrupt reasserted after being cleared.
>> This errata caused intermittent i2c instabilty(1 error per 3 hours) =
on several
>> customer platforms. After applying the workaround the intermittent e=
rrors were
>> not seen. This is not captured in the usual errata documents.
>>
>> The workaround is to have a double clear of ARDY status in
>> irq handler.
>>
>> Signed-off-by: Richard woodruff <r-woodruff2@ti.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
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
>
> Most probably this is correct but I was just wondering are there any =
use
> for ARDY interrupt (register access ready) anyway and is the ARDY her=
e
> caused by omap_i2c_write_reg for STAT_NACK in a few lines above.
>
Hello Jarkko,

ARDY interrupt indicates that the previous access has been performed
and the registers are ready to be accessed again. Coming to the second
part i checked even when the STAT_NACK bit is set and after
omap_i2c_write_reg the ARDY bit is not set. So that does not seem to
be the cause of ARDY getting set.


> Just my 2 cents about possible further patches (while this having the
> priority as fixes the issue).
>
> --
> Jarkko
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
