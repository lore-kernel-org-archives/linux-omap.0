From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 02/14] twl4030_charger: use devres for
 power_supply_register and kzalloc.
Date: Mon, 23 Mar 2015 22:25:36 +0100
Message-ID: <20150323212535.GC14779@amd>
References: <20150322231635.23789.70149.stgit@notabene.brown>
 <20150322232028.23789.38570.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57541 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbbCWVZj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2015 17:25:39 -0400
Content-Disposition: inline
In-Reply-To: <20150322232028.23789.38570.stgit@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Sebastian Reichel <sre@kernel.org>, NeilBrown <neilb@suse.de>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, inux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

On Mon 2015-03-23 10:20:28, NeilBrown wrote:
> From: NeilBrown <neilb@suse.de>
> 
> Final allocations/registrations are now managed by devres.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Patches 1,2: Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
