From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH v5 3/5] omap3: pm: Generic TRITON power scripts
	forOMAP3 based boards
Date: Mon, 17 May 2010 13:58:33 +0300
Message-ID: <20100517105833.GA4736@codecarver.research.nokia.com>
References: <1271677408-2143-1-git-send-email-leslyam@ti.com> <20100510143043.GA4703@codecarver.research.nokia.com> <015501caf28a$5a984e20$ba8818ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29200 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab0EQK6w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 06:58:52 -0400
Content-Disposition: inline
In-Reply-To: <015501caf28a$5a984e20$ba8818ac@apr.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Lesly Arackal Manuel <leslyam@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 'Lesly A M' <x0080970@ti.com>, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

Hi,

> 
> Hi Peter,
> 
> The RES_TYPE field is same for all messages.
> 
> The resource which can go to low-power mode with clk_req sig de-asserting is
> configured as RES_TYPE2 = '2'. And the resource which can go to low-power
> mode with sys_off sig de-asserting is configured as RES_TYPE2 = '1'.
> 
> The RES_TYPE2 is '2' for P3 wakeup and the msg will applicable for Resource
> which have their TYPE2 field configured '2' (RES_VINTANA1, RES_VINTANA2,
> RES_VINTDIG, VIO, RES_CLKEN, RES_HFCLKOUT).
> 
> RES_TYPE2 = '1' for P1_P2 wakeup.
> (Applicable for res: RES_VPLL1, RES_VDD1, RES_VDD2, RES_REGEN,
> RES_NRES_PWRON, RES_SYSEN)
> 

Ok. But why not just assign the resources to the appropriate groups ?
Eg.  assign VIO to P3 and assign VPLL1 to P1_P2 ? Then you only need one
message type. Also, why are you using RES_TYPE2 instead of RES_TYPE ?

Cheers,

Peter.

-- 
goa is a state of mind
