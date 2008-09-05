From: Tony Lindgren <tony@atomide.com>
Subject: Russell's ioremap patches pushed, please test and update drivers
Date: Thu, 4 Sep 2008 17:49:20 -0700
Message-ID: <20080905004919.GW23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59869 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbYIEAtX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 20:49:23 -0400
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1KbPVp-000PBQ-QV
	for linux-omap@vger.kernel.org; Fri, 05 Sep 2008 00:49:22 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I've pushed the ioremap patches from Russell. This means drivers need
to be converted to use ioremap instead of io_p2v or XXX_IO_ADDRESS.

After Russell's patches, ioremap does not remap areas that already
have a static mapping.

Tested on n810, 5912osk and omap3430sdp so far. Please test and update
your drivers as needed.

Basically all the drivers should get the physical base address in struct
resource, and ioremap it into a virtual address in driver probe. Then
driver exit needs to iounmap the area.

Cheers,

Tony
