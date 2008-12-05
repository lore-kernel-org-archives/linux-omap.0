From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 1/1] Save sram context after changing MPU, DSP or core clocks
Date: Fri, 5 Dec 2008 11:49:03 +0200
Message-ID: <B71CE868F2BC2847B3F23C5A8EE39430DF9821@vaebe110.NOE.Nokia.com>
References: <1227095127-7158-1-git-send-email-peter.de-schrijver@nokia.com> <1227095127-7158-2-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26182 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbYLEJtI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 04:49:08 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB59mNib016947
	for <linux-omap@vger.kernel.org>; Fri, 5 Dec 2008 03:49:06 -0600
Content-class: urn:content-classes:message
In-Reply-To: <1227095127-7158-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Peter.De-Schrijver@nokia.com

Hi Peter,

This patch causes linker error without CONFIG_PM option, should add
#ifdef:s around the call to omap3_save_scratchpad_contents();

-Tero

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext 
>Peter 'p2' De Schrijver
>Sent: 19 November, 2008 13:45
>To: linux-omap@vger.kernel.org
>Cc: De-Schrijver Peter (Nokia-D/Helsinki)
>Subject: [PATCH 1/1] Save sram context after changing MPU, DSP 
>or core clocks
>
>
>Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>---
> arch/arm/mach-omap2/clock34xx.c |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/clock34xx.c 
>b/arch/arm/mach-omap2/clock34xx.c index d97d5a9..962ce56 100644
>--- a/arch/arm/mach-omap2/clock34xx.c
>+++ b/arch/arm/mach-omap2/clock34xx.c
>@@ -911,6 +911,9 @@ printk("%s set to %luHz intended rate 
>%luHz\n",dpll2_clk->name,clk_get_rate(dpll
> 		clk_set_rate(dpll3_clk, prcm_vdd->rate);
> 		curr_vdd2_prcm_set = prcm_vdd;
> 	}
>+
>+	omap3_save_scratchpad_contents();
>+
> 	return 0;
> }
> 
>--
>1.5.6.3
>
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in the body of a message to 
>majordomo@vger.kernel.org More majordomo info at  
>http://vger.kernel.org/majordomo-info.html
>
