From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap2plus_defconfig: Enable appended DTB
 support
Date: Thu, 4 Jul 2013 05:09:04 -0700
Message-ID: <20130704120903.GN5523@atomide.com>
References: <1372684393-19025-1-git-send-email-trini@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37168 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab3GDMJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jul 2013 08:09:07 -0400
Content-Disposition: inline
In-Reply-To: <1372684393-19025-1-git-send-email-trini@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tom Rini <trini@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>

* Tom Rini <trini@ti.com> [130701 06:19]:
> As this config must support boards which cannot support separate device
> trees, enable support for appended ones.

This can cause things to go wrong when DTB is not appended for mistaking the
memory as an appended DTB, especially when doing a warm reset. But as we need
this in practise for older platforms, let's add it.

Regards,

Tony
