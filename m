From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: fix compilation issue in board-sx1.c
Date: Tue, 8 May 2012 17:17:34 -0700
Message-ID: <20120509001734.GC5088@atomide.com>
References: <1336485575-18352-1-git-send-email-dedekind1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11713 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab2EIARg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 20:17:36 -0400
Content-Disposition: inline
In-Reply-To: <1336485575-18352-1-git-send-email-dedekind1@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: OMAP Mailing List <linux-omap@vger.kernel.org>

* Artem Bityutskiy <dedekind1@gmail.com> [120508 07:02]:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> SX1 board requirese i2c, so select it in Kconfig, otherwise I have the
> following build error:

Thanks applying into fixes-non-critical as this seems to build
with omap1_defconfig.

Tony
