From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/9] OMAP2 SDRC: add timing data for Micron
 MT46H32M32LF-6
Date: Tue, 12 Aug 2008 15:42:27 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808121535180.10219@utopia.booyaka.com>
References: <20080708025225.11646.55912.stgit@localhost.localdomain>  <20080708025447.11646.48874.stgit@localhost.localdomain> <5e088bd90808121007w3f1587dehf6b827658a9e3d6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56093 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbYHLVm2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 17:42:28 -0400
In-Reply-To: <5e088bd90808121007w3f1587dehf6b827658a9e3d6b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

Hello Steve,

On Tue, 12 Aug 2008, Steve Sakoman wrote:

> Many early EVMs used Samsung memory (mine for example).  Are these
> timings compatible or is a separate Samsung header required?

Probably they will need fixing.  Presumably we'll have to use least common 
denominator values between the two, unless there is some way to 
discriminate in software between the chips.

BTW, if anyone would like to calculate their own timings/rates, I have a 
small utility here for doing so.  The plan is to clean it up and post it 
for inclusion eventually, but I would be happy to send it to anyone who 
would like a copy in the interim, in the event that they are using some 
other type of RAM or different DPLL3 timings on their OMAP3 board.


- Paul
