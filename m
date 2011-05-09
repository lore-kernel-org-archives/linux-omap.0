From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] OMAP: DSS2: DISPC register definition clean up
Date: Mon, 09 May 2011 09:53:09 +0300
Message-ID: <1304923989.2215.7.camel@deskari>
References: <1304662551-23832-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:50112 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751114Ab1EIGxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 02:53:17 -0400
Received: by eye13 with SMTP id 13so2135749eye.17
        for <linux-omap@vger.kernel.org>; Sun, 08 May 2011 23:53:13 -0700 (PDT)
In-Reply-To: <1304662551-23832-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2011-05-06 at 11:45 +0530, Archit Taneja wrote:
> With more overlays and overlay managers on OMAP4, and more coming in future
> OMAPs, the current way of defining the DISPC overlay and manager register
> offsets through macros isn't scalable. Introduce a new dispc.h header which
> contains Macros for common DISPC registers and inline functions for overlay and
> manager specific registers. Remove usage of struct dispc_reg and use u16
> instead.
> 
> Note:
> Can be tried on:
> 
> https://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone/commits/master
> 
> Tested on: 4430sdp and 3430sdp.
> 
> Archit Taneja (3):
>   OMAP: DSS2: Clean up DISPC overlay register definitions
>   OMAP: DSS2: Clean up DISPC overlay manager register definitions
>   OMAP: DSS2: Remove usage of struct dispc_reg
> 
>  drivers/video/omap2/dss/dispc.c | 1086 +++++++++++++++++---------------------
>  drivers/video/omap2/dss/dispc.h |  544 ++++++++++++++++++++
>  2 files changed, 1030 insertions(+), 600 deletions(-)
>  create mode 100644 drivers/video/omap2/dss/dispc.h

This looks good, applying. Thanks.

 Tomi


