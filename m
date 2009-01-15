From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: git-pull request for omap-fixes for 2.6.29-rc1 (Re: [PATCH
	00/10] Omap fixes for 2.6.29-rc1)
Date: Thu, 15 Jan 2009 15:15:45 +0200
Message-ID: <20090115131545.GB6635@scadufax.research.nokia.com>
References: <20090112143405.24205.52151.stgit@localhost> <20090113143528.GP7344@atomide.com> <20090115103716.GL2162@n2100.arm.linux.org.uk> <20090115112611.GX29324@atomide.com> <20090115124016.GA20409@n2100.arm.linux.org.uk>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24541 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128AbZAON1F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 08:27:05 -0500
Content-Disposition: inline
In-Reply-To: <20090115124016.GA20409@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, Jan 15, 2009 at 12:40:16PM +0000, ext Russell King - ARM Linux wrote:
> Thanks.  It would also be nice if the USB error could be fixed by USB
> folk as well - it's been broken since 2.6.28-git12.  (Maybe people
> should check kautobuild's errors summary page?)

are you talking about

drivers/usb/core/hub.c:1557: error: too few arguments to function
'usb_port_suspend' ??

that should be fixed by Greg, no ??

-- 
balbi
