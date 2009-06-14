From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH 15/20] omapfb: dispc: Enable wake up
 capability
Date: Sun, 14 Jun 2009 23:40:25 +0200
Message-ID: <20090614234025.001f36af.krzysztof.h1@poczta.fm>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
	<5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com>
	<646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
	<b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com>
	<9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com>
	<08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com>
	<057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com>
	<310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com>
	<5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
	<d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
	<d83034cc97924164ca9949fee84bfb480ad5c806.1244131952.git.imre.deak@nokia.com>
	<36ddd74a50b8c225b2c571035c67dbff4686b881.1244131952.git.imre.deak@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:10861 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758549AbZFNVck (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Jun 2009 17:32:40 -0400
In-Reply-To: <36ddd74a50b8c225b2c571035c67dbff4686b881.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>
Cc: Antonino Daplas <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, Tony Lindgren <tony@atomide.com>, Jouni Hogander <jouni.hogander@nokia.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, linux-omap@vger.kernel.org

On Thu,  4 Jun 2009 20:52:40 +0300
Imre Deak <imre.deak@nokia.com> wrote:

> From: Jouni Hogander <jouni.hogander@nokia.com>
> 
> Without wakeup enable omap doesn't wake up on dispc interrupts. This
> causes problems in a case where mpu is in sleep state and dispc
> interrupt fires.
> 
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Imre Deak <imre.deak@nokia.com>
> ---
>  drivers/video/omap/dispc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


----------------------------------------------------------------------
Nowa akcja Pepsi - nagrody za kody spod nakretek. Zarejestruj sie!
http://link.interia.pl/f21cc 


