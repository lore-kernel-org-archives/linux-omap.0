From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2 2/5] mailbox/omap: add support for parsing dt devices
Date: Sun, 13 Jul 2014 00:16:12 +0200
Message-ID: <20140712221612.GB17930@amd.pavel.ucw.cz>
References: <1405116252-53612-1-git-send-email-s-anna@ti.com>
 <1405116252-53612-3-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37433 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbaGLWQP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Jul 2014 18:16:15 -0400
Content-Disposition: inline
In-Reply-To: <1405116252-53612-3-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jassi Brar <jaswinder.singh@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>

On Fri 2014-07-11 17:04:09, Suman Anna wrote:
> Logic has been added to the OMAP2+ mailbox code to parse the
> mailbox dt nodes and construct the different sub-mailboxes
> associated with the instance. The DT representation of the
> sub-mailbox devices is different from legacy platform data
> representation to allow flexibility of interrupt configuration
> between Tx and Rx fifos (to also possibly allow simplex devices
> in the future). The DT representation gathers similar information
> that was being passed previously through the platform data, except
> for the number of fifos, interrupts and interrupt type information,
> which are gathered through driver compatible match data.
> 
> The non-DT support has to be maintained for now to not break
> OMAP3 legacy boot, and the legacy-style code will be cleaned
> up once OMAP3 is also converted to DT-boot only.
> 
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
