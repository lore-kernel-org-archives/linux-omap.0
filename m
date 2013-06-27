From: Roger Quadros <rogerq@ti.com>
Subject: Re: omap4 ehci sporadic resume issue
Date: Thu, 27 Jun 2013 17:49:41 +0300
Message-ID: <51CC5105.4070301@ti.com>
References: <51CC2755.2030505@amarulasolutions.com> <51CC454A.1040104@ti.com> <20130627141704.GF12956@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54689 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab3F0Otu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jun 2013 10:49:50 -0400
In-Reply-To: <20130627141704.GF12956@panicking>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: USB list <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, "Bilovol, Ruslan" <ruslan.bilovol@ti.com>

+Ruslan

On 06/27/2013 05:17 PM, Michael Trimarchi wrote:
> Hi Roger
> 
> On Thu, Jun 27, 2013 at 04:59:38PM +0300, Roger Quadros wrote:
>> Hi Michael,
>>
>> On 06/27/2013 02:51 PM, Michael Trimarchi wrote:
>>> Hi
>>>
>>> I'm working on omap4460 with two ulpi connected to (SMSC3320 -> HUB SMSC2514) or (TUSB1210 -> HUB SMSC2514). 
>>> The problem only happen when both port are used and after few suspend resume are triggered.
>>> If I use just one port there is no issue on suspend resume. I already covered all TI
>>> errata that I know and I'm working on TI kernel.
>>>
>>> The problem is here
>>>
>>> [   77.701934] ehci-omap ehci-omap.0: irq status a004 Async Recl PCD
>>>
>>> Both ports change status from 001005 to 001009 (you have a log just after). 
>>> So from host point of view both hub connected are not working in HS mode. 
>>> After that the omap ehci has gone because the bus can not work in FS and LS and I can not recover from here.
>>> Status of transceivers are dumped and they are ok after resume.
>>>
>>> Do you have any suggestion?
>>
>> I'm not very sure but both ports suddenly changing state like that look like
>> a hardware issue. Also, it is strange that you can reproduce it only when two
>> ports are simultaneously in use. Unfortunately, I can't match your setup with 2 ULPI
> 
> Yes I know that TI doesn't have any setup like that.
> 
>> ports.
>>
>> I have a OMAP5 uEVM that uses 2 ports but it won't be identical to your setup as
>> they are on HSIC and not ULPI.
>>
>> Did you try errata i693?
> 
> Yes I have it. It's not clear if I need to wait after
> ehci_writel(ehci, temp | PORT_SUSPEND, status_reg);
> polling the suspendM of the SMSC or the suspend status of the PORT or I can
> switch just after this instruction. Because TI kernel use an msleep of 4 mseconds and then switch. It could be a timing issue on how errata is implemented when I have two ports? How this internal count works?


The OMAP EHCI controller transparently sets the suspendM bit of the PHY when you
set the PORT_SUSPEND feature on the EHCI port. So you don't need to poll for anything.

What the errata says is that once software sets the PORT_SUSPEND feature, the PHY will
got into suspend and cut the PHY clock sooner than required for the EHCI controller to
complete its suspend operations. (NOTE: this is only applicable when the PHY is providing the
ulpi_clk).

What the workaround does is to just wait for a while (don't know why 4ms), and remux the
ulpi_clock to an internal 60MHz clock for a while so that it can complete its suspend operations.

> 
> First time is 18, and then?
>
I think it is 18 for every port suspend.
 
>>
>> Also, are you suspending and resuming only the USB or the entire system?
>>
> 
> Whole system. Right the only susbsytem that doens't go to suspend is the FSUSB
> but this depends on the bootloader.

OK. 

cheers,
-roger
