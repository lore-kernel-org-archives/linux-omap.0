From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPFB: Adding a check for timings in set_def_mode
Date: Wed, 23 Feb 2011 11:47:41 +0200
Message-ID: <1298454461.29392.5.camel@deskari>
References: <1298381713-13624-1-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41102 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173Ab1BWJrt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 04:47:49 -0500
In-Reply-To: <1298381713-13624-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lethal@linux-sh.org" <lethal@linux-sh.org>

On Tue, 2011-02-22 at 07:35 -0600, Janorkar, Mayuresh wrote:
> When omapfb.mode is passed through bootargs, when omapfb is setting mode,
> it would check if timings passed are fine for panel attached to it.
> It makes use of check_timing API provided by the panel.
> 
> In current code if check_timing API is not available for attached panel,
> OMAPFB would return -EINVAL and BPP sent via bootargs will not have any effect.
> 
> In case of panels like TAAL panel, omapfb or any other driver should not be allowed to
> change the timings. So bpps sent via bootargs will not have an effect.
> 
> In such case we can check only the x_res and y_res with the panels resolution
> and if they match go ahead and set the bpps.
> The bpp value sent via bootarg would have an effect.
> 
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>

This looks good, applying to DSS tree.

 Tomi


