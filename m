From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC] OMAP: I2C: Use correct bit for CLOCKACTIVITY
Date: Tue, 10 Mar 2009 22:55:10 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037B76377A@dlee02.ent.ti.com>
References: <12362344552581-git-send-email-ext-eero.nurkkala@nokia.com>
	 <alpine.DEB.2.00.0903050113021.26353@utopia.booyaka.com>
	 <1236242774.29572.45.camel@eenurkka-desktop>
 <1236243270.29572.49.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47160 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872AbZCKDzX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 23:55:23 -0400
In-Reply-To: <1236243270.29572.49.camel@eenurkka-desktop>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>, ext Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > How about McBSP? Same TRM.. I2C, Table 18-5 tells exactly the opposite
> > for I2C than what's said in Table 18-44: I2C_SYSC!!
> >
> > Please, Richard?
> >
> > - Eero
>
> To answer to myself, I am 100% certain the McBSP FCLK is the
> bit 8. I should have sent a patch about that already..
>
> Kind of worried as could they really change that much?
> >From page to page and block to block and within a block...=)

I think Nishant already said this but TRM is going to be updated to correct McBSP.

CBSPLP_SYSCONFIG_REG[9:8] CLOCKACTIVITY field description will be updated in next TRM version: OMAP34XX v-R

0x0: McBSPi_ICLK clock can be switched-off
PRCM Functional clock can be switched-off

0x1: McBSPi_ICLK clock must be maintained during wake up period
PRCM Functional clock can be switched-off

0x2: McBSPi_ICLK clock can be switched-off
PRCM Functional clock must be maintained during wake up period

0x3: McBSPi_ICLK clock must be maintained during wake up period
PRCM Functional clock must be maintained during wakeup period

Regards,
Richard W.
