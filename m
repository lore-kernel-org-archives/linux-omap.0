From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 8/8] OMAP3: powerdomain data: add wake-up latency
 figures
Date: Mon, 10 Oct 2011 16:44:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110101636470.5205@utopia.booyaka.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com> <1316622258-3892-1-git-send-email-j-pihet@ti.com> <1316622258-3892-9-git-send-email-j-pihet@ti.com> <alpine.DEB.2.00.1110062215270.4611@utopia.booyaka.com>
 <CAORVsuX2PUubPzO3mWTaO0Lg6Mdog8wjDY6hm93qheMwoz27CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39622 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab1JJWo4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Oct 2011 18:44:56 -0400
In-Reply-To: <CAORVsuX2PUubPzO3mWTaO0Lg6Mdog8wjDY6hm93qheMwoz27CA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Mon, 10 Oct 2011, Jean Pihet wrote:

> On Fri, Oct 7, 2011 at 6:17 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Wed, 21 Sep 2011, jean.pihet@newoldbits.com wrote:
> >
> >> From: Jean Pihet <j-pihet@ti.com>
> >>
> >> Figures are added to the power domains structs for RET and OFF modes.
> >>
> >> Note: the latency figures for MPU, PER, CORE, NEON have been obtained
> >> from actual measurements.
> >> The latency figures for the other power domains are preliminary and
> >> shall be added.
> >>
> >> Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
> >> for a detailed explanation on where are the numbers magically coming from.
> >>
> >> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
> >> on MPU, CORE and PER.
> >
> > Do the CSWR measurements include the time for the PMIC to scale the
> > voltage, or do they just represent the time to enter and exit clock stop
> > (presumably with DPLL idling)?
> 
> As described at [1] the measurements have not been performed with
> sys_offmode and sys_clkreq signals toggling correctly, because of the
> lack of support for it in the kernel.
> However the results are including a correction for the sys_offmode
> transition time (11.5ms), but no correction for the sys_clkreq signal
> (which should be 1ms for sysclk on, 2.5ms for sysclk off).
> 
> [1] http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement#cpuidle_results

OK.  sys_offmode only applies to OFF mode.  Voltage scaling can also occur 
during RETENTION and INACTIVE ("sleep").  So were these results with 
retention and voltage scaling disabled?


- Paul
