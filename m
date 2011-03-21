From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] omap display subsystem changes for 2.6.39
Date: Mon, 21 Mar 2011 15:05:11 +0200
Message-ID: <1300712711.2891.125.camel@deskari>
References: <1300701083.2891.77.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51834 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508Ab1CUNFQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 09:05:16 -0400
In-Reply-To: <1300701083.2891.77.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, 2011-03-21 at 04:51 -0500, Tomi Valkeinen wrote:
> Hi Paul,
> 
> Here are OMAP display subsystem patches for 2.6.39 merge window. Quite a
> bit of them, and many changes also in arch/arm/mach-omap2, which
> unfortunately couldn't go through Tony's linux-omap tree due to
> dependencies on DSS driver code.
> 
> The patches are mostly aiming to get OMAP4 display support up and
> running and both HDMI and DVI outputs should now work on Blaze and Panda
> boards.
> 
> One problem I noticed just now, the committer names seem a bit messed
> up. For example, Archit Taneja has three different style names there. Do
> you think I should rebase and fix them? Not a big job, but it'll mean,
> well, rebasing.
> 
> There's a minor conflict in Overo's board file. I have pushed
> "for-paul-merged" branch to gitorious, which contains a merge with
> Linus' tree. I'm not sure that is the best way to show how to fix the
> conflict, but hopefully it'll give the idea.
> 
>  Tomi
> 
> 
> The following changes since commit a44f99c7efdb88fa41128065c9a9445c19894e34:
> 
>   Merge branch 'trivial' of git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild-2.6 (2011-03-20 18:14:55 -0700)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/linux-omap-dss2/linux.git for-paul

I forgot to mention that this branch is based on Tony's omap-for-linus
branch, which got merged last week.

 Tomi


