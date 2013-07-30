From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/8] ARM: DRA7: Reuse all of PRCM and MPUSS SMP infra
Date: Tue, 30 Jul 2013 18:08:56 +0530
Message-ID: <51F7B3E0.9020005@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com> <1375183546-12758-4-git-send-email-rnayak@ti.com> <51F7B100.2020600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38989 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828Ab3G3Mj0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 08:39:26 -0400
In-Reply-To: <51F7B100.2020600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com

On Tuesday 30 July 2013 05:56 PM, Nishanth Menon wrote:
> On 07/30/2013 06:25 AM, Rajendra Nayak wrote:
>> From: R Sricharan <r.sricharan@ti.com>
> [...]
>>   # Clock framework
>>   obj-$(CONFIG_ARCH_OMAP2)        += $(clock-common) clock2xxx.o
>> @@ -181,6 +187,8 @@ obj-$(CONFIG_SOC_AM33XX)        += $(clock-common) dpll3xxx.o
>>   obj-$(CONFIG_SOC_AM33XX)        += cclock33xx_data.o
>>   obj-$(CONFIG_SOC_OMAP5)            += $(clock-common)
>>   obj-$(CONFIG_SOC_OMAP5)            += dpll3xxx.o dpll44xx.o
>> +obj-$(CONFIG_SOC_DRA7XX)        += $(clock-common)
>> +obj-$(CONFIG_SOC_DRA7XX)        += dpll3xxx.o dpll44xx.o
>>
> 
> are these in sync with DRA7 support being introduced for clock data in [1]?

I don't want to have a dependency on those patches since I am not sure of them
making it into 3.12.

> 
> 
> [1] http://marc.info/?l=linux-omap&m=137456411706971&w=2
> 

