From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Thu, 5 May 2011 14:02:04 +0100
Message-ID: <20110505130204.GK11744@opensource.wolfsonmicro.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
 <1304494704-7285-2-git-send-email-archit@ti.com>
 <20110504094050.GI27860@atomide.com>
 <1304595408.30935.16.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36531 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751599Ab1EENCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 09:02:36 -0400
Content-Disposition: inline
In-Reply-To: <1304595408.30935.16.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

On Thu, May 05, 2011 at 02:36:48PM +0300, Tomi Valkeinen wrote:

> So currently we have REGULATOR_SUPPLY defines for each board in all the
> board files which support display. It would be much better to have an
> overrideable standard setup for the DSS powers, but this would require
> dynamically setting up the regulator_consumer_supplies. And I can't see
> how this could be done, except dynamically creating the
> regulator_consumer_supply array before initializing the TWL chip, but as
> DSS is not the only user of those powers the end result could be quite a
> mess with changes needed in every board file.

I'm not sure I see a problem that needs solving here?  This wiring is
all totally system specific.  Once we have viable device tree for
relevant platforms I'd expect to see these things mapped in the device
tree for the system with a standard regulator API device tree mapping.
