From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Wed, 03 Apr 2013 15:16:05 +0200
Message-ID: <515C2B95.7050408@gmail.com>
References: <51312430.6060306@gmail.com> <87sj4cunp6.fsf@dell.be.48ers.dk> <5133E268.5010604@gmail.com> <51388D64.9000005@gmail.com> <513A1580.90303@gmail.com> <514863BD.5010503@gmail.com> <87620nwmd2.fsf@dell.be.48ers.dk> <515C19D7.6080702@gmail.com> <20130403120454.GX25837@arwen.pp.htv.fi> <515C23D4.3010206@gmail.com> <20130403130807.GB14680@arwen.pp.htv.fi> <62C108BE-894A-4F1D-BE85-14DB3217120E@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:41269 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758489Ab3DCNQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 09:16:05 -0400
In-Reply-To: <62C108BE-894A-4F1D-BE85-14DB3217120E@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: balbi@ti.com, Peter Korsgaard <jacmet@sunsite.dk>, "Mohammed, Afzal" <afzal@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Santhapuri, Damodar" <damodar.santhapuri@ti.com>, "B, Ravi" <ravibabu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>

On 03.04.2013 15:12, Koen Kooi wrote:
> 
> Op 3 apr. 2013, om 15:09 heeft Felipe Balbi <balbi@ti.com> het
> volgende geschreven:
> 
>> Hi,
>> 
>> On Wed, Apr 03, 2013 at 02:43:00PM +0200, Daniel Mack wrote:
>>> On 03.04.2013 14:04, Felipe Balbi wrote:
>>>> On Wed, Apr 03, 2013 at 02:00:23PM +0200, Daniel Mack wrote:
>>> 
>>>>> Felipe, could you explain the background on how the dsps
>>>>> driver is supposed to work in host mode at boot time with the
>>>>> rework of the driver you did for 3.7? It might just be me not
>>>>> understanding the rationale behind all these changes, but
>>>>> appearantly, I'm not the only one who's affected by that.
>>>> 
>>>> right, so the idea with that was to drop the huge amount of
>>>> ifdeferry hack from the MUSB driver. It would be great if
>>>> someone would send *CLEAN* patches adding Kconfig-based role
>>>> choices again.
>>> 
>>> Are Kconfig-based rules really what we want here after all?
>>> Wouldn't run-time configured settings make much more sense,
>>> considering that
>> 
>> we need both. Say that you want to build a product with MUSB
>> hardwired as host, why would you enable gadget framework ?
>> 
>> I can think of at least am335x where this would be perfectly
>> plausible (no EHCI available, only MUSB).
> 
> Nice that you mention am335x, since the beaglebone has 2 MUSB
> controllers: one hardwired as host and one hardwired as slave. So how
> will KConfig options solve that?
> 

You would enable DUAL_ROLE and then let run-time code sort out the
actual config. Which is what most people would do if they are uncertain,
and which leaves the Kconfig option only for opting out some binary size.

Also, we already have CONFIG_USB_GADGET_MUSB_HDRC which is there to
remove all the gadget-only bits, right?


Daniel
