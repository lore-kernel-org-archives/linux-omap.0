From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC v3][PATCH 0/4] OMAP: DSS2: Overlay Manager LCD2 support
 in DISPC
Date: Tue, 19 Oct 2010 16:09:50 +0300
Message-ID: <1287493790.2216.26.camel@tubuntu>
References: <1286279724-11692-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62788 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758554Ab0JSNKB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 09:10:01 -0400
In-Reply-To: <1286279724-11692-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 2010-10-05 at 13:55 +0200, ext Archit Taneja wrote:
> This patch series which incorporates changes in DSS2 to enable
> omap_dss_device instances to use the new Overlay Manager LCD2 in
> DISPC.
> 
> On OMAP4, we have a new DISPC channel for Overlay Manager LCD2. This
> channel's video port is a source port for RFBI, DSI2 and DPI. The
> Primary channel's video port is connected to RFBI and DSI1.
> 
> There is a set of regsiters for LCD2 channel similar to the existing
> LCD channel, like DISPC_CONTROL2, DISPC_DIVISOR2, DISPC_CONFIG2 and so
> on.
> 
> In order to decide which LCD Overlay Manager to configure(LCD/LCD2),
> there is a need for the omap_dss_device instances to tell the interface
> drivers(DSI, DPI, RFBI etc) which LCD channel they want to connect to, so
> that the corresponding registers get configured. Therefore, a new
> enum omap_channel member is introduced to omap_dss_device.
> 
> This design was made keeping in mind the possible addition of more
> Overlay Managers in future OMAPs, this code is also backward compatible
> with OMAP3 as omap_dss_device instances in OMAP3 will stick only with
> OMAP_DSS_CHANNEL_LCD.
> 
> This will apply over the set of dss_feature framework patches:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34768.html

The patchset makes dispc API changes in patch 2, but doesn't change any
of the code that uses that API. This means that the kernel doesn't
compile after applying patch 2.

The kernel has to be compilable and working after each patch, so that is
not acceptable.

Fixing that in easy way would mean squashing the later patches together
with patch 2, but that would result in a huge patch, and patch 2 is
already very big. Thus I'd suggest doing the changes in smaller bits.

You could first add the register definitions, and make the changes in
dispc.c to keep everything working. After that you could change the
dispc functions, one by one or in small groups (depending on the amount
of changes), and add the channel argument and adjusting the code using
those functions in the same time.

This would solve the problem of keeping the kernel working, and would
make the patches much more readable.

 Tomi


