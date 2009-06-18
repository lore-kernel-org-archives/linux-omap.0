From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH -pm 1/2] SDRC: check for stuck DLL state machine and
 kick
Date: Thu, 18 Jun 2009 15:06:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906181505460.4087@utopia.booyaka.com>
References: <1245105775-28844-1-git-send-email-khilman@deeprootsystems.com> <1245105775-28844-2-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.0906170139170.3382@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE8967162038E2AC611@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44788 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbZFRVGr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 17:06:47 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038E2AC611@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Mike Chan <mikechan@google.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Richard,

On Wed, 17 Jun 2009, Woodruff, Richard wrote:

> I've only seen the condition along side of very aggressive SDRC_POWER 
> settings. 

Could you send over the SDRC_POWER settings that cause this problem?


thanks,

- Paul
