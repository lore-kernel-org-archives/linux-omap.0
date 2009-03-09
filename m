From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] regulator: twl4030 VAUX3 supports 3.0V
Date: Mon, 09 Mar 2009 11:47:25 +0000
Message-ID: <1236599245.6781.86.camel@vega.slimlogic.co.uk>
References: <49B11EB0.30809@nokia.com>
	 <200903061116.21544.david-b@pacbell.net>
	 <20090306221842.GB15728@sirena.org.uk>
	 <200903061448.43749.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slimlogic.co.uk ([89.16.172.20]:57778 "EHLO slimlogic.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbZCILra (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Mar 2009 07:47:30 -0400
In-Reply-To: <200903061448.43749.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, Adrian Hunter <adrian.hunter@nokia.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>

On Fri, 2009-03-06 at 14:48 -0800, David Brownell wrote:
> On Friday 06 March 2009, Mark Brown wrote:
> > Would it make sense to make this platform data so that if a given board
> > requires running the chip like this it can be enabled for those boards
> > but it's not something people might turn on because it seems useful?
> 
> Let's hear if it's actually needed, first.  :)
> 
> I coded those tables so that it would be easy to kick in the
> support for out-of-spec operation if it's really needed.  But
> so far we don't know that it's needed, and I'd rather it not
> be too easy to run like that.
> 

I've now reverted this patch. 

Liam

