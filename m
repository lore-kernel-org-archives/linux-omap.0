From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 01/28] ARM: OMAP: Remove unnecessary platform callbacks
 for VENC devices
Date: Thu, 28 Mar 2013 17:18:39 +0200
Message-ID: <51545F4F.5070502@compulab.co.il>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <1364474962-20439-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:40928 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754936Ab3C1PSq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 11:18:46 -0400
In-Reply-To: <1364474962-20439-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On 03/28/13 14:48, Tomi Valkeinen wrote:
> From: Archit Taneja <archit@ti.com>
> 
> The omap_dss_device's platform_enable/disable callbacks don't do anything for
> any of the boards. The platform calls from the VENC driver will also be removed
> in the future. Remove these calls from boards which have a VENC device.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

This should have been done long long time ago...
Thanks!

Acked-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
