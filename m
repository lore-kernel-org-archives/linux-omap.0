From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH 12/20] omapfb: Add support for
 rotation on the Blizzard LCD ctrl
Date: Sun, 14 Jun 2009 23:38:15 +0200
Message-ID: <20090614233815.a0e7db4d.krzysztof.h1@poczta.fm>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
	<e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:28654 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbZFNVad (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Jun 2009 17:30:33 -0400
In-Reply-To: <5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>
Cc: Antonino Daplas <adaplas@gmail.com>, Rodrigo Vivi <rodrigo.vivi@openbossa.org>, linux-fbdev-devel@lists.sourceforge.net, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, linux-omap@vger.kernel.org

On Thu,  4 Jun 2009 20:52:37 +0300
Imre Deak <imre.deak@nokia.com> wrote:

> From: Rodrigo Vivi <rodrigo.vivi@openbossa.org>
> 
> The LCD controller (EPSON S1D13744) supports rotation (0, 90, 180
> and 270 degrees) on hardware just setting the bits 0 and 1 of 0x28
> register (LCD Panel Configuration Register). Now it is possible to
> use this caps only setting the angle degree on var rotate of
> fb_var_screeninfo using the FBIOPUT_VSCREENINFO ioctl.
> 
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@openbossa.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Fixed-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
> Signed-off-by: Imre Deak <imre.deak@nokia.com>
> ---
>  drivers/video/omap/blizzard.c    |   91 +++++++++++++++++++++++++++++++++++--
>  drivers/video/omap/omapfb_main.c |   52 ++++++++++++++++------
>  2 files changed, 124 insertions(+), 19 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

----------------------------------------------------------------------
Przekaz dalej wiadomosc: Zawsze warto oszczedzac. Teraz 5,5%!
Sprawdz > http://link.interia.pl/f21b1

