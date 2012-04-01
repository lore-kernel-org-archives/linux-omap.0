From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Sun, 1 Apr 2012 09:39:03 +0800
Message-ID: <CACVXFVMjSPhF_+CfbF2vD5ts+WtZGjofEWmknB0D1OpTM7geZw@mail.gmail.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
	<1326983304-14619-2-git-send-email-hvaibhav@ti.com>
	<87mx9ej8fp.fsf@ti.com>
	<CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
	<CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
	<4F672364.3020403@ti.com>
	<79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
	<CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
	<CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83183EB47@DBDE01.ent.ti.com>
	<CAMQu2gzYULK+=6-WKQnnQDpzTYW7xKAOZo7obyu2q178jtNE-Q@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A831840C2E@DBDE01.ent.ti.com>
	<CAMQu2gw7aceHSYSd+UMVS6kHQMqy0_maf8QTJaUMzp9z8822rQ@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A831840E0C@DBDE01.ent.ti.com>
	<4F7570FC.8000907@ti.com>
	<79CD15C6BA57404B839C016229A409A831840F82@DBDE01.ent.ti.com>
	<CAMQu2gzOkE6LD0WZ_9bKe3J-=Dv89rWaMzvWWvJHPMSPe6MzNg@mail.gmail.com>
	<CACVXFVPbU2OqTN=S0AZCD10KuSBYxqyyRH_xee+WTaCD6VSmMQ@mail.gmail.com>
	<CAMQu2gzuQ-q+3RHsW0=U305jCF-td5-PEXkGZ6WnQTqA1K8oAQ@mail.gmail.com>
	<CACVXFVPu1GEQy+sCgXMB8JCszPBBs8zHRVm94TYb1-y2afkqgw@mail.gmail.com>
	<CAMQu2gwuRpZ133962r3N4Y4K3oQ88ySa=SyoS6v=sSHGA=SGKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40934 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab2DABjE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Mar 2012 21:39:04 -0400
Received: by pbcun15 with SMTP id un15so3219655pbc.19
        for <linux-omap@vger.kernel.org>; Sat, 31 Mar 2012 18:39:03 -0700 (PDT)
In-Reply-To: <CAMQu2gwuRpZ133962r3N4Y4K3oQ88ySa=SyoS6v=sSHGA=SGKw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Sun, Apr 1, 2012 at 3:10 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Sat, Mar 31, 2012 at 2:09 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>> On Sat, Mar 31, 2012 at 2:30 PM, Shilimkar, Santosh
>>> Since you need to recompile the kernel, you can very much tweak the
>>> clocksource to use GPTIMER with sysl clock. Support for that is still
>>> in place.
>>
>> With current kernel, running 'make menuconfig' can do it, but after applying
>> Hiremath's patch[1], I have to edit the source code manually to get it, so looks
>> this kind of tweaking is not friendly enough, :-(
>>
> It's not friendly but doable. But above can be supported I guess.
>
> Since you are talking about doing menuconfig
> and rebuilding kernel so what can be done is when one disable CPUIDLE
> and PM, one can disabled 32K source as well. And then 32K clocksource
> init should fail and fallback on gptimer clock source.

OK, it should work, but looks OMAP_32K_TIMER option has to be kept
for the usage, which may be a bit divergent to the purpose of the patch set.

So how about introducing a kernel parameter to decide if bypassing
32K source and using gptimer source directly, and let which depend
on PM?

>
> Vaibhav,
> Can you update your patch to support above. The patch which I
> did was doing exactly that but was not using hwmod. The problem with your
> patch is synctimer hwmod lookup on OMAP will never fail if the hwmod
> entry is supported.
>
> So you might better use failure case of omap_init_clocksource_32k() for
> fall back on gptimer source as I tried in my patch. That should support

You patch still doesn't work for the usage because you removed 32K option.


Thanks,
-- 
Ming Lei
