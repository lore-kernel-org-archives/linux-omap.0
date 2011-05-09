From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Mon, 09 May 2011 18:34:34 +0300
Message-ID: <1304955274.2215.26.camel@deskari>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
	 <1304494704-7285-2-git-send-email-archit@ti.com>
	 <20110504094050.GI27860@atomide.com> <1304595408.30935.16.camel@deskari>
	 <20110505130204.GK11744@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:59478 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752565Ab1EIPej (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 11:34:39 -0400
Received: by mail-ew0-f52.google.com with SMTP id 28so2275280ewy.39
        for <linux-omap@vger.kernel.org>; Mon, 09 May 2011 08:34:38 -0700 (PDT)
In-Reply-To: <20110505130204.GK11744@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

On Thu, 2011-05-05 at 14:02 +0100, Mark Brown wrote:
> On Thu, May 05, 2011 at 02:36:48PM +0300, Tomi Valkeinen wrote:
> 
> > So currently we have REGULATOR_SUPPLY defines for each board in all the
> > board files which support display. It would be much better to have an
> > overrideable standard setup for the DSS powers, but this would require
> > dynamically setting up the regulator_consumer_supplies. And I can't see
> > how this could be done, except dynamically creating the
> > regulator_consumer_supply array before initializing the TWL chip, but as
> > DSS is not the only user of those powers the end result could be quite a
> > mess with changes needed in every board file.
> 
> I'm not sure I see a problem that needs solving here?  This wiring is
> all totally system specific.  Once we have viable device tree for
> relevant platforms I'd expect to see these things mapped in the device
> tree for the system with a standard regulator API device tree mapping.

I think there are two things here:

The first is that we want to avoid unnecessary board file changes, and
as almost all boards configure the DSS powers the same way, it'd be nice
to have a default config for these.

The second thing is that even if the power source for vdds_dsi may be
configured differently on different boards, the same vdds_dsi goes to
multiple DSS HW blocks inside OMAP, each represented by a separate
omap_device. So it'd be much nicer to configure just the vdds_dsi power
in the board file, but let the omap display code configure the
regulators properly for all the DSS HW blocks in that particular OMAP.

I'm not familiar with the capabilities of the device tree, so it may
solve these neatly (at least from kernel's perspective). I guess Tony
just wants to try to minimize arch/arm changes wherever possible due to
the recent arch/arm dispute.

 Tomi


