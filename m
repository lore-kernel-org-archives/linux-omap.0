From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch 2.6.29-rc7-omap] twl4030-regulator: list more VAUX4
 voltages
Date: Wed, 11 Mar 2009 14:30:21 +0000
Message-ID: <1236781821.6781.155.camel@vega.slimlogic.co.uk>
References: <200903101251.15700.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slimlogic.co.uk ([89.16.172.20]:60415 "EHLO slimlogic.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbZCKOaY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2009 10:30:24 -0400
In-Reply-To: <200903101251.15700.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, OMAP <linux-omap@vger.kernel.org>

On Tue, 2009-03-10 at 11:51 -0800, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> The VAUX4 voltage table scrolls onto a second page in many versions
> of the TWL4030 family manuals.  This doesn't mean we should ignore
> those values!  Some boards use the (fully supported) 2.8V setting.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---

Applied to regulator-next.

Thanks

Liam

