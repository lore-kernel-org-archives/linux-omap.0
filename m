From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/19] ARM: OMAP4 device off support
Date: Thu, 10 May 2012 00:14:18 +0100
Message-ID: <20120509231418.GC10375@n2100.arm.linux.org.uk>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com> <873979gehh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41829 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759093Ab2EIXOb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 19:14:31 -0400
Content-Disposition: inline
In-Reply-To: <873979gehh.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, May 09, 2012 at 03:46:02PM -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Hi,
> >
> > First version for this work. Applies on top of mainline + iochain set +
> > OMAP4 core retention set. Working tree available here:
> > tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> > branch: mainline-3.4-omap4-dev-off
> 
> FYI... seems your get repo is corrupted.  I tried fetching both with git
> and https protocols:
> 
> $ git remote add tero git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> $ git fetch tero
> fatal: The remote end hung up unexpectedly
> fatal: protocol error: bad pack heade
> $ git remote rm tero
> $ git remote add tero https://git.gitorious.org/~kristo/omap-pm/omap-pm-work.git
> $ git fetch tero
> error: Unable to find 653621e4dd02d4a2117e1b813d9c5f1ccb11c9ed under https://git.gitorious.org/~kristo/omap-pm/omap-pm-work.git
> Cannot obtain needed object 653621e4dd02d4a2117e1b813d9c5f1ccb11c9ed
> error: Fetch failed.

You will have a partially transferred pack file in your repository...
