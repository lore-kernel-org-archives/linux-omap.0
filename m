From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v2] OMAP: DSS2: Fix error path in omap_dsi_update()
Date: Tue, 27 Jul 2010 10:19:48 +0300
Message-ID: <1280215188.2427.34.camel@tubuntu.research.nokia.com>
References: <1279109510-12992-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54544 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab0G0HUG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 03:20:06 -0400
In-Reply-To: <1279109510-12992-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-07-14 at 14:11 +0200, ext Archit Taneja wrote:
> In the case of an error on calling dsi_update_screen_l4(), a
> successful framedone callback is still sent to panel-taal. An
> error should be returned to taal_update() instead.
> 

Looks ok to me, I'll add it to my tree. Are you actually using
dsi_update_screen_l4?

 Tomi


