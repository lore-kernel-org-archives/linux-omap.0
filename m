From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] ARM: OMAP3: Add SMSC911X support to Overo platform
	(V2)
Date: Sun, 15 Mar 2009 15:38:27 +0000
Message-ID: <20090315153827.GA10541@n2100.arm.linux.org.uk>
References: <20090313224259.8810.3283.stgit@localhost> <20090313224453.8810.41743.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52719 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbZCOPil (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 11:38:41 -0400
Content-Disposition: inline
In-Reply-To: <20090313224453.8810.41743.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

On Fri, Mar 13, 2009 at 03:44:53PM -0700, Tony Lindgren wrote:
> Gumstix will soon be shipping a variant of their Summit board that
> includes an SMSC LAN9221 ethernet interface.  This patch provides
> support via the smsc911x driver when enabled in kernel config.

Does this actually work with the smsc911x driver which is in mainline,
or is it dependent on the smsc911x patches from Steve Glendinning?
