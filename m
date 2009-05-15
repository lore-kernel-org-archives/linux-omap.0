From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: RE: [PATCH] PM: Disable usb host HW save and restore
Date: Fri, 15 May 2009 09:44:34 +0300
Message-ID: <1242369874.6466.213.camel@ubuntu>
References: <1240484331-18722-1-git-send-email-kalle.jokiniemi@digia.com>
	 <87zldftxtu.fsf@deeprootsystems.com>
	 <13B9B4C6EF24D648824FF11BE8967162038BE09C66@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:20088 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756494AbZEOGoc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 May 2009 02:44:32 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038BE09C66@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

On Thu, 2009-05-14 at 20:40 +0300, Woodruff, Richard wrote:
> > From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> > Sent: Thursday, May 14, 2009 12:10 PM
> > To: Kalle Jokiniemi
> 
> > Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:
> >
> > > The hardware SAVEANDRESTORE mechanism seems to leave
> > > USB HOST power domain permanently into active state
> > > after one transition from off to active state.
> > > Disabling for now.
> 
> Some are is needed around USB host domain handling.  There are a
> couple errata impacting different chip revs.
> 
> Today in the older TI reference code this condition of a stuck on
> power domain does not happen.  However, we are using a software
> supervised method to disable the power domain.  May be this code has a
> bug or the hardware does around auto use for this domain.

Yes, usb-host autoidle was enabled when I was digging this issue.

> 
> You will want TLL or host SAR activated to minimally work around a
> possible false cold reset issue.  There is a window coming back from
> OFF where a reset will be thrown.  Enabling SAR conclusively moves the
> internal window so there is no danger.  The error is fairly easily
> seen so if you start taking resets know this is likely the root cause.
> 
> What Rev of CPU is the issue occurring on?

I think the usb-host problem was on ES3.1 at least.

> 
> The USBTLL SAR in 3.0 and before silicon will case a deadlock on 2nd
> sleep attempt.  On 3.1 and after its fixed.

So ES3.0 devices are exposed to the cold reset issue (since USBTLL SAR
is only enabled in ES3.1). Would you suspect that we can enable USB host
SAR, if the AUTOIDLE is turned off? Then we would not need this patch.

- Kalle

> 
> Regards,
> Richard W.

