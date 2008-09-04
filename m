From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Working with Linux-Omap GIT Tree
Date: Thu, 4 Sep 2008 13:44:23 -0500
Message-ID: <A24693684029E5489D1D202277BE894411A869D4@dlee02.ent.ti.com>
References: <1f11a5490809041140u9ebba10r9687c5f72383101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60879 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758866AbYIDSob convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 14:44:31 -0400
In-Reply-To: <1f11a5490809041140u9ebba10r9687c5f72383101@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Ashwin,

The folder you're looking for has been moved to arch/arm/plat-omap/include/

This has to have the same contents you had in that version + the following changes to them.

Hope this helped you.

Regards,
Sergio

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ashwin Bihari
Sent: Thursday, September 04, 2008 1:40 PM
To: linux-omap@vger.kernel.org
Subject: Working with Linux-Omap GIT Tree

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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

