From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 6/8] omap-3630-sdp: enable Flash device support
Date: Mon, 5 Jul 2010 15:27:13 +0300
Message-ID: <20100705122710.GV15951@atomide.com>
References: <s-ghorai@ti.com>
 <1276688400-4812-1-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-2-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-3-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-4-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-5-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-6-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-7-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65043 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758308Ab0GEM1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 08:27:24 -0400
Content-Disposition: inline
In-Reply-To: <1276688400-4812-7-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org

* Sukumar Ghorai <s-ghorai@ti.com> [100616 14:34]:
> update config file to support for NAND, OneNAND, NOR on omap 3630-sdp board.

Let's drop all the defconfig changes from this series, we won't
be patching the defconfigs any longer as requested by Linus.

Regards,

Tony
