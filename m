From: Tony Lindgren <tony@atomide.com>
Subject: Linux-omap git tree updated, hsmmc reset
Date: Tue, 27 Jan 2009 13:13:05 -0800
Message-ID: <20090127211304.GH32148@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64060 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbZA0VNI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 16:13:08 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Jarkko Lavinen (NMP/Helsinki)" <jarkko.lavinen@nokia.com>

Hi all,

Looks like the earlier omap-fixes got into the mainline along with the
omap_hsmmc.c. So I've just updated the git tree to that.

I've also reset the omap_hsmmc.c to be what's in the mainline, so
some resending of patches may be needed.

I believe Jarkko Lavinen is planning to put together a queue of the
hsmmc patches against the mainline, so please everybody make sure he
has all the necessary patches to send to LKML for Pierre to review :)

I will not be applying anything to omap_hsmmc.c in the linux-omap tree
until we have ack from Pierre.

Regards,

Tony
