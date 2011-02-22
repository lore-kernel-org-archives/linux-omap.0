From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [GIT PULL] USB patches
Date: Tue, 22 Feb 2011 22:01:19 +0200
Message-ID: <1298404879.1789.5.camel@eowin>
References: <20110218073513.GW14574@legolas.emea.dhcp.ti.com>
	 <20110222190129.GO15225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46566 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab1BVUBk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 15:01:40 -0500
In-Reply-To: <20110222190129.GO15225@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, 2011-02-22 at 11:01 -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110217 23:33]:
> > Hi Tony,
> > 
> > Here's a pull request for the changes we need to get into the upcoming
> > merge window. These have been tested overnight on pandaboard.
> > 
> > I also checked that it merges cleanly with your omap-for-linus branch.
> 
> Thanks pulled. Looks like there were few merge confclicts with
> the omap2/3 hwmod data, but got those sorted out.

conflict resolution was huge but at a first glance it looks ok.

Tomorrow I'll check if there aren't any conflicts between your for-next
and Greg's usb-next branch.

-- 
balbi

