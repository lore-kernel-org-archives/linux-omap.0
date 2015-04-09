From: Tony Lindgren <tony@atomide.com>
Subject: Re: am335x crypto module clocks
Date: Thu, 9 Apr 2015 08:13:39 -0700
Message-ID: <20150409151338.GQ18048@atomide.com>
References: <CAALWOA8Zno6pTfWRZpacgWm83m4=1+uvTmyREG9Nc+C2MZjK1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:43267 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830AbbDIPRQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Apr 2015 11:17:16 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA8Zno6pTfWRZpacgWm83m4=1+uvTmyREG9Nc+C2MZjK1w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>, Tero Kristo <t-kristo@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150404 21:26]:
> Hi all,
> 
> To my surprise, the am335x clock tree (am33xx-clocks.dtsi) currently
> lists the functional clock of the AES accelerator and other crypto
> modules to be the (max 26 MHz) main osc. This struck me as rather
> unlikely, since the AES module is clocked much higher on other
> devices, and such a slow clock would condemn it to being slower than a
> software AES implementation.  As usual the TRM is silent on the crypto
> accelerators and their clock management, but I did some preliminary
> tests.
> 
> The AES module turned out far from slow.  I actually had a lot of
> trouble keeping the module continuously fed with data with a simple
> non-dma test from userspace, since for most modes of operation the AES
> module could even keep pace with a tight loop using 128-bit neon
> load/store without even checking its status register for readiness.
> 
> Although I haven't been able to get obtain a very reliable measurement
> yet as a result, it appears to be clocked at ~200 MHz. This also
> matches the fact that it is hooked up to the L3F (which would be
> rather pointless if it had a separate low-rate fck).
> 
> It seems very likely to me the other crypto modules will also have a
> unified fck/ick (L3F for the hash accelerator, L4LS for the RNG and
> PKA). This should preferably still be double-checked of course.

Tero, got any ideas about this one?

Regards,

Tony
