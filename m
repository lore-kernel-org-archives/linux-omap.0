From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 21/30] sound/soc/omap: limit to omap2plus
Date: Sun, 2 Oct 2011 20:18:48 +0100
Message-ID: <20111002191847.GA1005@sirena.org.uk>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-22-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:60794 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab1JBTSu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Oct 2011 15:18:50 -0400
Content-Disposition: inline
In-Reply-To: <1317566760-25681-22-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>

On Sun, Oct 02, 2011 at 04:45:51PM +0200, Arnd Bergmann wrote:
> These drivers do not build correctly on omap1, so only allow
> selecting them on omap2 or higher.

No, OMAP1 is supposed to work and people actively seem to care about it.
If there's some problem with OMAP1 then please report it so that it can
be fixed.

You should also *always* both CC maintainers and relevant mailing lists
on patches so they can see what's going on (I'm being especially grumpy
now because you really should know better), and my previous comments
about subject lines also apply.
