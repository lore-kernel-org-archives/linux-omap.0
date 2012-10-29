From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 09/20] OMAPDSS: add dispc_ovl_enabled()
Date: Mon, 29 Oct 2012 15:39:00 +0530
Message-ID: <508E55BC.5060607@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-10-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55852 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752510Ab2J2KJQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 06:09:16 -0400
In-Reply-To: <1351070951-18616-10-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 24 October 2012 02:59 PM, Tomi Valkeinen wrote:
> Add new dispc function, dispc_ovl_enabled(). This returns if the overlay
> enable bit is set in the registers.

Is this function used by omapdrm? I can't see it being used in the later 
patches.

Archit
