From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCHv2 1/1] OMAP3: PM: Fix OTG autoidle workaround
Date: Fri, 18 Dec 2009 13:12:36 +0200
Message-ID: <20091218111236.GE32312@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A71@dbde02.ent.ti.com>
 <1261132763-16697-1-git-send-email-eduardo.valentin@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32710 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbZLRLNj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 06:13:39 -0500
Content-Disposition: inline
In-Reply-To: <1261132763-16697-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Gadiyar Anand <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, Dec 18, 2009 at 11:39:23AM +0100, Valentin Eduardo (Nokia-D/Helsinki) wrote:
>From: Eduardo Valentin <eduardo.valentin@nokia.com>
>
>This patch fix the OTG autoidle workaround so now
>usb gadget modules can be properly loaded.
>
>Besides it also adds a cpu check, because this hardware
>but is present only in OMAP34xx chips.
>
>Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>

looks like after this patch we can drop the workaround from omap2430.c 
and use whatever platform code configured.

Thanks

-- 
balbi
