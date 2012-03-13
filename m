From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] ARM: OMAP3+: smartreflex: add class support
Date: Tue, 13 Mar 2012 10:31:17 -0700
Message-ID: <20120313173117.GM12083@atomide.com>
References: <1331634381-31436-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48447 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab2CMRbU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 13:31:20 -0400
Content-Disposition: inline
In-Reply-To: <1331634381-31436-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Jean Pihet <j-pihet@ti.com>

* jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [120313 03:29]:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Add the class support so that various classes of operation can be
> implemented (class 1p5 etc.).
> 
> Based on linux-omap's master branch (3.3.0-rc6), commit
> 85244e0edd240da2004bb2ab7cbcbc67a336f20d

We need to move smartreflex into drivers before adding
anything new to it.

Tony
