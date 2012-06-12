From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 10/14] ARM: OMAP2+: gpmc: waitpin helper
Date: Tue, 12 Jun 2012 09:00:11 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E997F7C@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <bba49a35f81f33fbdfeda78a71cbe4aa3417d6a2.1339419492.git.afzal@ti.com>
 <4FD6783D.9030208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48425 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371Ab2FLJAT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 05:00:19 -0400
In-Reply-To: <4FD6783D.9030208@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, Jun 12, 2012 at 04:29:09, Hunter, Jon wrote:

> > +enum {
> > +	GPMC_WAITPIN_IDX0,
> > +	GPMC_WAITPIN_IDX1,
> > +	GPMC_WAITPIN_IDX2,
> > +	GPMC_WAITPIN_IDX3,
> > +	GPMC_NR_WAITPIN
> > +};
> 
> Max number of wait pins is 3 for omap4/5. I know that we discussed this
> in the past, but are you not supporting these devices are the moment? I
> know that you have not done the hwmod for these, but still I was hoping
> that you would take these into account.

I don't see reason for omap4/5 not to work with this

> 
> > +
> > +enum {
> > +	LOW,
> > +	HIGH
> > +};
> 
> To be honest, I don't see the point in either of the above enums when
> you have the definitions at the bottom. Seems that one set of
> definitions should be enough.

Thanks for catching that, it will be removed

> > +	case GPMC_WAITPIN_0:
> > +		idx =  GPMC_WAITPIN_IDX0;
> 
> For example, here you could have ...
> 
> 		idx = GPMC_WAITPIN_0 - 1;

Sorry, not sure whether I follow you, can you please clarify

Regards
Afzal
