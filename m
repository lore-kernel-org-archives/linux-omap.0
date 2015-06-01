From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv4 05/10] ARM: DRA7: hwmod: set DSS submodule parent
 hwmods
Date: Mon, 1 Jun 2015 22:26:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1506012224120.14902@utopia.booyaka.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com> <1433139798-23450-6-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58377 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbbFAW0T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 18:26:19 -0400
In-Reply-To: <1433139798-23450-6-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>

On Mon, 1 Jun 2015, Tomi Valkeinen wrote:

> Set DSS core hwmod as the parent for all the DSS submodules.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

By the way, for commits like this one, it would be nice to add a line 
describing why the change is needed to the commit message.  Something like 
"This ensures that the parent hwmods are enabled before any DSS 
submodules are accessed."  Tony, feel free to add that to the commit 
message if you think it's useful.


- Paul
