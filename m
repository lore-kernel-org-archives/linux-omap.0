From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v9 6/9] MFD: TWL4030: workaround changes for TWL4030
 Erratum 27
Date: Tue, 26 Apr 2011 12:13:07 +0200
Message-ID: <20110426101306.GJ2659@sortiz-mobl>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
 <1302784077-16697-7-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23831 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114Ab1DZKNK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 06:13:10 -0400
Content-Disposition: inline
In-Reply-To: <1302784077-16697-7-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>

Hi Lesly,

On Thu, Apr 14, 2011 at 05:57:54PM +0530, Lesly A M wrote:
> Workaround for TWL5030 Silicon Errata 27 & 28:
> 	27 - VDD1, VDD2, may have glitches when their output value is updated.
> 	28 - VDD1 and / or VDD2 DCDC clock may stop working when internal clock
> 		is switched from internal to external.
> 
> Erratum 27:
> 	If the DCDC regulators is running on their internal oscillator,
> 	negative glitches may occur on VDD1, VDD2 output when voltage is changed.
> 	The OMAP device may reboot if the VDD1 or VDD2 go below the
> 	core minimum operating voltage.
> 
> 	WORKAROUND
> 	Set up the TWL5030 DC-DC power supplies to use the HFCLKIN instead of
> 	the internal oscillator.
> 
> Erratum 28:
> 	VDD1/VDD2 clock system may hang during switching the clock source from
> 	internal oscillator to external. VDD1/VDD2 output voltages may collapse
> 	if clock stops.
> 
> 	WORKAROUND
> 	If HFCLK is disabled in OFFMODE, modify the sleep/wakeup sequence and
> 	setuptimes to make sure the switching will happen only when HFCLKIN is stable.
> 	Also use the TWL5030 watchdog to safeguard the first switching from
> 	internal oscillator to HFCLKIN during the TWL5030 init.
> 
> 	IMPACT
> 	power sequence is changed.
> 	sleep/wakeup time values will be changed.
> 
> The workaround changes are called from twl4030_power_init(), since we have to
> make some i2c_read calls to check the TWL4030 version & the i2c will not be
> initialized in the early stage.
> 
> This workaround is required for TWL5030 Silicon version less than ES1.2
> The power script & setup time changes are recommended by TI HW team.
> 
> http://omapedia.org/wiki/TWL4030_power_scripts
> 
> Changes taken from TWL4030 Erratum 27 workaround patch by Nishanth Menon.
This patch and the following one depend on patch#4. Please re-send it once you
agreed with Tony about where it should go.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
