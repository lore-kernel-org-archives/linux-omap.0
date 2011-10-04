From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH v2 0/6] TI81XX: Add clock and hwmod data
Date: Tue, 4 Oct 2011 03:24:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110040318260.4611@utopia.booyaka.com>
References: <1314119594-22647-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51425 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab1JDJYN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 05:24:13 -0400
In-Reply-To: <1314119594-22647-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

Hi,

On Tue, 23 Aug 2011, Hemant Pedanekar wrote:

> This patch set is the v2 of TI816X clock and hwmods patches sent earlier.
> 
> The clock data is currently added only for TI816X, while minimal hwmod data
> common for TI816X and TI814X is added.
> 
> This patch set depends on following patches:
> 	TI81XX: Prepare for addition of TI814X support
> 	TI814X: Add cpu type macros and detection support
> 	TI814X: Create board support and enable build for TI8148 EVM
> 
> Please note that CHIP_IS_TI816X/CHIP_IS_TI814X are still being used and I will
> send update once SoC list usage is available.	

I've been spending some time with these patches.  A few aspects don't make 
much sense to me.  For example, looking at the TRMs, the 816x doesn't seem 
to have powerdomains for HDVICP0, 1, or 2, although they are listed in the 
patch.  Also, the clockdomain layout is quite different between 814x and 
816x, according to the TRMs.  Are the patches more accurate than the TRMs, 
or vice versa?

Will send over the current reworked patches for TI81XX PRCM accessors, 
powerdomain code & data, and clockdomain code & data.  They are intended 
to apply over the TI814x patches that you sent recently.  I'd like to get 
your opinion(s) on these reworked patches.  Please note, so far they have 
only been compile-tested.


- Paul
