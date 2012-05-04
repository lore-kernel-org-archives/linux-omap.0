From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: igep0020: fix smsc911x dummy regulator id
Date: Fri, 4 May 2012 10:33:25 -0700
Message-ID: <20120504173325.GG5613@atomide.com>
References: <1335806408-614-1-git-send-email-ebutera@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:11827 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab2EDRd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 13:33:27 -0400
Content-Disposition: inline
In-Reply-To: <1335806408-614-1-git-send-email-ebutera@users.sourceforge.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enrico <ebutera@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, Enrico Butera <ebutera@users.berlios.de>

* Enrico <ebutera@users.sourceforge.net> [120430 10:23]:
> From: Enrico Butera <ebutera@users.berlios.de>
> 
> Using id 0 causes errors at boot:
> 
> WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9c/0xac()
> sysfs: cannot create duplicate filename '/devices/platform/reg-fixed-voltage.0'
> 
> Fix it by using a random (not-already-used) id, as suggested
> by Tony Lindgren.

Thanks applying into fixes.

Regards,

Tony
