From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: missing the TWL4030 keypad driver
Date: Thu, 6 Aug 2009 10:26:11 +0300
Message-ID: <20090806072611.GD984@nokia.com>
References: <200908060906.03137.linz@li-pro.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49854 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbZHFHZV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 03:25:21 -0400
Content-Disposition: inline
In-Reply-To: <200908060906.03137.linz@li-pro.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Stephan Linz <linz@li-pro.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Syed Mohammed Khasim <x0khasim@ti.com>, Manjunatha G K <manjugk@ti.com>

On Thu, Aug 06, 2009 at 09:06:02AM +0200, ext Stephan Linz wrote:
> Hi Syed and Manjunatha,
> Hi list,
> 
> where can I find the TWL4030 keypad driver in one of the latest devel trees?
> 
> I know there is one in the the historical OMAP tree hosted by Montavista at 
> http://source.mvista.com/git/gitweb.cgi --> linux-omap-2.6-historic.git --> 
> tree --> drivers/input/keyboard/omap-twl4030keypad.c
> 
> Since 6 moths ago MontaVista's tree was becoming obsolete and I think even 
> this development front was moved to the linux-omap tree at kernel.org, isn't 
> it?

it was removed from linux-omap and Tony is waiting for it to be merged
via lkml.

You can fetch it from commit 0887c518816b...


-- 
balbi
