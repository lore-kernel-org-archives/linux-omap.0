From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v6 0/7] OMAP: DSS2: Overlay Manager LCD2 support in
 DISPC
Date: Thu, 02 Dec 2010 14:38:44 +0200
Message-ID: <1291293524.24276.6.camel@tubuntu>
References: <1291289235-12122-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:40366 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757459Ab0LBMiu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 07:38:50 -0500
In-Reply-To: <1291289235-12122-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 2010-12-02 at 16:57 +0530, ext Archit Taneja wrote:
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

Thanks, applied to my devel branch!

 Tomi


