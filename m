From: Avik Sil <aviksil@linux.vnet.ibm.com>
Subject: Re: arm: pmu: support pmu/perf on OMAP4 - booting problem on pandaboard
Date: Thu, 07 Apr 2011 16:12:17 +0530
Message-ID: <4D9D9509.7050804@linux.vnet.ibm.com>
References: <4D95E244.1050400@linux.vnet.ibm.com> <BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com> <4D99D251.6000901@linux.vnet.ibm.com> <BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com> <4D99EB4B.3020303@linux.vnet.ibm.com> <BANLkTinQ-QQ7zu2KrhhhdWwnzo=a-KynoQ@mail.gmail.com> <4D9AF790.7010504@linux.vnet.ibm.com> <BANLkTikxu3DaxWZ88wgCP2cCZD=kNm-YeQ@mail.gmail.com> <4D9D7E8E.7020200@linux.vnet.ibm.com> <BANLkTinzr300_4AM9kJO-NVXx7zPj8GYVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:52283 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab1DGKm1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 06:42:27 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p37AQkFT018817
	for <linux-omap@vger.kernel.org>; Thu, 7 Apr 2011 04:26:46 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id p37AgKQi118760
	for <linux-omap@vger.kernel.org>; Thu, 7 Apr 2011 04:42:20 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p37AgKld007337
	for <linux-omap@vger.kernel.org>; Thu, 7 Apr 2011 04:42:20 -0600
In-Reply-To: <BANLkTinzr300_4AM9kJO-NVXx7zPj8GYVg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Ming,

On Thursday 07 April 2011 03:24 PM, Ming Lei wrote:
> Hi Avik,
>
> Please check if the option CONFIG_PM is enabled or not.
CONFIG_PM is enabled in my config:

$ grep CONFIG_PM .config
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_SLEEP=y
CONFIG_PM_RUNTIME=y
CONFIG_PM_OPS=y
CONFIG_PM_OPP=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_ADP5520=y

As suggested in 
http://groups.google.com/group/pandaboard/browse_thread/thread/74abf5dafa2fd6e2/b1cc29b5060b4223?#b1cc29b5060b4223 
, do you think prcm_setup_regs() has to be called for OMAP4?

Regards,
Avik

>
> If not, please try to enable it to see you issue can be fixed.
>
>
> 2011/4/7 Avik Sil<aviksil@linux.vnet.ibm.com>:
>> Hi Ming,
>>
>> On Wednesday 06 April 2011 11:37 AM, Ming Lei wrote:
>>>
>>> Hi Avik,
>>>
>>> 2011/4/5 Avik Sil<aviksil@linux.vnet.ibm.com>:
>>>>
>>>> Even after using ioremapped addresses in omap_writel() I'm getting the
>>>> oops.
>>>> Can you please point me to the location in mainline, where these l3
>>>> clocks
>>>> are enabled?
>>>
>>> I guess you can find here:
>>>
>>>           l3_main_3_ick&&    l3_instr_ick:
>>> arch/arm/mach-omap2/clock44xx_data.c
>>>
>>> the clocks are set as ENABLE_ON_INIT.
>>
>> Those clocks are also set ENABLE_ON_INIT in the linaro kernel. But still
>> it's hanging at "val = __raw_readl(base + LOCKSTATUS);" in cti_unlock(),
>> even after explicitly enabling it using:
>>
>> omap_writel(1, CM_L3INSTR_L3_3_CLKCTRL);
>> omap_writel(1, CM_L3INSTR_L3_INSTR_CLKCTRL);
>> omap_writel(2, CM_EMU_CLKSTCTRL);
>> while ((omap_readl(CM_EMU_CLKSTCTRL)&  0x300) != 0x300);
>>
>> BTW, the oops were fixed by replacing omap_writel with __raw_writel.
>>
>> Regards,
>> Avik
>>
>>>
>>> thanks,
>>
>>
>
>
> thanks,

