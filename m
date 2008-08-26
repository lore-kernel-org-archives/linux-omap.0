From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: git-pull-request for omap2-upstream branch for next merge window (Was: [PATCH 00/16] Omap2 patches for post 2.6.26)
Date: Tue, 26 Aug 2008 09:06:16 +0100
Message-ID: <20080826080616.GC24147@flint.arm.linux.org.uk>
References: <20080819212300.GF17034@flint.arm.linux.org.uk> <20080820072310.GA28862@atomide.com> <20080823233711.GM4713@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54084 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbYHZIG2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 04:06:28 -0400
Content-Disposition: inline
In-Reply-To: <20080823233711.GM4713@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Sat, Aug 23, 2008 at 04:37:12PM -0700, Tony Lindgren wrote:
> Here's the pull request for you assuming your don't have other comments.
> 
> I'll be out of town next week, so if there are other comments I won't
> be able to refresh the patches until I get back.
> 
> Regards,
> 
> Tony
> 
> 
> The following changes since commit dcac5512382d8df4476ce2e9c13e9540b3801d32:
>   Russell King (1):
>         Merge branch 'omap2-clock' of git://git.kernel.org/.../tmlind/linux-omap-2.6.git

This is why I don't want to publish my git tree.  You're the second person
to base their tree off my devel branch.

The devel branch is _constantly_ remerged.  Basing your tree on it will
mean I can't merge it.  Please don't.  Base it either on something in
Linus' tree _or_ something you've already asked me to pull.

If this continues, I'll go back to only publishing my git tree in diff
and mbox form.
