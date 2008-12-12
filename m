From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP3: DVFS core patch set
Date: Thu, 11 Dec 2008 18:59:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812111831360.26754@utopia.booyaka.com>
References: <> <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38343 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757817AbYLLB7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 20:59:19 -0500
In-Reply-To: <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>, peter.de-schrijver@nokia.com


Hello,

For anyone interested, here are some worst case measurements for CORE DVFS 
transition times with patches 1-16.

The test board was a 3430SDP ES2.0 GP.  Tests were run both with and 
without changing the VDD2 voltage; and at two different MPU frequencies.

No voltage change:
MPU @ 381MHz: 13 ticks (0.40 ms) worst-case
MPU @  83MHz: 38 ticks (1.19 ms) worst-case

With voltage change:
MPU @ 381MHz: 34 ticks (1.04 ms) worst-case
MPU @  83MHz: 130 ticks (3.97 ms) worst-case

Some important notes:

* Mean CORE DVFS times will be quite a bit lower, based on eyeballing the 
individual test run durations.  Variability was quite high; the above 
numbers would probably be considered outliers.

* The TI "September 11" u-boot on this board programs the CORE DPLL for a 
slightly derated frequency.  This causes the SDRC DLL to unlock on 
transitions to a lower frequency, and causes it to relock on transitions 
to a higher frequency.  Since a fixed bootloader would use 83000000 Hz and 
166000000 Hz, the DLL would lock at both frequencies, which may affect the 
above figures.

* Environmental parameters weren't tracked since the board is remote.

* Since the 32KiHz sync timer was used, there is a max roundoff 
variability of ((1/32768) * 2) seconds, or about 61 microseconds.

* The test script and additional test patches are available upon request 
by E-mailing me.

* I did not test at the highest MPU rate, for no real reason aside from 
381MHz is what the bootloader set the MPU to

* The tests were relatively short-duration; perhaps a few hundred 
transitions in each case.


Commentary:

* The variability caused by MPU rate was quite surprising.  I thought that 
the bulk of the time in this process would be MPU rate-invariant.


- Paul
