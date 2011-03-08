From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP1: McBSP: fix build break for non-multi-OMAP1
 configs
Date: Mon, 7 Mar 2011 19:34:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103071933350.10981@utopia.booyaka.com>
References: <alpine.DEB.2.00.1103041535150.10981@utopia.booyaka.com> <20110307163047.a65c51d2.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57088 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab1CHCeK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 21:34:10 -0500
In-Reply-To: <20110307163047.a65c51d2.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Kishon Vijay Abraham I <kishon@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, 7 Mar 2011, Jarkko Nikula wrote:

> omapxxx_mcbsp_res_0 doesn't look the best here in readability point of
> view but provides the smallest fix as no need to rename array and
> modify the _RES_SZ and _COUNT macros. So this fix is needed here and a
> small readability update can be done later.
> 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Thanks Jarkko.  For what it's worth, I agree it's an ugly patch.


- Paul
