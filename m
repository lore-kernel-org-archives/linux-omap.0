From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH 13/20] omapfb: dispc: Various typo
 fixes
Date: Sun, 14 Jun 2009 23:38:50 +0200
Message-ID: <20090614233850.94c12a70.krzysztof.h1@poczta.fm>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
	<e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com>
	<833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com>
	<5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com>
	<646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
	<b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com>
	<9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com>
	<08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com>
	<057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com>
	<310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com>
	<5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
	<d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:8677 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbZFNVbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Jun 2009 17:31:05 -0400
In-Reply-To: <d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>
Cc: Antonino Daplas <adaplas@gmail.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Thu,  4 Jun 2009 20:52:38 +0300
Imre Deak <imre.deak@nokia.com> wrote:

> - value and register offset was swapped in a dispc write
> - DISPC_CONTROL register was used instead of DISPC_SYSCONFIG
> - FIFO size bit field had incorrect length for OMAP3
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Fixed-by: arun <arunedarath@mistralsolutions.com>
> Fixed-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
> Fixed-by: Andrzej Zaborowski <balrog@zabor.org>
> Signed-off-by: Imre Deak <imre.deak@nokia.com>
> ---
>  drivers/video/omap/dispc.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


----------------------------------------------------------------------
Wejdz i kliknij na Swoj znak zodiaku!
http://link.interia.pl/f21b8

