From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: arm: pmu: support pmu/perf on OMAP4 - booting problem on pandaboard
Date: Mon, 4 Apr 2011 22:23:18 +0800
Message-ID: <BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com>
References: <4D95E244.1050400@linux.vnet.ibm.com>
	<BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
	<4D99D251.6000901@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50650 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337Ab1DDOXT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 10:23:19 -0400
Received: by yxs7 with SMTP id 7so2180255yxs.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Apr 2011 07:23:18 -0700 (PDT)
In-Reply-To: <4D99D251.6000901@linux.vnet.ibm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Avik Sil <aviksil@linux.vnet.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

2011/4/4 Avik Sil <aviksil@linux.vnet.ibm.com>:
> Hi Ming,
>
> On Saturday 02 April 2011 10:57 AM, Ming Lei wrote:
>>
>> Hi Avik,
>>
>> 2011/4/1 Avik Sil<aviksil@linux.vnet.ibm.com>:
>>>
>>> Hi,
>>>
>>> I've applied the patches in
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/04=
5283.html
>>> on top of a linaro kernel which resulted in booting problem on
>>> Pandaboard.
>>> It hangs inside the cti_unlock() while reading the LOCKSTATUS value=
,
>>> which
>>> happens when omap_init_pmu() is called. Please help me debug the is=
sue.
>>
>> Please check if =A0l3 clocks are enabled to drive CTI, such as done =
in
>> below:
>>
>> =A0 =A0 =A0 =A0omap_writel(1, CM_L3INSTR_L3_3_CLKCTRL);
>> =A0 =A0 =A0 =A0omap_writel(1, CM_L3INSTR_L3_INSTR_CLKCTRL);
>> =A0 =A0 =A0 =A0omap_writel(2, CM_EMU_CLKSTCTRL);
>> =A0 =A0 =A0 =A0while ((omap_readl(CM_EMU_CLKSTCTRL)& =A00x300) !=3D =
0x300);
>>
> Can you please tell me where should I insert the above code to enable=
 l3
> clocks to drive CTI?

It should be inserted before calling omap4_configure_pmu_irq.

thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
