From: Avik Sil <aviksil@linux.vnet.ibm.com>
Subject: Re: arm: pmu: support pmu/perf on OMAP4 - booting problem on pandaboard
Date: Tue, 05 Apr 2011 16:35:52 +0530
Message-ID: <4D9AF790.7010504@linux.vnet.ibm.com>
References: <4D95E244.1050400@linux.vnet.ibm.com> <BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com> <4D99D251.6000901@linux.vnet.ibm.com> <BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com> <4D99EB4B.3020303@linux.vnet.ibm.com> <BANLkTinQ-QQ7zu2KrhhhdWwnzo=a-KynoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:39621 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743Ab1DELF5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Apr 2011 07:05:57 -0400
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p35AeuXr009351
	for <linux-omap@vger.kernel.org>; Tue, 5 Apr 2011 06:40:56 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CF94438C803B
	for <linux-omap@vger.kernel.org>; Tue,  5 Apr 2011 07:05:48 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p35B5uBU341832
	for <linux-omap@vger.kernel.org>; Tue, 5 Apr 2011 07:05:56 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p35B5tXT001917
	for <linux-omap@vger.kernel.org>; Tue, 5 Apr 2011 07:05:56 -0400
In-Reply-To: <BANLkTinQ-QQ7zu2KrhhhdWwnzo=a-KynoQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tuesday 05 April 2011 07:33 AM, Ming Lei wrote:
> Hi,
>
> 2011/4/5 Avik Sil<aviksil@linux.vnet.ibm.com>:
>> #define OMAP4430_CM_L3INSTR_L3_3_CLKCTRL
>> OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_INST, 0x0720)
>> [...]
>>
>> Should I use those identifier instead?
>
> Yes, seems right, but you need to use the ioremap addresses of the identifiers.
>
Even after using ioremapped addresses in omap_writel() I'm getting the 
oops. Can you please point me to the location in mainline, where these 
l3 clocks are enabled?

Regards,
Avik
>> Are there other definitions for the identifiers you have used?
>
> As I said  before, these are not needed for mainline, so I didn't try these.
>
>
> thanks,

