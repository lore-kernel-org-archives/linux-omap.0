From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/12] omap2 patches for post 2.6.25
Date: Tue, 18 Mar 2008 12:39:48 +0200
Message-ID: <1205836800-31737-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51474 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbYCRKkm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 06:40:42 -0400
In-Reply-To: omap2-upstream-2008-03-18-123926
References: omap2-upstream-2008-03-18-123926
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi all,

Attached patch series starts syncing up arch/arm/mach-omap2 directory with
linux-omap tree. The patchset updates pin multiplexing, register access
and clock framework in order to add support for 34xx later on.

The register access and clock framework changes are quite large, but they
allow us to share clock and PM code with 24xx and 34xx.

I've combined Paul's register access and clock framework changes into
larger patches, as in the linux-omap tree they have been done in many 
add-replace-fix cycles.

Regards,

Tony

