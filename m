From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 20/20] omapfb: HWA742: fix pointer to be const
Date: Sun, 14 Jun 2009 23:45:42 +0200
Message-ID: <20090614234542.789e94bf.krzysztof.h1@poczta.fm>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
	<057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com>
	<310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com>
	<5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
	<d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
	<d83034cc97924164ca9949fee84bfb480ad5c806.1244131952.git.imre.deak@nokia.com>
	<36ddd74a50b8c225b2c571035c67dbff4686b881.1244131952.git.imre.deak@nokia.com>
	<024fee28b6c89decf0d50747127db8fc61ac789e.1244131952.git.imre.deak@nokia.com>
	<20541a2436ab1399a93c28197244bb05e8657859.1244131952.git.imre.deak@nokia.com>
	<63e0213f6444a9d3c99c659dbef14207e8756b37.1244131952.git.imre.deak@nokia.com>
	<06b710348c4bdd4929e4d270ef29155214ca2a4a.1244131952.git.imre.deak@nokia.com>
	<453d7f9a2fc8ca4bdbd3b4205ec9f9fcb2eafb30.1244131952.git.imre.deak@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:44122 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993AbZFNVh6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Jun 2009 17:37:58 -0400
In-Reply-To: <453d7f9a2fc8ca4bdbd3b4205ec9f9fcb2eafb30.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>
Cc: Antonino Daplas <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Thu,  4 Jun 2009 20:52:45 +0300
Imre Deak <imre.deak@nokia.com> wrote:

> Fixes the following:
> warning: assignment discards qualifiers from pointer target type
> 
> CC: linux-arm-kernel@lists.arm.linux.org.uk
> Signed-off-by: Imre Deak <imre.deak@nokia.com>
> ---
>  drivers/video/omap/hwa742.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


----------------------------------------------------------------------
Interia.pl w Twojej kieszeni!
Kliknij >>>http://link.interia.pl/f21b8



