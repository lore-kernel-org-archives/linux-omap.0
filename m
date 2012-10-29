From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 19/20] OMAPDSS: DISPC: remove dssdev depependency from
 error handler
Date: Mon, 29 Oct 2012 12:42:08 +0530
Message-ID: <508E2C48.6020008@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-20-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46707 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab2J2HMY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 03:12:24 -0400
In-Reply-To: <1351070951-18616-20-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Wednesday 24 October 2012 02:59 PM, Tomi Valkeinen wrote:
> The dispc error handler tries to "fix" issues by disabling and enabling
> panel. This is problematic, as we're trying to remove the dependency
> from omapdss to the omap_dss_devices. It's also racy, and doesn't really
> fix anything.
>
> This patch removes the use of omap_dss_device from the error handler,
> and just disables and enables the associated overlay manager. This
> should produce similar results as the previous solution, without using
> dssdev.

Calling APPLY functions from the DISPC driver seems a bit incorrect. 
Instead of disabling/enabling the panel, can't we disable/enable the 
manger by just using DISPC funcs?

Archit
