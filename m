From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: origin tree build failure
Date: Tue, 15 Dec 2009 09:07:19 +0100
Message-ID: <20091215080719.GA23630@elte.hu>
References: <20091215164108.45c9d766.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:41693 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbZLOIHp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 03:07:45 -0500
Content-Disposition: inline
In-Reply-To: <20091215164108.45c9d766.sfr@canb.auug.org.au>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Linus <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next build (powerpc allyesconfig) failed like this:
> 
> drivers/mfd/twl4030-codec.c:29:31: error: linux/i2c/twl4030.h: No such file or directory

FYI, x86 allyesconfig fails to build too so this doesnt only affect PowerPC.

	Ingo
