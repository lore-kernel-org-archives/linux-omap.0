From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFT 6/8] ARM: OMAP: remove unused cpu_is_omap3505()
Date: Mon, 30 Apr 2012 10:20:27 -0700
Message-ID: <87y5pduof8.fsf@ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
	<1335482993-14035-7-git-send-email-khilman@ti.com>
	<CAORVsuVYXooj5CPzZZhOL8asmoX5X1bB=D-7pyf4McgKOATmyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:35100 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756332Ab2D3RUb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 13:20:31 -0400
Received: by pbbrp8 with SMTP id rp8so3484629pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 10:20:30 -0700 (PDT)
In-Reply-To: <CAORVsuVYXooj5CPzZZhOL8asmoX5X1bB=D-7pyf4McgKOATmyg@mail.gmail.com>
	(Jean Pihet's message of "Mon, 30 Apr 2012 11:07:16 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Kevin,
>
> On Fri, Apr 27, 2012 at 1:29 AM, Kevin Hilman <khilman@ti.com> wrote:
>> The 3505 check is now unused and can be removed.
>>
>> There are no longer any cpu_is_* checks that depend on specific IP
>> detection.
>>
>> Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> =C2=A0arch/arm/plat-omap/include/plat/cpu.h | =C2=A0 =C2=A08 +------=
-
>> =C2=A01 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-o=
map/include/plat/cpu.h
>> index 41f3e5a..b34bf6c 100644
>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>> @@ -250,8 +250,7 @@ IS_AM_SUBCLASS(335x, 0x335)
>> =C2=A0* cpu_is_omap2423(): =C2=A0True for OMAP2423
>> =C2=A0* cpu_is_omap2430(): =C2=A0True for OMAP2430
>> =C2=A0* cpu_is_omap3430(): =C2=A0True for OMAP3430
>> - * cpu_is_omap3505(): =C2=A0True for OMAP3505
>> - * cpu_is_omap3517(): =C2=A0True for OMAP3517
>> + * cpu_is_omap3517(): =C2=A0True for AM35x: OMAP3517, OMAP3505
> Is cpu_is_omap35xx() a better name for it?

Later in the series, it is renamed to cpu_is_am35xx().

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
