From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Thu, 6 Nov 2008 02:53:18 +0200
Message-ID: <20081106005318.GB21860@frodo>
References: <1224964548-31844-1-git-send-email-me@felipebalbi.com> <20081025200349.GA18177@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55420 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYKFAx0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 19:53:26 -0500
Content-Disposition: inline
In-Reply-To: <20081025200349.GA18177@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, paul@pwsan.com

Hi all,

a couple of changes to omap_clk_associate,

On Sat, Oct 25, 2008 at 11:03:50PM +0300, Felipe Balbi wrote:
> > +void omap_clk_associate(const char *id, struct device *dev);

This i changed to omap_clk_associate(struct device *dev, const char *id)
as it looks closer to clk_get().

> > +		list_for_each_entry(d, &p->consumers, node) {

The list_head in struct device was changed to a klist. I already fixed
the patches. Will test them tomorrow afternoon and send the new version
here.

I'll also Cc Greg as there's a symbol from driver core that would be useful
to get it exported.

-- 
balbi
