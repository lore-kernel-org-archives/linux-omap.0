From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 8/8] OMAP3: powerdomain data: add wake-up latency
 figures
Date: Thu, 6 Oct 2011 22:17:15 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110062215270.4611@utopia.booyaka.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com> <1316622258-3892-1-git-send-email-j-pihet@ti.com> <1316622258-3892-9-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44140 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab1JGERQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 00:17:16 -0400
In-Reply-To: <1316622258-3892-9-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi Jean

On Wed, 21 Sep 2011, jean.pihet@newoldbits.com wrote:

> From: Jean Pihet <j-pihet@ti.com>
> 
> Figures are added to the power domains structs for RET and OFF modes.
> 
> Note: the latency figures for MPU, PER, CORE, NEON have been obtained
> from actual measurements.
> The latency figures for the other power domains are preliminary and
> shall be added.
> 
> Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
> for a detailed explanation on where are the numbers magically coming from.
> 
> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
> on MPU, CORE and PER.

Do the CSWR measurements include the time for the PMIC to scale the 
voltage, or do they just represent the time to enter and exit clock stop 
(presumably with DPLL idling)? 


- Paul
