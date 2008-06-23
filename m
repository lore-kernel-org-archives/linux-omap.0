From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/4] usb: musb: musb on omap3 has 32 endpoints
Date: Mon, 23 Jun 2008 14:14:55 +0300
Message-ID: <20080623111455.GH4414@gandalf.research.nokia.com>
References: <1213351443-3336-1-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-2-git-send-email-felipe.balbi@nokia.com> <20080623111009.GM7741@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48079 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287AbYFWLPy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2008 07:15:54 -0400
Content-Disposition: inline
In-Reply-To: <20080623111009.GM7741@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Mon, Jun 23, 2008 at 02:10:09PM +0300, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [080613 13:05]:
> > Fix hdrc_cnf.h for omap3 configuration.
> 
> Does this break the configuration for omap2?
> 
> We should set these dynamically if different for omap2 and omap3
> so we can compile both into the same kernel.

Should check omap2430 trm to be sure, maybe someone in TI could help us
with it ?

Maybe we could bring it via platform_data as well?

-- 
	- Balbi
