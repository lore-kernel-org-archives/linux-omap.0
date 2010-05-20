From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/4] fbdev: add a MIPI DSI header
Date: Thu, 20 May 2010 11:54:06 +0300
Message-ID: <20100520085405.GA14584@gandalf>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
 <Pine.LNX.4.64.1005071102440.4777@axis700.grange>
 <1274255350.2307.159.camel@tubuntu.research.nokia.com>
 <Pine.LNX.4.64.1005190955500.3099@axis700.grange>
 <1274257308.2307.168.camel@tubuntu.research.nokia.com>
 <Pine.LNX.4.64.1005200939030.26000@axis700.grange>
 <1274344369.4246.28.camel@tubuntu.research.nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48728 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755052Ab0ETIxt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 04:53:49 -0400
Content-Disposition: inline
In-Reply-To: <1274344369.4246.28.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>

On Thu, May 20, 2010 at 11:32:49AM +0300, Tomi Valkeinen wrote:
> On Thu, 2010-05-20 at 10:07 +0200, ext Guennadi Liakhovetski wrote:
> 
> > Yes, right, I should have said "they are related";) How about calling the 
> > header mipi_display.h? This would then unite DSI, DCS, DBI and DPI? 
> > Creating a separate header for each of these standards seems like an 
> > overkill to me. We could then put MIPI CSI and CPI standards in an 
> > include/media/mipi_camera.h. Not sure where to put various other MIPI 
> > standards, I guess, we'll have to think about it as a need arises.
> 
> mipi_display.h sounds good to me.

if there are extra mipi standards which should be taken care of, why
not include/linux/mipi/[display.h camera.h other1.h other2.h...] ?

-- 
balbi
