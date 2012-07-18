From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv6 2/7] ARM: OMAP4460: Workaround for ROM bug because of
 CA9 r2pX GIC control register change.
Date: Wed, 18 Jul 2012 03:54:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207180354200.16772@utopia.booyaka.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>  <1339428387-4800-3-git-send-email-t-kristo@ti.com>  <alpine.DEB.2.00.1207180314250.28834@utopia.booyaka.com> <1342605105.4672.95.camel@sokoban>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60241 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab2GRJyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 05:54:50 -0400
In-Reply-To: <1342605105.4672.95.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wed, 18 Jul 2012, Tero Kristo wrote:

> There isn't public erratum number for this, thats the reason for xxx. I
> can change the xxx to GICD though if that is better.

Yep please do (or something else more meaningful than GICD if you can 
think of something better).


- Paul
