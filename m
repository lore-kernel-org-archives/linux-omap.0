From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] PM: Disable usb host HW save and restore
Date: Thu, 14 May 2009 12:40:15 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038BE09C66@dlee02.ent.ti.com>
References: <1240484331-18722-1-git-send-email-kalle.jokiniemi@digia.com>
 <87zldftxtu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60268 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbZENRkc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:40:32 -0400
In-Reply-To: <87zldftxtu.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>


> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, May 14, 2009 12:10 PM
> To: Kalle Jokiniemi

> Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:
>
> > The hardware SAVEANDRESTORE mechanism seems to leave
> > USB HOST power domain permanently into active state
> > after one transition from off to active state.
> > Disabling for now.

Some are is needed around USB host domain handling.  There are a couple errata impacting different chip revs.

Today in the older TI reference code this condition of a stuck on power domain does not happen.  However, we are using a software supervised method to disable the power domain.  May be this code has a bug or the hardware does around auto use for this domain.

You will want TLL or host SAR activated to minimally work around a possible false cold reset issue.  There is a window coming back from OFF where a reset will be thrown.  Enabling SAR conclusively moves the internal window so there is no danger.  The error is fairly easily seen so if you start taking resets know this is likely the root cause.

What Rev of CPU is the issue occurring on?

The USBTLL SAR in 3.0 and before silicon will case a deadlock on 2nd sleep attempt.  On 3.1 and after its fixed.

Regards,
Richard W.
