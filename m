From: Tony Lindgren <tony@atomide.com>
Subject: Re: HTTP url not working
Date: Tue, 7 Oct 2008 10:02:42 +0300
Message-ID: <20081007070241.GB21037@atomide.com>
References: <94a0d4530810060744m111dfd19mf4c3a9e76f11894f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62427 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbYJGG7o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 02:59:44 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530810060744m111dfd19mf4c3a9e76f11894f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

* Felipe Contreras <felipe.contreras@gmail.com> [081006 17:44]:
> Hi,
> 
> The http url doesn't seem to be working anymore:
> http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> 
> Can you?
> mv .git/post-update{.sample,}

Hmm, I just did a git-clone over http, and it worked fine. 

Kevin just told me that the new pm branched don't show up over http,
but do appear over git. Trying to debug.

Tony
