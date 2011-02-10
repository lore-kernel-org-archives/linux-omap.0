From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v5 1/4] TI816X: Update common omap platform files
Date: Thu, 10 Feb 2011 23:07:17 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036ACA41C9@dbde02.ent.ti.com>
References: <1297270555-32447-1-git-send-email-hemantp@ti.com>
 <20110210013910.GF20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39987 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab1BJRip convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 12:38:45 -0500
In-Reply-To: <20110210013910.GF20795@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

cvTony Lindgren wrote on Thursday, February 10, 2011 7:09 AM:

> Hi,
> 
> * Hemant Pedanekar <hemantp@ti.com> [110209 08:54]:
>> 
>>  1) Multi-OMAP build with CONFIG_SOC_OMAPTI816X: The kernel built only for
>>  TI816X OMAP3 SoCs along with any other OMAP2/4 (e.g., OMAP4s). May not
>>  boot on other OMAP3 SoCs.
> 
> This option does not sound right. For the multi-omap builds we need to have
> the system working for all the processors, there should not be any reason
> not to have things working.
> 
> Do you have some example in mind where other omaps break? If so, we should
> just fix that issue.
> 
> Regards,
> 
> Tony

I will take care of this using separate map_io as you mentioned on
the other mail on patch 2 comment.

Do you think the 2nd case restriction mentioned in this patch comment is OK?

" 2) OMAP3 only build with CONFIG_SOC_OMAPTI816X: This will build TI816X
 optimized kernel. May not boot on other OMAP3 SoCs."

As I had mentioned on follow up on Paul's comment on v4, some OMAP3 specific
code may get skipped on non-multi-omap builds with CONFIG_SOC_OMAPTI816X
(cpu_is_ti816x() is true) such as:

-       if (omap_rev() >= OMAP3430_REV_ES2_0)     
+       if (!cpu_is_ti816x() && (omap_rev() >= OMAP3430_REV_ES2_0)) 
                omap3_clk_lock_dpll5();    

Thanks.

   Hemant