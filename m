From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Mon, 6 Oct 2008 21:53:08 +0300
Message-ID: <20081006185305.GC8273@frodo>
References: <200810010915.46032.david-b@pacbell.net> <200810021350.03739.david-b@pacbell.net> <20081003.092336.243854668.Hiroshi.DOYU@nokia.com> <200810061142.08759.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39476 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbYJFSxc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 14:53:32 -0400
Content-Disposition: inline
In-Reply-To: <200810061142.08759.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com

On Mon, Oct 06, 2008 at 11:42:08AM -0700, David Brownell wrote:
> They're all OMAP-specific drivers.  They can know that they
> need to ask for both clocks.  If perchance only one of them
> were actually needed, that would be exceptional ... and the
> driver should be able to assume the device was properly
> set up, and continue without it.

exactly, look at the changes to watchdog driver for an example :-)
if interface clock fails, we continue anyways since we could be using it
in an omap1-based board.

-- 
balbi
