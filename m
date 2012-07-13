From: Tony Lindgren <tony@atomide.com>
Subject: Re: Criteria for merging new board support files
Date: Thu, 12 Jul 2012 23:51:04 -0700
Message-ID: <20120713065102.GJ1122@atomide.com>
References: <20120712204710.GA3850@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61025 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab2GMGvF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 02:51:05 -0400
Content-Disposition: inline
In-Reply-To: <20120712204710.GA3850@renkinjitsu.usine.8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raphael Assenat <raph@8d.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Raphael Assenat <raph@8d.com> [120712 14:28]:
> Hello,
> 
> We have designed a board based on the AM3505 to use in one of our products,
> an unattended payment terminal. I am wondering if it would be meaningful 
> to clean up and submit our patches to add support for our board in the 
> mainline.
> 
> As this board is neither a development/evm platform nor a mass produced 
> consumer product, not many users, if ever, will want to customize
> their kernel. Therefore I am not sure what the advantages for the 
> community at large would be... Besides our code serving as yet another 
> board file example.
> 
> What is the current maintainer position regarding new board support files? 
> Were submissions from people in the same situation ever merged? Do you think
> it worth the effort to clean up and submit our board support files?

We're moving towards device tree based booting and the board-*.c files
will be going away except for board-generic.c. No new board-*.c files
will be merged.

I've been carrying some board-*.c files in the testing-board branch,
but we're now at a point where the devicetree based booting should work
for simple cases. Some parts are of course still missing.

So I suggest you just provide a new .dts file for your board. Might be
worth posting the board-*.c file anyways so people can use that if
they want to.

Regards,

Tony
