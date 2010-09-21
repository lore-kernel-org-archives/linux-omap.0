From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: SMP_ON_UP? - Build break with custom minimal defconfig
Date: Tue, 21 Sep 2010 21:29:22 +0530
Message-ID: <AANLkTinPK7SmOh5dHmBfyOupKFCGcWHLz_pvDWFOd6io@mail.gmail.com>
References: <AANLkTim-mQjFnqGo_G971yTbU9FLnUja2t_axytGM5LN@mail.gmail.com> <20100921155400.GR4611@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:49569 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757647Ab0IUQAW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 12:00:22 -0400
Received: by wwa36 with SMTP id 36so6105909wwa.26
        for <linux-omap@vger.kernel.org>; Tue, 21 Sep 2010 09:00:00 -0700 (PDT)
In-Reply-To: <20100921155400.GR4611@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

>> =A0 CC =A0 =A0 =A0init/main.o
>> In file included from include/linux/highmem.h:9,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0from include/linux/pagemap.h:10,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0from include/linux/mempolicy.h:70=
,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0from init/main.c:50:
>> /home/userdata/a0393673/kernels/tony/linux-omap-2.6/arch/arm/include=
/asm/cacheflush.h:
>> In function '__flush_icache_all':
>> /home/userdata/a0393673/kernels/tony/linux-omap-2.6/arch/arm/include=
/asm/cacheflush.h:332:
>> error: implicit declaration of function '__flush_icache_preferred'
>> make[1]: *** [init/main.o] Error 1
>> make: *** [init] Error 2
>>
>> I think this is related to the recent SMP_ON_UP patches.
>>
>> The reduced .config I'm using (generated using `make savedefconfig`)=
 is below.
>>
>> I'll try and debug in a while, but just reporting for now.
>
> Yes that sounds like a bug in a smp_on_up related patch. Will try you=
r
> defconfig here too.
>

=46ound it - it's due to a typo in the defines.

Patch coming up in a few minutes.

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
