From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c-omap: fix I2C timeouts due to recursive
	omap_i2c_{un,}idle()
Date: Sat, 11 Oct 2008 17:58:32 +0300
Message-ID: <20081011145826.GA15868@atomide.com>
References: <alpine.DEB.2.00.0810101056020.13922@utopia.booyaka.com> <200810101429.45548.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55292 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbYJKO6h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Oct 2008 10:58:37 -0400
Content-Disposition: inline
In-Reply-To: <200810101429.45548.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, r-woodruff2@ti.com

* David Brownell <david-b@pacbell.net> [081011 00:32]:
> On Friday 10 October 2008, Paul Walmsley wrote:
> > Problem reported by David Brownell <david-b@pacbell.net>.
> 
> Hmm, seems to solve the problem for me too... though for
> the life of me I can't quite see how that explains all
> the symptoms I've observed.  I'll keep an eye out to see
> what comes up over time; I could believe this is only one
> of the problems lurking here.

Great to hear Paul got it figured out! Pushed.

Tony
