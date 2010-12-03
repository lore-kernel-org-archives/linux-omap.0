From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] arm: mach-omap2: remove NULL board_mux from board
 files
Date: Thu, 2 Dec 2010 17:10:00 -0800
Message-ID: <20101203011000.GB17222@atomide.com>
References: <1291296340-27327-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56032 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758225Ab0LCBKM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 20:10:12 -0500
Content-Disposition: inline
In-Reply-To: <1291296340-27327-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

* Aaro Koskinen <aaro.koskinen@nokia.com> [101202 05:15]:
> If CONFIG_OMAP_MUX is not enabled, we can define board_mux in the header
> file instead of forcing every single board to define it.

Thanks, queueing for the next merge window.

Tony
