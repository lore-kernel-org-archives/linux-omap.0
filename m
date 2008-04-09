From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/17] omap2 patches for post 2.6.25, take #3
Date: Wed,  9 Apr 2008 14:03:06 -0700
Message-ID: <1207775003-7429-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:53512 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbYDIVD0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 17:03:26 -0400
In-Reply-To: omap2-upstream-2008-04-09-210318
References: omap2-upstream-2008-04-09-210318
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi all,

Here's a resent series with Russell's comments fixed:

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

