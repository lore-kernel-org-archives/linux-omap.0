From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP3: DVFS core patch set
Date: Thu, 18 Dec 2008 01:22:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812180115130.24916@utopia.booyaka.com>
References: <> <1229010762-3150-1-git-send-email-tero.kristo@nokia.com> <alpine.DEB.2.00.0812111831360.26754@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54549 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbYLRIW3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 03:22:29 -0500
In-Reply-To: <alpine.DEB.2.00.0812111831360.26754@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>, peter.de-schrijver@nokia.com


a quick followup on this:

On Thu, 11 Dec 2008, Paul Walmsley wrote:

> With voltage change:
> MPU @  83MHz: 130 ticks (3.97 ms) worst-case

It recently occurred to me that part of this 130 tick time is due to the 
udelay()s in the SmartReflex code.  My test code did not update 
loops_per_jiffy when it did the MPU rate, so the udelay()s there would 
loop for longer than they should.  So that needs to be fixed and 
re-measured.

Presumably further improvements would be gained by converting 
sr_voltagescale_vcbypass() to be interrupt-driven, rather than polling for 
the voltage change to complete.  That should reduce the CORE DVFS 
time further.


- Paul
