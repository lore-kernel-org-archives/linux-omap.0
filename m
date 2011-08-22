From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/10] OMAPDSS: code cleanups
Date: Mon, 22 Aug 2011 11:42:36 +0300
Message-ID: <1314002556.2168.25.camel@deskari>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57385 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752702Ab1HVImm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:42:42 -0400
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org

On Mon, 2011-08-22 at 11:27 +0300, Tomi Valkeinen wrote:
> Cleanups for DSS driver, no functionality changed.
> 
>  Tomi
> 
> Tomi Valkeinen (10):
>   OMAP: DSS2: Remove support for non-DISPC overlays
>   OMAP: DSS2: DISPC: use lookup tables for bit shifts
>   OMAP: DSS2: Add overlay caps to DSS features
>   OMAP: DSS2: Add GLOBAL_ALPHA & PRE_MULT_ALPHA to ovl caps
>   OMAP: DSS2: string parsing cleanups
>   OMAP: OMAPFB: string parsing cleanups
>   OMAP: DSS2: DISPC: remove non-existing func prototypes
>   OMAP: DSS2: DISPC: rename overlay related funcs
>   OMAP: DSS2: DISPC: rename manager related funcs
>   OMAP: DSS2: reorganize functions in dss.h

This patch set had some minor conflicts with the patch "OMAP: DSS2:
Handle manager change in apply". The dss master branch has all the
patches with conflicts resolved.

 Tomi


