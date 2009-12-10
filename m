From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP3 : Fix I2C lockup during timeout/error cases
Date: Thu, 10 Dec 2009 14:49:37 -0800
Message-ID: <20091210224937.GX24013@atomide.com>
References: <1260451164-9459-1-git-send-email-manjugk@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A88E0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53824 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761857AbZLJWtd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 17:49:33 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A88E0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charu Latha" <charu@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Sonasath, Moiz" <m-sonasath@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "George, Harith" <harith@ti.com>

* Varadarajan, Charu Latha <charu@ti.com> [091210 06:27]:
>  
> 
> >-----Original Message-----
> >From: G, Manjunath Kondaiah 
> >Sent: Thursday, December 10, 2009 6:49 PM
> >To: linux-omap@vger.kernel.org
> >Cc: G, Manjunath Kondaiah; Menon, Nishanth; Sonasath, Moiz; 
> >Krishnamoorthy, Balaji T; Varadarajan, Charu Latha; George, Harith
> >Subject: [PATCH v2] OMAP3 : Fix I2C lockup during timeout/error cases
> >
> >Current OMAP3 I2C driver code does not follow the correct 
> >sequence for soft
> >reset. Due to this, lock up issues are reported during 
> >timeout/error cases.
> >
> >This patch fixes above issue by disabling I2C controller as 
> >per OMAP3430 TRM
> >for soft reset. As per TRM, I2C controller needs to be 
> >disabled as a first
> >step during soft reset.
> >
> >Here is correct soft reset sequence:
> >a. Ensure that the module is disabled
> >(clear the I2Ci.I2C_CON[15] I2C_EN bit to 0).
> >b. Set the I2Ci.I2C_SYSC[1] SRST bit to 1.
> >c. Enable the module by setting I2Ci.I2C_CON[15] I2C_EN bit to 1.
> >d. Check the I2Ci.I2C_SYSS[0] RDONE bit until it is set to 1 to
> >indicate the software reset is complete.
> >
> >v1 : Initital version
> >v2 : Removed delay since time taken for disabling I2C 
> >controller is zero
> >     jiffies
> >
> >Tested on Zoom2 and Zoom3 
> >
> >Signed-off-by: Manjunatha GK <manjugk@ti.com>
> >Signed-off-by: George, Harith<harith@ti.com>
> 
> Tested on 3430SDP too.
> Acked-by: Charulatha V <charu@ti.com>

This should be sent via the i2c list and to Ben Books.

Regards,

Tony
