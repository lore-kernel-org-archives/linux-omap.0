From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv6 3/7] ARM: OMAP4: hwmod: flag hwmods/modules not
 supporting module level context status
Date: Thu, 19 Jul 2012 12:50:55 +0300
Message-ID: <1342691455.4672.125.camel@sokoban>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
	 <1339428387-4800-4-git-send-email-t-kristo@ti.com>
	 <CAOMWX4e9bpJivetsx-FD_U7BbjrWh0Xto-7MTUe5YK8Mjpi9Sg@mail.gmail.com>
	 <1342628606.4672.112.camel@sokoban>
	 <alpine.DEB.2.00.1207181122280.19048@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44340 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019Ab2GSJvF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 05:51:05 -0400
In-Reply-To: <alpine.DEB.2.00.1207181122280.19048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>

On Wed, 2012-07-18 at 11:24 -0600, Paul Walmsley wrote:
> On Wed, 18 Jul 2012, Tero Kristo wrote:
> 
> > On Tue, 2012-07-17 at 03:11 -0500, Menon, Nishanth wrote:
> >
> > > OMAP4430_RM_ABE_AESS_CONTEXT? why not use LOSTMEM_AESSMEM ? ABE will
> > > need to know when it lost context to be able to reload it's firmware,
> > > no?
> > 
> > It looks like current hwmod data doesn't support specific bits to be
> > used for the context declaration, it is only specifying the register
> > offset. Also, the same register is used by aess hwmod, so this will
> > cause a conflict if I take the same register into use.
> > 
> > This could be fixed by adding a field for the context bits, but I guess
> > this should be commented upon by someone (Benoit / Paul) before I craft
> > some sort of patch for that.
> 
> If you need to add a u8 there to specify the bitshift, go ahead and do it.  
> u8 lostmem_bit, perhaps?

Mask might be better, as we have RFF / DFF bits, and also if mask is not
defined, we can assume we want to check the whole register (current
behavior.) I'll add this for next rev.

-Tero


