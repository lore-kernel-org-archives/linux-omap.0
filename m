From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS pwrdm usecount, disabling autodeps for DSS
Date: Fri, 9 Mar 2012 10:57:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203091055150.7039@utopia.booyaka.com>
References: <87r4x27gh0.fsf@ti.com> <1331291641.1927.38.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45871 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab2CIR5F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 12:57:05 -0500
In-Reply-To: <1331291641.1927.38.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, 9 Mar 2012, Tomi Valkeinen wrote:

> I didn't get very far with the patch =(. Tested on omap3 overo, with
> -rc6 based dss tree.

Thanks for testing and the .config.  Probably the best thing to do in the 
medium term is to fix the hwmod iclk handling; I think that will also fix 
the DSS autodeps problem.

BTW, regarding your other recent E-mails and your patches, I regret that I 
haven't had the chance to get back to you on them, but I do plan to.  Too 
much going on at the moment...


- Paul
