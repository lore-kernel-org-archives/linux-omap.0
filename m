From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Thu, 12 Mar 2015 13:42:54 -0700
Message-ID: <20150312204253.GH5264@atomide.com>
References: <20150309205157.GE5140@atomide.com>
 <1426072599.4244.98.camel@x220>
 <20150311152015.GW5264@atomide.com>
 <87h9trxcci.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:36784 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbbCLUr4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Mar 2015 16:47:56 -0400
Content-Disposition: inline
In-Reply-To: <87h9trxcci.fsf@rustcorp.com.au>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul Bolle <pebolle@tiscali.nl>, Dave Jones <davej@codemonkey.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>, Jon Corbet <corbet@lwn.net>

* Rusty Russell <rusty@rustcorp.com.au> [150311 18:15]:
> Tony Lindgren <tony@atomide.com> writes:
> > * Paul Bolle <pebolle@tiscali.nl> [150311 04:16]:
> > Oh, it should be just GPL v2 like most of the kernel. Probably copied
> > the header from some other phy driver, will update that instead.
> 
> Well, all my code is explicitly v2 or later.
> 
> I'll leave it someone else to try to figure out the stats.  I vote for
> Jon!

It seems I nowadays prefer a mix of GPLv2 with just a sprinkle of the
later! Keeps people guessing you know :)

Tony
