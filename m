From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 10/13 v5] OMAP: GPIO: Implement GPIO as a platform
 device
Date: Tue, 10 Aug 2010 23:47:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1008102344440.27472@utopia.booyaka.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com> <1281098065-24177-2-git-send-email-charu@ti.com> <1281098065-24177-3-git-send-email-charu@ti.com> <1281098065-24177-4-git-send-email-charu@ti.com> <1281098065-24177-5-git-send-email-charu@ti.com>
 <1281098065-24177-6-git-send-email-charu@ti.com> <1281098065-24177-7-git-send-email-charu@ti.com> <1281098065-24177-8-git-send-email-charu@ti.com> <1281098065-24177-9-git-send-email-charu@ti.com> <1281098065-24177-10-git-send-email-charu@ti.com>
 <1281098065-24177-11-git-send-email-charu@ti.com> <878w4ffkth.fsf@deeprootsystems.com> <B85A65D85D7EB246BE421B3FB0FBB59301E80AC400@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42186 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab0HKFrF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 01:47:05 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E80AC400@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Tue, 10 Aug 2010, Basak, Partha wrote:

> As per our discussion with Paul & you during workshop, I believe, 
> optional clock control should be done using clock APIs. So, I would go 
> by your suggestion 1 of exposing an API to expose the optional clocks in 
> the hwmod, something like:
>
> struct omap_hwmod_opt_clk * omap_hwmod_get_opt_clks(struct omap_hwmod 
> *oh);
>
> If agreed, Charu will send updated patch.

This should be done by modifying the hwmod code to call clk_add_alias() 
for the clock names for the optional clocks.  I don't think any extra API 
is needed.


- Paul
