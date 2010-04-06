From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/5] OMAP: Add in helper macros for the SDRAM timings
Date: Tue, 6 Apr 2010 20:17:13 +0300
Message-ID: <20100406171713.GA24981@nokia.com>
References: <1270572668-2336-1-git-send-email-lwalkera@ieee.org>
 <1270572668-2336-2-git-send-email-lwalkera@ieee.org>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17617 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245Ab0DFRRZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 13:17:25 -0400
Content-Disposition: inline
In-Reply-To: <1270572668-2336-2-git-send-email-lwalkera@ieee.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Laine Walker-Avina <lwalkera@ieee.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Apr 06, 2010 at 06:51:04PM +0200, ext Laine Walker-Avina wrote:
>
>Signed-off-by: Laine Walker-Avina <lwalkera@ieee.org>
>---
> arch/arm/plat-omap/include/plat/sdrc.h |   23 +++++++++++++++++++++++
> 1 files changed, 23 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/plat-omap/include/plat/sdrc.h b/arch/arm/plat-omap/include/plat/sdrc.h
>index 7b76f50..c74d1e7 100644
>--- a/arch/arm/plat-omap/include/plat/sdrc.h
>+++ b/arch/arm/plat-omap/include/plat/sdrc.h
>@@ -124,6 +124,29 @@ struct omap_sdrc_params {
> 	u32 mr;
> };
>
>+/* Helper macros and defines for the omap_sdrc_params registers */
>+#define ACTIM_TRFC(a)		(((a) & 0x1f)<<27)

you need to add more spacing in all these macros, something like:

#define ACTIM_TRFC(a)		(((a) & 0x1f) << 27)

similar to all others.

-- 
balbi
