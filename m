From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RESEND/RFC/RFT] [PATCH] arm: omap1: get rid of OMAP_TAG_USB
Date: Sat, 28 Feb 2009 01:22:52 +0200
Message-ID: <20090227232251.GO16801@frodo>
References: <1234661409-653-1-git-send-email-felipe.balbi@nokia.com> <20090219211942.GK20723@frodo> <20090227230354.GO11594@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37131 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbZB0XXA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 18:23:00 -0500
Content-Disposition: inline
In-Reply-To: <20090227230354.GO11594@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Fri, Feb 27, 2009 at 03:03:55PM -0800, Tony Lindgren wrote:
> Well I got around trying this applied on mainline kernel on H2.
> Still getting "hub 1-0:1.0: unable to enumerate USB device on port 2"
> but the result is same as without the patch. So let's apply this.

could be a bug in either ohci-omap.c or tps65010.c

-- 
balbi
