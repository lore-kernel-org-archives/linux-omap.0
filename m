From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Mon, 7 May 2012 10:09:07 +0200
Message-ID: <20120507080907.GB3229@sortiz-mobl>
References: <4F901CCC.9000703@compulab.co.il>
 <Pine.LNX.4.44L0.1204191059581.2070-100000@iolanthe.rowland.org>
 <20120420115728.GF12830@arwen.pp.htv.fi>
 <4FA61941.5080603@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61598 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021Ab2EGIJG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 04:09:06 -0400
Content-Disposition: inline
In-Reply-To: <4FA61941.5080603@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: balbi@ti.com, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keshava Munegowda <Keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi Igor,

On Sun, May 06, 2012 at 09:25:05AM +0300, Igor Grinberg wrote:
> Sorry, for being jumpy...
> Samuel has not answered yet (it has been more then two weeks already)
Sorry about that.

> and I'd like this to go into 3.5.
Then you may need a better changelog explaining how this fixes a regression,
runtime crash or build failure.


> Also, the dependency patch is already in Linus' tree. It has been merged with
> fixes (I thought it will happen only during the merge window...).
> 
> Can you, please take this one?
At that point, it definitely makes more sense for Alan to push it.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
