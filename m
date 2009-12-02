From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] OMAP3: SDRC: Comment out SDRC AC timing and MR changes
	in CORE DVFS SRAM code
Date: Wed, 2 Dec 2009 09:56:14 -0600
Message-ID: <20091202155614.GA3699@lixom.net>
References: <1254835224-19500-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.0910201918230.22645@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162039B3CF012@dlee02.ent.ti.com> <74583B8642AB8841B30447520659FCA9DDD9D7E9@dnce01.ent.ti.com> <13B9B4C6EF24D648824FF11BE8967162039B459718@dlee02.ent.ti.com> <1F18D6510CF0474A8C9500565A7E41A2236DA1C1F3@NOK-EUMSG-02.mgdnok.nokia.com> <alpine.DEB.2.00.0912011832290.13408@utopia.booyaka.com> <4B160552.6050108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:41363 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913AbZLBPyI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Dec 2009 10:54:08 -0500
Content-Disposition: inline
In-Reply-To: <4B160552.6050108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Tero.Kristo@nokia.com, r-woodruff2@ti.com, b-cousson@ti.com, rnayak@ti.com, c-sucur@ti.com

On Wed, Dec 02, 2009 at 08:12:34AM +0200, Menon, Nishanth wrote:

> why not make this a #ifdef instead if we need it some other time, a #if
> 0 and it's intention might not be readable without doing a git annotate
> in a few months time..

Just remove the code. The old implementation is still there in git and
can be brought back if need be. It's the purpose of having revision
control in the first place.


-Olof

