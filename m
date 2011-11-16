From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] arm:omap:serial:cleanup: use module rev instead of
 cpu_is_xxxx
Date: Wed, 16 Nov 2011 14:53:15 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A803242D@DBDE01.ent.ti.com>
References: <1320677860-32663-1-git-send-email-hvaibhav@ti.com>
 <87k47bsonr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42387 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268Ab1KPOxZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Nov 2011 09:53:25 -0500
In-Reply-To: <87k47bsonr.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Hilman, Kevin
> Sent: Tuesday, November 08, 2011 1:15 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH] arm:omap:serial:cleanup: use module rev instead of
> cpu_is_xxxx
> 
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > For OMAP3 uarts (module rev >= 0x52) and all successor devices
> > (omap4, TI81xx, AM33xx, etc...) empty fifo read errata is applicable,
> > so we can get rid of cpu_is_xxxx check and simply check for module rev
> here.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> > NOTE: This patch has been tested on OMAP3EVM, and I expect to work on
> all OMAP3
> > family of devices (including TI816x, TI814x, AM335x, etc...).
> > but I am quite not sure about OMAP2 device, can anybody comment/test?
> 
> Leaving OMAP2 as it is should be fine.
> 
> There is a major UART cleanup in progress from Govindraj.  I suggest you
> rework this patch on top of his series from 10/18:
> 
>        [PATCH v7 00/21] OMAP2+: UART: Runtime adaptation + cleanup
> 
> although it still has a few changes to go through before being ready to
> merge.
> 
Kevin,

Sorry, I missed to update on this.

We do not need this patch anymore. With latest cleanup series from Govindraj, it is already taken care. Please read below commit description -

-------------From Govindraj's commit (405b5009)------------
Serial_in and serial_out override for 8250 serial driver is also
removed. Empty fifo read fix is already taken care with omap-serial
driver with data ready bit check from LSR reg before reading RX fifo.
Also waiting for THRE(transmit hold reg empty) is done with wait_for_xmitr
in omap-serial driver.

Thanks,
Vaibhav

> Kevin
