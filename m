From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH 18/20] omapfb: Fix coding style /
 remove dead line
Date: Sun, 14 Jun 2009 23:43:54 +0200
Message-ID: <20090614234354.cffde752.krzysztof.h1@poczta.fm>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
	<9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com>
	<08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com>
	<057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com>
	<310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com>
	<5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
	<d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
	<d83034cc97924164ca9949fee84bfb480ad5c806.1244131952.git.imre.deak@nokia.com>
	<36ddd74a50b8c225b2c571035c67dbff4686b881.1244131952.git.imre.deak@nokia.com>
	<024fee28b6c89decf0d50747127db8fc61ac789e.1244131952.git.imre.deak@nokia.com>
	<20541a2436ab1399a93c28197244bb05e8657859.1244131952.git.imre.deak@nokia.com>
	<63e0213f6444a9d3c99c659dbef14207e8756b37.1244131952.git.imre.deak@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:30676 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbZFNVgL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Jun 2009 17:36:11 -0400
In-Reply-To: <63e0213f6444a9d3c99c659dbef14207e8756b37.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>
Cc: Antonino Daplas <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, Tony Lindgren <tony@atomide.com>, arun c <arunedarath@mistralsolutions.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Thu,  4 Jun 2009 20:52:43 +0300
Imre Deak <imre.deak@nokia.com> wrote:

> From: arun c <arunedarath@mistralsolutions.com>
> 
> - use __iomem type attribute where appropriate
> - expand (a ? : b) to (a ? a : b)
> As suggested by Russell King <linux@arm.linux.org.uk>
> 
> - remove a dead line from omapfb_main.c
> 
> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> CC: linux-arm-kernel@lists.arm.linux.org.uk
> Signed-off-by: Imre Deak <imre.deak@nokia.com>
> ---
>  arch/arm/plat-omap/include/mach/omapfb.h |    4 ++--
>  drivers/video/omap/omapfb_main.c         |    5 ++---
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

----------------------------------------------------------------------
Kup wlasne mieszkanie za 33 tys. zl.
Sprawdz >>> http://link.interia.pl/f21eb

