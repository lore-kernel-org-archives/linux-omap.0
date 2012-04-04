From: Paul Walmsley <paul@pwsan.com>
Subject: A few maintenance notes for the 3.4-rc and future merge windows
Date: Wed, 4 Apr 2012 16:58:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204041643520.6667@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34282 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757355Ab2DDW6H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 18:58:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com


Hi everyone,

A few notes about maintenance changes for the 3.4-rc and later merge 
windows for patches that pass through me.

- Discussing the upcoming release cycle with Tony, it sounds like he's 
  planning to take non-regression fixes also during the early -rc series.  
  So I'll be submitting both regression fixes and non-regression fixes 
  during those timeframes.  One pull request will be sent to Tony shortly;
  please don't hesitate to speak up if I've forgotten something so it can 
  be queued for the next pull request.


- I'll now be sending upstream pull requests for GPG-signed tags, 
  hosted on the following git.kernel.org tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending

  This tree is also covered by gitweb at:

  http://git.kernel.org/?p=linux/kernel/git/pjw/omap-pending.git;a=summary


- The pull request E-mails will themselves be signed by GPG.


- And at some point in the future, I'll probably move my kernel 
  development kernel Git repo there too, to take advantage of gitweb.


Thanks for bearing with the changes.  It might take a few iterations to 
get things completely sorted out...



- Paul
