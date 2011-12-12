From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 01/15] OMAP3+: PM: VP: use uV for max and min voltage
 limits
Date: Mon, 12 Dec 2011 11:39:41 +0200
Message-ID: <1323682781.31914.8.camel@sokoban>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	 <1322236188-19456-2-git-send-email-t-kristo@ti.com> <87wra5fwk4.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48943 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265Ab1LLJjo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 04:39:44 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBC9dixg032658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:39:44 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC9diCI015866
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:39:44 -0600 (CST)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC9diTl012687
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:39:44 -0600 (CST)
In-Reply-To: <87wra5fwk4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Vishwanath BS <vishwanath.bs@ti.com>

On Fri, 2011-12-09 at 10:07 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > From: Nishanth Menon <nm@ti.com>
> >
> > Every PMIC has it's own eccentricities, For example, one of the
> > PMIC has MSB set to 1 for a specific function - voltage enable!
> > using an hardcoded value specific for TWL when copied over to
> > such an implementation causes the system to crash as the MSB bit
> > was 0 and the voltage got disabled!.
> >
> > Instead we use actual values and depend on the convertion routines
> > to abstract out the eccentricities of each PMIC.
> >
> > With this, we can now move the voltages to a common location in
> > voltage.h as they are no longer dependent on PMICs and expect the
> > PMIC's conversion routines to set a cap if the voltage is out of
> > reach for the PMIC.
> 
> Nice.
> 
> > Reported-by: Jon Hunter <jon-hunter@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> 
> Also needs your sign-off, since you're on the delivery path now.

Oh sorry about that, I'll add it.

-Tero


