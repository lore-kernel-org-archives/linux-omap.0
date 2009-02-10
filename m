From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: MMC: recover from transfer failures - Resend
Date: Mon, 9 Feb 2009 17:09:48 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0902091707330.12013@utopia.booyaka.com>
References: <20081207213617.10456.43951.stgit@localhost> <20090205121045.4022c319.akpm@linux-foundation.org> <alpine.DEB.2.00.0902051323090.8131@utopia.booyaka.com> <200902061422.32689.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44134 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbZBJAJu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 19:09:50 -0500
In-Reply-To: <200902061422.32689.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, tony@atomide.com, ext-adrian.hunter@nokia.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, drzeus-mmc@drzeus.cx, linux-kernel@vger.kernel.org

On Fri, 6 Feb 2009, Jean Pihet wrote:

> Do you want a finite loop with udelay in it? I located 4 places were this 
> could be used. If so I can generate a new patch for that.

Just as an aside, from the standpoint of minimizing CPU usage, there seems 
little point in using udelay() here, since it is implemented as a CPU 
busy-wait.


- Paul
