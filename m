From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP1: McBSP: fix build break for non-multi-OMAP1
 configs
Date: Tue, 8 Mar 2011 15:11:49 -0800
Message-ID: <20110308231149.GG26463@atomide.com>
References: <alpine.DEB.2.00.1103041535150.10981@utopia.booyaka.com>
 <20110307163047.a65c51d2.jhnikula@gmail.com>
 <alpine.DEB.2.00.1103071933350.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28215 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891Ab1CHXMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 18:12:06 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1103071933350.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110307 18:32]:
> On Mon, 7 Mar 2011, Jarkko Nikula wrote:
> 
> > omapxxx_mcbsp_res_0 doesn't look the best here in readability point of
> > view but provides the smallest fix as no need to rename array and
> > modify the _RES_SZ and _COUNT macros. So this fix is needed here and a
> > small readability update can be done later.
> > 
> > Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> Thanks Jarkko.  For what it's worth, I agree it's an ugly patch.

Applying.

Tony
