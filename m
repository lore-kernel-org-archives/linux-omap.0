From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 5/5] OMAP3: PM: Disable OTG autoidle when waking up from
 off-mode
Date: Thu, 12 Nov 2009 21:10:56 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8537@dbde02.ent.ti.com>
References: <1258020444-3809-1-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-2-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-3-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-4-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-5-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-6-git-send-email-tero.kristo@nokia.com>
 <87zl6ru53p.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46387 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbZKLPk7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 10:40:59 -0500
In-Reply-To: <87zl6ru53p.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Tero Kristo <tero.kristo@nokia.com> writes:
> 
> > From: Tero Kristo <tero.kristo@nokia.com>
> >
> > OMAP3 sleep can be prevented in some cases where OTG autoidle is enabled.
> > This patch force disables autoidle during wakeup from off-mode. See omap
> > errata 1.164.
> >
> > This fix can't be done in driver level, as off-mode entry resets and enables
> > the autoidle bit, and driver does not access the register after each off-mode
> > entry even if it is loaded.
> >
> > Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> 
> Thanks Tero for the updated changelog.
> 
> Applying to PM branch reluctantly and with grumbles.  I sure hope
> someone in TI is reporting all these ROM code issues to the ROM code
> team so they get appropriate fixes.
> 
> Kevin

Yes, rest assured we're following these up with the HW teams.

This particular one should not matter on 3630, we can keep autoidle
enabled all the time, I think.

- Anand
