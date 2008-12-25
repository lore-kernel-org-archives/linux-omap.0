From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: using git with linux-omap
Date: Thu, 25 Dec 2008 21:55:03 +0200
Message-ID: <20081225195450.GF10240@frodo>
References: <20081224032419.GG4080@swansys> <20081224041903.GD10240@frodo> <20081225004631.GH4080@swansys>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34880 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbYLYTzv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Dec 2008 14:55:51 -0500
Received: from [91.154.126.168] (port=28833 helo=frodo)
	by serv01.siteground211.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <me@felipebalbi.com>)
	id 1LFwJ8-0002w7-RW
	for linux-omap@vger.kernel.org; Thu, 25 Dec 2008 13:55:48 -0600
Content-Disposition: inline
In-Reply-To: <20081225004631.GH4080@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>

On Wed, Dec 24, 2008 at 06:46:31PM -0600, green wrote:
> On Wed, 2008.12.24, 359, Felipe Balbi wrote:
> > On Tue, Dec 23, 2008 at 09:24:19PM -0600, green wrote:
> > > I have cloned linux-omap-2.6 and created a local branch.  In the local branch I 
> > > have made one very simple commit with a single line change to Makefile for use 
> > > when cross-compiling (arm-linux-gnueabi-).  I would like to be able to rebase 
> > > that branch (just the 1 commit) onto any commit in the master branch so that I 
> > > can test N810 builds using git-bisect without modifying the Makefile every 
> > > time.  I can easily move the branch forward to the latest commit with 'git 
> > > rebase master' (with the local branch active) but something like 'git rebase 
> > > v2.6.27-omap1' returns merge errors.  Of course that 1 commit will apply easily 
> > > to that specific tree.
> > 
> > hmmm, something like git rebase --onto HEAD v2.6.27-omap1 <your_branch>
> > should work.
> 
> I got a bunch of merge conflicts this way.

maybe I got the parameters wrong. git help rebase will have the correct
answer. But there are two other easier ways to do it:

a. with git cherry-pick:
$ git checkout -b newbranch v2.6.27-omap1
$ git cherry-pick <commit id for your Makefile change>

b. symlink: just create a symbolic link from arm-none-linux-gnueabi-* to
arm-linux-*, something like:

$ cd /path/to/compiler
$ for i in `ls`; do ln -s $i ${i/none-linux-gnueabi/linux}; done

this might help. To be sure the command is right before really executing
it, change ln -s to echo and see if the paths are ok.

-- 
balbi
