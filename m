From: Artem Bityutskiy <dedekind@yandex.ru>
Subject: Re: [PATCH] DSPBRIDGE: Fix module build warnings
Date: Wed, 01 Apr 2009 10:04:56 +0300
Message-ID: <49D31218.8050200@yandex.ru>
References: <1238516811-11401-1-git-send-email-ameya.palande@nokia.com> <49D3111E.2060304@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34295 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbZDAHFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 03:05:49 -0400
In-Reply-To: <49D3111E.2060304@yandex.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: h-kanigeri2@ti.com, linux-omap@vger.kernel.org

Artem Bityutskiy wrote:
> Ameya Palande wrote:
>> diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c=20
>> b/drivers/dsp/bridge/wmd/tiomap3430.c
>> index 1fca3e5..b489da1 100644
>> --- a/drivers/dsp/bridge/wmd/tiomap3430.c
>> +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
>> @@ -2034,26 +2034,27 @@ static DSP_STATUS PteSet(struct PgTableAttrs=
=20
>> *pt, u32 pa, u32 va,
>>              if (pfn_valid(__phys_to_pfn(patemp))) {
>>                  pg =3D phys_to_page(patemp);
>>                  get_page(pg);
>> +                if (page_count(pg) <=3D 1) {
>> +                    printk(KERN_EMERG "DSPBRIDGE:MAP  "
>> +                        "function: COUNT 0 FOR PA "
>> +                        "0x%x\n", patemp);
>> +                    printk(KERN_EMERG "Bad page state"
>> +                        "in process '%s'\n"
>> +                        "page:%p flags:0x%0*lx "
>> +                        "mapping:%p mapcount:%d "
>> +                        "count:%d\n"
>> +                        "Trying to fix it up, but "
>> +                        "a reboot is needed\n"
>> +                        "Backtrace:\n",
>> +                        current->comm, pg,
>> +                        (int)(2*sizeof(unsigned long)),
Why do you need this (int) cast? Thiere is a %zd modifyer.
>> +                        (unsigned long)pg->flags,
What for do you have to cast here?


--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
