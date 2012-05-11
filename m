From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: AM35xx: fix UART4 softreset
Date: Fri, 11 May 2012 03:35:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205110333240.3201@utopia.booyaka.com>
References: <20120510172449.13418.66815.stgit@dusk> <20120510172918.13418.64781.stgit@dusk> <4FACD255.3080702@ti.com> <alpine.DEB.2.00.1205110316500.3201@utopia.booyaka.com> <4FACDC63.7060605@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34900 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758020Ab2EKJfT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 05:35:19 -0400
In-Reply-To: <4FACDC63.7060605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kyle Manna <kyle.manna@fuel7.com>, Ranjith Lohithakshan <ranjithl@ti.com>, "Mark A. Greer" <mgreer@animalcreek.com>

On Fri, 11 May 2012, Cousson, Benoit wrote:

> On 5/11/2012 11:22 AM, Paul Walmsley wrote:
> 
> > On the rest of the OMAPs, as far as I know, the UART clocks are all
> > separate.
> 
> In fact, not really. The same PER_48M_GFCLK clock is used for every UART
> instances in OMAP4. We do have a separate modulemode for each UART but as far
> as clocks are concerned, the source clock is the same.

By "separate" I mean that they are all independently gated. This does not 
appear to be the case with AM3517.  Or perhaps it is the case and 
something isn't right with the idle management FSMs.


- Paul
