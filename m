From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [beagleboard] Re: TWL4030 intermittent freakout on boot
Date: Sat, 10 May 2008 11:33:54 +0200
Message-ID: <D7C4A9C8-893A-4E80-AC68-D885D31A7397@student.utwente.nl>
References: <alpine.DEB.1.00.0805081201450.27986@utopia.booyaka.com> <EF9B9E21-ACCB-46A7-94C7-1FB6DD58B093@student.utwente.nl> <20080508182807.GE24454@atomide.com> <48249322.4060004@googlemail.com> <20080509213608.GA5976@atomide.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:48158 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480AbYEJJnY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 May 2008 05:43:24 -0400
In-Reply-To: <20080509213608.GA5976@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 9 mei 2008, om 23:36 heeft Tony Lindgren het volgende geschreven:
> * Dirk Behme <dirk.behme@googlemail.com> [080509 11:08]:
>> Tony Lindgren wrote:
>>>
>> http://source.mvista.com/git/?p=linux-omap-2.6.git;a=commitdiff;h=0d81cf7e804c529c58d3054c1b9bdb7b3f1dec5d
>>
>> I don't know OMAP3 good enough yet, but which clock should we use on
>> OMAP3 here?
>
> It should be osc_sys_ck for 34xx.
>
>> Does it make sense to use osc_ck for OMAP3 instead of osc_sys_ck,  
>> too?
>>
>> E.g something like
>>
>> ...
>> if (cpu_is_omap2430() || cpu_is_omap34xx())
>>  osc = clk_get(NULL, "osc_ck");
>> else
>>  osc = clk_get(NULL, "osc_sys_ck");
>> ...
>
> There's no osc_ck in clock34xx.h.

Does this patch make sense for omap3?

- --- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -779,7 +779,11 @@ int __init omap2_pm_init(void)
         l = __raw_readl(OMAP24XX_PRCM_REVISION);
         printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l  
& 0x0f);

- -       osc_ck = clk_get(NULL, "osc_ck");
+       if (cpu_is_omap2430() )
+               osc_ck = clk_get(NULL, "osc_ck");
+       else
+               osc_ck = clk_get(NULL, "osc_sys_ck");
+
         if (IS_ERR(osc_ck)) {
                 printk(KERN_ERR "could not get osc_ck\n");
                 return -ENODEV;


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIJWwEMkyGM64RGpERAnnYAKC8UMuAY0FPTDt0xbMoaWKo7eBWCwCfaal8
p388pzBedv0UHmduWhWJKqc=
=A+rF
-----END PGP SIGNATURE-----
