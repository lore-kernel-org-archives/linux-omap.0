From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Wed, 9 Mar 2011 14:44:02 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103091440101.15132@utopia.booyaka.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com> <4D775418.6050105@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49630 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab1CIVoD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 16:44:03 -0500
In-Reply-To: <4D775418.6050105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, tero.kristo@nokia.com, linux-arm-kernel@lists.infradead.org

(cc'ing Tero also)

Hi Rajendra

On Wed, 9 Mar 2011, Rajendra Nayak wrote:

> On Wednesday 09 March 2011 09:20 AM, Paul Walmsley wrote:
> > On Fri, 4 Mar 2011, Rajendra Nayak wrote:
> 
> PRCM waking up the module's clockdomains when in hardware-supervised
> and INACTIVE, atleast does not seem to be true for OMAP4 and does seem
> to be documented atleast in the func specs (need to see if its
> in TRM, else I will raise a request to include it) Chapter 11 to 23,
> Section Chapter#.5.2.1: Enabling one <clockdomain name> module after
> power-on-reset.
> This seems to suggest that the clockdomains have to be force woken-up
> using SW_WKUP, and can then be programmed in HW_AUTO once the module
> is accessible.
> From what I know this was true on OMAP3 as well and maybe on OMAP2,
> and thinking of why we might not have seen any issues with them, I
> realized, because of the autodeps of all clockdomains with MPU, they
> would never be in INACTIVE while a module is being enabled, even if
> the clockdomain was in HW_AUTO.

OK, maybe this is why the autodeps were needed, because otherwise we would 
need to wake the clockdomain up before enabling the clocks.  Something to 
experiment with for 2.6.40.

> hmm.. I am not sure if this is a TRM bug, but FWIK, no clockdomains
> should go to INACTIVE without taking into account the target idle
> state. All targets should be sent a idlereq and only on a idleack from
> all of them, should the clockdomain transition to INACTIVE. If the
> clockdomain hits INACTIVE just based on its initiators asserting
> standby, it does not seem right.

Ok, probably just a TRM bug then.  Guess we'll find out when we start 
removing the autodeps...

> Btw, the patch does not change the behaviour/sequence followed on OMAP3,
> it just affects OMAP4.

Until the autodeps get removed :-)

> Since no clockdomains on OMAP4 were programmed in HW_AUTO untill now,
> we did not have any issues, but with the recent series from Santosh
> (which adds mpu ret/off support in idle/suspend) programming the
> clockdomains to HW_AUTO did show issues/aborts, and this patch
> fixes them.

Okay, I'll queue this for 2.6.39.

Thanks for thinking through the module enable sequence with me,


- Paul
