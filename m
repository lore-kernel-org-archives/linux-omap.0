From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 03/10] ARM: DRA7: hwmod: set DSS submodule parent
 hwmods
Date: Fri, 3 Apr 2015 19:03:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1504031902470.19540@utopia.booyaka.com>
References: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com> <1427208910-17678-4-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57463 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbbDCTDG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2015 15:03:06 -0400
In-Reply-To: <1427208910-17678-4-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>

On Tue, 24 Mar 2015, Tomi Valkeinen wrote:

> Set DSS core hwmod as the parent for all the DSS submodules.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued.  Will send a pull request for this to Tony today, but it  
may not make it for v4.1.  

Note that I cannot boot test this since I do not have a DRA7xx board.


- Paul
