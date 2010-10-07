From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v4 0/2] OMAP: DSS2: Framework to handle omap version
 specific DSS features
Date: Thu, 07 Oct 2010 11:32:04 +0300
Message-ID: <1286440324.28499.1032.camel@tubuntu.research.nokia.com>
References: <1284559794-4771-1-git-send-email-archit@ti.com>
	 <20100915175921.GE4174@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30923 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab0JGIcd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 04:32:33 -0400
In-Reply-To: <20100915175921.GE4174@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "archit@ti.com" <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-09-15 at 19:59 +0200, ext Tony Lindgren wrote:
> * archit@ti.com <archit@ti.com> [100915 07:00]:
> > From: Archit Taneja <archit@ti.com>
> > 
> > This is a simple approach to prevent scattered cpu_is_omapxxxx checks
> > in DSS2 by bringing all omap version specific DSS features/values to one
> > single place, initialize them and expose a set of functions to DSS2 driver
> > files which return the value/existance of a feature.
> 
> Glad to hear. We should absolutely not use cpu_is_omapxxxx checks
> anywhere in the drivers. The drivers should be arch independent.
> Basically any driver using those is broken from Linux point of view.

Yep. This patch set won't accomplish that, but after they have been
moved to one central place, it'll be much easier to remove the
cpu_is_omapxxxx calls totally from the driver.

 Tomi


