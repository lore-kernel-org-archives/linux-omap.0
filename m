From: "Ashwin Bihari" <abihari@gmail.com>
Subject: Working with Linux-Omap GIT Tree
Date: Thu, 4 Sep 2008 14:40:13 -0400
Message-ID: <1f11a5490809041140u9ebba10r9687c5f72383101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:4357 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757340AbYIDSkP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 14:40:15 -0400
Received: by wa-out-1112.google.com with SMTP id j37so43004waf.23
        for <linux-omap@vger.kernel.org>; Thu, 04 Sep 2008 11:40:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Greetings,

I've been tasked with taking all of the code for our OMAP based board
currently based on the 2.6.22.18 Kernel to the latest version and so I
decided that I would do things in a way that not allowed me to move
our code forward but also allow me to take any new changes made to the
Linux-Omap tree.

To that end, I cloned the GIT tree from
git.kernel.org/linux/kernel/git/tmlind/linux-omap-2.6.git and am
looking at the HEAD of the tree. I was going to start creating
branches for each step of my integration effort which would allow me
to keep things separate and also allow me to pull any changes from the
mainline tree.

When I pulled the tree I noticied that most of the files from the
include/arch-arm/ directory were missing save for a couple of
directories. I then visited the web interface and see the same
situation looking at the latest v2.6.27-rc5 tag from 6 days ago or the
latest commit marked Master. I then began going back to previous tags
and previous commits to see where this changed and had to go all the
way back to v2.6.26-omap1 tag (commit
d6daf8d8cc5ccf90247def5551ee9c3e8555e848) to see the contents of the
include/arch-asm directory, and the commit immediately after (commit
a7448db4826efb097e94f601f4cd9b37053e81bf) is where the files are all
missing.

I'm a bonafide newbie when it comes to GIT and am trying to get my
hands around this while trying not to mess things up in a way that
would require me to re-do a lot of things..

So what's the right way for me to get the latest tree so that I can
begin integrating my code rather than using a tag some 3-4 weeks ago
which contains all the files I'm interested in modifying?

Regards
~ Ashwin
