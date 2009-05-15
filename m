From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: RE: [PATCH] PM: Disable usb host HW save and restore
Date: Fri, 15 May 2009 16:52:31 +0300
Message-ID: <1242395551.6466.294.camel@ubuntu>
References: <1240484331-18722-1-git-send-email-kalle.jokiniemi@digia.com>
	 <87zldftxtu.fsf@deeprootsystems.com>
	 <13B9B4C6EF24D648824FF11BE8967162038BE09C66@dlee02.ent.ti.com>
	 <1242369874.6466.213.camel@ubuntu>
	 <13B9B4C6EF24D648824FF11BE8967162038BE0A140@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:26800 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754618AbZEONw2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 May 2009 09:52:28 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038BE0A140@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, felipe.balbi@nokia.com

On Fri, 2009-05-15 at 14:47 +0300, Woodruff, Richard wrote:
> > > couple errata impacting different chip revs.
> > >
> > > Today in the older TI reference code this condition of a stuck on
> > > power domain does not happen.  However, we are using a software
> > > supervised method to disable the power domain.  May be this code has a
> > > bug or the hardware does around auto use for this domain.
> >
> > Yes, usb-host autoidle was enabled when I was digging this issue.
> 
> Host domain?  (not host module).

OTG_SYSCONFIG.AUTOIDLE was what I meant.

> 
> > > The USBTLL SAR in 3.0 and before silicon will case a deadlock on 2nd
> > > sleep attempt.  On 3.1 and after its fixed.
> >
> > So ES3.0 devices are exposed to the cold reset issue (since USBTLL SAR
> > is only enabled in ES3.1). Would you suspect that we can enable USB host
> > SAR, if the AUTOIDLE is turned off? Then we would not need this patch.
> 
> For 3.0 we used a software sar if ohci was in use.  For ehci its not
> good enough as there is state not accessible by software.

USB is by no means my specialty. That being said, using HW SAR could be
used on ohci as well, right? Like you said: the cold reset issue will
remain, if we don't use HW SAR for either USBTLL or USB HOST. And using
USBTLL is not possible for ES3.0 due to that errata.  

> 
> Not as you wrote. I was thinking you need to try to go to idle using
> CM_CLKSTCTRL_USBHOST = 1.  Not at 0x3 and then waiting for a dependent
> event to trigger you.  Once your preconditions are met you can
> initiate and idle ack sequence.

Ok, now I understand what you meant. I used toggling
"/sys/power/enable_off_mode" to switch the USB HOST power domain state
from RET->OFF->RET->.... Problem was I got RET->OFF->ON->ON->ON....

The resource framework takes care of switching usb-state (with
next_state values and hw automated state transition) in this case. We
would need some special usb sw transition code in resource framework
and/or pm code to make the transitions work for usb host.

- Kalle

> 
> Regards,
> Richard W.

