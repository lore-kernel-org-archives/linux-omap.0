From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Omap fixes for v2.6.32-rc6
Date: Wed, 11 Nov 2009 11:08:20 -0800
Message-ID: <20091111190820.GG24837@atomide.com>
References: <20091111025907.31793.84134.stgit@localhost>
 <4AFA2CA1.4000005@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64293 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758431AbZKKTIR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 14:08:17 -0500
Content-Disposition: inline
In-Reply-To: <4AFA2CA1.4000005@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: linux-omap@vger.kernel.org

* Sid Boyce <sboyce@blueyonder.co.uk> [091110 19:16]:
> I still haven't been able to find the reason why the Ralink drivers
> haven't been offered in make config/menuconfig/xconfig - cross compiling
> on Fedora 12 x86_64 as per my previous post. I downloaded the latest
> linux-omap snapshot Tuesday, 6 hours after it was up.

Sounds like that should be patched via drivers/net.

Regards,

Tony
