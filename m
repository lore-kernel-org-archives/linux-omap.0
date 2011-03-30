From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP4: DSS2: Add Panel Taal device struct in 4430sdp
 board file
Date: Wed, 30 Mar 2011 10:02:41 +0300
Message-ID: <1301468561.2333.86.camel@deskari>
References: <1301390798-22951-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:40153 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754335Ab1C3HCp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 03:02:45 -0400
Received: by mail-ew0-f41.google.com with SMTP id 9so388134ewy.14
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 00:02:44 -0700 (PDT)
In-Reply-To: <1301390798-22951-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org

On Tue, 2011-03-29 at 14:56 +0530, Archit Taneja wrote:
> Panel Taal is a DSI panel connected to the DSI1 lanes on 4430sdp and Blaze.
> Add omap_dss_device struct for Panel Taal in the 4430sdp board file. This
> represents the primary lcd device on 4430sdp board and Blaze board. The
> following things are done:
> -Add regulator consumers (vdds_dsi) for the VCXIO supply. VCXIO on blaze and
> 4430sdp is a regulator supply for dsi, csi2, usb otg, and the DPLLs of mpu, iva
> and audio core. Since VCXIO has no consumers declared and the mpu's DPLL is also
> powered by it, set the always_on flag for the regulator so that VCXIO is never
> shut off accidentally.
> -Remove dummy lcd platform_device.
> -Add dsi_set_backlight() routine, original routine was written by Vikram Pandita.
> -Mux settings for DSI1 lanes, GPIO initialisations for Taal reset and Backlight.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
> Note:
> Can be tested with the tree:
> http://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone
> 
>  arch/arm/mach-omap2/board-4430sdp.c |  132 +++++++++++++++++++++++++++++++---
>  1 files changed, 120 insertions(+), 12 deletions(-)

Looks good to me. I think I can take this to my tree, and see if I can
get this and the few DSS bug fixes in for rc2.

Tony, can you ack this if it looks ok for you?

 Tomi


