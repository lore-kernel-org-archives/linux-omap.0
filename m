From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH -pm 1/2] SDRC: check for stuck DLL state machine and kick
Date: Fri, 19 Jun 2009 20:42:56 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038E317258@dlee02.ent.ti.com>
References: <1245105775-28844-1-git-send-email-khilman@deeprootsystems.com>
 <1245105775-28844-2-git-send-email-khilman@deeprootsystems.com>
 <alpine.DEB.2.00.0906170139170.3382@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE8967162038E2AC611@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0906181505460.4087@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39582 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbZFTBnF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jun 2009 21:43:05 -0400
In-Reply-To: <alpine.DEB.2.00.0906181505460.4087@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mike Chan <mikechan@google.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, June 18, 2009 4:07 PM

Hi Paul,

> On Wed, 17 Jun 2009, Woodruff, Richard wrote:
>
> > I've only seen the condition along side of very aggressive SDRC_POWER
> > settings.
>
> Could you send over the SDRC_POWER settings that cause this problem?

This is one pulled for a custom board:

# ./readmem 0x6d000070
0x000200AD

Regards,
Richard W.

