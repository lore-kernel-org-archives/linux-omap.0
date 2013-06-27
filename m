From: Roger Quadros <rogerq@ti.com>
Subject: Re: omap4 ehci sporadic resume issue
Date: Thu, 27 Jun 2013 16:59:38 +0300
Message-ID: <51CC454A.1040104@ti.com>
References: <51CC2755.2030505@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40967 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408Ab3F0N7m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jun 2013 09:59:42 -0400
In-Reply-To: <51CC2755.2030505@amarulasolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: USB list <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

Hi Michael,

On 06/27/2013 02:51 PM, Michael Trimarchi wrote:
> Hi
> 
> I'm working on omap4460 with two ulpi connected to (SMSC3320 -> HUB SMSC2514) or (TUSB1210 -> HUB SMSC2514). 
> The problem only happen when both port are used and after few suspend resume are triggered.
> If I use just one port there is no issue on suspend resume. I already covered all TI
> errata that I know and I'm working on TI kernel.
> 
> The problem is here
> 
> [   77.701934] ehci-omap ehci-omap.0: irq status a004 Async Recl PCD
> 
> Both ports change status from 001005 to 001009 (you have a log just after). 
> So from host point of view both hub connected are not working in HS mode. 
> After that the omap ehci has gone because the bus can not work in FS and LS and I can not recover from here.
> Status of transceivers are dumped and they are ok after resume.
> 
> Do you have any suggestion?

I'm not very sure but both ports suddenly changing state like that look like
a hardware issue. Also, it is strange that you can reproduce it only when two
ports are simultaneously in use. Unfortunately, I can't match your setup with 2 ULPI
ports.

I have a OMAP5 uEVM that uses 2 ports but it won't be identical to your setup as
they are on HSIC and not ULPI.

Did you try errata i693?

Also, are you suspending and resuming only the USB or the entire system?

cheers,
-roger
