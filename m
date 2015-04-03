From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 02/10] ARM: DRA7: hwmod: add DMM hwmod description
Date: Fri, 3 Apr 2015 19:02:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1504031901440.19540@utopia.booyaka.com>
References: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com> <1427208910-17678-3-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57446 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbbDCTCk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2015 15:02:40 -0400
In-Reply-To: <1427208910-17678-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>

On Tue, 24 Mar 2015, Tomi Valkeinen wrote:

> Add DMM hwmod entries for DRA7. This is identical to DMM on OMAP5.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued.  Will send a pull request for this to Tony today, but it 
may not make it for v4.1.

Note that I cannot boot-test this since I do not have a DRA7 board.


- Paul
