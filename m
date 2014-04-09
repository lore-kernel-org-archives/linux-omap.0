From: Roger Quadros <rogerq@ti.com>
Subject: Re: omap based boards (next-20140409-omap2plus_defconfig) - boot
 time warning:
Date: Wed, 9 Apr 2014 16:25:47 +0300
Message-ID: <53454A5B.3040505@ti.com>
References: <53453FF1.60803@ti.com> <53454803.3090703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33168 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685AbaDINZu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2014 09:25:50 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id s39DPnlK008647
	for <linux-omap@vger.kernel.org>; Wed, 9 Apr 2014 08:25:49 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s39DPnGj005535
	for <linux-omap@vger.kernel.org>; Wed, 9 Apr 2014 08:25:49 -0500
In-Reply-To: <53454803.3090703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>

Nishant,

On 04/09/2014 04:15 PM, Nishanth Menon wrote:
> On 04/09/2014 07:41 AM, Nishanth Menon wrote:
>> Hi,
>> http://slexy.org/raw/s2pkLsiFBX
>>
>> I noticed the following sets of warnings with omap2plus_defconfig on
>> next-20140409. As per older logs, next-20140401 had it and v3.14 tag
>> also had it (I have'nt retained older logs).
>>
> 
> Here is a quick list of 20 odd boards I am testing with:
> 
> next-20140409-omap2plus_defconfig
> 
>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2Ho7WPbaZ
> omap_hwmod: tptc* using broken dt data from edma
> platform 49000000.edma: alias fck already exists
> 
>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2A5ZJjsuZ
> same for tptc, edma
> 
>  3: am3517-evm:  Boot PASS: http://slexy.org/raw/s20q8rTwCJ
> omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
> omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
> Address Hole seen by USB_OTG  at address dc0f9c0c
> platform iva.2: Cannot lookup hwmod 'iva'
> platform 480c5000.aes: Cannot lookup hwmod 'aes'
> platform 48094000.mailbox: Cannot lookup hwmod 'mailbox'
> platform 480bd400.mmu: Cannot lookup hwmod 'mmu_isp'
> platform 480c3000.sham: Cannot lookup hwmod 'sham'
> platform 480cb000.smartreflex: Cannot lookup hwmod 'smartreflex_core'
> platform 480cb000.smartreflex: Cannot lookup hwmod 'smartreflex_iva'
> edma-dma-engine: probe of edma-dma-engine.0 failed with error -5
> 
>  4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s21kcHKdyf
> nothing interesting.
> 
>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s210geZKgS
> platform 53701000.des: Cannot lookup hwmod 'des'
> platform 49000000.edma: alias fck already exists
> the usb and qspi issue reported.
> 
>  6: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s20t5JOyI4
> known issue. (gpio reset for DDR)
> 
>  7: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2TXdBONNI
>  omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
>  omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp

>  omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
>  omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm

these 2 usb host/tll messages seem to appear for all OMAP3 based boards.
Seems like incorrect hwmod data. I'll send a patch to fix this.

cheers,
-roger

