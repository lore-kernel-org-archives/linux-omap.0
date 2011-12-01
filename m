From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC PATCH 07/11] arm:omap:am33xx: Add irq, dma and module base
 addr to SoC header files
Date: Thu, 1 Dec 2011 12:03:16 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A804762B@DBDE01.ent.ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
	<1321809555-13833-8-git-send-email-hvaibhav@ti.com> <87obvtt66u.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41764 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669Ab1LAMD1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Dec 2011 07:03:27 -0500
In-Reply-To: <87obvtt66u.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Mohammed, Afzal" <afzal@ti.com>


> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, December 01, 2011 7:16 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; paul@pwsan.com; linux-
> arm-kernel@lists.infradead.org; Cousson, Benoit; Mohammed, Afzal
> Subject: Re: [RFC PATCH 07/11] arm:omap:am33xx: Add irq, dma and module
> base addr to SoC header files
> 
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > This patch creats seperate irq and dma defination header file
> > and updates the module base addresses required for HWMOD data.
> >
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> These headers/defines should no longer be needed.  Instead, as with
> OMAP4, the raw values are used in the hwmod data (and we'll be moving
> device tree for these values.)
> 
Ok, will clean this up in next version.

Thanks,
Vaibhav

> Kevin
