From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv3 00/10] ARM: DRA7: add display support
Date: Mon, 1 Jun 2015 05:46:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1506010538330.14902@utopia.booyaka.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47964 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758766AbbFAFqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 01:46:45 -0400
In-Reply-To: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>

Hi Tomi

On Wed, 6 May 2015, Tomi Valkeinen wrote:

> This series adds the arch/arm/ side of the display support for DRA7 (DRA72x,
> DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 EVM boards
> is added.
> 
> This series is v3, and is based on v4.1-rc2. There are no differences to v2,
> except rebased and tested.

Are you still planning to move the DESHDCP clock enable to the beginning 
of the series to avoid the warnings, per:

http://www.spinics.net/lists/arm-kernel/msg410968.html

?

Also, not sure if you can arrange for someone at TI to send over a DRA7xx 
board for the testbed, but it would be nice to have a board to test these 
patches with, to avoid issues like the one mentioned in your E-mails...


- Paul
