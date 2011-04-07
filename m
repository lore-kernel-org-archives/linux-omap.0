From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: arm: pmu: support pmu/perf on OMAP4 - booting problem on pandaboard
Date: Thu, 7 Apr 2011 17:54:27 +0800
Message-ID: <BANLkTinzr300_4AM9kJO-NVXx7zPj8GYVg@mail.gmail.com>
References: <4D95E244.1050400@linux.vnet.ibm.com>
	<BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
	<4D99D251.6000901@linux.vnet.ibm.com>
	<BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com>
	<4D99EB4B.3020303@linux.vnet.ibm.com>
	<BANLkTinQ-QQ7zu2KrhhhdWwnzo=a-KynoQ@mail.gmail.com>
	<4D9AF790.7010504@linux.vnet.ibm.com>
	<BANLkTikxu3DaxWZ88wgCP2cCZD=kNm-YeQ@mail.gmail.com>
	<4D9D7E8E.7020200@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45377 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab1DGJy2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 05:54:28 -0400
Received: by yxs7 with SMTP id 7so917929yxs.19
        for <linux-omap@vger.kernel.org>; Thu, 07 Apr 2011 02:54:28 -0700 (PDT)
In-Reply-To: <4D9D7E8E.7020200@linux.vnet.ibm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Avik Sil <aviksil@linux.vnet.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Avik,

Please check if the option CONFIG_PM is enabled or not.

If not, please try to enable it to see you issue can be fixed.


2011/4/7 Avik Sil <aviksil@linux.vnet.ibm.com>:
> Hi Ming,
>
> On Wednesday 06 April 2011 11:37 AM, Ming Lei wrote:
>>
>> Hi Avik,
>>
>> 2011/4/5 Avik Sil<aviksil@linux.vnet.ibm.com>:
>>>
>>> Even after using ioremapped addresses in omap_writel() I'm getting =
the
>>> oops.
>>> Can you please point me to the location in mainline, where these l3
>>> clocks
>>> are enabled?
>>
>> I guess you can find here:
>>
>> =A0 =A0 =A0 =A0 =A0l3_main_3_ick&& =A0l3_instr_ick:
>> arch/arm/mach-omap2/clock44xx_data.c
>>
>> the clocks are set as ENABLE_ON_INIT.
>
> Those clocks are also set ENABLE_ON_INIT in the linaro kernel. But st=
ill
> it's hanging at "val =3D __raw_readl(base + LOCKSTATUS);" in cti_unlo=
ck(),
> even after explicitly enabling it using:
>
> omap_writel(1, CM_L3INSTR_L3_3_CLKCTRL);
> omap_writel(1, CM_L3INSTR_L3_INSTR_CLKCTRL);
> omap_writel(2, CM_EMU_CLKSTCTRL);
> while ((omap_readl(CM_EMU_CLKSTCTRL) & 0x300) !=3D 0x300);
>
> BTW, the oops were fixed by replacing omap_writel with __raw_writel.
>
> Regards,
> Avik
>
>>
>> thanks,
>
>


thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
