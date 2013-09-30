From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH v4 07/11] ARM: OMAP2+: CM: AM43x clockdomain data
Date: Mon, 30 Sep 2013 17:08:12 +0530
Message-ID: <524962A4.5080405@ti.com>
References: <cover.1380179370.git.afzal@ti.com> <a6758751113ef93bc912ccefb9cdb0ba383f19d5.1380179370.git.afzal@ti.com> <alpine.DEB.2.02.1309300927520.17980@utopia.booyaka.com> <52495B03.3050006@ti.com> <alpine.DEB.2.02.1309301107150.17980@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49541 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754733Ab3I3Lik (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Sep 2013 07:38:40 -0400
In-Reply-To: <alpine.DEB.2.02.1309301107150.17980@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ambresh K <ambresh@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>

Hi Paul,

On Monday 30 September 2013 04:39 PM, Paul Walmsley wrote:
> On Mon, 30 Sep 2013, Afzal Mohammed wrote:

>>> The references to "wkup_pwrdm" on some of these clockdomains don't 
>>> look right to me.  For example, this clockdomain is listed as being in 
>>> AM43XX_CM_WKUP_INST, but its enclosing powerdomain is listed as being in 
>>> AM43XX_PRM_WKUP_INST.  Looks to me like it's best to have two different 
>>> wakeup powerdomains: one CM_WKUP, and one PRM_WKUP.
>>
>> On AM43x, prcm is a single block as in AM335x and is part of wakeup
>> domain. This is different from OMAP4 that had separate prm and cm
>> blocks. Script also generated the same output.

> Why are there two different address offsets for CM_WKUP and PRM_WKUP?  
> From another patch in the series:
> 
> +#define AM43XX_PRM_WKUP_INST                           0x2000
> 
> ...
> 
> +#define AM43XX_CM_WKUP_INST                            0x2800

AM43XX_PRM_WKUP_INST and AM43XX_CM_WKUP_INST are offsets from PRCM_BASE.
We don't have separate base address for PRM & CM. This is similar to as
that in AM335x, where it is 0xD00 and 0x400 respectively (both from same
base) as in prm33xx.h & cm33xx.h.

Please note that AM43XX_PRM_PARTITION and AM43XX_CM_PARTITION both are '1'.

PRCM register details from TRM (not yet public) is mentioned below.

Regards
Afzal


PRCM Functional Registers
The table below shows the base address and address space for the PRCM
module instances.
Table 2. PRCM Instance Summary
ModuleName	BaseAddress	Size
OCP_SOCKET_PRM	0x0000		256 Bytes
PRM_MPU		0x0300		256 Bytes
PRM_GFX		0x0400		256 Bytes
PRM_RTC		0x0500		256 Bytes
PRM_TAMPER	0x0600		256 Bytes
PRM_CEFUSE	0x0700		256 Bytes
PRM_PER		0x0800		6 KBytes
PRM_WKUP	0x2000		2 KBytes
CM_WKUP		0x2800		2 KBytes
PRM_DEVICE	0x4000		256 Bytes
CM_DEVICE	0x4100		256 Bytes
CM_DPLL		0x4200		256 Bytes
CM_MPU		0x8300		256 Bytes
CM_GFX		0x8400		256 Bytes
CM_RTC		0x8500		256 Bytes
CM_TAMPER	0x8600		256 Bytes
CM_CEFUSE	0x8700		256 Bytes
CM_PER		0x8800		6 KBytes



