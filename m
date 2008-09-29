From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 15/22] twl4030: move pm_power_off initialization to
	twl4030-core.c
Date: Mon, 29 Sep 2008 18:42:52 +0300
Message-ID: <20080929154251.GG30555@frodo>
References: <1222694079-16289-7-git-send-email-felipe.balbi@nokia.com> <1222694079-16289-8-git-send-email-felipe.balbi@nokia.com> <1222694079-16289-9-git-send-email-felipe.balbi@nokia.com> <1222694079-16289-10-git-send-email-felipe.balbi@nokia.com> <1222694079-16289-11-git-send-email-felipe.balbi@nokia.com> <1222694079-16289-12-git-send-email-felipe.balbi@nokia.com> <1222694079-16289-13-git-send-email-felipe.balbi@nokia.com> <1222694079-16289-14-git-send-email-felipe.balbi@nokia.com> <1222694079-16289-15-git-send-email-felipe.balbi@nokia.com> <1222694079-16289-16-git-send-email-felipe.balbi@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34937 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbYI2PnB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 11:43:01 -0400
Content-Disposition: inline
In-Reply-To: <1222694079-16289-16-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>

On Mon, Sep 29, 2008 at 04:14:32PM +0300, Felipe Balbi wrote:
> We don't really need a whole new driver just for initializing
> one pointer. Move it to core initialization.

I'll refactor this patch. We (me and Dave) agreed this code doesn't
belong to twl4030-core.c. For now, let's keep it the way it is and we
touch this when we go for twl4030-power.c and twl4030-pwrirq.c rework.

Resending the series soon.

-- 
balbi
