From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP: PM support for OMAP4 MPU sub-system
Date: Thu, 8 Dec 2011 11:19:56 -0800
Message-ID: <20111208191956.GC31337@atomide.com>
References: <874nxaewbv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19468 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab1LHTT7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 14:19:59 -0500
Content-Disposition: inline
In-Reply-To: <874nxaewbv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Kevin Hilman <khilman@ti.com> [111208 10:14]:
> Tony,
> 
> Please pull the OMAP4 MPUSS PM series below.  It is based on the
> Russell's devel-stable branch due to dependencies
> 
> Kevin
> 
> The following changes since commit 3ee0fc5ca129cbae81c073756febcb1c552af446:
> 
>   Merge branch 'kexec/idmap' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into devel-stable (2011-12-06 20:27:54 +0000)

I don't think there's a dependency here to the kexec/idmap commit?

Great yeah this is badly needed. One minor thing, can you please rebase
this on one commit earlier to commit deee6d5359969a0ce4e2760cfd7b9f379bd5698a
(ARM: 7194/1: OMAP: Fix build after a merge between v3.2-rc4 and ARM
restart changes) as that's what we have as the base for other branches.

It sounds like we'll have to base board branch to something later in
devel-stable for the machine_id, but from generating pull requests point
of view it's best to have the same base for other branches unless
there are new dependencies involved.

Regards,

Tony
