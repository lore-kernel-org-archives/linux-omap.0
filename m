From: Colin Cross <ccross@google.com>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Wed, 27 Apr 2011 13:48:52 -0700
Message-ID: <BANLkTinWD0ktYKzR_jnQSE76AuW+Z1PSLw@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
	<BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
	<BANLkTikEtTDp3Cpj0D5z34wA0_G_DWwKFg@mail.gmail.com>
	<alpine.LFD.2.02.1104272104390.3323@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:2995 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756789Ab1D0Usz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 16:48:55 -0400
Received: from kpbe13.cbf.corp.google.com (kpbe13.cbf.corp.google.com [172.25.105.77])
	by smtp-out.google.com with ESMTP id p3RKmrFl015184
	for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 13:48:53 -0700
Received: from gwb17 (gwb17.prod.google.com [10.200.2.17])
	by kpbe13.cbf.corp.google.com with ESMTP id p3RKlUrA011673
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 13:48:52 -0700
Received: by gwb17 with SMTP id 17so953997gwb.29
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 13:48:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1104272104390.3323@ionos>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Menon, Nishanth" <nm@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, linux-omap <linux-omap@vger.kernel.org>

On Wed, Apr 27, 2011 at 12:26 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Forget OMAP implementation details for a while, sit back and look at
> the big picture.

Here's my proposal for DVFS:
- DVFS is implemented in drivers/clk/dvfs.c, and is called by the
common clock implementation to adjust the voltages, if necessary, on
regular clk_* calls.
- Platform code provides mappings in the form (clk, regulator, max
frequency, min voltage) to the dvfs code.
- Everything that is in OPP today gets converted to helper functions
inside the dvfs implementation, and is never called from SoC code
(except to pass tables at init), or from drivers.
- OPP can be recreated in the future as a upper level policy manager
for clocks that need to move together, if that is ever necessary.  It
would not know anything about voltages.
- A few common policy implementations need to be added to the common
clock implementation, like temperature limits.

For Tegra:
- DVFS continues to be accessed by calling clk_* functions

For OMAP:
- DVFS is triggered by hwmod through clk_* functions.  Any cross-arch
driver can continue to call clk_* functions.

OPP currently has opp_enable and opp_disable functions.  I don't
understand why these are needed, they are only used at init time to
determine available voltages, which could be handled by never passing
unavailable voltages to the dvfs implementation.
