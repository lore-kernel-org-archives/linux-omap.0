From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 2/3] omap4: opp: add OPP table data
Date: Mon, 22 Nov 2010 17:30:08 -0600
Message-ID: <4CEAFD00.4090200@ti.com>
References: <1289933661-19505-3-git-send-email-nm@ti.com> <87aal1kktu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48866 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757824Ab0KVXaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 18:30:13 -0500
Received: by mail-yx0-f179.google.com with SMTP id 34so393147yxf.38
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 15:30:12 -0800 (PST)
In-Reply-To: <87aal1kktu.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>, Thomas <thomas.petazzoni@free-electrons.com>

Kevin Hilman wrote, on 11/22/2010 05:19 PM:
> Nishanth Menon<nm@ti.com>  writes:
>
>> This patch adds OPP tables for OMAP4. New file has been added to keep
>> the OMAP4 opp tables and the registration of these tables with the
>> generic opp framework by OMAP SoC OPP interface.
>
> [...]
>
>> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
>> index 66e12be..48a553f 100644
>> --- a/arch/arm/mach-omap2/opp.c
>> +++ b/arch/arm/mach-omap2/opp.c
>> @@ -131,4 +131,5 @@ static int __init omap_init_opp_table(struct omap_opp_def *opp_def,
>>
>>   /* omap3 opps */
>>   #include "opp3xxx_data.c"
>> -
>> +/* omap4 opps */
>> +#include "opp4xxx_data.c"
>
> I'm not sure I like the including of C files.  Any reason you prefer
> this to just adding them to the Makefile?  e.g. opp24xx_dta.c are
> compiled in via Makefile and these two are included.

I dont buy it. I am seeing us go around in circles for this:
http://marc.info/?l=linux-omap&m=128986880406272&w=2
a) we dont want others to use specifics implemented in opp.c in other 
files (e.g. board files)
b) we have many similar usage in linux kernel - so this usage is not 
first time.
c) opp2xx usage is very different from opp3/4 usage

-- 
Regards,
Nishanth Menon
