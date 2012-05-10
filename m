From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/19] ARM: OMAP4 device off support
Date: Thu, 10 May 2012 12:47:57 +0300
Message-ID: <1336643277.2149.283.camel@sokoban>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
	 <873979gehh.fsf@ti.com>  <20120509231418.GC10375@n2100.arm.linux.org.uk>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53063 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757812Ab2EJJue (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 05:50:34 -0400
In-Reply-To: <20120509231418.GC10375@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 2012-05-10 at 00:14 +0100, Russell King - ARM Linux wrote:
> On Wed, May 09, 2012 at 03:46:02PM -0700, Kevin Hilman wrote:
> > Tero Kristo <t-kristo@ti.com> writes:
> > 
> > > Hi,
> > >
> > > First version for this work. Applies on top of mainline + iochain set +
> > > OMAP4 core retention set. Working tree available here:
> > > tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> > > branch: mainline-3.4-omap4-dev-off
> > 
> > FYI... seems your get repo is corrupted.  I tried fetching both with git
> > and https protocols:
> > 
> > $ git remote add tero git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> > $ git fetch tero
> > fatal: The remote end hung up unexpectedly
> > fatal: protocol error: bad pack heade
> > $ git remote rm tero
> > $ git remote add tero https://git.gitorious.org/~kristo/omap-pm/omap-pm-work.git
> > $ git fetch tero
> > error: Unable to find 653621e4dd02d4a2117e1b813d9c5f1ccb11c9ed under https://git.gitorious.org/~kristo/omap-pm/omap-pm-work.git
> > Cannot obtain needed object 653621e4dd02d4a2117e1b813d9c5f1ccb11c9ed
> > error: Fetch failed.
> 
> You will have a partially transferred pack file in your repository...

Strange, well I pushed 1 new branch and it looks like it is cloning
properly now.

-Tero


