From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: HDQ: convert HDQ to runtime PM
Date: Mon, 25 Jun 2012 08:36:02 -0700
Message-ID: <20120625153601.GE12766@atomide.com>
References: <alpine.DEB.2.00.1206220809460.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14808 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829Ab2FYPgG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 11:36:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1206220809460.10198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, neilb@suse.de

* Paul Walmsley <paul@pwsan.com> [120622 07:16]:
> Hi Tony
> 
> The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:
> 
>   Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-b-for-3.6
> 
> for you to fetch changes up to c354a86484b61e32100eb94c1f3f0aa512958cee:
> 
>   W1: OMAP HDQ1W: use runtime PM (2012-06-21 21:40:40 -0600)
> 
> ----------------------------------------------------------------
> Convert the OMAP HDQ1W driver to use runtime PM.  Make it available on
> all OMAP2+ chips that appear to have it integrated.  Fix a problem
> preventing it from being used on OMAP4.
> 
> ----------------------------------------------------------------

Thanks pulling into devel-driver branch.

Tony
