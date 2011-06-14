From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3.0-rc2] OMAP: ams-delta: fix broken uevent sysfs
 entries
Date: Tue, 14 Jun 2011 04:48:48 -0700
Message-ID: <20110614114848.GS3352@atomide.com>
References: <201106070316.41099.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60414 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755894Ab1FNLsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 07:48:51 -0400
Content-Disposition: inline
In-Reply-To: <201106070316.41099.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [110606 18:15]:
> 
> Removing __initdata tags, introduced by commit 
> bdc58fb950a3a1b0bc3cbd8e23d21ecdde2ac9a2, "arm: omap1: fix a bunch of 
> section mismatches", from corresponding platform_device structures 
> declared in arch/arm/mach-omap1/board-ams-delta.c, corrects the problem 
> for me, which may indicate that their members (.name ?) are still 
> referred to during runtime so they shouldn't be freed after boot.

Sounds like this needs a bit more research where this initdata
gets used?

Tony
