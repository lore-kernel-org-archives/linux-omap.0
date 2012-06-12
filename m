From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 06/14] ARM: OMAP2+: gpmc: CS configuration helper
Date: Tue, 12 Jun 2012 12:58:10 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998201@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <9dd458171d6a68ea4f97a4ba19dbacc0d6b5ba35.1339419492.git.afzal@ti.com>
 <4FD66666.8060002@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997F1F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57286 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117Ab2FLM6V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 08:58:21 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E997F1F@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, Jun 12, 2012 at 14:10:08, Mohammed, Afzal wrote:

> > > +	l |= conf & GPMC_CONFIG1_DEVICETYPE_NAND;
> > > +	l |= conf & GPMC_CONFIG1_DEVICESIZE_16;
> > 
> > I can see that it works to use the above definitions as masks because of
> > the possible values that can be programmed into these fields. However,
> > from a read-ability standpoint this is unclear and requires people to
> > review the documentation to understand what you are doing here.
> > Furthermore, if any new device-types or sizes were added in the future
> > this could lead to bugs. Hence, it would be better to define a mask for
> > these fields.
> 
> I had thought about it initially, but then it was felt it will
> lead to a less simple code, that path was not taken, let me
> revisit this.

Thinking again over it, I am feeling above is sufficient, reason same as
said earlier, to keep code simple & currently this is sufficient to
handle GPMC bit patterns for IPs presently available. What you are
suggesting is to take care of the imaginary case when new GPMC IP happens
with new device type or size, I think that should be handled when such a
scenario happens. Probably, it is better here to add a comment to make
intention clear.

Regards
Afzal
