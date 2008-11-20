From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [FYI] Rebase: tidspbridge-20081118
Date: Thu, 20 Nov 2008 10:21:14 +0200 (EET)
Message-ID: <20081120.102114.116290435.Hiroshi.DOYU@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A5303E11EBF40@dlee03.ent.ti.com>
	<20081117.153629.191249242.Hiroshi.DOYU@nokia.com>
	<20081119213725.GD9504@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52053 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbYKTIVf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 03:21:35 -0500
In-Reply-To: <20081119213725.GD9504@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, x00omar@ti.com, vikram.pandita@ti.com, h-kanigeri2@ti.com

From: "ext Tony Lindgren" <tony@atomide.com>
Subject: Re: [FYI] Rebase: tidspbridge-20081118
Date: Wed, 19 Nov 2008 13:37:29 -0800

> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [081117 05:37]:
> > Hi,
> > 
> > The following changes since commit f23f23fb6bfd8ce4669070df35ec9b320983ac0c:
> >   Grazvydas Ignotas (1):
> >         HSMMC: Add MMC configuration for pandora
> > 
> > are available in the git repository at:
> > 
> >   http://git.gitorious.org/lk/mainline.git tidspbridge-20081118
> 
> Great, I'm now also mirroring tidspbridge-20081118 branch at:
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary

Since I think that logical patchset doesn't make sense for this early
stage, I am considering to stop rebasing on the top of "omap/master"
and to start updating "tidspbridge", just merging "omap/master" into
it frequently.

    Hiroshi DOYU



