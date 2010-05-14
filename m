From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v3 0/2] McBSP changes for OMAP4 platform
Date: Fri, 14 May 2010 11:23:03 +0100
Message-ID: <1273832583.3069.11.camel@odin>
References: <1273684720-16619-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33988 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab0ENKXI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 06:23:08 -0400
Received: by wyb32 with SMTP id 32so1571852wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 03:23:06 -0700 (PDT)
In-Reply-To: <1273684720-16619-1-git-send-email-jorge.candelaria@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com

On Wed, 2010-05-12 at 12:18 -0500, Jorge Eduardo Candelaria wrote:
> The following patches enable McBSP driver to be used along with the
> audio driver in SDP4430 and other OMAP4 based boards.
> 
> Changes from v2:
> - Fixed missing parentheses.
> - Added Acked-by tag to patch #1.
> - Sending to alsa-devel list also, as suggested by Peter Ujfalusi
>   and Liam Girdwood
> 
> Jorge Eduardo Candelaria (2):
>       ARM: McBSP: Fix request for irq in OMAP4
>       ARM: OMAP4: Add support for omap4 in McBSP driver
> 
>  arch/arm/mach-omap2/mcbsp.c |   12 ++++--------
>  arch/arm/plat-omap/mcbsp.c  |   34 +++++++++++++++++++---------------
>  2 files changed, 23 insertions(+), 23 deletions(-)
> 

Both Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

