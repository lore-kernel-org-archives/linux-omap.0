From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP2+: N900: remove omapdss init for DT boot
Date: Wed, 9 Apr 2014 02:09:21 +0300
Message-ID: <20140408230921.GC15736@drone.musicnaut.iki.fi>
References: <1396990278-16706-1-git-send-email-sre@kernel.org>
 <20140408214011.GB15736@drone.musicnaut.iki.fi>
 <20140408222355.GA23005@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:36960 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598AbaDHXNi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2014 19:13:38 -0400
Content-Disposition: inline
In-Reply-To: <20140408222355.GA23005@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On Tue, Apr 08, 2014 at 03:23:55PM -0700, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [140408 14:48]:
> > Shouldn't we delete the whole file, since non-DT boot is
> > not anymore supported?
> 
> Legacy support is still there for omap3 until the DSS displays are
> converted.

Sorry, I was confused. It seems on omap2 (N800 etc.) the legacy boot
is not supported anymore, and I thought it's the same for omap3. Sorry
for the noise.

A.
