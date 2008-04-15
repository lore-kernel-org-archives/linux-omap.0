From: Paul Walmsley <paul@booyaka.com>
Subject: Re: Missing mmc debounce clock (??)
Date: Tue, 15 Apr 2008 10:17:28 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0804151013130.21271@utopia.booyaka.com>
References: <20080325114302.GA4652@gandalf.research.nokia.com> <4804B2D5.8000708@indt.org.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53061 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765544AbYDOQR3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 12:17:29 -0400
In-Reply-To: <4804B2D5.8000708@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <francisco.alecrim@indt.org.br>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Tue, 15 Apr 2008, Francisco Alecrim wrote:

> Hi Balbi,
> 
>    I was with the patch below in my queue when you told about your email at
> linux-omap.
> 
> I guess that is the correct solution.
> 
> What do you think?

Eh, those clocks are identical to the existing MMC clocks.  

Seems better for the time being  to modify omap_hsmmc.c:777 to test 
against !cpu_is_omap34xx() before emitting a warning?


- Paul
