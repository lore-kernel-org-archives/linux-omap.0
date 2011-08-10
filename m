From: Tony Lindgren <tony@atomide.com>
Subject: Re: when to submit new board support
Date: Wed, 10 Aug 2011 03:33:36 -0700
Message-ID: <20110810103336.GE1939@atomide.com>
References: <4E425B4A.3050808@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:22467 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751811Ab1HJKdj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 06:33:39 -0400
Content-Disposition: inline
In-Reply-To: <4E425B4A.3050808@matrix-vision.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>
Cc: linux-omap@vger.kernel.org

* Michael Jones <michael.jones@matrix-vision.de> [110810 03:14]:
> I would like to submit some patches to add support for a new OMAP board...
> 
> Is there a right or wrong time to post such patches to this list? How
> does the kernel merge window effect what kind of patches are expected
> here on the OMAP list?

Well this is the right time, however we're moving things to device tree
and coalescing code. So you may need to be prepared to update the patches
a few times before we get them to mainline.
 
> What should I use as the base for my patches? At
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git,
> at the moment 'master' hasn't been updated for 4 weeks. Should I base it
> on v3.1-rc1 instead (as an example, since I won't manage to submit it
> while v3.1-rc1 is the most recent tag)?

Yes v3.1-rc1 should be used as the base. I've been on vacation and
have not updated the omap tree for a while, will updated it soonish,
but will be just v3.1-rc1 + bug fixes.

Tony
