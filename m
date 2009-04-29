From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [PATCH] OMAP3: SR: Fix SR driver to check for omap-pm return
 values
Date: Wed, 29 Apr 2009 10:49:51 +0300
Message-ID: <49F8069F.9020205@nokia.com>
References: <1240988319-30282-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62709 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757523AbZD2Hui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 03:50:38 -0400
In-Reply-To: <1240988319-30282-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

ext Rajendra Nayak wrote:
> This patch checks for the return values of omap_pm_vddx_get_opp()
> in SR driver and acts accordingly. With no SRF layer enabled the OMAP-PM layer
> api is unable to return the current OPP.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   42 +++++++++++++++++++++++++++++++++---
>  1 files changed, 38 insertions(+), 4 deletions(-)
> 

> +		if (!omap_pm_vdd1_get_opp())
> +			/* Assume Nominal OPP as current OPP unknown */
> +			vsel = mpu_opps[VDD1_OPP3].vsel;
> +		else
> +			vsel = mpu_opps[omap_pm_vdd1_get_opp()].vsel;
> +

Hi Rajendra,

   By this approach, what will be the implications if the bootloader had set the 
OPP to something different than your assumption?
   I think the best approach would be to modify the PM layer to at least return 
correct OPP and Frequency values. What do you think?
   We should not expect every driver using X_get_opp to assume the OPP if it 
returns error.

Please see this thread to see the alternative solution.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12021.html

I know it uses resource framework even if we set PM_NONE or PM_NOOP, but only 
for getting the correct OPP/frequency values.

regards,
-roger
