From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap
 clock framework
Date: Thu, 17 Apr 2008 12:45:02 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0804171243340.8530@utopia.booyaka.com>
References: <20080416205119.GF17055@atomide.com> <1208441374-25408-1-git-send-email-Hiroshi.DOYU@nokia.com> <alpine.DEB.1.00.0804170952270.3689@utopia.booyaka.com> <200804171140.59906.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58156 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYDQSpE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 14:45:04 -0400
In-Reply-To: <200804171140.59906.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

Hello David,

On Thu, 17 Apr 2008, David Brownell wrote:

> On Thursday 17 April 2008, Paul Walmsley wrote:
> > But it would be nice to be able to call into clock functions like 
> > round_rate, set_rate, and set_parent via filesystem writes for debugging 
> > purposes, and I don't think that debugfs supports this.
> 
> It does, if you set up the files properly ... except
> maybe the set_parent stuff.

Could you be more specific?  The only write support that I see in the 
debugfs API is to store bytes into memory locations.  We'd need to call 
functions also upon writes.


- Paul
