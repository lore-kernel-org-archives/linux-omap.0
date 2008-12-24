From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: using git with linux-omap
Date: Wed, 24 Dec 2008 06:19:04 +0200
Message-ID: <20081224041903.GD10240@frodo>
References: <20081224032419.GG4080@swansys>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36126 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbYLXETK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 23:19:10 -0500
Received: from [91.154.126.168] (port=23565 helo=frodo)
	by serv01.siteground211.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <me@felipebalbi.com>)
	id 1LFLD8-0001Ds-4M
	for linux-omap@vger.kernel.org; Tue, 23 Dec 2008 22:19:06 -0600
Content-Disposition: inline
In-Reply-To: <20081224032419.GG4080@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>

On Tue, Dec 23, 2008 at 09:24:19PM -0600, green wrote:
> Hey, I am trying to figure out git and am having trouble with something that 
> ought to be simple.
> 
> I have cloned linux-omap-2.6 and created a local branch.  In the local branch I 
> have made one very simple commit with a single line change to Makefile for use 
> when cross-compiling (arm-linux-gnueabi-).  I would like to be able to rebase 
> that branch (just the 1 commit) onto any commit in the master branch so that I 
> can test N810 builds using git-bisect without modifying the Makefile every 
> time.  I can easily move the branch forward to the latest commit with 'git 
> rebase master' (with the local branch active) but something like 'git rebase 
> v2.6.27-omap1' returns merge errors.  Of course that 1 commit will apply easily 
> to that specific tree.
> 
> Is this possible?  What am I missing?  Thanks lots!

hmmm, something like git rebase --onto HEAD v2.6.27-omap1 <your_branch>
should work.

Try that.

-- 
balbi
