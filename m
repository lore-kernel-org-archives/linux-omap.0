From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH 2/3] TI814X: Add cpu type macros and detection support
Date: Fri, 19 Aug 2011 09:48:38 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03ABD26D82@dbde02.ent.ti.com>
References: <1312479894-22824-1-git-send-email-hemantp@ti.com>
 <20110815151723.GU12348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47033 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab1HSESx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Aug 2011 00:18:53 -0400
In-Reply-To: <20110815151723.GU12348@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

Tony Lindgren wrote on Monday, August 15, 2011 8:47 PM:

> * Hemant Pedanekar <hemantp@ti.com> [110804 20:39]:
>> This patch adds cpu type, macros for identification of TI814X device.
>> 
>> Note that following updates to common OMAP data structures are made:
>> 1) struct omap_chip_id member 'oc' is updated to u32 from u16 as omap chip
>> bitfield has exhausted 16 bits for CHIP_IS_XXX.
>> 2) cpu_mask and RATE_IN_XXX flags have crossed 8 bit hence struct
>> clksel_rate.flags, struct prcm_config.flags and cpu_mask are changed to
>> u16 from u8.
> 
> We'll be getting rid of CHIP_IS usage and replace them with SoC specific
> lists. So we need to wait few days and then this patch will need to get
> updated a bit.
> 

Tony,
Is there a branch which I can have a look at for changes being done?
Thanks.


   Hemant