From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: RE: [RFC] OMAP: I2C: Use correct bit for CLOCKACTIVITY
Date: Wed, 11 Mar 2009 07:51:05 +0200
Message-ID: <1236750665.29572.201.camel@eenurkka-desktop>
References: <12362344552581-git-send-email-ext-eero.nurkkala@nokia.com>
	 <alpine.DEB.2.00.0903050113021.26353@utopia.booyaka.com>
	 <1236242774.29572.45.camel@eenurkka-desktop>
	 <1236243270.29572.49.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE8967162037B76377A@dlee02.ent.ti.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24699 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbZCKFyo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 01:54:44 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037B76377A@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: ext Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2009-03-11 at 04:55 +0100, ext Woodruff, Richard wrote:
> I think Nishant already said this but TRM is going to be updated to correct McBSP.
> 
> CBSPLP_SYSCONFIG_REG[9:8] CLOCKACTIVITY field description will be updated in next TRM version: OMAP34XX v-R
> 
> 0x0: McBSPi_ICLK clock can be switched-off
> PRCM Functional clock can be switched-off
> 
> 0x1: McBSPi_ICLK clock must be maintained during wake up period
> PRCM Functional clock can be switched-off
> 
> 0x2: McBSPi_ICLK clock can be switched-off
> PRCM Functional clock must be maintained during wake up period
> 
> 0x3: McBSPi_ICLK clock must be maintained during wake up period
> PRCM Functional clock must be maintained during wakeup period
> 
> Regards,
> Richard W.

I don't remember him saying exactly that. Wow, this looks like one
really really good explanation for one of our PM effors with McBSP
audio.. thank you!

- Eero

