From: Avik Sil <aviksil@linux.vnet.ibm.com>
Subject: Re: arm: pmu: support pmu/perf on OMAP4 - booting problem on pandaboard
Date: Mon, 04 Apr 2011 19:44:41 +0530
Message-ID: <4D99D251.6000901@linux.vnet.ibm.com>
References: <4D95E244.1050400@linux.vnet.ibm.com> <BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:37996 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab1DDOPD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 10:15:03 -0400
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p34E1l05027221
	for <linux-omap@vger.kernel.org>; Mon, 4 Apr 2011 08:01:47 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p34EEoCD068630
	for <linux-omap@vger.kernel.org>; Mon, 4 Apr 2011 08:14:50 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p34EJiNG009062
	for <linux-omap@vger.kernel.org>; Mon, 4 Apr 2011 08:19:45 -0600
In-Reply-To: <BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Ming,

On Saturday 02 April 2011 10:57 AM, Ming Lei wrote:
> Hi Avik,
>
> 2011/4/1 Avik Sil<aviksil@linux.vnet.ibm.com>:
>> Hi,
>>
>> I've applied the patches in
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/045283.html
>> on top of a linaro kernel which resulted in booting problem on Pandaboard.
>> It hangs inside the cti_unlock() while reading the LOCKSTATUS value, which
>> happens when omap_init_pmu() is called. Please help me debug the issue.
>
> Please check if  l3 clocks are enabled to drive CTI, such as done in below:
>
>         omap_writel(1, CM_L3INSTR_L3_3_CLKCTRL);
>         omap_writel(1, CM_L3INSTR_L3_INSTR_CLKCTRL);
>         omap_writel(2, CM_EMU_CLKSTCTRL);
>         while ((omap_readl(CM_EMU_CLKSTCTRL)&  0x300) != 0x300);
>
Can you please tell me where should I insert the above code to enable l3 
clocks to drive CTI?

Regards,
Avik

> No such issue on mainline since this clocks are enabled automatically.
>
> thanks,

