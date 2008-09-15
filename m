From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [patch] kill compile warning on twl4030-power.c
Date: Mon, 15 Sep 2008 18:55:12 +0300
Message-ID: <20080915155512.GF4712@codecarver.research.nokia.com>
References: <20080915151208.GA17076@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37009 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbYIOPzw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2008 11:55:52 -0400
Content-Disposition: inline
In-Reply-To: <20080915151208.GA17076@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Sep 15, 2008 at 06:12:11PM +0300, ext Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> This part of the patch was left out on previous merge. Here's a
> fix for that.
> 

I doubt this works if you compile for SDP or labrador. OTOH the code for
that bit looks suspicious :)

Cheers,

Peter.
-- 
goa is a state of mind
