From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE
 flag from VENC slave interface
Date: Fri, 13 Apr 2012 05:20:29 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204130520170.25832@utopia.booyaka.com>
References: <1334304116-18872-1-git-send-email-archit@ti.com> <1334304116-18872-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41603 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab2DMLUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Apr 2012 07:20:31 -0400
In-Reply-To: <1334304116-18872-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 13 Apr 2012, Archit Taneja wrote:

> The clocks for all DSS slave interfaces were recently changed to "dss_ick" on
> OMAP2 and OMAP3, this clock can be autoidled by PRCM. The VENC interface
> previously had "dss_54m_fck" as it's clock which couldn't be autoidled, and
> hence the OCPIF_SWSUP_IDLE flag was needed.
> 
> Remove the OCPIF_SWSUP_IDLE flag from VENC interfaces as it's clock is now
> "dss_ick".
> 
> Signed-off-by: Archit Taneja <archit@ti.com>

Thanks, queued for 3.4-rc.


- Paul
