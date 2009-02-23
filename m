From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: OMAP3530 USB host problems
Date: Mon, 23 Feb 2009 20:00:53 +0200
Message-ID: <20090223180052.GB31792@frodo>
References: <499EFB84.1020201@mlbassoc.com> <20090220185426.GR20723@frodo> <499EFF0D.6060602@mlbassoc.com> <20090220192330.GN32564@gandalf> <499F0601.7080608@mlbassoc.com> <20090220194157.GP32564@gandalf> <20090223102151.GY16942@scadufax.research.nokia.com> <49A29FBC.2060604@mlbassoc.com> <20090223132745.GB16942@scadufax.research.nokia.com> <49A2DB15.3040806@mlbassoc.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50163 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbZBWSBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:01:01 -0500
Content-Disposition: inline
In-Reply-To: <49A2DB15.3040806@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: felipe.balbi@nokia.com, ext Felipe Balbi <me@felipebalbi.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Feb 23, 2009 at 10:21:25AM -0700, Gary Thomas wrote:
> It turns out that the various USB clocks were not enabled (this is prototype
> hardware, only roughly equivalent to the OMAP3EVM and I started with a
> kernel snapshot more than a month ago, so much may have changed in the
> meantime).  I can now get through this part of the USB host initialization
> code (still doesn't work, but I think I can figure it out).

Yeah, as I suspected. Even in current linux-omap, I got report that vbus
goes on, but enumeration doesn't happen, so you're at the same stage.

> Thanks for the pointers

no problems

-- 
balbi
