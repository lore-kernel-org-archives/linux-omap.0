From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH RFC 1/2] watchdog : omap_wdt : Implement
 WDIOC_GETBOOTSTATUS for omap3+
Date: Tue, 24 Jan 2012 11:40:43 +0530
Message-ID: <CAM=Q2ctL_Z5P6=NwAWBHD2bR=xqHMCF15g6v0Ap=hJMPdgXwyQ@mail.gmail.com>
References: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
	<1327317188-14782-2-git-send-email-shubhrajyoti@ti.com>
	<B5906170F1614E41A8A28DE3B8D12143317901B9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58929 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab2AXGKo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jan 2012 01:10:44 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D12143317901B9@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Vaibhav,

On Tue, Jan 24, 2012 at 10:32 AM, Bedia, Vaibhav <vaibhav.bedia@ti.com>=
 wrote:
> On Mon, Jan 23, 2012 at 16:43:07, Datta, Shubhrajyoti wrote:
>> This patch intends to implement the WDIOC_GETBOOTSTATUS ioctl
>> for the omap3 and omap4.
>>
>
> Instead of just returning the register content why not parse
> the RSTST register value and check if it's really a watchdog
> reset or not?

That is what is done for 24xx and below cpus. So I thought of extending=
 it.


>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>> =A0drivers/watchdog/omap_wdt.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt=
=2Ec
>> index 4b33e3f..5395a4c 100644
>> --- a/drivers/watchdog/omap_wdt.c
>> +++ b/drivers/watchdog/omap_wdt.c
>> @@ -229,7 +229,7 @@ static long omap_wdt_ioctl(struct file *file, un=
signed int cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap16xx())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return put_user(__raw_re=
adw(ARM_SYSST),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (int __user *)arg);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap24xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap24xx() || cpu_is_omap34xx()=
 || cpu_is_omap44xx())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return put_user(omap_prc=
m_get_reset_sources(),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (int __user *)arg);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return put_user(0, (int __user *)arg);
>> --
>> 1.7.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
