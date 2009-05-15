From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] PM: Disable usb host HW save and restore
Date: Fri, 15 May 2009 06:47:02 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038BE0A140@dlee02.ent.ti.com>
References: <1240484331-18722-1-git-send-email-kalle.jokiniemi@digia.com>
	 <87zldftxtu.fsf@deeprootsystems.com>
	 <13B9B4C6EF24D648824FF11BE8967162038BE09C66@dlee02.ent.ti.com>
 <1242369874.6466.213.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47635 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbZEOLrW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 07:47:22 -0400
In-Reply-To: <1242369874.6466.213.camel@ubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>


> > couple errata impacting different chip revs.
> >
> > Today in the older TI reference code this condition of a stuck on
> > power domain does not happen.  However, we are using a software
> > supervised method to disable the power domain.  May be this code has a
> > bug or the hardware does around auto use for this domain.
>
> Yes, usb-host autoidle was enabled when I was digging this issue.

Host domain?  (not host module).

> > The USBTLL SAR in 3.0 and before silicon will case a deadlock on 2nd
> > sleep attempt.  On 3.1 and after its fixed.
>
> So ES3.0 devices are exposed to the cold reset issue (since USBTLL SAR
> is only enabled in ES3.1). Would you suspect that we can enable USB host
> SAR, if the AUTOIDLE is turned off? Then we would not need this patch.

For 3.0 we used a software sar if ohci was in use.  For ehci its not good enough as there is state not accessible by software.

Not as you wrote. I was thinking you need to try to go to idle using CM_CLKSTCTRL_USBHOST = 1.  Not at 0x3 and then waiting for a dependent event to trigger you.  Once your preconditions are met you can initiate and idle ack sequence.

Regards,
Richard W.
