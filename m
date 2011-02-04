From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: Add empty inituart macros
Date: Thu, 3 Feb 2011 19:07:08 -0800
Message-ID: <20110204030708.GR3322@atomide.com>
References: <20110204012008.26298.16341.stgit@baageli.muru.com>
 <20110204012209.26298.75402.stgit@baageli.muru.com>
 <alpine.LFD.2.00.1102032116091.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33716 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab1BDDHZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 22:07:25 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102032116091.12104@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nicolas Pitre <nico@fluxnic.net> [110203 18:19]:
> On Thu, 3 Feb 2011, Tony Lindgren wrote:
> 
> > Add empty inituart macros. These can be used to initialize
> > the debug serial port based on the machine ID.
...
 
> A better way would be to define the empty inituart macro in a common 
> place, and use the following in the machine specific header file:
> 
> 	.purgem inituart
> 	.macro inituart ...
> 	...
> 	.endm
> 
> This way you won't need to add empty inituart all over the place.

Thanks for the tip, will try that out.

Tony
