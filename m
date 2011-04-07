From: Avik Sil <aviksil@linux.vnet.ibm.com>
Subject: Re: arm: pmu: support pmu/perf on OMAP4 - booting problem on pandaboard
Date: Thu, 07 Apr 2011 14:36:22 +0530
Message-ID: <4D9D7E8E.7020200@linux.vnet.ibm.com>
References: <4D95E244.1050400@linux.vnet.ibm.com> <BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com> <4D99D251.6000901@linux.vnet.ibm.com> <BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com> <4D99EB4B.3020303@linux.vnet.ibm.com> <BANLkTinQ-QQ7zu2KrhhhdWwnzo=a-KynoQ@mail.gmail.com> <4D9AF790.7010504@linux.vnet.ibm.com> <BANLkTikxu3DaxWZ88wgCP2cCZD=kNm-YeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:33632 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab1DGJG0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Apr 2011 05:06:26 -0400
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p378gAdw004447
	for <linux-omap@vger.kernel.org>; Thu, 7 Apr 2011 04:42:10 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1A5AB38C8038
	for <linux-omap@vger.kernel.org>; Thu,  7 Apr 2011 05:06:17 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p3796PFW406686
	for <linux-omap@vger.kernel.org>; Thu, 7 Apr 2011 05:06:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p3796ObH023350
	for <linux-omap@vger.kernel.org>; Thu, 7 Apr 2011 05:06:25 -0400
In-Reply-To: <BANLkTikxu3DaxWZ88wgCP2cCZD=kNm-YeQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Ming,

On Wednesday 06 April 2011 11:37 AM, Ming Lei wrote:
> Hi Avik,
>
> 2011/4/5 Avik Sil<aviksil@linux.vnet.ibm.com>:
>> Even after using ioremapped addresses in omap_writel() I'm getting the oops.
>> Can you please point me to the location in mainline, where these l3 clocks
>> are enabled?
>
> I guess you can find here:
>
>           l3_main_3_ick&&  l3_instr_ick: arch/arm/mach-omap2/clock44xx_data.c
>
> the clocks are set as ENABLE_ON_INIT.

Those clocks are also set ENABLE_ON_INIT in the linaro kernel. But still 
it's hanging at "val = __raw_readl(base + LOCKSTATUS);" in cti_unlock(), 
even after explicitly enabling it using:

omap_writel(1, CM_L3INSTR_L3_3_CLKCTRL);
omap_writel(1, CM_L3INSTR_L3_INSTR_CLKCTRL);
omap_writel(2, CM_EMU_CLKSTCTRL);
while ((omap_readl(CM_EMU_CLKSTCTRL) & 0x300) != 0x300);

BTW, the oops were fixed by replacing omap_writel with __raw_writel.

Regards,
Avik

>
> thanks,

