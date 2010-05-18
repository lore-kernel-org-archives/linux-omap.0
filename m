From: "Lesly Arackal Manuel" <leslyam@ti.com>
Subject: RE: [PATCH v5 3/5] omap3: pm: Generic TRITON power scriptsforOMAP3 based boards
Date: Tue, 18 May 2010 14:18:33 +0530
Message-ID: <000f01caf666$e799e4c0$db8818ac@apr.dhcp.ti.com>
References: <1271677408-2143-1-git-send-email-leslyam@ti.com> <20100510143043.GA4703@codecarver.research.nokia.com> <015501caf28a$5a984e20$ba8818ac@apr.dhcp.ti.com> <20100517105833.GA4736@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46215 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757023Ab0ERIsp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 May 2010 04:48:45 -0400
In-Reply-To: <20100517105833.GA4736@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org, 'Lesly A M' <x0080970@ti.com>, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>



> -----Original Message-----
> From: Peter 'p2' De Schrijver [mailto:peter.de-schrijver@nokia.com]
> Sent: Monday, May 17, 2010 4:29 PM
> To: ext Lesly Arackal Manuel
> Cc: linux-omap@vger.kernel.org; 'Lesly A M'; 'Nishanth Menon'; 'David
> Derrick'; 'Samuel Ortiz'
> Subject: Re: [PATCH v5 3/5] omap3: pm: Generic TRITON power
> scriptsforOMAP3 based boards
> 
> Hi,
> 
> >
> > Hi Peter,
> >
> > The RES_TYPE field is same for all messages.
> >
> > The resource which can go to low-power mode with clk_req sig de-
> asserting is
> > configured as RES_TYPE2 = '2'. And the resource which can go to low-
> power
> > mode with sys_off sig de-asserting is configured as RES_TYPE2 = '1'.
> >
> > The RES_TYPE2 is '2' for P3 wakeup and the msg will applicable for
> Resource
> > which have their TYPE2 field configured '2' (RES_VINTANA1, RES_VINTANA2,
> > RES_VINTDIG, VIO, RES_CLKEN, RES_HFCLKOUT).
> >
> > RES_TYPE2 = '1' for P1_P2 wakeup.
> > (Applicable for res: RES_VPLL1, RES_VDD1, RES_VDD2, RES_REGEN,
> > RES_NRES_PWRON, RES_SYSEN)
> >
> 
> Ok. But why not just assign the resources to the appropriate groups ?
> Eg.  assign VIO to P3 and assign VPLL1 to P1_P2 ? Then you only need one
> message type. Also, why are you using RES_TYPE2 instead of RES_TYPE ?
> 

Hi Peter,

This sequence is recommended by the Hardware team.

Because some resource have non-zero reset values for RES_TYPE, and may be
used in some other seq (eg: power_up).

Regards,
Lesly A M

