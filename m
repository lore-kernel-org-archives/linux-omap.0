From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFT 5/8] ARM: OMAP: clock: remove unused CK_3505 flag
Date: Mon, 30 Apr 2012 10:19:40 -0700
Message-ID: <87397lw30z.fsf@ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
	<1335482993-14035-6-git-send-email-khilman@ti.com>
	<CAORVsuVgNKUcsM+GuQfahp0r5U=24qBQhrX1E-DewhNvh0hk7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:55327 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755985Ab2D3RTp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 13:19:45 -0400
Received: by pbbrp2 with SMTP id rp2so1357299pbb.0
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 10:19:43 -0700 (PDT)
In-Reply-To: <CAORVsuVgNKUcsM+GuQfahp0r5U=24qBQhrX1E-DewhNvh0hk7g@mail.gmail.com>
	(Jean Pihet's message of "Mon, 30 Apr 2012 11:05:41 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Kevin,
>
> On Fri, Apr 27, 2012 at 1:29 AM, Kevin Hilman <khilman@ti.com> wrote:
>> This flag is no longer used since clock init all AM35x devices
>> is now the same.
>>
>> Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> =C2=A0arch/arm/plat-omap/include/plat/clkdev_omap.h | =C2=A0 =C2=A03=
 +--
>> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/ar=
m/plat-omap/include/plat/clkdev_omap.h
>> index b299b8d..45afa4d 100644
>> --- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
>> +++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
>> @@ -34,7 +34,6 @@ struct omap_clk {
>> =C2=A0#define CK_243X =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(1 << 5) =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 243x, 253x */
>> =C2=A0#define CK_3430ES1 =C2=A0 =C2=A0 (1 << 6) =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* 34xxES1 only */
>> =C2=A0#define CK_3430ES2PLUS (1 << 7) =C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
34xxES2, ES3, non-Sitara 35xx only */
>> -#define CK_3505 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1 << 8)
>> =C2=A0#define CK_3517 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(1 << 9)
> If this is the only flag remaining, should it better be renamed to CK=
_35XX?

That happens later in the series.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
