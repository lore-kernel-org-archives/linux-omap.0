From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 04/11] OMAP3: DMA: HWMOD: Add hwmod data structures
Date: Sat, 04 Sep 2010 16:45:29 +0200
Message-ID: <4C825B89.1000200@ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>	<1282647866-6918-5-git-send-email-manjugk@ti.com> <871v9awnwy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54688 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443Ab0IDOpg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 4 Sep 2010 10:45:36 -0400
In-Reply-To: <871v9awnwy.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Kevin,

On 9/3/2010 10:51 PM, Kevin Hilman wrote:
> Manjunatha GK<manjugk@ti.com>  writes:

[...]

>> +static struct omap_hwmod omap3xxx_dma_system_hwmod = {
>> +	.name		= "dma",
>> +	.class		=&omap3xxx_dma_hwmod_class,
>> +	.mpu_irqs	= omap3xxx_dma_system_irqs,
>> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dma_system_irqs),
>> +	.main_clk	= "l3_div_ck",
>> +	.slaves		= omap3xxx_dma_system_slaves,
>> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dma_system_slaves),
>> +	.masters	= omap3xxx_dma_system_masters,
>> +	.masters_cnt	= ARRAY_SIZE(omap3xxx_dma_system_masters),
>> +	.dev_attr	=&dma_dev_attr,
>> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>> +	.flags		= HWMOD_NO_IDLEST,
>
> hmm, I see an ST_DMA bit in CM_IDLEST1_CORE for DMA.

In fact in the case of the SDMA, the ST_DMA is the standby status and 
not the idle status... This is indeed not confusing at all...

This bit will just provide information about the master port activity 
(MStandby). Extract from the TRM:
In case of Smart-Standby: MStandby is asserted if at least one of the
following two conditions is satisfied:
1. All the channels are disabled
2. There is no non-synchronized channel enabled and or no DMA request 
input is asserted and no request in the read and write port scheduler 
state machine.

This information is unfortunately useless for the OCP slave port point 
of view.

There are a couple of other initiators that does not have any idle 
status: IVA, MPU and SGX. USB_OTG has both idle and standby.

Regards,
Benoit
