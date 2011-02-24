From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] Adding help for FB_OMAP_LCD_VGA option
Date: Thu, 24 Feb 2011 16:38:08 +0200
Message-ID: <1298558288.16119.97.camel@deskari>
References: <1298540357-30365-1-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57210 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755608Ab1BXOiL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 09:38:11 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1OEcAt0031913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 08:38:10 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1OEcAUc021068
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 08:38:10 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1OEcAmO012139
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 08:38:10 -0600 (CST)
In-Reply-To: <1298540357-30365-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-02-24 at 03:39 -0600, Janorkar, Mayuresh wrote:
> CONFIG_FB_OMAP_LCD_VGA option is present in drivers/video/omap
> There is no explaination about what this flag does.
> Lets add information about it.
> 
> FB_OMAP_LCD_VGA flag sets resolution of display to VGA (640 X 480).
> The default resolution of 3430 LDP is 320 X 240.

Looks fine to me. I'll apply to my tree.

In the long run let's try to port the LCD drivers to the new display
subsystem driver, and remove hacky Kconfigs like this =).

 Tomi


