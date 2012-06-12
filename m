From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 08/14] ARM: OMAP2+: gpmc: bool type timing helper
Date: Tue, 12 Jun 2012 08:41:50 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E997F32@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <36a87118922fb714e52d3d27235a35346aaf7b61.1339419492.git.afzal@ti.com>
 <4FD670E1.5070807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52004 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab2FLIl7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 04:41:59 -0400
In-Reply-To: <4FD670E1.5070807@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, Jun 12, 2012 at 03:57:45, Hunter, Jon wrote:

> > +	if (p->cycle2cyclesamecsen)
> > +		l |= GPMC_CONFIG6_CYCLE2CYCLESAMECSEN;
> > +	else
> > +		l &= ~GPMC_CONFIG6_CYCLE2CYCLESAMECSEN;
> > +	if (p->cycle2cyclediffcsen)
> > +		l |= GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN;
> > +	else
> > +		l &= ~GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN;
> > +	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG6, l);
> > +}
> 
> How about adding a sub-function like ...

Agree, that is better.

Regards
Afzal
