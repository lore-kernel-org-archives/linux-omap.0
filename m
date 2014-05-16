From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: SX1: remove check for CONFIG_SX1_OLD_FLASH
Date: Fri, 16 May 2014 14:12:31 -0700
Message-ID: <20140516211231.GF12881@atomide.com>
References: <1400182902.11786.21.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29461 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224AbaEPVMf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 17:12:35 -0400
Content-Disposition: inline
In-Reply-To: <1400182902.11786.21.camel@x220>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Paul Bolle <pebolle@tiscali.nl> [140515 12:42]:
> A check for CONFIG_SX1_OLD_FLASH was added in v2.6.24. But the related
> Kconfig symbol was never part of the tree. So we can remove some dead
> code.

Thanks applying into omap-for-v3.16/board.

Tony
