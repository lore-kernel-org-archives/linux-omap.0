From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: Introduce CONFIG_SOC_HAS_OMAP_DPLL macro
Date: Fri, 11 May 2012 11:46:32 +0530
Message-ID: <CAJ7qFSf9=h-hjSwrcd+n=zK4HyB+=DXGrqsgsMvaL_f1xyQQog@mail.gmail.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
	<1336669615-16454-2-git-send-email-r.sricharan@ti.com>
	<79CD15C6BA57404B839C016229A409A83EA217D2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:47639 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752397Ab2EKGQg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 02:16:36 -0400
Received: by lbbgj10 with SMTP id gj10so2152213lbb.37
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 23:16:33 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA217D2@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pswan.com" <paul@pswan.com>

Vaibhav,
[snip]
>> diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat=
-omap/include/plat/clock.h
>> index d0ef57c..095bee8 100644
>> --- a/arch/arm/plat-omap/include/plat/clock.h
>> +++ b/arch/arm/plat-omap/include/plat/clock.h
>> @@ -156,7 +156,7 @@ struct dpll_data {
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0min_divide=
r;
>> =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_divider;
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0modes;
>> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>> +#ifdef CONFIG_SOC_HAS_OMAP_DPLL
>> =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*autoidle_reg;
>> =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*idlest_reg;
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 autoidle_mas=
k;
>> @@ -167,7 +167,7 @@ struct dpll_data {
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0auto_recal=
_bit;
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0recal_en_b=
it;
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0recal_st_b=
it;
>> -# =A0endif
>> +#endif
>
> I had submitted similar patch recently, and Kevin had suggested that
> Instead of adding config option, we shoule simply get rid of this ifd=
ef
> completely.
>
> Refer to
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg68293.html
>
>
> Waiting for Paul to conform here.
>
 Thanks for pointing that out. Will check on this and Paul's PRCM serie=
s
 cleanup series then.

Thanks,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
