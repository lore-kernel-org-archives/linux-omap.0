From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix path for omap-sha1-md5 import of irqs.h
Date: Thu, 14 May 2009 15:33:08 -0700
Message-ID: <20090514223307.GV5593@atomide.com>
References: <49D7D3BB.30500@gmail.com> <20090514165627.GJ5593@atomide.com> <4A0C9277.7070905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51702 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbZENWdI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 18:33:08 -0400
Content-Disposition: inline
In-Reply-To: <4A0C9277.7070905@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Auty <mike.auty@gmail.com>
Cc: linux-omap@vger.kernel.org

* Mike Auty <mike.auty@gmail.com> [090514 14:52]:
> > Sorry for the delay.. I'll apply this to linux-omap tree. Do you want
> > to take this driver and prepare a patch to the associated driver mailing
> > list so we can get it integrated?
> 
> Errr, I'm not sure what that entails?  What would I have to do?  It's
> really such a trivial fix, I wasn't sure it needed a patch at all.  I
> can do something extra if that's necessary, but I was really just
> reporting it since I thought someone should know...

Well if you want to do some Linux stuff that's a good way to get started :)

Just see who maintains the those kind of drivers and prepare the patch
against mainline tree and send it to the maintainer with the right
driver mailing list Cc'd and linux-omap list Cc'd. Then fix the comments
if needed. That's all it takes. Be sure to read Documentation/Submit*
files, and run your patch through checkpatch.pl first..

Tony
