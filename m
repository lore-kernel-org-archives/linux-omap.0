From: Peter Barada <peterb@logicpd.com>
Subject: Problem trying to pull particular commit from PM tree
Date: Wed, 18 Nov 2009 09:25:11 -0500
Message-ID: <1258554311.750.33.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:2836 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757044AbZKROUh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Nov 2009 09:20:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Is it possible to back up in time on the PM tree to find a particular
commit, even across rebasings?  I'm interested in the commit used by TI
to base their AM3517 work on which is:

[Commit:ef25c2a0e0]: OMAP3: PM: defconfig: enable SRF by default.

I tried:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
git checkout -b pm origin/pm
git reset --hard ef25c2a0

But that came back with:

fatal: ambiguous argument 'ef25c2a0': unknown revision or path not in
the working tree.

My git 'fu' is pretty weak.  Any ideas why this doesn't work?
Thanks in advance!

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
