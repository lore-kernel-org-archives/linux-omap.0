From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] MMC: OMAP: Flush posted write to IRQ
Date: Mon, 6 Apr 2009 04:01:36 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904060400330.22223@utopia.booyaka.com>
References: <49D9D258.80008@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52691 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbZDFKBi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 06:01:38 -0400
In-Reply-To: <49D9D258.80008@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org


Hello Roger,

these patches may be useful: 

http://www.pwsan.com/omap/spurious-irq-fix.tar.gz

I'd be curious to know if they resolve any other spurious IRQs that you 
might be seeing.


- Paul
