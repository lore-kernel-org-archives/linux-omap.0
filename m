From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: OMAP totally fucked?
Date: Sat, 3 Mar 2012 18:29:06 +0000
Message-ID: <201203031829.06992.arnd@arndb.de>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk> <20120303180428.GA10293@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63963 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab2CCS3T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Mar 2012 13:29:19 -0500
In-Reply-To: <20120303180428.GA10293@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Saturday 03 March 2012, Tony Lindgren wrote:
> Well 85631d2 builds fine, looks like now some more includes of
> plat/hardware.h are now needed.Have not yet tracked down which
> commit triggers the build errors. Eventually those should become
> local headers too..

I've tried building arm-soc/for-next and rmk/for-next, they are both
fine, just merging the two gives me the same build errors that Russell
saw.

Adding plat/hardware.h in all files that break solves the problems,
aside from the iommu dependency for rpmsg for which Ohad has provided
a fix already that I should pull.

	Arnd
