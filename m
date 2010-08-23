From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 broken with 36-rc1
Date: Mon, 23 Aug 2010 10:15:09 +0300
Message-ID: <1282547709.2202.1.camel@tubuntu.research.nokia.com>
References: <1281962906.1888.25.camel@chotu>
	 <4C72192A.9050801@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24322 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab0HWHPf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 03:15:35 -0400
In-Reply-To: <4C72192A.9050801@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mike Rapoport <mike@compulab.co.il>
Cc: "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, 2010-08-23 at 08:46 +0200, ext Mike Rapoport wrote:
> Hi Ameya,
> 
> Ameya Palande wrote:
> > Hi Tomi,
> > 
> > When I tried to boot 2.6.36-rc1 kernel on Nokia N900, omapfb failed with
> > following error messages:
> > 
> > [    0.124145] OMAP DSS rev 2.0
> > [    0.124237] OMAP DISPC rev 3.0
> > 
> > [    0.303833] acx565akm spi1.2: omapfb: acx565akm rev 8b LCD detected
> > 
> > [    0.805419] omapfb omapfb: failed to allocate framebuffer
> > [    0.810882] omapfb omapfb: failed to allocate fbmem
> > [    0.815856] omapfb omapfb: failed to setup omapfb
> > [    0.820648] omapfb: probe of omapfb failed with error -12

I tested 36-rc1 briefly with OMAP 3430SDP board. I wonder why that
works, but not N900...

Tomi


