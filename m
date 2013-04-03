From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Wed, 03 Apr 2013 14:43:00 +0200
Message-ID: <515C23D4.3010206@gmail.com>
References: <509420D8.1030307@gmail.com> <C8443D0743D26F4388EA172BF4E2A7A93EA0A1F2@DBDE01.ent.ti.com> <51312430.6060306@gmail.com> <87sj4cunp6.fsf@dell.be.48ers.dk> <5133E268.5010604@gmail.com> <51388D64.9000005@gmail.com> <513A1580.90303@gmail.com> <514863BD.5010503@gmail.com> <87620nwmd2.fsf@dell.be.48ers.dk> <515C19D7.6080702@gmail.com> <20130403120454.GX25837@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:59634 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756765Ab3DCMm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 08:42:59 -0400
In-Reply-To: <20130403120454.GX25837@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Peter Korsgaard <jacmet@sunsite.dk>, "Mohammed, Afzal" <afzal@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Santhapuri, Damodar" <damodar.santhapuri@ti.com>, "B, Ravi" <ravibabu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, Kishon Vijay Abraham I <kishon@ti.com>

On 03.04.2013 14:04, Felipe Balbi wrote:
> On Wed, Apr 03, 2013 at 02:00:23PM +0200, Daniel Mack wrote:

>> Felipe, could you explain the background on how the dsps driver is
>> supposed to work in host mode at boot time with the rework of the driver
>> you did for 3.7? It might just be me not understanding the rationale
>> behind all these changes, but appearantly, I'm not the only one who's
>> affected by that.
> 
> right, so the idea with that was to drop the huge amount of ifdeferry
> hack from the MUSB driver. It would be great if someone would send
> *CLEAN* patches adding Kconfig-based role choices again.

Are Kconfig-based rules really what we want here after all? Wouldn't
run-time configured settings make much more sense, considering that
people might want to run a single kernel image on multiple platforms? I
believe it should be up to the DT to define the actual hardware wiring.


Daniel

